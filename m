Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3223528-1520949167-2-14205929089673499901
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
    t=1520949166; b=s1w2nPgJ17YK/5nx9a8tC/1fwvOrW70/YbBcXakd5Hy2AA1
    fAfDQ530cYPVKgjWRnbqtcaeS2r55Jll6vjiMx1xx54qprAnxJUiw5RL3qgIrfDH
    GvI+Ps0RZL7d6IyGnHZELXngbW6IKyGxhun8Nzt9DUdXvO0B1V0IawYiya8DCUGU
    1/3wg5EHuzBAJiUtqlTNwlZiaxdTAX/6pVisj7ad67O/IMf3IDMf/Om/qOum4IQq
    GH3SC/X2MrTjmO+iBYyEVpurHVGcU4mJbHoU89nt+NHw9/XlBOcFVTn7BTK+zMU8
    OIMKpkHKjwuNkgr00dnrxd9m1K//yd1OPE4cVwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520949166; bh=6
    tK92p0RliACFZj57WqCzSWAk26/zqPsBk+3NmkTLHY=; b=nNhTFhsBIMiYig5Py
    /72L66eXQlKZbqeOyTmXDLU6BPQkzLgkCIX9KuSJoysB/jYPw4wvrqgGQIlSf7Yo
    f5EkK5+pKL1BrqSUrG3g7pHEm0YZoyY3/AyY/0/ogbp3Z2CPfcGAr79zB8Di9Rp6
    wan5upCnZ1Tp42pbm4LlbzQU9WHtxcOhYusZtopbMlywilEuYXByEsJdh/qchOtM
    QR+HvgnFABZN5wsY6WW7rVDWqFcpzVMNyv5qKX9gn0UhjI53A4LM1YVD5bcF83Ws
    nXKAFFCF1OcInXl/ounWWsdrb0FFfXSBInxQ/ZOF32zxFpFeoC3CeocOu+D4l0O2
    az17w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=k+efnJoo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=k+efnJoo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
Subject: [PATCH v5 5/6] staging: fsl-dpaa2/ethsw: Add README
Date: Tue, 13 Mar 2018 08:51:55 -0500
Message-Id: <20180313135156.3322-6-razvan.stefanescu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: d137c3e8-68f2-4b9a-b0d9-08d588e9a4f3
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);
 SRVR:DB3PR04MB0747;
X-Microsoft-Exchange-Diagnostics: 1; DB3PR04MB0747;
 3:CGkebtV5nz7H6i0r1jfOR9zOE0geSQvzLfLEY3u2nfghS4om5OPWXCj+ANN2B+V/fY2eLA6Hxv692C2pYaWgufJqGP53QTkmW1BCaiF986imvr66U+oVHOfAZjcQeSjNFWbTSGjPUJbkQijxC67UoWujSwIQc3vovoo24BYjBDjKiH8/4HjDlxFsaIwVE4l7vAR7ONrDZ49dAEk9tXXluFjnTclaVJFRI7dj3aN1Ic31ScPTJ3l4otmDnIuW1OvX;
 25:ecS9q5qd9tSLf8BwkbCjDRXWVfCD+mZIsx9U2jF34/i5cK8karudbOFbDw7CuJuGnBea2s+w7JtCojG22telPHZSCIs8QGjX3iVEkJjXFDBiEzz6B0AIqx+wABx0rLyfuqJANVnzy+yJJwBOVXlKcWZxGDEduv01qKfI3ps89UEXaEy4IZRE143LRdeUMTKGTq5vYSFRfFywDC8CkxpQ1TcpYPU1TxR8H3/XDdZEW0NWDaXIOhnubsD+u3VtMGHQ32L/NLXjTULW16YKm81jDruokvuQjCUhFu3xhnWn/Ca/vGhU94D97Gdwp5H/X7HV5fYy44Fxub4rue9Z8oroAg==;
 31:BZX0fuhjFa0QUZRkeNZuiiiU1IIdmzvftO9IPmbLMvbllfscXzrOJj9oXe9zkOWieb+rMIZZ1bNRzSBzCBqw2bT9w7chTNf2gRljK0nW3NRB49ZCfljkE3khc+APWALknCtbRW1yC7FAanhUV9hE3YVxh8WVfemLTIcOa1p0g23GYBeMZ8Hmm0bAi2knWPvGiAo/ENzlBjnzJ/Pybm9NIxcdkvPzWCpCVNpQPiMqXP4=
X-MS-TrafficTypeDiagnostic: DB3PR04MB0747:
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1; DB3PR04MB0747;
 20:J0q8uct4Gh4iR0J3gqA8blJ5tt9mHFKu2zDf4xEYsq5Kx93g/NTk0dJJCc6UODvwrknKKMfce95vOX+j3t/s5OWaTkY+FwV0MWPwH8/+VIonYlBuWFTAsM+vqSAaihzO7unD5ChrmJblhhekWbF++tmNja3VeKeqhSPMNhUtizQRkNrJ1QmfpA7UikxndW5D0hGLztqVgibYpOLsQvvN3IOQxTTfTtnlARCKLp7nWC4m7KsfcfYy+VwnPkJV55CekLtrF8vbZ/0izWPoi6qZawpH3ZAwKLcx7aeHpNF8QNregV4kjulldXN2l9UPt2LZfS5u9ZzfcXp7ROUwYar2dCLFcDOWwKF7Y38hf9x/C3RlOGRgJyOQzd+/9FvxKgtoI0QOxeOQqwn1du7Vy1w/LEFAotV36mOCahRsfuOcmUIbh6vYzKx3X3Qo/0ZWLEGQW4mnbs0khXU0rbfS2SAKduQ1VjWyjpmtNwc8uziF/ZCBl29ycLiL3S0SFp4Za5Po;
 4:2KiFJyB4ILsxPEDlrKlG0fY6ZhC5hRACL895LJBQQHpinXcLKkBh2YJu+BsK/GGbxL9GPjN6huHAKF0tQZJW2rlS5NfFfe1oah0r9OJoUKd7B1XiHTilccZZ+51HgHSNisEwWUXdsH1gZ+owv9umL2e6HW4W1qX3TMNXQoAn4jnYnrJlnRmNjBp2Xx/Vo0YrxHsjhqhYVerqSxLPwHFM67zVoDkquqGJdMmF8tUa9HqG+rQsI+OjZz1ZxcbyskRxyzNJGvHZIZR6lc3ut+K8L2+B805LWBNeQu4j7bMbqXj5YVtj8ikWWfMdAPdvZ+Oc1ZtfI4SmKLwHxLAEVvoJpwLskOrjxrM0lLcWQRm1ZEI=
X-Microsoft-Antispam-PRVS: <DB3PR04MB074738DB55C74A1E88F8E946E6D20@DB3PR04MB0747.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(227817650892897);
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501244)(52105095)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);
 SRVR:DB3PR04MB0747; BCL:0; PCL:0; RULEID:; SRVR:DB3PR04MB0747;
X-Forefront-PRVS: 0610D16BBE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(376002)(39380400002)(366004)(39860400002)(346002)(396003)(54534003)(189003)(199004)(1076002)(16526019)(186003)(6916009)(5660300001)(478600001)(50466002)(48376002)(3846002)(6116002)(8676002)(47776003)(6666003)(26005)(2906002)(7736002)(81156014)(2950100002)(66066001)(81166006)(6506007)(305945005)(76176011)(386003)(25786009)(50226002)(52116002)(86362001)(8936002)(316002)(16586007)(39060400002)(36756003)(51416003)(106356001)(68736007)(6486002)(53936002)(2351001)(2361001)(4326008)(6512007)(97736004)(105586002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB3PR04MB0747; H:rhuath.am.freescale.net; FPR:;
 SPF:None; PTR:InfoNoRecords; MX:1; A:1; LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; DB3PR04MB0747;
 23:W7k1xIwENWA2hBKdjXgmcG9Plc7bQn55E1aWuI9Qu?=
 =?us-ascii?Q?x2HrcqEkjhCtrRt0quISHLe2njhNurfaaLpr7U4zwNfToxSkv4yXVdSDllWf?=
 =?us-ascii?Q?DUD/L+WCCUTG+lI2GA6jSA3YyxOF0n0+s2NAlAS20QZDylw7WeeYu3StURjK?=
 =?us-ascii?Q?vRmtz360pixqOtre1OlGsIcD5Q2wcQv6Tpg5ffEY7cMp6J2sKUZPNIgB12aS?=
 =?us-ascii?Q?jPV9lk9NykHsieaqTys/n+IWxnR0KyrFVFtru+mRbMTcIVEdaOrdqmPBndRA?=
 =?us-ascii?Q?VQUHkWbBv6x+DDrd/TvQ5qqvBvZEgWDYQwYQp32vH+a4CwVOlnX3njaST2F2?=
 =?us-ascii?Q?IEUsdknSEw0QqDpudfAIO3n59Ix3lWwn4XVbAc0+5VjvtpRv7bMozCME+wLf?=
 =?us-ascii?Q?56mdw0CYbqczeInM+xqX0XeZ1BjBGuAszb0UqJ0gxjLt+PGU6vavjIwJDhRg?=
 =?us-ascii?Q?FYwkvfNzhtJQGn/0p65mX8beSVzHtXbuwaATH34NvIf+0c+BzrQjuDxxxz0D?=
 =?us-ascii?Q?Xs+H+WKoW3aGdCoOWn8j1glLcCFNmN6XURMqcbkSt3UtfQV1XrjjDGH2I+6s?=
 =?us-ascii?Q?m3CU4nAX17R8qBxVu932oC+GFcSOo2b5VU3yZKf0klhL6mMZebR7qFXwZ1YC?=
 =?us-ascii?Q?gNiQooHpNm5HX9FO04UJdQlI3FZquLqilbCF3B7nlNPM1NXra8RGACA8AflT?=
 =?us-ascii?Q?Qyftp/0LfLpLiUNK9BK9dBZ4mINIVeF2c6jnUWtzjwunjRoUSew+/wIIxo+J?=
 =?us-ascii?Q?7O0VLq/1iet1LeV9EIKBYZdzeZ8Z1UzcYFIT0HCijsGgCXamQ5qRc2VU4iQe?=
 =?us-ascii?Q?Yfts+kRqG0ZLvJsfsxdD+1ITbSL7KFnO2YisLwukhKrK56OvJ55UZcbnCzEC?=
 =?us-ascii?Q?TBFiWeWpgg/xW8g0NVoZOXFuso5g7MpeiVlfcLD3vi19gb2xBhBXd6DX+q5V?=
 =?us-ascii?Q?R3qptVlMQvUvc9AFmuDn4hAR/Bh1Xq7H2odlZUOUxl+TUecKi+nq4xNsN1OA?=
 =?us-ascii?Q?cV/VXEn2b2/s2K8XDRYyue8A8wvpiBOgqKsFSVyZiUvlA/RSx6NYRtz3hdL3?=
 =?us-ascii?Q?XWygljxb1zjC93zHKULmPpCgRIMxD6ikqpQgIHI4cypRpNzPEuk6njsZ+kEA?=
 =?us-ascii?Q?YvMkYZB6tTPftRcU3Y43nU0bZP8fdvbp+x1geRCcPjNiTuLxlTFLSd9citQb?=
 =?us-ascii?Q?hwd3fCGxK/hn3RkUQbrPDKnZGT4J9pKzXcQ?=
X-Microsoft-Antispam-Message-Info: nSznQmn51pShwnF4zBfdvFJveUI408vV396DZOHNynAKxe1pY4dp8IJyQtDyYCUX/JHPTxmRaptqGn5ao3/mmLYs2z8q1HTBnkwopMsYBK3K17Ptk5cI2kFIN5vxw92JdeT1IDIfBfCCqxuvtvNCOTflaF4ucaPIycgwORiDbg0IH7/8I84p3JJG9TDOmklL
X-Microsoft-Exchange-Diagnostics: 1; DB3PR04MB0747;
 6:b54+c0kf/4ELv08ZV4/LsIbfjxqB7S8duNTsy4a9/XtZTSPvzobusbjN4lcht9GtjK3C7lwB44VGJX2bDoSIo1ZFSPbcOqudwsBu+RAMl2fJ+UfV/oogsU6B/jCGEhYthkfmwpZ0yJ+vAD8BBru1KkmSkHegCAWLIPBlASTx5wk+GE3NdSGuyrEQUgBC8wFf6TOjHYqHWqJc2jP4QTvplOiIHjIL2N2RpcOdtGSL4r41qCEy/4zr4sRhpX8292jYBN26oZmR1nWW8p6FlpWYJqbxmwbsXI/gGTNJ+PeJgFfojaiYPADRbccTHDQJxUEHSF7E2/P2uq/6fPpXyee9GYdDbPKiDQH8OSkAI8pUxpc=;
 5:B3JGQQuN15fao9F+XdcKV07Y7WfCjzyu9NkJ4vg8nt7Pi2zJ4y22dJzuVEvYwp9VFAX97RfX0tGkZMk43v39qgfsTYNgBJhbVgvoiJkfJtqXPUzH/cYMb26x9DR8LX/6XY+M/DSh+O9ViRvBY57zmVtq+DGWa3N0YuzIftEGT/A=;
 24:kvGkxwSA6YPKSkY0D8WmGHpn9e7gZPMix/bmytmPWQ+Zf2Xu2R0Gsv7gNDvafP4dLVKPdU7Qtoop0hG4CpWNOFEleyosiW8KbuusrIUrHOE=;
 7:7YP7Qutk9gkRSvnJB9fRrthl7JVAYdSaxL/pkWJbB7uPd2g32GtVx2Iyel663ZdZqJ1uCg4qZVAxYAUWqxFtT4k7zEkDrFJmn7se/AUrMzlEuXk+igKRcEDRniuODc44GRFXOtwhN0ZUgNR4dvsNBxQwNTa/Tm4Dz48SmCaMqeR5Ncrln6McPA+PLMf03EOCMlaP4ld23TrUAhui+2bVCDLpGyQILa6+PGkR0HvbgF6KgMXoHpWLR/rxgZ4TNGTg
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2018 13:52:19.9140 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d137c3e8-68f2-4b9a-b0d9-08d588e9a4f3
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

Add a README file describing the driver architecture, components and
interfaces.

Signed-off-by: Razvan Stefanescu <razvan.stefanescu@nxp.com>
---
Changelog:
 v2:
    - no changes
 v3:
    - no changes
 v4:
    - no changes
 v5:
    - no changes

 drivers/staging/fsl-dpaa2/ethsw/README | 106 +++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)
 create mode 100644 drivers/staging/fsl-dpaa2/ethsw/README

diff --git a/drivers/staging/fsl-dpaa2/ethsw/README b/drivers/staging/fsl-dpaa2/ethsw/README
new file mode 100644
index 0000000..f6fc07f
--- /dev/null
+++ b/drivers/staging/fsl-dpaa2/ethsw/README
@@ -0,0 +1,106 @@
+DPAA2 Ethernet Switch driver
+============================
+
+This file provides documentation for the DPAA2 Ethernet Switch driver
+
+
+Contents
+========
+	Supported Platforms
+	Architecture Overview
+	Creating an Ethernet Switch
+	Features
+
+
+	Supported Platforms
+===================
+This driver provides networking support for Freescale LS2085A, LS2088A
+DPAA2 SoCs.
+
+
+Architecture Overview
+=====================
+The Ethernet Switch in the DPAA2 architecture consists of several hardware
+resources that provide the functionality. These are allocated and
+configured via the Management Complex (MC) portals. MC abstracts most of
+these resources as DPAA2 objects and exposes ABIs through which they can
+be configured and controlled.
+
+For a more detailed description of the DPAA2 architecture and its object
+abstractions see:
+	drivers/staging/fsl-mc/README.txt
+
+The Ethernet Switch is built on top of a Datapath Switch (DPSW) object.
+
+Configuration interface:
+
+          ---------------------
+         | DPAA2 Switch driver |
+          ---------------------
+                   .
+                   .
+              ----------
+             | DPSW API |
+              ----------
+                   .           software
+ ================= . ==============
+                   .           hardware
+          ---------------------
+         | MC hardware portals |
+          ---------------------
+                   .
+                   .
+                 ------
+                | DPSW |
+                 ------
+
+Driver uses the switch device driver model and exposes each switch port as
+a network interface, which can be included in a bridge. Traffic switched
+between ports is offloaded into the hardware. Exposed network interfaces
+are not used for I/O, they are used just for configuration. This
+limitation is going to be addressed in the future.
+
+The DPSW can have ports connected to DPNIs or to PHYs via DPMACs.
+
+
+ [ethA]     [ethB]     [ethC]     [ethD]     [ethE]     [ethF]
+    :          :          :          :          :          :
+    :          :          :          :          :          :
+[eth drv]  [eth drv]  [                ethsw drv              ]
+    :          :          :          :          :          :        kernel
+========================================================================
+    :          :          :          :          :          :        hardware
+ [DPNI]      [DPNI]     [============= DPSW =================]
+    |          |          |          |          |          |
+    |           ----------           |       [DPMAC]    [DPMAC]
+     -------------------------------            |          |
+                                                |          |
+                                              [PHY]      [PHY]
+
+For a more detailed description of the Ethernet switch device driver model
+see:
+	Documentation/networking/switchdev.txt
+
+Creating an Ethernet Switch
+===========================
+A device is created for the switch objects probed on the MC bus. Each DPSW
+has a number of properties which determine the configuration options and
+associated hardware resources.
+
+A DPSW object (and the other DPAA2 objects needed for a DPAA2 switch) can
+be added to a container on the MC bus in one of two ways: statically,
+through a Datapath Layout Binary file (DPL) that is parsed by MC at boot
+time; or created dynamically at runtime, via the DPAA2 objects APIs.
+
+Features
+========
+Driver configures DPSW to perform hardware switching offload of
+unicast/multicast/broadcast (VLAN tagged or untagged) traffic between its
+ports.
+
+It allows configuration of hardware learning, flooding, multicast groups,
+port VLAN configuration and STP state.
+
+Static entries can be added/removed from the FDB.
+
+Hardware statistics for each port are provided through ethtool -S option.
-- 
1.9.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
