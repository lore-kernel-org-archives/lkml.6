Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3262519-1520949161-2-2438547990389031239
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAD_ENC_HEADER 0.001, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520949160; b=behrYTvcDhCBdPGaba4zkV3Cwfv5nUM7x1YH3tcXy0j8x7f
    Ny81VQKy1bQCclblmjmXPI8QBtOB3ozlcOyvK21uYIk+Mj/BfWeHcCHmVpcGA7vA
    wZr/doPcnimGO/TV1oNtD5AJOWHt9GU9TlTjzVvU7EGNYln3up74kqC/ywTPQoP8
    7e19FEj9Lis98yOFPl5uC4kfzHE74viUQ0DrtK6ueKMy6FKHnS/AprsglLf2ewEG
    oIyFq/OXXEzUoNiMcU13v1nMLa2zebaHS/UmFbxPMRbFOAYYD14nHYZhyRG/bKlu
    682Z4HrWWJ5COOyUM2ekU/WT17j+GZCP1JlLUqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520949160; bh=v
    hgLtiPDOQ+j0d04ZvWUNvWUqyj2hIEX3DlLAhrbI9s=; b=F1FJvMSCGP1MI+UVP
    8l8L+/PmevTTJH7w/B9KC7GX4xbl7N/C5iNZymqSgJ6+966i0urRxMx6Mj5fOYrC
    5//fAI1/m3qUbFcCaWOtXtZmGoBT98NFm4HExQFhbQtpqVS+6/wu6t4kdGDSWMTx
    x4naDRrkBx/sdZsqEdf15U/G+VfpW8QKdtLR1/mEzfMNiRsTWCRMdc249YNH2UZo
    3J47Up/Dxa4n4iFYTbQS1RWP91zI9bYwOr7kbJoGZlAd3D5dztT7zz//ncyCwDUt
    9Jy6KTlDsmqhGlHnyHsyHDdFVx70f/voUuSljxt+UqLbyln+ykC1MADb3fQ0IIof
    ESB1g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=u8wh27uf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=u8wh27uf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=razvan.stefanescu@nxp.com;
From: Razvan Stefanescu <razvan.stefanescu@nxp.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH v5 3/6] staging: fsl-dpaa2/ethsw: Add ethtool support
Date: Tue, 13 Mar 2018 08:51:53 -0500
Message-Id: <20180313135156.3322-4-razvan.stefanescu@nxp.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180313135156.3322-1-razvan.stefanescu@nxp.com>
References: <20180313135156.3322-1-razvan.stefanescu@nxp.com>
MIME-Version: 1.0
X-Originating-IP: [192.88.168.1]
X-ClientProxiedBy: DM3PR12CA0069.namprd12.prod.outlook.com
 (2603:10b6:0:57::13) To DB3PR04MB0747.eurprd04.prod.outlook.com
 (2a01:111:e400:9440::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a5e536fd-3ef0-488c-ba19-08d588e9a217
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);
 SRVR:DB3PR04MB0747;
X-Microsoft-Exchange-Diagnostics: 1; DB3PR04MB0747;
 3:TAfGJ16AEJR1sf1QnoKpsIu75ZYUepS2lBPnuTZ5HFRHgF/a1FgIa6PjuFfe03j43Ut37DkLOrncII5/ITUc2+r8MysQzQ99xCaSntsGZFFpp99N8Oly0P+gI7vlgQH05qRms+Nfu8g0onXRQoxNkV9Bi/xsdxe8PPHRQOAGGo1TqgvVj9hbvKO9be5JB8TN1DfgT8Ttz3wabzsa8ZaA/ZIpcqbSUt6tGl2eTNC1EXSanF0QHqG+atx8j9o0QK2F;
 25:DHTjU+Hgi9scP1CjIq2lRRJg7m9cYFgJ9idlUXYRW/NCObPrKe8o+j/5GHh1e2SEEzh1dhFZuqTqs1pCTnlmKInDzSxAnxWNdDvI4LDPPThEhB3ZcADm4ARsZ5BqS9POSv1BKAB0/84BxjFApHzur/suVnS/GZhoBeAgVIX5Upwb8lTk///bNnBzr7PgvmUqmLBlibvDdXNPDH93FA4qa4y0sjeqnRJeFNtAPBCTUmmfr9pg/02mdFqDD8nz+aQSB9T/OK67QC5gmDkjxuni4oNswl3vg3L296tlrgJGeHCXvsdkit4zyed205HNfeGzP98EDLIIqmnANGZJXpm21Q==;
 31:OxH2y2TvARU5JjHsvOuCJ7LClo5cQH9GjMv6ULCCPw4iA+fWjNZE+mNC/+VWEb3EjZwmJjLE08iTam/jZzOrIKxTKVXMX0SZyHq2Hcr95Col7aEuQY2s6C0FVG7aGCKgtAucx+nZvSR/cCf7xxIjjZfYltJ4MSOQLp/w8f+P9l8oKhGVXSBJSi8ohhN3DWRpWZL3Acrst3nyYhbUMTAQdATiptBVmWz5AlaHoxOfeDE=
X-MS-TrafficTypeDiagnostic: DB3PR04MB0747:
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1; DB3PR04MB0747;
 20:ueeNAZL/7Ns7IWPWFUrkdTEp8pILALZkXusIXfICGdDTD0gpQdhYEtdx3qR4sTaZDD7+EMLW+p1quWKBGxI1cybv8N1Jj213q5MAWwFbD5KBJCmxuJHp4bOSiZtMgNlM/rVoHtGbZAC2+gar+qTaepp8doEbqGVbldXPu7l7ND3xZdlcHmYEMSuw3bg3OAGOHma2IbBjlbtiJU76GjfoLD8V2W1kZjsc3VB6EzzrFuifKWlQwgbJ2Mpo7HW9/BET1WRgoKkUnVCayVeooN1ypGnr0/eKYf1NYiEIX87h7GF1hgRY//cs6w8kazxg1+WF4Fnw1RMFNawV1GAr1iDRUHVMMHxrS6j+1M5QIsLE8hg0OVEACs1Mu1UTF5XH8MKduxZHEkzI+L23PJT57MTDx/tEDV3UTKOtyKF1Rfff8hUpmCxRe5pjOZDHs64cEA+T+x4txlF6V8inyWbqjcRLdBAR9Ah9tlYmk0ifRltQL8JVuweXR6b380Dqr9Z2706I;
 4:KH67xYEAT36IoM2FdmFJqF4+3rGTxOlur+dgY6kAN03NokPMRkn9myUebO9xicc7hDXTG1x0uxI3keMv+E8ujM1iOV7BKCN6xAP/qxc2G5cmL9tJ4+eVyYhvuLEjts2mUdCP9FpZeIIGowOyW/GDFIJveR9ddCHgMj+fGAPk0zoiJYZ7iMf298HTvM4am2hdFWWZss0KNdf8E/3Lwk0ByAIJQzg8mrszAUxvXZyirgJkl/6A4bLkQG7cn6Ew2uR9S0ONhHICywv9g1YONRyhQIuwS1GMSK/7QVgkY3pFci4x6GQb3uWkaAsHvypPh2l3myV6jSORBMon+6jFN1ZRAEAaZb6KRgWyj9qO9bUsp2Y=
X-Microsoft-Antispam-PRVS: <DB3PR04MB0747FB7DF68351E2CCBF9D94E6D20@DB3PR04MB0747.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(275809806118684);
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501244)(52105095)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);
 SRVR:DB3PR04MB0747; BCL:0; PCL:0; RULEID:; SRVR:DB3PR04MB0747;
X-Forefront-PRVS: 0610D16BBE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(376002)(39380400002)(366004)(39860400002)(346002)(396003)(54534003)(189003)(199004)(1076002)(16526019)(186003)(6916009)(5660300001)(478600001)(50466002)(48376002)(3846002)(6116002)(8676002)(47776003)(6666003)(26005)(2906002)(7736002)(81156014)(2950100002)(66066001)(575784001)(81166006)(6506007)(59450400001)(305945005)(76176011)(386003)(25786009)(50226002)(52116002)(86362001)(8936002)(316002)(16586007)(39060400002)(36756003)(51416003)(106356001)(68736007)(6486002)(53936002)(2351001)(2361001)(4326008)(6512007)(97736004)(105586002)(2004002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB3PR04MB0747; H:rhuath.am.freescale.net; FPR:;
 SPF:None; PTR:InfoNoRecords; MX:1; A:1; LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; DB3PR04MB0747;
 23:GXs926Cpb1yngQnbBwsP41i7EVV+6DmrnaJoPzK/L?=
 =?us-ascii?Q?SLb3blzJQOX+Bj1DZZKddkhxtgwbBz6VdUUoOTtATBYu9tZR7VultkFRlcbB?=
 =?us-ascii?Q?wXiyaQF/z+sI6WpqUtxZpR7KDdyKRecq4Oer1QNJtovzQAv3mwUIir/CgVEY?=
 =?us-ascii?Q?7QQWr3gfiVMyMvMfUev60RVBfo2eOLgcknj+0FfV4yFe7G6S7RCTdFBwSRH+?=
 =?us-ascii?Q?DHxVHpIRIvBMPAsmxLmXiwF3/f6+uTiqKOioGObmi6aK1oRtk8y9++ggWvGi?=
 =?us-ascii?Q?T9kIt9Cv54n1R6yII7nAgFB/xfBStAsEKQy6x1x3wd1+f2wdMpBM5I4uj+0t?=
 =?us-ascii?Q?zjUUJMB7Xs6mw3vOG7Uvx57PQWIkJpkwuJf8CvhLkoEPyBSRN+pZ4zfcDedX?=
 =?us-ascii?Q?Gkz8MDgHcC5YzQ/mLRrZnv89VttE0SJUy0qQvJ9siADNGtfqlYWr/q16RipS?=
 =?us-ascii?Q?hd7/2Q76pTu0hZv2JVxx4ve2WPd+9El9JNTH/eUGHLSp2VU3jQ4ohDSLaY/T?=
 =?us-ascii?Q?mvuqJRuDmZOHazFokZXs5gyvbNbit5iUoJ6WnuIq6Fw0pwuBD4clKe5J5Q/2?=
 =?us-ascii?Q?JKLs6oaq6v6Xvoxlbt1M1zGijgbRqg11MTBYDjifnXd0ZE0CDFVmCKZquJHH?=
 =?us-ascii?Q?n+mppkYwCbze6e1kNMlNBPdGjULec4VkPXcsnO4wtZFuqynV1KgmSmP1us2S?=
 =?us-ascii?Q?5uKCADNg1I+cZlfv8VqUTcLP2nohfeBPKiw6sIJTrbEdCVXRP2ij5UN8djTl?=
 =?us-ascii?Q?fN7fCYY7UocLlWoBsLAzLsOCTE3XZ3iB4qE7Y5v0xvOlZGioiqr8ThW9dL/b?=
 =?us-ascii?Q?SYEoHbbVDCgHNgPAtodrH+nCIcR5JGTuoV0uk7am7pRgtzUYD6F7huJyWgGn?=
 =?us-ascii?Q?wpZH9vcKrGYCswg/a76CHnXG+yUTi00Ogo3PzVWpNFmXqmpeK79DTG0/uKJy?=
 =?us-ascii?Q?CwP+Tph445kpwv7O+dU1lI+Dru9Slsyq9ePywC2G0/lST8fORocbrfhBdf/g?=
 =?us-ascii?Q?P8/KTRU6FjBKkkfo1tDr8arg+yG+79sA2fjfJD0wNn9rMgC/nZD7qGyeICDW?=
 =?us-ascii?Q?Ap7emdGcdY7XJrTrH3ZNhxdu1JxjixrFzwsx9mjUIl7S3UtWYmBghopd8F3d?=
 =?us-ascii?Q?vgCOl0TZZXGi+Q+q0vJ0d14NUaS8CmyXIk8lhM23I/+15fQwgQm/PRsphzmR?=
 =?us-ascii?Q?CyoU6G77SGXQFnA3VFxY263/lJWbkDobBGx5FurU6dpmIFo25YVvNo6eXfHw?=
 =?us-ascii?Q?UZ3sWfy3tuxiHYMEt1CK5+J5nHHpXM03stR2MTz?=
X-Microsoft-Antispam-Message-Info: yLSrdyqV8fo3ldAopPhVRg+fEHA1oSBVBmJZ98pwgWnh4kUIN5CRtNC0JoT9OvILvJXEBm73tVf9GqCfm0BZGDCdQEnwTXUHEEumUUZOHAErXW01PWypeDQM8cR9EonGbqekletC1rcdCN9+cKnSfIQ49z5BGf+QsfaymKSk87SLhuEXaCnuD30TSjbsw0wa
X-Microsoft-Exchange-Diagnostics: 1; DB3PR04MB0747;
 6:CthhKAjU0bkm+GbQZZyH03Q42ztKuoPKl7yNaDJx/Mcr3EAxkWF6XUXbfFuDUORG/R7fRkizG2HXcPIu3QaxZJv/ZaD3JofAZfn0Umsybui0Fx+OstMksMLTAbCz1ghWSALllc8KY4EohUQeKOZgGo0j8twalE2rGBJy0bRZUtA99XU6PAm+T6pTDP8FCHww5sWomSnWKrK5G9SpIYvAZ2aRfRAcFcjl8P1Gw1qzZ92YW7BG2l3a6y1OzNhQ6L8l4u7CzRET1DMi29lRzXTNBQZeCFLgOLomZ+KD1LPFeqvKranf3uYzXbJs51ILu0yuKCJxNz8CTjC3VLOkdU28mJxm9523oJpzala32+IdoOU=;
 5:+I/KBif7pmN5hKs5hJMKU4W0v58h3QFUVtQVGEgIQqzT8FVL1bceV11BKhU0SdYYLxdWvmhaDLfmn9vOcRwaXmQUbW0Rg8Hcl0y5zl2+Ym29ygzhWfmUQz4LojYLgdCX3N/rrGhrBnAGO24fqlBd4SKQfa23gNlrUy6DlSUMfPs=;
 24:r7z7ozy+r3ycpxEsuRNogJd2cKRgCNlHcrHA3aCzuBqGVzUK5iNlmZfcDPNkeQZ1W8wOwop0VXQdAHyYPo0w5uMFyxGh3ZKv3DMzVqiIIzw=;
 7:Sht+NAmtJUyuBxX+S+Qa2T7nMltkW8DmFYYo5+qWaVxcLsVmIAFvru14ZwIhHdk/M+PE3l8j51GSsdxHmUUZ5SyDIpQfjWh/MTN5WmI/Gn/gmhFLpLxAU7Nr2WMnlBLcdM0YRRv05/Q3cyGBeEj4SZtfMvL1BxRRgPkLL7aJQO1C+IBCzAlvchq5GC7GmvQl7ztM6t9zAfsU/KtNZBasOYZvfPO4c+9mB1Ty5s1PNUmeZXyldQE4xCgTr/tc7/hK
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2018 13:52:15.0857 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5e536fd-3ef0-488c-ba19-08d588e9a217
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR04MB0747
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, arnd@arndb.de, netdev@vger.kernel.org,
 alexandru.marginean@nxp.com, linux-kernel@vger.kernel.org, agraf@suse.de,
 stuyoder@gmail.com, ioana.ciornei@nxp.com, laurentiu.tudor@nxp.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add driver information, link details and hardware statistics to be
reported via ethtool -S.

Signed-off-by: Razvan Stefanescu <razvan.stefanescu@nxp.com>
---
Changelog:
 v2:
    - no changes
 v3:
    - removed driver version
 v4:
    - no changes
 v5:
    - no changes

 drivers/staging/fsl-dpaa2/ethsw/Makefile        |   2 +-
 drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h      |  13 ++
 drivers/staging/fsl-dpaa2/ethsw/dpsw.c          |  32 ++++
 drivers/staging/fsl-dpaa2/ethsw/dpsw.h          |  32 ++++
 drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c | 206 ++++++++++++++++++++++++
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c         |   1 +
 drivers/staging/fsl-dpaa2/ethsw/ethsw.h         |   2 +
 7 files changed, 287 insertions(+), 1 deletion(-)
 create mode 100644 drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c

diff --git a/drivers/staging/fsl-dpaa2/ethsw/Makefile b/drivers/staging/fsl-dpaa2/ethsw/Makefile
index a6d72d1..de92cd9 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/Makefile
+++ b/drivers/staging/fsl-dpaa2/ethsw/Makefile
@@ -4,4 +4,4 @@
 
 obj-$(CONFIG_FSL_DPAA2_ETHSW) += dpaa2-ethsw.o
 
-dpaa2-ethsw-objs := ethsw.o dpsw.o
+dpaa2-ethsw-objs := ethsw.o ethsw-ethtool.o dpsw.o
diff --git a/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h b/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h
index 36edef6..c45f001 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h
+++ b/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h
@@ -74,6 +74,8 @@
 #define DPSW_CMDID_IF_SET_FLOODING          DPSW_CMD_ID(0x047)
 #define DPSW_CMDID_IF_SET_BROADCAST         DPSW_CMD_ID(0x048)
 
+#define DPSW_CMDID_IF_SET_LINK_CFG          DPSW_CMD_ID(0x04C)
+
 #define DPSW_CMDID_VLAN_ADD                 DPSW_CMD_ID(0x060)
 #define DPSW_CMDID_VLAN_ADD_IF              DPSW_CMD_ID(0x061)
 #define DPSW_CMDID_VLAN_ADD_IF_UNTAGGED     DPSW_CMD_ID(0x062)
@@ -262,6 +264,17 @@ struct dpsw_cmd_if_set_max_frame_length {
 	__le16 frame_length;
 };
 
+struct dpsw_cmd_if_set_link_cfg {
+	/* cmd word 0 */
+	__le16 if_id;
+	u8 pad[6];
+	/* cmd word 1 */
+	__le32 rate;
+	__le32 pad1;
+	/* cmd word 2 */
+	__le64 options;
+};
+
 struct dpsw_cmd_if_get_link_state {
 	__le16 if_id;
 };
diff --git a/drivers/staging/fsl-dpaa2/ethsw/dpsw.c b/drivers/staging/fsl-dpaa2/ethsw/dpsw.c
index 8e52d74..e63531d 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/dpsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/dpsw.c
@@ -383,6 +383,38 @@ int dpsw_get_attributes(struct fsl_mc_io *mc_io,
 }
 
 /**
+ * dpsw_if_set_link_cfg() - Set the link configuration.
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPSW object
+ * @if_id:	Interface id
+ * @cfg:	Link configuration
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+int dpsw_if_set_link_cfg(struct fsl_mc_io *mc_io,
+			 u32 cmd_flags,
+			 u16 token,
+			 u16 if_id,
+			 struct dpsw_link_cfg *cfg)
+{
+	struct mc_command cmd = { 0 };
+	struct dpsw_cmd_if_set_link_cfg *cmd_params;
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPSW_CMDID_IF_SET_LINK_CFG,
+					  cmd_flags,
+					  token);
+	cmd_params = (struct dpsw_cmd_if_set_link_cfg *)cmd.params;
+	cmd_params->if_id = cpu_to_le16(if_id);
+	cmd_params->rate = cpu_to_le32(cfg->rate);
+	cmd_params->options = cpu_to_le64(cfg->options);
+
+	/* send command to mc*/
+	return mc_send_command(mc_io, &cmd);
+}
+
+/**
  * dpsw_if_get_link_state - Return the link state
  * @mc_io:	Pointer to MC portal's I/O object
  * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
diff --git a/drivers/staging/fsl-dpaa2/ethsw/dpsw.h b/drivers/staging/fsl-dpaa2/ethsw/dpsw.h
index d13970c..5a0c7ad 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/dpsw.h
+++ b/drivers/staging/fsl-dpaa2/ethsw/dpsw.h
@@ -245,6 +245,38 @@ enum dpsw_action {
 };
 
 /**
+ * Enable auto-negotiation
+ */
+#define DPSW_LINK_OPT_AUTONEG		0x0000000000000001ULL
+/**
+ * Enable half-duplex mode
+ */
+#define DPSW_LINK_OPT_HALF_DUPLEX	0x0000000000000002ULL
+/**
+ * Enable pause frames
+ */
+#define DPSW_LINK_OPT_PAUSE		0x0000000000000004ULL
+/**
+ * Enable a-symmetric pause frames
+ */
+#define DPSW_LINK_OPT_ASYM_PAUSE	0x0000000000000008ULL
+
+/**
+ * struct dpsw_link_cfg - Structure representing DPSW link configuration
+ * @rate: Rate
+ * @options: Mask of available options; use 'DPSW_LINK_OPT_<X>' values
+ */
+struct dpsw_link_cfg {
+	u32 rate;
+	u64 options;
+};
+
+int dpsw_if_set_link_cfg(struct fsl_mc_io *mc_io,
+			 u32 cmd_flags,
+			 u16 token,
+			 u16 if_id,
+			 struct dpsw_link_cfg *cfg);
+/**
  * struct dpsw_link_state - Structure representing DPSW link state
  * @rate: Rate
  * @options: Mask of available options; use 'DPSW_LINK_OPT_<X>' values
diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c
new file mode 100644
index 0000000..2853105
--- /dev/null
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c
@@ -0,0 +1,206 @@
+/* Copyright 2014-2016 Freescale Semiconductor Inc.
+ * Copyright 2017-2018 NXP
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *	 notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *	 notice, this list of conditions and the following disclaimer in the
+ *	 documentation and/or other materials provided with the distribution.
+ *     * Neither the name of the above-listed copyright holders nor the
+ *	 names of any contributors may be used to endorse or promote products
+ *	 derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE
+ * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
+ * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
+ * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#include "ethsw.h"
+
+static struct {
+	enum dpsw_counter id;
+	char name[ETH_GSTRING_LEN];
+} ethsw_ethtool_counters[] =  {
+	{DPSW_CNT_ING_FRAME,		"rx frames"},
+	{DPSW_CNT_ING_BYTE,		"rx bytes"},
+	{DPSW_CNT_ING_FLTR_FRAME,	"rx filtered frames"},
+	{DPSW_CNT_ING_FRAME_DISCARD,	"rx discarded frames"},
+	{DPSW_CNT_ING_BCAST_FRAME,	"rx b-cast frames"},
+	{DPSW_CNT_ING_BCAST_BYTES,	"rx b-cast bytes"},
+	{DPSW_CNT_ING_MCAST_FRAME,	"rx m-cast frames"},
+	{DPSW_CNT_ING_MCAST_BYTE,	"rx m-cast bytes"},
+	{DPSW_CNT_EGR_FRAME,		"tx frames"},
+	{DPSW_CNT_EGR_BYTE,		"tx bytes"},
+	{DPSW_CNT_EGR_FRAME_DISCARD,	"tx discarded frames"},
+
+};
+
+#define ETHSW_NUM_COUNTERS	ARRAY_SIZE(ethsw_ethtool_counters)
+
+static void ethsw_get_drvinfo(struct net_device *netdev,
+			      struct ethtool_drvinfo *drvinfo)
+{
+	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
+	u16 version_major, version_minor;
+	int err;
+
+	strlcpy(drvinfo->driver, KBUILD_MODNAME, sizeof(drvinfo->driver));
+
+	err = dpsw_get_api_version(port_priv->ethsw_data->mc_io, 0,
+				   &version_major,
+				   &version_minor);
+	if (err)
+		strlcpy(drvinfo->fw_version, "N/A",
+			sizeof(drvinfo->fw_version));
+	else
+		snprintf(drvinfo->fw_version, sizeof(drvinfo->fw_version),
+			 "%u.%u", version_major, version_minor);
+
+	strlcpy(drvinfo->bus_info, dev_name(netdev->dev.parent->parent),
+		sizeof(drvinfo->bus_info));
+}
+
+static int
+ethsw_get_link_ksettings(struct net_device *netdev,
+			 struct ethtool_link_ksettings *link_ksettings)
+{
+	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
+	struct dpsw_link_state state = {0};
+	int err = 0;
+
+	err = dpsw_if_get_link_state(port_priv->ethsw_data->mc_io, 0,
+				     port_priv->ethsw_data->dpsw_handle,
+				     port_priv->idx,
+				     &state);
+	if (err) {
+		netdev_err(netdev, "ERROR %d getting link state", err);
+		goto out;
+	}
+
+	/* At the moment, we have no way of interrogating the DPMAC
+	 * from the DPSW side or there may not exist a DPMAC at all.
+	 * Report only autoneg state, duplexity and speed.
+	 */
+	if (state.options & DPSW_LINK_OPT_AUTONEG)
+		link_ksettings->base.autoneg = AUTONEG_ENABLE;
+	if (!(state.options & DPSW_LINK_OPT_HALF_DUPLEX))
+		link_ksettings->base.duplex = DUPLEX_FULL;
+	link_ksettings->base.speed = state.rate;
+
+out:
+	return err;
+}
+
+static int
+ethsw_set_link_ksettings(struct net_device *netdev,
+			 const struct ethtool_link_ksettings *link_ksettings)
+{
+	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
+	struct dpsw_link_cfg cfg = {0};
+	int err = 0;
+
+	netdev_dbg(netdev, "Setting link parameters...");
+
+	/* Due to a temporary MC limitation, the DPSW port must be down
+	 * in order to be able to change link settings. Taking steps to let
+	 * the user know that.
+	 */
+	if (netif_running(netdev)) {
+		netdev_info(netdev, "Sorry, interface must be brought down first.\n");
+		return -EACCES;
+	}
+
+	cfg.rate = link_ksettings->base.speed;
+	if (link_ksettings->base.autoneg == AUTONEG_ENABLE)
+		cfg.options |= DPSW_LINK_OPT_AUTONEG;
+	else
+		cfg.options &= ~DPSW_LINK_OPT_AUTONEG;
+	if (link_ksettings->base.duplex  == DUPLEX_HALF)
+		cfg.options |= DPSW_LINK_OPT_HALF_DUPLEX;
+	else
+		cfg.options &= ~DPSW_LINK_OPT_HALF_DUPLEX;
+
+	err = dpsw_if_set_link_cfg(port_priv->ethsw_data->mc_io, 0,
+				   port_priv->ethsw_data->dpsw_handle,
+				   port_priv->idx,
+				   &cfg);
+	if (err)
+		/* ethtool will be loud enough if we return an error; no point
+		 * in putting our own error message on the console by default
+		 */
+		netdev_dbg(netdev, "ERROR %d setting link cfg", err);
+
+	return err;
+}
+
+static int ethsw_ethtool_get_sset_count(struct net_device *dev, int sset)
+{
+	switch (sset) {
+	case ETH_SS_STATS:
+		return ETHSW_NUM_COUNTERS;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static void ethsw_ethtool_get_strings(struct net_device *netdev,
+				      u32 stringset, u8 *data)
+{
+	int i;
+
+	switch (stringset) {
+	case ETH_SS_STATS:
+		for (i = 0; i < ETHSW_NUM_COUNTERS; i++)
+			memcpy(data + i * ETH_GSTRING_LEN,
+			       ethsw_ethtool_counters[i].name, ETH_GSTRING_LEN);
+		break;
+	}
+}
+
+static void ethsw_ethtool_get_stats(struct net_device *netdev,
+				    struct ethtool_stats *stats,
+				    u64 *data)
+{
+	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
+	int i, err;
+
+	memset(data, 0,
+	       sizeof(u64) * ETHSW_NUM_COUNTERS);
+
+	for (i = 0; i < ETHSW_NUM_COUNTERS; i++) {
+		err = dpsw_if_get_counter(port_priv->ethsw_data->mc_io, 0,
+					  port_priv->ethsw_data->dpsw_handle,
+					  port_priv->idx,
+					  ethsw_ethtool_counters[i].id,
+					  &data[i]);
+		if (err)
+			netdev_err(netdev, "dpsw_if_get_counter[%s] err %d\n",
+				   ethsw_ethtool_counters[i].name, err);
+	}
+}
+
+const struct ethtool_ops ethsw_port_ethtool_ops = {
+	.get_drvinfo		= ethsw_get_drvinfo,
+	.get_link		= ethtool_op_get_link,
+	.get_link_ksettings	= ethsw_get_link_ksettings,
+	.set_link_ksettings	= ethsw_set_link_ksettings,
+	.get_strings		= ethsw_ethtool_get_strings,
+	.get_ethtool_stats	= ethsw_ethtool_get_stats,
+	.get_sset_count		= ethsw_ethtool_get_sset_count,
+};
diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index 2127037..f410671 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -1400,6 +1400,7 @@ static int ethsw_probe_port(struct ethsw_core *ethsw, u16 port_idx)
 
 	SET_NETDEV_DEV(port_netdev, dev);
 	port_netdev->netdev_ops = &ethsw_port_ops;
+	port_netdev->ethtool_ops = &ethsw_port_ethtool_ops;
 	port_netdev->switchdev_ops = &ethsw_port_switchdev_ops;
 
 	/* Set MTU limits */
diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.h b/drivers/staging/fsl-dpaa2/ethsw/ethsw.h
index e4d5ac8..03139e8 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.h
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.h
@@ -57,6 +57,8 @@
 #define ETHSW_MAX_FRAME_LENGTH	(DPAA2_MFL - VLAN_ETH_HLEN - ETH_FCS_LEN)
 #define ETHSW_L2_MAX_FRM(mtu)	((mtu) + VLAN_ETH_HLEN + ETH_FCS_LEN)
 
+extern const struct ethtool_ops ethsw_port_ethtool_ops;
+
 struct ethsw_core;
 
 /* Per port private data */
-- 
1.9.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
