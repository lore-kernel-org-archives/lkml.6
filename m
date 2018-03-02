Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1258868-1519986288-2-15313060566588391992
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAD_ENC_HEADER 0.001, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enrofr,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519986287; b=E7QINAt8EeGpi8bOMjOIWaM5iH0e1sJo2me9yvERTY3Y7lX
    rsYXAnGo19oINTLxBjk/ZKc+oUUu4kDG/F/JWXU1H2zEwlUMNUdBodYHYAJPIFls
    ERwv/Pc2Ztg+Dd8/qQXIle8c2m9lSoauzppucrnBASzG7c4UezwdVxhVDpmU7dF5
    fm3Zs0Nb51mYte+w8iVq3LlreYC5zB3nvmTq7twAzawqKo/4gceDIgEZrs7zB6eC
    I9vpw9s9kKjSqC3KY3alddCJgJcd7jiMDQDIGltnudGx37e/fyIk6IfQL2Y0biUA
    tz+EnOVUCBuXIbG7fss+NFH/s0sQ9l//BCK45Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519986287; bh=F
    9eho5K9Tta+H5Bu3S3Sg88+kFu/Kq0pKeF1Q612lz4=; b=gyXhI9DFAXP2fPtd+
    67kdkohUPxErqXlgG4EUdrCAaRTvyL48KPzoXYBqpEzbKPZvCNKPnsaP9dkEkQNR
    eZ3QzF838QnKYoSp+FCL0C9r4zzME2xi2EjN69V+P2kvqb9G509mUcHtfSrRQNiY
    vYBGnxhg8NDEYREGA/1AI7u+3Ac08Apa5VjfckGW4Nqq0lQXmi2WNoc4PjxiS9MF
    OuipS0KCC5zkjZBACZUQEw1x6RD7dxPWOyuLljU+tMEVRbllaMBaWoR4ojZXSiF3
    R0/v2n0S+mfF/VXYZJDEwi0CU2Cns8PbQNBEBEy5b5Dt2Jvo5LJR7t0ILkmp1Oka
    L/YiA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=I4H6vujf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=I4H6vujf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=bogdan.purcareata@nxp.com;
From: Bogdan Purcareata <bogdan.purcareata@nxp.com>
To: gregkh@linuxfoundation.org, laurentiu.tudor@nxp.com,
 ruxandra.radulescu@nxp.com
Subject: [PATCH v2 2/2] staging: fsl-mc: Move DPCON out of staging
Date: Fri,  2 Mar 2018 04:23:59 -0600
Message-Id: <20180302102359.16979-3-bogdan.purcareata@nxp.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180302102359.16979-1-bogdan.purcareata@nxp.com>
References: <20180302102359.16979-1-bogdan.purcareata@nxp.com>
MIME-Version: 1.0
X-Originating-IP: [192.88.168.1]
X-ClientProxiedBy: MWHPR2201CA0055.namprd22.prod.outlook.com
 (2603:10b6:301:16::29) To AM0PR0402MB3649.eurprd04.prod.outlook.com
 (2603:10a6:208:c::32)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 505ed8df-b3d9-4edc-ad3d-08d58027ca63
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);
 SRVR:AM0PR0402MB3649;
X-Microsoft-Exchange-Diagnostics: 1; AM0PR0402MB3649;
 3:61jV9DXU2LW3IypHYsMqgMiAOE7WCERHoQbWwtGT33MNz1BH7UFCEpVfhYWAOsQZba1LnH2koI5kbS81JKA+oSwuQBZhp+Gr4/jHmf18xf7MmrHGjT7m2v/MJqhnQK5c/QJCB9opE+9tgFKSBfOra4NpSCpVIMmI92/l+6ck/hCgnS/3zkfzSMaQtKz2wQVP+oRSU1zuqU9K84sHD/Sw8unE6XDnvhowWm0L4fcQsAJK5AnA7M8kE7Ah7jNtR/V9;
 25:kHPdgKzVeuND9TdyOVtCdDJemFQv9j51vtBpq0xrgvbx59uf4HAOFmMEqkyDlwpohtp50NjBhrkzi+Znr/hvRMxwFuAsJiEPmb2KHh5jt8UQAn2P0o3xD0JTkZULmFqZmIE0+zEY3wi5zIx1Ul5v5udQ3OLDttwF4FhDuVh5QTS+sqovEV/N6ebcUrp8iFJigEGikPMDzZx7aBUkTWpn2qj0jgoCJAmm/2DOaaFfwpb5JVIyF2RWWEASinE5SBLqRvUPZ04MifTe25RiTvKSb3zdqnGoEG4RlVYTFEtLhAq3fwgk7RBhwxA/uzM5nx9dMRSohtfe2tAgMPnxWdjFwg==;
 31:5Fmilp4CiHWRZtXXMOcW5XijbENZT8FTdRzWN3T6yWuJp+T6DAHiSyFtPjAe2JF6McF173GsMEgWN44esh6UxUmeKoBgBP18bGvSN3LQaviTRIND9Y21ddnFI5/BcFS0/2cjfPw9c35iqDqcQjr1UxOWvQ6Z0EPbQkg323NqnQrGlJOlCOBRKH1FXKxteIT1ooVWwNPeNL+a7u2aykJLMkdZzD6NdBSB5BmhAcfqiRY=
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3649:
X-Microsoft-Exchange-Diagnostics: 1; AM0PR0402MB3649;
 20:HczjObj8JDuU+a0etgyRhZkzYSA8htLJNR6wwfERB7Lj/GI+HjK1uHmvvb+AhFAUwO4BzLb2BeqbSl7aV1smw0t7MyjUqTlxM5Tbo0mLTKJVcUvI2heO7fsr0qyHYLBlPd6DGp0Bg3mRNQ67PmZAKG7J6tfj61HL10IsvsMxz12AU+7cCyr+M/4TupfltaYIt+KAU1fS4GYTLXWafDiZb2f91Iu8y/LZD+0fZ1NtF/7f7L2XA60KNUFhqyuc8D5mkCT6mwH2V7YpqvO8DHQiMXaznO+FedKaZVI9lloBgNP8DYscQ0Z9Cq4eN0/hZY/3qD/IdAVo97kUB4hPYeKHWMlClQ9kETMCrIAE/WN7e2wVWNtgNBYsllRdmvfM02WBU+aXMpbg5K59kDX8QJHvVRF2rvgLwZmPoajTSc+8QisZ7T1wsUXppf9yEgg7m1St1MDTX9QTApsxvyYBxCQh/Rqr+CIHUfGNHT+0jthPmKlET1JsmmdFrzBdMDRBc8DO;
 4:5y3KWSh9USoQAgJmMnHaXxYQfDtjDdj79LmjqHlrwJI9LNvSduqGINUuUUX4vSeZ+bBczBOBLqL1KskLMnXLhaEN5Lc0SGAhw6JKiiGlHZtlLsBYBqy9VplKtH4pPYXpxoxv37KPNzT27A8tduZd4JnTU830ZXc1wihaPc3rwFhdC++kf/BNCWhDVUBuPMdQkujgv70/uN3xKrVyRHcuj1/crEdMAY99aIktwRQyEU6f05l8tYGWOpglewindbNFXidA7mDgpl4+Sd9ZUkbfGqAq4YpJwVfjvJy3+qJlg6DXQrKJdBRreoPCLAB9fN6w
X-Microsoft-Antispam-PRVS: <AM0PR0402MB3649B991749DD78A6130C859EAC50@AM0PR0402MB3649.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3231220)(944501238)(3002001)(93006095)(93001095)(6055026)(6041288)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);
 SRVR:AM0PR0402MB3649; BCL:0; PCL:0; RULEID:; SRVR:AM0PR0402MB3649;
X-Forefront-PRVS: 05991796DF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(39380400002)(39860400002)(376002)(396003)(366004)(346002)(189003)(199004)(81166006)(16586007)(86362001)(50466002)(48376002)(53936002)(76176011)(106356001)(6512007)(5660300001)(51416003)(25786009)(186003)(16526019)(68736007)(50226002)(36756003)(97736004)(478600001)(59450400001)(52116002)(66066001)(39060400002)(6116002)(3846002)(1076002)(386003)(105586002)(8676002)(81156014)(26005)(47776003)(4326008)(8936002)(2906002)(316002)(6636002)(6666003)(6486002)(6506007)(7736002)(2950100002)(305945005)(473944003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR0402MB3649; H:rhuath.am.freescale.net;
 FPR:; SPF:None; PTR:InfoNoRecords; MX:1; A:1; LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; AM0PR0402MB3649;
 23:RZ9pwszf0/u1KszZmev8YqI75fYh1BFFFLHqYW8?=
 =?us-ascii?Q?dPI5xTt7TqMeUWB00viRR6AAYnBWtvIzJo04VNjjO0nuYXo9EJwGx9W0tq2r?=
 =?us-ascii?Q?smgc7NIh3fMaKzS0s3SIRVkSJ5JMLkSGsAl5qA1YiUJMRPSRdDC5MiIiR42u?=
 =?us-ascii?Q?g31yRTJOXBnYk0ZAD1SbGMA8ps7xzOhr/9YsABsU233iJ4AxFcP7shuB0ome?=
 =?us-ascii?Q?9E/g/z6BNySELl3QZZgUv3Uzt1UFTEXYIFpMYxuaVEgYPQtJzfJQ1Fa2Se3z?=
 =?us-ascii?Q?ErsUt7q4QALLrwAyMgsgzQmUSBqV0XLPeW1nB/NUNkGa9TsPWPl3h521N7Wa?=
 =?us-ascii?Q?JJgkaLWRStUDJXzFGCP9SyZOlHy+cTY7EDKaf/hoIx3/iL0kE6w9JXlel8cf?=
 =?us-ascii?Q?iIdswT+f1vqR4AQP5cHw+Z9oBZDhk3hn7RzRDaMfJOrphCgCRCxTisLmgQRv?=
 =?us-ascii?Q?sMCkrV/E7HGI/lJXJ+MSHlQW9IKDZoXAQZPnej30HEfU5BdT+gaRunVeOfOw?=
 =?us-ascii?Q?xpGPf5+agk94Ta3VJk0e4UStMZG0qDzVsQlAu/tb3Lg5Mz7QvM2Au/PxdBkB?=
 =?us-ascii?Q?ZF44eaXbHpKge3ADjDphFJUN7xOjcrEXQ8UdgZiuUMJsAydqRlOJevYctXmX?=
 =?us-ascii?Q?dhtSkJJtjwl5AjO2CSPQMc9phMdM/SqHUxs5xKuxZzHYV+aWRDCbOfZdU7CM?=
 =?us-ascii?Q?rLUvZ0aiZgZUwjAsoulaI0prqp5gJxRiaWh0QKs1z5RZs5NSBvDpQBBpvRTv?=
 =?us-ascii?Q?9UtRUBpjfFmoH4h/IhlKSRa9zJ4T7LNE17fhiH1jwDfBHtcKkVJw0v71Mb8W?=
 =?us-ascii?Q?JKOzOYeXlmlB5qmTw/25QJ5evu1mjMFN5TUtr1ATe+2cCzWC1Z4muR1zpK63?=
 =?us-ascii?Q?bvGf8WqiGR/rBCy+4xrtHBI05nVmp7CCdS1haI/sgJzD0GtYcAkboCEgpOBB?=
 =?us-ascii?Q?MW5r1dESGQiooth5nKhK8U1s6w0QbbX4gihI5DR703AC+irIn3vzAEZynfXP?=
 =?us-ascii?Q?pCv9D9RkYlsxqLDjAWByt71dJ/JmZQgWfUvKW4blL8ztbFW+Ow6UCwyYm6yu?=
 =?us-ascii?Q?xDwsUPlVu/O1uZdoTRhyIPAhf8RHMN25o733+fz+wANiZGzHlpTfy4FaL9yx?=
 =?us-ascii?Q?nhMldAZiYIi+OymZD3NPo+83iQu6sRC4sP/TYAjC/jupsLpfZ5uwk4IWcSU9?=
 =?us-ascii?Q?g1WiDr7l+syPH7vWLSLbS55/HptqMl1NCzzyk?=
X-Microsoft-Exchange-Diagnostics: 1; AM0PR0402MB3649;
 6:LdkdRTG05v3KwosV7j9cAdrH1/Nc/yCJOZxJhQgu9nSzzo0q6XMkbFBTj2U6odEzLe9msjC9ZN3PstZK6lVQb078BWNvlCpSGDhpSFHfYye4kfeds/g1bxZ096TJ2AEVh4CwQaH+Uenef2XIFhtAijG584rvQoz2wJF2Qs5rfBxlVUCM7tIkeqnHdAxM5980M9OENhIRExXZHgYM6QbYk+hep4WXyc0IMUJ3K0k8v/wM2M48hu4NAZ9oCSGnmplrsFv4PYi15dIlAfD8BOFCiolQcITRjcg+DyfOK+zBx2TwuDh/R5bi6IaCjY3rkKcJjB0z/dtGqkUYDlL9jt4TBRIbVzBZ8hdMhTLeM3vZGYI=;
 5:dXbTiMlBCINBJyjCItYkX50xiZPjiFtKtIijoaO6LhOL85zjIU8GqFy8ocmqWovHBma21X5/zm5CLWHexe2kD7dQkRMj5pYTVHOjM3R0ra2r5EUuhsrfdHLBh8x/MZvP614nAVvyawQTHn91SHBMAJiCb+9U9ALw/Q6LnWtg+0E=;
 24:d85ZOGwcqdO3+JC7O6I9NnobzOvVsHunornH7MF/hhV5ggqVVSGIrzbOTrJFuhjd/YZPYchblY+3dfMmo6SvwJRv+4mVpZIjh7NGrz/iD7U=;
 7:IjpBKlZewnIgP4rffhdrgB9cCJicZmPgCS+MIlS+ZzmvCqgA4i299XJW+nkVmWAoUvNEzYSGMFdSkZ4R62Kv5AEKowWx4hMCw+iZGd3lZeM2NuUIYrDQqHm/G6wWu/pDpqpTbUK7DB6ktUc9bnx+NtN37lZSfARQuZyy8YeIVMbwjcoqq7lP2gTJAlmWi7qbh4uCDXL4QdCptt3Q2kD0/SUlUW7+r2nw32nZEDa2vM7vup5ISd5bvffNGdq6VlmH
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2018 10:24:30.1965 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 505ed8df-b3d9-4edc-ad3d-08d58027ca63
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3649
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

Move the source files out of staging into their final locations:
- dpcon.c goes to drivers/bus/fsl-mc/, next to the core infrastructure
- dpcon-cmd.h gets merged into drivers/bus/fsl-mc/fsl-mc-private.h, next
  to the other internally used APIs
- dpcon.h gets merged into include/linux/fsl/mc.h, exposing the public
  API

Update references in the dpaa2-eth staging driver.

DPCON stands for Data Path Concentrator - an interface between DPIO
(Data Path IO) and its users (e.g. dpaa2-eth). You can read more about
DPIO in Documentation/networking/dpaa2/overview.rst

Signed-off-by: Bogdan Purcareata <bogdan.purcareata@nxp.com>
Reviewed-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
v1 -> v2:
- properly refactor #include line (Laurentiu)

 drivers/bus/fsl-mc/Makefile                        |  1 +
 drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpcon.c |  4 +-
 drivers/bus/fsl-mc/fsl-mc-private.h                | 48 +++++++++++++
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h     |  1 -
 drivers/staging/fsl-mc/bus/Makefile                |  1 -
 drivers/staging/fsl-mc/bus/dpcon-cmd.h             | 53 ---------------
 drivers/staging/fsl-mc/include/dpcon.h             | 79 ----------------------
 include/linux/fsl/mc.h                             | 66 ++++++++++++++++++
 8 files changed, 117 insertions(+), 136 deletions(-)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpcon.c (99%)
 delete mode 100644 drivers/staging/fsl-mc/bus/dpcon-cmd.h
 delete mode 100644 drivers/staging/fsl-mc/include/dpcon.h

diff --git a/drivers/bus/fsl-mc/Makefile b/drivers/bus/fsl-mc/Makefile
index da26e52..3c518c7 100644
--- a/drivers/bus/fsl-mc/Makefile
+++ b/drivers/bus/fsl-mc/Makefile
@@ -10,6 +10,7 @@ mc-bus-driver-objs := fsl-mc-bus.o \
 		      mc-sys.o \
 		      mc-io.o \
 		      dpbp.o \
+		      dpcon.o \
 		      dprc.o \
 		      dprc-driver.o \
 		      fsl-mc-allocator.o \
diff --git a/drivers/staging/fsl-mc/bus/dpcon.c b/drivers/bus/fsl-mc/dpcon.c
similarity index 99%
rename from drivers/staging/fsl-mc/bus/dpcon.c
rename to drivers/bus/fsl-mc/dpcon.c
index 021b425..a1ba819 100644
--- a/drivers/staging/fsl-mc/bus/dpcon.c
+++ b/drivers/bus/fsl-mc/dpcon.c
@@ -5,9 +5,9 @@
  */
 #include <linux/kernel.h>
 #include <linux/fsl/mc.h>
-#include "../include/dpcon.h"
+#include <linux/fsl/mc.h>
 
-#include "dpcon-cmd.h"
+#include "fsl-mc-private.h"
 
 /**
  * dpcon_open() - Open a control session for the specified object
diff --git a/drivers/bus/fsl-mc/fsl-mc-private.h b/drivers/bus/fsl-mc/fsl-mc-private.h
index 4ef8d7e..52c069d 100644
--- a/drivers/bus/fsl-mc/fsl-mc-private.h
+++ b/drivers/bus/fsl-mc/fsl-mc-private.h
@@ -418,6 +418,54 @@ struct dpbp_rsp_get_attributes {
 	__le16 version_minor;
 };
 
+/*
+ * Data Path Concentrator (DPCON) API
+ */
+
+/* DPCON Version */
+#define DPCON_VER_MAJOR				3
+#define DPCON_VER_MINOR				2
+
+/* Command versioning */
+#define DPCON_CMD_BASE_VERSION			1
+#define DPCON_CMD_ID_OFFSET			4
+
+#define DPCON_CMD(id)	(((id) << DPCON_CMD_ID_OFFSET) | DPCON_CMD_BASE_VERSION)
+
+/* Command IDs */
+#define DPCON_CMDID_CLOSE			DPCON_CMD(0x800)
+#define DPCON_CMDID_OPEN			DPCON_CMD(0x808)
+
+#define DPCON_CMDID_ENABLE			DPCON_CMD(0x002)
+#define DPCON_CMDID_DISABLE			DPCON_CMD(0x003)
+#define DPCON_CMDID_GET_ATTR			DPCON_CMD(0x004)
+#define DPCON_CMDID_RESET			DPCON_CMD(0x005)
+
+#define DPCON_CMDID_SET_NOTIFICATION		DPCON_CMD(0x100)
+
+struct dpcon_cmd_open {
+	__le32 dpcon_id;
+};
+
+#define DPCON_ENABLE			1
+
+struct dpcon_rsp_get_attr {
+	/* response word 0 */
+	__le32 id;
+	__le16 qbman_ch_id;
+	u8 num_priorities;
+	u8 pad;
+};
+
+struct dpcon_cmd_set_notification {
+	/* cmd word 0 */
+	__le32 dpio_id;
+	u8 priority;
+	u8 pad[3];
+	/* cmd word 1 */
+	__le64 user_ctx;
+};
+
 /**
  * Maximum number of total IRQs that can be pre-allocated for an MC bus'
  * IRQ pool
diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
index ce864ee..b8990cf 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
@@ -39,7 +39,6 @@
 
 #include "../../fsl-mc/include/dpaa2-io.h"
 #include "../../fsl-mc/include/dpaa2-fd.h"
-#include "../../fsl-mc/include/dpcon.h"
 #include "dpni.h"
 #include "dpni-cmd.h"
 
diff --git a/drivers/staging/fsl-mc/bus/Makefile b/drivers/staging/fsl-mc/bus/Makefile
index ea6479f..21d8ebc 100644
--- a/drivers/staging/fsl-mc/bus/Makefile
+++ b/drivers/staging/fsl-mc/bus/Makefile
@@ -4,7 +4,6 @@
 #
 # Copyright (C) 2014 Freescale Semiconductor, Inc.
 #
-obj-$(CONFIG_FSL_MC_BUS) += dpcon.o
 
 # MC DPIO driver
 obj-$(CONFIG_FSL_MC_DPIO) += dpio/
diff --git a/drivers/staging/fsl-mc/bus/dpcon-cmd.h b/drivers/staging/fsl-mc/bus/dpcon-cmd.h
deleted file mode 100644
index 27fa098..0000000
--- a/drivers/staging/fsl-mc/bus/dpcon-cmd.h
+++ /dev/null
@@ -1,53 +0,0 @@
-/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
-/*
- * Copyright 2013-2016 Freescale Semiconductor Inc.
- *
- */
-#ifndef _FSL_DPCON_CMD_H
-#define _FSL_DPCON_CMD_H
-
-/* DPCON Version */
-#define DPCON_VER_MAJOR				3
-#define DPCON_VER_MINOR				2
-
-/* Command versioning */
-#define DPCON_CMD_BASE_VERSION			1
-#define DPCON_CMD_ID_OFFSET			4
-
-#define DPCON_CMD(id)	(((id) << DPCON_CMD_ID_OFFSET) | DPCON_CMD_BASE_VERSION)
-
-/* Command IDs */
-#define DPCON_CMDID_CLOSE			DPCON_CMD(0x800)
-#define DPCON_CMDID_OPEN			DPCON_CMD(0x808)
-
-#define DPCON_CMDID_ENABLE			DPCON_CMD(0x002)
-#define DPCON_CMDID_DISABLE			DPCON_CMD(0x003)
-#define DPCON_CMDID_GET_ATTR			DPCON_CMD(0x004)
-#define DPCON_CMDID_RESET			DPCON_CMD(0x005)
-
-#define DPCON_CMDID_SET_NOTIFICATION		DPCON_CMD(0x100)
-
-struct dpcon_cmd_open {
-	__le32 dpcon_id;
-};
-
-#define DPCON_ENABLE			1
-
-struct dpcon_rsp_get_attr {
-	/* response word 0 */
-	__le32 id;
-	__le16 qbman_ch_id;
-	u8 num_priorities;
-	u8 pad;
-};
-
-struct dpcon_cmd_set_notification {
-	/* cmd word 0 */
-	__le32 dpio_id;
-	u8 priority;
-	u8 pad[3];
-	/* cmd word 1 */
-	__le64 user_ctx;
-};
-
-#endif /* _FSL_DPCON_CMD_H */
diff --git a/drivers/staging/fsl-mc/include/dpcon.h b/drivers/staging/fsl-mc/include/dpcon.h
deleted file mode 100644
index 062e90a..0000000
--- a/drivers/staging/fsl-mc/include/dpcon.h
+++ /dev/null
@@ -1,79 +0,0 @@
-/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
-/*
- * Copyright 2013-2016 Freescale Semiconductor Inc.
- *
- */
-#ifndef __FSL_DPCON_H
-#define __FSL_DPCON_H
-
-/* Data Path Concentrator API
- * Contains initialization APIs and runtime control APIs for DPCON
- */
-
-struct fsl_mc_io;
-
-/** General DPCON macros */
-
-/**
- * Use it to disable notifications; see dpcon_set_notification()
- */
-#define DPCON_INVALID_DPIO_ID		(int)(-1)
-
-int dpcon_open(struct fsl_mc_io *mc_io,
-	       u32 cmd_flags,
-	       int dpcon_id,
-	       u16 *token);
-
-int dpcon_close(struct fsl_mc_io *mc_io,
-		u32 cmd_flags,
-		u16 token);
-
-int dpcon_enable(struct fsl_mc_io *mc_io,
-		 u32 cmd_flags,
-		 u16 token);
-
-int dpcon_disable(struct fsl_mc_io *mc_io,
-		  u32 cmd_flags,
-		  u16 token);
-
-int dpcon_reset(struct fsl_mc_io *mc_io,
-		u32 cmd_flags,
-		u16 token);
-
-/**
- * struct dpcon_attr - Structure representing DPCON attributes
- * @id: DPCON object ID
- * @qbman_ch_id: Channel ID to be used by dequeue operation
- * @num_priorities: Number of priorities for the DPCON channel (1-8)
- */
-struct dpcon_attr {
-	int id;
-	u16 qbman_ch_id;
-	u8 num_priorities;
-};
-
-int dpcon_get_attributes(struct fsl_mc_io *mc_io,
-			 u32 cmd_flags,
-			 u16 token,
-			 struct dpcon_attr *attr);
-
-/**
- * struct dpcon_notification_cfg - Structure representing notification params
- * @dpio_id:	DPIO object ID; must be configured with a notification channel;
- *	to disable notifications set it to 'DPCON_INVALID_DPIO_ID';
- * @priority:	Priority selection within the DPIO channel; valid values
- *		are 0-7, depending on the number of priorities in that channel
- * @user_ctx:	User context value provided with each CDAN message
- */
-struct dpcon_notification_cfg {
-	int dpio_id;
-	u8 priority;
-	u64 user_ctx;
-};
-
-int dpcon_set_notification(struct fsl_mc_io *mc_io,
-			   u32 cmd_flags,
-			   u16 token,
-			   struct dpcon_notification_cfg *cfg);
-
-#endif /* __FSL_DPCON_H */
diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
index 66118e1..cfb1fbf 100644
--- a/include/linux/fsl/mc.h
+++ b/include/linux/fsl/mc.h
@@ -493,4 +493,70 @@ int dpbp_get_attributes(struct fsl_mc_io *mc_io,
 			u16 token,
 			struct dpbp_attr *attr);
 
+/* Data Path Concentrator (DPCON) API
+ * Contains initialization APIs and runtime control APIs for DPCON
+ */
+
+/**
+ * Use it to disable notifications; see dpcon_set_notification()
+ */
+#define DPCON_INVALID_DPIO_ID		(int)(-1)
+
+int dpcon_open(struct fsl_mc_io *mc_io,
+	       u32 cmd_flags,
+	       int dpcon_id,
+	       u16 *token);
+
+int dpcon_close(struct fsl_mc_io *mc_io,
+		u32 cmd_flags,
+		u16 token);
+
+int dpcon_enable(struct fsl_mc_io *mc_io,
+		 u32 cmd_flags,
+		 u16 token);
+
+int dpcon_disable(struct fsl_mc_io *mc_io,
+		  u32 cmd_flags,
+		  u16 token);
+
+int dpcon_reset(struct fsl_mc_io *mc_io,
+		u32 cmd_flags,
+		u16 token);
+
+/**
+ * struct dpcon_attr - Structure representing DPCON attributes
+ * @id: DPCON object ID
+ * @qbman_ch_id: Channel ID to be used by dequeue operation
+ * @num_priorities: Number of priorities for the DPCON channel (1-8)
+ */
+struct dpcon_attr {
+	int id;
+	u16 qbman_ch_id;
+	u8 num_priorities;
+};
+
+int dpcon_get_attributes(struct fsl_mc_io *mc_io,
+			 u32 cmd_flags,
+			 u16 token,
+			 struct dpcon_attr *attr);
+
+/**
+ * struct dpcon_notification_cfg - Structure representing notification params
+ * @dpio_id:	DPIO object ID; must be configured with a notification channel;
+ *	to disable notifications set it to 'DPCON_INVALID_DPIO_ID';
+ * @priority:	Priority selection within the DPIO channel; valid values
+ *		are 0-7, depending on the number of priorities in that channel
+ * @user_ctx:	User context value provided with each CDAN message
+ */
+struct dpcon_notification_cfg {
+	int dpio_id;
+	u8 priority;
+	u64 user_ctx;
+};
+
+int dpcon_set_notification(struct fsl_mc_io *mc_io,
+			   u32 cmd_flags,
+			   u16 token,
+			   struct dpcon_notification_cfg *cfg);
+
 #endif /* _FSL_MC_H_ */
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
