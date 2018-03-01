Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3540727-1519926481-2-13485469531079060210
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAD_ENC_HEADER 0.001, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519926480; b=cRg6Bfvw7LLKRCIuMVKmzrjkFPQc4s3nfCjfLCgAOzJeVCa
    vDlYHxkpNpgj1KdceBe+iQdtjG04sO0e8eb9N5E2yt0l7j0SXYetuOt/R8BMx9/P
    vgKEyrD3Xtxv6tSn6xvfbAfNtl7PDVVmoyIpJcHgP0pig7FiCgnt2OR3StHs5qzL
    EOQbt1kftoworSkHN3Ct0MpU34tTLLRwOk20SaLpw00PPqsF+jXV8JKj/HT1HFVv
    gNFr9610jLdDHTXeRAAmjoWvzkjWJ2WhsVdn83J/lpfimXwJ+iGB2vproOhPiBZx
    h9HUHieI5xiDFYYJvF7AuYiUBVmDR7mt8gvplUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519926480; bh=6
    w/DxAfEiCIt3MetY89nIxsQD0t5SFmORf+a89u6nQ8=; b=TGUVyM62YjQEKOY7T
    RXdPAvq03mbvNn0XrPnjtItzVfXdfdcoATU8gZSdKXPgjPpZbwWZkQlmfmgd6wBM
    bP/1Sn9ORMfQ23Xq0+dk922knfCLeQDO3gur55vpWKj2NgyhMj/LqLjWEmzPwvyG
    oA5z53dBgbutw3Fbp0lDGLItid1D9h3c1i4QC3nTNa/EDJb5j9gB3gwyZwukG7Kt
    bwLZE61RhoaDhAFDe43uNgh0kIMuEQwGpdAa+FME3bD0VQ+gzpmBHbS6WIYVBNsx
    N/zdgYbUSPoUuos0JQLM0VCT4sAIWZ3RF1Y0RV7g4Kjy4TG7njG/19QeoNu6GgIY
    v99tQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=cI5a1jUA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=cI5a1jUA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=bogdan.purcareata@nxp.com;
From: Bogdan Purcareata <bogdan.purcareata@nxp.com>
To: gregkh@linuxfoundation.org, laurentiu.tudor@nxp.com,
 ruxandra.radulescu@nxp.com
Subject: [PATCH 0/3] staging: fsl-mc: Move DPBP and DPCON out of staging
Date: Thu,  1 Mar 2018 11:47:09 -0600
Message-Id: <20180301174712.2660-1-bogdan.purcareata@nxp.com>
X-Mailer: git-send-email 2.8.3
MIME-Version: 1.0
X-Originating-IP: [192.88.168.1]
X-ClientProxiedBy: SN6PR0102CA0030.prod.exchangelabs.com (2603:10b6:805:1::43)
 To AM0PR0402MB3650.eurprd04.prod.outlook.com
 (2603:10a6:208:d::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 16c2b108-06f2-4c6d-17e7-08d57f9c8a63
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);
 SRVR:AM0PR0402MB3650;
X-Microsoft-Exchange-Diagnostics: 1; AM0PR0402MB3650;
 3:PHBp3F7cUMO44TBn6sKV3fSnCZ9CRLdTi7Jf+iBiYcgi2z0p/GLU+aqqSo5u9U6UAH25NOuxyNldUdg+m4rsLZZxzDSqrdY1uj7AvIp59AU6xwTopjyr9C49N4UCY/JsMYjgsaCxS5uO2wm2n4etKq4FksFNy5AQHkusCip5GCjdsHa4djaS3hrpOA45OyO9vjhIm6bTwEtFCAZYKZZA8qX8Cx6oBoyHvnmOwzB1OFAovV2SlBSPCfYrLpaiqz7x;
 25:L5el4zDtCW2FOJuYJy5iePLOAzzwZyNJNqG6r6ulgtEKkPyZ7akxk4wNWOgylUb666nVoT6urFv6XVyoui6CRODEHzp5yPwWFaFifFnqAPTW0R7ENP/99zY0V3leNo5U7/CGPdd+gxzPH8sqVLTYBZdLxt+c2KfIj9AwBTIfhfUYiLF1VJqrASLk4dZRcHXRKMAL1CYWsyyrkLcalQNvkNdOv9NGqSu0E/4Em647D/H/ywk0aR/Gt07RHhQTEEdqhvAgv5Nd0Hwow+TjMo0k2NPBJvcP+1Mqk+6Ot93WzQK4lmIHu4GHzZgwO4oR2+BcAfILPaDOd8/iUEoYLYEm+A==;
 31:mOf1zVY2crPdmNulNVLTT4PEj2i+WHqhioS5hk2lLbldVaaF59A6MGpm0QXH6ot65cFoWGqacZOv7vQl9B2PFgIjkXzgQDcH0agAEL/zlCubK0sndGrY6MniE2bnHbTDJ9nL87tresGYYYwvIDLAetTVuUm0F20uieboQanQs2uL0UqCQ+ovSaPd1d0SU6GmOXTewF9jLsQ2tn+VxMWhqcP/KC3hI2Uh8XkrIA2zfaM=
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3650:
X-Microsoft-Exchange-Diagnostics: 1; AM0PR0402MB3650;
 20:33N0i4hR9N9XlYX+Hbsy2z40frVSvngWZhN4t71wZclnJj0/U4CHQLG3MInPiF1fUIwOhVw8vxEULA6OG2WSVblDcFTumajkEdWhyGffUed/fyxVKH/NQRAzH+xlZMxQixYp05+eCs4WrsGpxGkCFPk8vPEcf4JYjvBghB6uI3m3PyeNTgbovSqvIBJZnX+ntEzF4mXcafHNu5eVa42SbNDibv6Z6Et+7MCCJK/5cgvvEMKR4l8NBE73XSMk0zGq/vFqrIQlivuxgteOuU5f3ha6YAMTsKbz4KRCdpPkWj2ZPlSJSTrcz2dBcAIOntsVmvhnau+gPys7LGnNmRoJVwUYwN/FgBFzyjWepk5oRSwkYcP9RtHoqPtz+PBlWgxgy2Mm+AAAp0BvdC1Ae73jjpiKdnMcJmivpol3sq0VZl2kNHc30WwVVTVlyibiNNn/V1OW3xXWlxV1yc+c3fY8iT8WF2DfjJFAGQJwhuxWmb5g/rWhalCeY3mTstlMuEdD;
 4:PKIBzl+hdui3b9LHAbU5W/ip8VakNe16lRjklgF2KZ10gWWz2XNlkrxzMqw8/tP0UoiAfWEMn2MoixJdJVmm9G00r8XPpnxhHLcvemafMOS66KV0uW7enXrAB+LqIo7pIm4kGSWWtaK6ECJJ6td4iynaUZyZyNRyfbyMJyOcC7dRP0XbkGePhtHs9MJ1Dy1MzQ/2gIfKyu7MInnVzMCoO5qDw+UjIk+N/awl2DWyTjjxCvq8qe+LjXAprxuIsq6LK39PLGPE47cXTDuEVnW33A==
X-Microsoft-Antispam-PRVS: <AM0PR0402MB3650817B9C5B769CFCB9D2ADEAC60@AM0PR0402MB3650.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231220)(944501230)(52105095)(10201501046)(6055026)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);
 SRVR:AM0PR0402MB3650; BCL:0; PCL:0; RULEID:; SRVR:AM0PR0402MB3650;
X-Forefront-PRVS: 05986C03E0
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(396003)(39860400002)(39380400002)(366004)(376002)(346002)(189003)(199004)(36756003)(16586007)(2906002)(6666003)(106356001)(316002)(6636002)(26005)(186003)(6116002)(16526019)(59450400001)(3846002)(25786009)(51416003)(52116002)(6506007)(386003)(50466002)(48376002)(53936002)(5660300001)(478600001)(47776003)(6486002)(8936002)(1076002)(6512007)(86362001)(4326008)(305945005)(97736004)(68736007)(81156014)(50226002)(7736002)(105586002)(8676002)(81166006)(66066001)(39060400002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR0402MB3650; H:rhuath.am.freescale.net;
 FPR:; SPF:None; PTR:InfoNoRecords; MX:1; A:1; LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; AM0PR0402MB3650;
 23:PGn3jz4X630Dp5IB939yXSUY/FQoHZWbFZLFJc+?=
 =?us-ascii?Q?XJmTkfcRskFqu2gxr1PR2OkRPPeMX2nPtMfaSUgJ7bbh5KqhP8xXx9vYogzE?=
 =?us-ascii?Q?VVdwPceAGFc2pQ2177RNZup4ofqZwqS4phPWfsIhFm+gVpTsiBak7uKdsxE0?=
 =?us-ascii?Q?OB5GE0Xh+lh8KPvfUamAhUtEat5b+j/0XMb0RFr80UWN2aAjk9PMPG8rdwOQ?=
 =?us-ascii?Q?RRJbPnV04uxXK/v1CIUJB/mKiP/HlbisIzXmvlXZyi7JSC2Aq7LfJ4DbIjR4?=
 =?us-ascii?Q?m2e+2xjQQb3VXo2o3BBkaC1QYlHmhmrmyD/RFDs+47WiXUyH2iN+j0Mm8eDk?=
 =?us-ascii?Q?tJJpnpfe+TbyeVvR3aCbhfSqJCVDSKkaudCavzrb0IMpMZbkPhq4a0nVmddi?=
 =?us-ascii?Q?W+wbfw3zKvd0TKTlh6qSKjPZucq5saVm5aUtBUBTTjswNwBlYYWm2utxhihP?=
 =?us-ascii?Q?ydMZl6IBH3ZzHERMt4WKXu8S3rXWlYboTMybfr7L5JTrzsQyNN4hLkjRlAAS?=
 =?us-ascii?Q?P80sOKWX+zz5IDm2ClcOIfKTSxX5+40v8nCLzKCnlJaxhhttXt7FEBnPYfmX?=
 =?us-ascii?Q?IiUPiMwZz6J0AJksiyiQikC5ZWuJcagt0G9Dw0WvOAGEw5uSP2gdEn32DBbP?=
 =?us-ascii?Q?o2ICSfAsxkzdPgRlzD8Hy4sjm1G1HX9p3E+5pdaB28sz/Jk7i89tPv/my9S6?=
 =?us-ascii?Q?xvy4oxgRieXmnTI4/8Q8mMwqWrHWrAjgvuHimI5aaWrTqCyJo0jClrIAqoY2?=
 =?us-ascii?Q?gCjx69BPTHR8Tu+TtM88+gTW8CRnmKOM5tGfHkSmRa1AVaYDvoTjfTBA4Y4m?=
 =?us-ascii?Q?iAshNZ8pe0w9d1lidT/wN7h+e8YcelmQd8Kcy9L30mDOmv+p6EvL3Z6+f5J4?=
 =?us-ascii?Q?UJYeKlGMfBeoomnW3KgEA8roXJ1mV+210GF4wdKruI76cTRfwyZVnDK1W+ze?=
 =?us-ascii?Q?hPJlxn1h9Kj7IYbEuVe4q6R1FP/TSRVZ+wHx/o/BHSw426XBiVOdAt1UYjaO?=
 =?us-ascii?Q?kVFtf1ulXz+T1Epr0PI/lz/ZOInWDXzpr3iTH7gw715RJgf8RjBJGqIBbtux?=
 =?us-ascii?Q?OSbxoAvEE+WP3UIjWwKUF+RKro8qCPjuJ2ri8TOAM2lcOD/T/3rOUJrU20hR?=
 =?us-ascii?Q?Ov42QvjG7ogg=3D?=
X-Microsoft-Exchange-Diagnostics: 1; AM0PR0402MB3650;
 6:6iZPXv2xMWB8h7MCsFJfCqeCmnGKsKNeEoDMmKtmlbCO1deDArm0XLmdVvtMev39BMzpHH0IGVuwEexvB6Il78goD5xOB5O4vp8F4m4RkSXW3y5GLkXq7BErhYC1ghTBRnsUYzgxScgG+B58lMfRhifloBVBk5pAyXElz/8xaV9VC3OzPaPyaWcPOvDoZewMOF0mfc0NaVJpo8n/qViNvhsVgiBnM6j7pHOvDu+AgtcejaCI1f7HTUWWbDLHb3eAnZBw+IAE7fGDhdbABHkI4bCx4+8bqv2MMscZJH0wyedXrY/AjhNt2DrpjEQD7DQdRlQRGLwyIUn8+qOXgb2Bl98fJEV84q+x9fyllnymT3k=;
 5:zA9+fxQPFFdQZy6ty4UJdU++0Qhpa2dBjhhoRZlDsFu5iIAkSkOIS7IMWGjmCFZkUdp2g/rEah3vEM/3il11h5EKbIUu1IJp2P6/AjorB3ors6tXeZM8c2UdUB3X1tae6vmmGekBL+M8u9A325id18+5OItI1RkwVcDxUInCYt0=;
 24:JQFq2CACNVpPn8ymMbEtpnJlJ2oDIn1MSdtaLsfe2hb9CoJQrY9jpCl+fRkKgbBK4J/ujCmfE2ubNWZGyAjzMnu0V1biA6z5JaksAaB7sEg=;
 7:xUqtv9+XHuncRcF60Yl1UtcaH2VDSdVDSS2Z80HRTAZv1/F4cBhIxt8YIebaSK3D4Ft7/bz3ouT+2bTcs1q0L/pq/mHqwy7Lcp9gLEG3saNb/MGm8FEdVZAhc0OS0gPCcf1HjlhgRbZsha2Yd0I3yEkgfEg8eSnRd58H2s/L+TK4wVPj2ReoTc+NN0PQAvC9EXCq2239LY6qNTHHhHhJlcQZno4vCnAcWK+1a0OHrE80oS2Q0ilzWLL4pEiiDlTI
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2018 17:47:43.7106 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16c2b108-06f2-4c6d-17e7-08d57f9c8a63
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3650
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
Cc: devel@driverdev.osuosl.org, stuyoder@gmail.com, horia.geanta@nxp.com,
 roy.pledge@nxp.com, ioana.ciornei@nxp.com, linux-kernel@vger.kernel.org,
 nipun.gupta@nxp.com, Bogdan Purcareata <bogdan.purcareata@nxp.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit 6bd067c48ef ("staging: fsl-mc: Move core bus out of staging")
moves the fsl-mc bus driver infrastructure out of staging to
drivers/bus/fsl-mc. The next step is moving a couple of tightly
connected DPAA2 objects - DPBP (Data Path Buffer Pool) and DPCON
(Data Path Concentrator).

Patch 1 removes dead code from the involved source files.

Patches 2-3 handle moving out the mentioned objects, one at a time.

Bogdan Purcareata (3):
  staging: fsl-mc: Cleanup dpbp and dpcon API
  staging: fsl-mc: Move DPBP out of staging
  staging: fsl-mc: Move DPCON out of staging

 drivers/bus/fsl-mc/Makefile                        |   2 +
 drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpbp.c  |  71 +-------------
 drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpcon.c |   4 +-
 drivers/bus/fsl-mc/fsl-mc-private.h                |  87 +++++++++++++++++
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h     |   3 +-
 drivers/staging/fsl-mc/bus/Makefile                |   2 -
 drivers/staging/fsl-mc/bus/dpbp-cmd.h              |  54 -----------
 drivers/staging/fsl-mc/bus/dpcon-cmd.h             |  53 ----------
 drivers/staging/fsl-mc/include/dpbp.h              |  63 ------------
 drivers/staging/fsl-mc/include/dpcon.h             |  79 ---------------
 include/linux/fsl/mc.h                             | 108 +++++++++++++++++++++
 11 files changed, 202 insertions(+), 324 deletions(-)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpbp.c (73%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpcon.c (99%)
 delete mode 100644 drivers/staging/fsl-mc/bus/dpbp-cmd.h
 delete mode 100644 drivers/staging/fsl-mc/bus/dpcon-cmd.h
 delete mode 100644 drivers/staging/fsl-mc/include/dpbp.h
 delete mode 100644 drivers/staging/fsl-mc/include/dpcon.h

-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
