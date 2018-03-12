Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4009665-1520844633-2-9230670402691030804
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAD_ENC_HEADER 0.001, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520844632; b=tPa2phBakTDjNRWxv9rFBM/eVeo7HrvlPDGoAbVcc21XtK2
    mlD38jkgYH7olZXlTLEn7n32kan4Qx8NSbu/hvEvXR5amEtWsvP/+PpnyAxXab1V
    pNM070uFZeVT80ZQy/NnxtJViHp9izk+cEjkJPwQ0so13VXecsdqmWBhALuY6wq9
    W7gTBiX4X+WYHnBdCtbDNpun0j9y4nxs/MNTQy87GXORCV1gcIah2UHrP7pa+ffV
    uG4GaX3Oq24Ac7bljtkfK9Z/j9WtuR7WsmZ6Nm21aE04+i/9fA6ahdqcC9yfU28N
    2W9tpxz+kbKCujrYW18ICVFOCMt3wG3DTMXALLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520844632; bh=4
    nyz/rSbFmrzvyZA8rnAct2n8RCHMinn32YRKjmkS7Y=; b=Oci7SCISI5DxJFb3t
    PaTkHyjztBjWOHVpyksPY5O7LoNnNBkTEOqT+sNx2aF3gTjyna8mkGn8EqjgEwOF
    YL9lU/TRzzZWpIKcfylBfGgQrdGZBwsmQHMTHr5VyQJKieirfczyfox2UgsvJ0b5
    kkWa2QeBg1+iOaLfQrn3gPm7lELamiMs6KPYgZ819kKFWcI/YFH2raKGq0YNV+tB
    grxaUB/FSXRyfXTIwsccUnsLkSBBNi25un/VJ79+8gu0HizLPFj5FolRCyQU9Ovd
    gKqLIZjuGDRFsSSXdAF0KX52z+9ziRrvRMIcxu8/OB2Pmk2yyfrVjMh/F1L1/N/E
    8thgg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=W5QjsKbC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=W5QjsKbC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=razvan.stefanescu@nxp.com;
From: Razvan Stefanescu <razvan.stefanescu@nxp.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH v4 0/6] staging: Introduce DPAA2 Ethernet Switch driver
Date: Mon, 12 Mar 2018 03:49:49 -0500
Message-Id: <20180312084955.12686-1-razvan.stefanescu@nxp.com>
X-Mailer: git-send-email 2.8.3
MIME-Version: 1.0
X-Originating-IP: [192.88.168.49]
X-ClientProxiedBy: DM5PR19CA0022.namprd19.prod.outlook.com
 (2603:10b6:3:151::32) To AM3PR04MB0743.eurprd04.prod.outlook.com
 (2a01:111:e400:8839::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 887a50c2-21cc-4304-9cfc-08d587f64193
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);
 SRVR:AM3PR04MB0743;
X-Microsoft-Exchange-Diagnostics: 1; AM3PR04MB0743;
 3:v0IYDx2r4qOOmTRJwgB7usICkZDZiH/Q2EguD4T6PE6wNpJ4KUXF6tKtN6ta2rnHCspRHZH3JqEhTXEpGCYELowAE9DyHoQz1A+JMFBrG0uiEYDFhu2dmIKdVVKi9lPlvnHHycl0rPbfOZR+FdAFsNS9eb7ABBgf4jWYKEdIoN0MTIgER5BSLl7b6qpe6s7MkP2SGei2T2fFsM1vKD88ZMUWDMOzqZWzrlRYRxmId5Sc64Hy38nOBWtEmABwHtGn;
 25:oaFc9Y2X929iLUaajWg/ZfF5JusFqutkdD+FUZO5Ec5eM/oxN1ERtL8Ox8ONEW7ZUD2D5bC+Dkzvk9Lj+ax73oB6Aca8Kh+asLE25Z0Ke+3KI3Avo2nY6FlzUy2F5t8aa6cXSSF8j4lEEmcQNkyNeDpqah49KqnfFTA1dhvWuunDVFzc1RKba91XLC9Hpekw6IUpLTqwHDKV/NWe+Q5eRmeqWiMZfnbu611c4ZohrgXliy3vYcaODHileNAEKgFB8ekfPaJL0S6DiO7AGWzr41q4djngPlgXgvE2iGRZmHJ1psR4xiO1+uhqRcgnBXq5gONvDo0B4vQM5qivsmXtxA==;
 31:E/Cwy3446a1/vZS5B5gW71LxRyQus4uSs4Z+5v7cCcaWBjsqg6gem3hNBoXhpCQYu6AB4VYEXrmetKnFFcRiW29xNQXmYQbfcOJynQkrCpUqroZg56P6V9bVQt4maOdNsQmhLTi9m3CL6FNE9pH5Cw/7c0PCY/d7q33a7HZFq4VfLbz3TEeuxPs7C6rHzawMVIPGg0QeV3aoKC5MDOvJ1HQsI/c9x7fpbPXJHibMgyw=
X-MS-TrafficTypeDiagnostic: AM3PR04MB0743:
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1; AM3PR04MB0743;
 20:9TSal0cz+FzuXqfd8FpLQvLdZZyl3rVkxdPmqIBQqyGBk+Btnnv0OhIwBo0DVS8wwLQkTl9JaB/QYrUo0hK2l6e37dXPiOG9oqfboQaM02z0ixyh+RbPNqRL9NmBPgtjtQYF6tdrumDNv7wrolC5mhz5jCUDiR3CBiF8VR0PirPQak/UOMd/TrHF8lB96+oSJ1XRgfVX3cYuforthQ1xGoPgFipm+YU6AYqFF5OemXGErbH7IFPH+U3hWcJ+8GibCf7GoOp+6s88v6Rm3wZW/JC+VOlWiINLno8yXT1mAE/Yce4GT9H7k+SqquNnsmK/cDZm4nBPNr3Db45frer30wbAP2QnIzp5hHIJAgS3+bRRZeuGM9WuUPcDCbI4vYk+RbYR3Wb9KuZgg2/BZfLnU1bGn1+nSsbetnRJTXATsV937EHvyt033KOL5D+spDzCn7dRgUYRJq66E7FIdDglow12Dk/oXil2buHUeMTIqwfMu/DIkWkwFHnQByA0pdfd;
 4:p6ZUVS6tELiLN/xpKbZ979S18SoWDldxGinuytKsK6qyx/TLGnPVrZlhagZugwZY++Em+gm3ZY6eZBK0zx4vcjjiPIuTIyCMP1LxJ4yILYpxsHOeqvqOT+F+/gd/9To3M8f1itMXGVS8FzE1qYZLk/Vf69kvhfxoBc1Dfi+OM8Y4b8VpXYXispSE+Fq1gVkuQxAoMGlhBp4tIrpRSRmrPEeBby7EWdB0eArX4uLxMRbAd/lBuz/NmOPgKkfOcRWVjKvCCc+BYUSLz65luwclJw==
X-Microsoft-Antispam-PRVS: <AM3PR04MB0743DE9442E9EA373BCF7DDEE6D30@AM3PR04MB0743.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231220)(944501244)(52105095)(10201501046)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011);
 SRVR:AM3PR04MB0743; BCL:0; PCL:0; RULEID:; SRVR:AM3PR04MB0743;
X-Forefront-PRVS: 06098A2863
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(396003)(346002)(39860400002)(366004)(39380400002)(376002)(199004)(189003)(54534003)(1076002)(47776003)(52116002)(6512007)(36756003)(6486002)(39060400002)(66066001)(51416003)(386003)(6506007)(59450400001)(5660300001)(478600001)(26005)(4326008)(53936002)(48376002)(6116002)(3846002)(16586007)(6916009)(6666003)(105586002)(2361001)(2351001)(25786009)(8936002)(97736004)(106356001)(2906002)(81156014)(316002)(50226002)(81166006)(16526019)(50466002)(86362001)(68736007)(186003)(305945005)(7736002)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM3PR04MB0743; H:rhuath.am.freescale.net; FPR:;
 SPF:None; PTR:InfoNoRecords; A:1; MX:1; LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; AM3PR04MB0743;
 23:xXkmwQv87oCxAJ/Qcw0aw1uL1JVkkqysGyfTLD1ql?=
 =?us-ascii?Q?9vjV2Rv96Cem2ZxnInkfu7XnawfNSrp+Syq5fCwcibeGJNhYoqSJvgH6S2Lx?=
 =?us-ascii?Q?ovBjqAQPzd0MHg1+d8JvoAepzUKeivzat2PkGNTLfT4+3DzAWNUU0IDzJQjL?=
 =?us-ascii?Q?KPQsRqJfl8Q5Cgt0kJ+5atVIWR9ApWnJKssxp8paICrz59hknCfOMUEtedMw?=
 =?us-ascii?Q?ob8xhldFRHhz3fDGu7xoa6TIgftCs0hZY0IIO/YgF/yJUFR5d7p+97fPFin0?=
 =?us-ascii?Q?Imj819r8yKyKDpQ4USOKZ9SjO4Lp8bM7dWKBfooRTAZOI7o8p4Hq7C7SGmBk?=
 =?us-ascii?Q?t9261qf3F+G3Zv+XErrwCodQTnKBt7lyZjphMGYHAavmRUcTUpzCFlIQB0mh?=
 =?us-ascii?Q?c+qBWHfMxIvfyz4qKbTUiiwAvGrsDgbSoUPMtll7JvOudBAcE/SHn+RvmEEN?=
 =?us-ascii?Q?Bnuo1UIheBn38VX2zmWMsFdWKP9z88fDHFOBjk+VspJxLKvC+zLYFieQ3rcb?=
 =?us-ascii?Q?eSuw88YfXRVG6inu+OzC8Ify+0rx1jzrs2IGj4CH7Gd0Ahiwqg+7b6QoSvzT?=
 =?us-ascii?Q?BABFkC/s7fJouFjiaa0V9jmnZltM7gwQMvwmv/hiOzpv2vEjV/WFRwz60qXd?=
 =?us-ascii?Q?GqrD2TWvY3odUT/3GMA/sqV42UwNjrH3qV+FpmREVtphBOmqgC0MDqb6SmcF?=
 =?us-ascii?Q?Xleg2y7NFX2ODCjCg1QuJ0ihw7cSbVsgeWA2mRfEtm8FCVzjPlm219Xj7Dbg?=
 =?us-ascii?Q?ymdZz/AY1ze1yZ9F9k3ETjtvm3jiyDe4yl8YVym8gJ3fCZG6X9ycCSMEUz5+?=
 =?us-ascii?Q?pYtew9eC2RPfdUXsM4EyMfeJTsvvxXUkXmS4PzU5EHj0knFSD50dspwkRb6n?=
 =?us-ascii?Q?62yM5XYWT9RUy92g5DekOxkZf2PZbdnx4v29VgY6Fa1khOzGQFmiuuzYPpq9?=
 =?us-ascii?Q?ljrYFbyVA30B8/S5y7LLCcTjkxN9kwq4j8u23KdsAmo4Ro0fVmU9gDT0VT1q?=
 =?us-ascii?Q?4z2OBu6wI4foEf9xumgdtOucfyqTR44CdG2FyaUnG1pBqYyyRRP3CbVEmf0w?=
 =?us-ascii?Q?kvNYZAM9Ny1LogzIaHycvmkmBol6fed6mqXryhhMdPhuYzMzMhoSaEvPw2AV?=
 =?us-ascii?Q?0H0pXJsgpG7QVYdqCR63kuSCYcwQqjm+X7mutj09lwOwSNnUgfsp2L4TtCBH?=
 =?us-ascii?Q?xyFl+TLa4c+ve4=3D?=
X-Microsoft-Antispam-Message-Info: 9yUg1AD+0Kd5DhJYiFgV8+Pp8P2iS4chTFN68IhWavxPl0UIc6sQw3tVpZzARaP6HcsyjA46Bf1lL9tAv8fnSGru79Pxar378yTdEIVlKd4Xx1QzCaYMPcssHzSH4W7jh/99amZojk0SG+lzvTc1ZdT8PzoGayWntGr6/QEFe1LQh/pzu1daAM7ad9HO6OdT
X-Microsoft-Exchange-Diagnostics: 1; AM3PR04MB0743;
 6:BP1IMGf2WzFEFi0fIcUM5zjoGkzumioSfFVf2eA/vpNZWUnNoMQDDJFk/u7k0Xi6OqTQbs7slTGLhA7fiPKGJGYmBRENui2mzQoI1S4BoLDHoK61L8dfa3oBmGFnPzu5PcnKnKEjV/BTicRrGUlKabyAzZZEiDFWlCIkR4y4br/0CaRUnmIMW428cv1ncGBdhj17RUNf8IubqA8PEt8vtKFhce4s1V9Ij36+SngGYBQg/TX4WCcvRmc9EcOX2zFLTS109/KQV4qlbbOpLZwxoiRsljTFp0YjvMZIf+pnP8S0Rx3rWWox/uoYe2f5NqEDQJZOLhHrUgtAiM0BLqhiE7ont0FM7rk61Vj5Ba/ixmc=;
 5:DTS5b0eYdsxqewq/gSggimItdS7nTh0VVhi6wCls69oANI/bQwV7B+nhwkYLnE2Ngy2REtaqC0Pql1cEgxIBGPjfJsEzySfe02es23srO8wPRXCdQPhuyxLnXDR5WJSW0BYZnfRRwhmTS5QflKN7FH20+iYoWkxklaAMCmdBwQY=;
 24:OOIH0qLteBGnhXxXpJ3Xk/zTpj7Pb4SAnRhFZ8sOpGCircOcjESjblowRJICahV0EU3QyCOgQN7WANUW5+TM3D90Yw8TXCcoNI5mwPIx9Fo=;
 7:4kjQgzat1zWL/glM85mMl2LCrNNRq9aNVatURnQAKXZS8bf+piGLg0ArnRbxHQJqZaWFpuUzvkD+syy4Af/ECTIYD1mdPqxWmPkmpFqXMy1pTLXG9a2eKliDsT8ASPcrRHyOvBsOFCQYwzz8ijGGYC5S4e6TvgFfsVEl6E5fnuY2MPGgdPX2uRgpa9Q4ug/r/Ohc83dvVF6S/amZVtvRr7Q5irRJSKM0a6nU6R5BPHRRgLViRLg8xv/yu/+iYYh3
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2018 08:50:05.2971 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 887a50c2-21cc-4304-9cfc-08d587f64193
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB0743
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

This patchset introduces the Ethernet Switch Driver for Freescale/NXP SoCs
with DPAA2 (DataPath Acceleration Architecture v2). The driver manages
switch objects discovered on the fsl-mc bus. A description of the driver
can be found in the associated README file.

The patchset consists of:
* A set of libraries containing APIs for configuring and controlling
  Management Complex (MC) switch objects
* The DPAA2 Ethernet Switch driver
* Patch adding ethtool support

Limitations:
* no support for control traffic to/from CPU
* only DPSW ports can be added to a bridge

Changelog:
 v2: addressed comments from Bogdan P.

 v3: addressed comments from Andrew L. (patch 3/6 updated)

 v4: adjust to moving MC-bus out of staging
     support adding/deleting multicast entries to/from FDB
     avoid triggering console stack traces due to benign MC errors
     refactor TCI setting code to avoid code duplication
     fix sparse warning

Razvan Stefanescu (6):
  staging: fsl-dpaa2/ethsw: Add APIs for DPSW object
  staging: fsl-dpaa2/ethsw: Add Freescale DPAA2 Ethernet Switch driver
  staging: fsl-dpaa2/ethsw: Add ethtool support
  staging: fsl-dpaa2/ethsw: Add maintainer for Ethernet Switch driver
  staging: fsl-dpaa2/ethsw: Add README
  staging: fsl-dpaa2/ethsw: Add TODO

 MAINTAINERS                                     |    6 +
 drivers/staging/fsl-dpaa2/Kconfig               |    8 +
 drivers/staging/fsl-dpaa2/Makefile              |    1 +
 drivers/staging/fsl-dpaa2/ethsw/Makefile        |    7 +
 drivers/staging/fsl-dpaa2/ethsw/README          |  106 ++
 drivers/staging/fsl-dpaa2/ethsw/TODO            |   13 +
 drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h      |  371 ++++++
 drivers/staging/fsl-dpaa2/ethsw/dpsw.c          | 1148 +++++++++++++++++
 drivers/staging/fsl-dpaa2/ethsw/dpsw.h          |  611 +++++++++
 drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c |  206 +++
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c         | 1516 +++++++++++++++++++++++
 drivers/staging/fsl-dpaa2/ethsw/ethsw.h         |   90 ++
 12 files changed, 4083 insertions(+)
 create mode 100644 drivers/staging/fsl-dpaa2/ethsw/Makefile
 create mode 100644 drivers/staging/fsl-dpaa2/ethsw/README
 create mode 100644 drivers/staging/fsl-dpaa2/ethsw/TODO
 create mode 100644 drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h
 create mode 100644 drivers/staging/fsl-dpaa2/ethsw/dpsw.c
 create mode 100644 drivers/staging/fsl-dpaa2/ethsw/dpsw.h
 create mode 100644 drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c
 create mode 100644 drivers/staging/fsl-dpaa2/ethsw/ethsw.c
 create mode 100644 drivers/staging/fsl-dpaa2/ethsw/ethsw.h

-- 
1.9.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
