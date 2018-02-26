Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3286258-1519662521-2-13205373086165523154
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAD_ENC_HEADER 0.001, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519662521; b=DmT/R19zzvAPWu+Xjumw5cNBljU8Jy6Ozei3CBQaLwslXxX
    u1mMrCBGxQnqzNYY+Aqqw371fblBJSwu3IQM9QTn3dUXdDNwX2VTS6Wl/69YeJPc
    D5As4hBacm0glv3xC2winu5cRLU5+3/b9ahQZ27/fVr6L5QHBByRCoLyxEVG6t7+
    AyDceVrUZdvNBzABbj26WMM/0Wmymi6Ljv7q7xMZj7MisZBPc2eiEglzrsi68Xm7
    8tyLXWGEY7SdQiG86sOdlFYMQHaZpP6AHaFsEMNPnr6dIVioK49h5g5aq1iRj2ol
    epp3EeJHR0/2JPWg75EhHS8Gpsp8JYFSugMqonA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519662521; bh=u
    5JwjT6JKNQN/q9QuhtBhLAb9RxA8EiDQHoY/vCd8/Y=; b=lxQ4cy9gC+Gp/0fGT
    AMy8x8kcVMe/4es5RFqEzcfSdktS7bEm4j0lSCJAghmvz7tXRxgmG2X7ELVQ4Tgs
    7/xfjjUv2R1lg6Q52d5v8O9aYKjuJ7YFU2qXe6/Yn3gulreVJBJZialrY3KOq/g6
    uie6mNFHe8B71iHlug2gtKlWJelwtCG0cgzxDv3j6YZ0SlTD1AG/wi1yxmAPjcdq
    TS2076hbouinJvoKPvCMxEnhpVD6P4sJPzx5qitzXAU8XKikM2zhMXHttrEJvi07
    h8f1zID1jMYV/Nd3BOTLi6+Zz2RKABYGHbxK/i5LZ0s7ipkshwqYfdk6ceynb+CX
    HPgmA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=GmyF4Clg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=GmyF4Clg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ruxandra.radulescu@nxp.com;
From: Ioana Radulescu <ruxandra.radulescu@nxp.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH 1/4] staging: fsl-mc/dpio: Fix incorrect casts
Date: Mon, 26 Feb 2018 10:28:04 -0600
Message-Id: <20180226162807.20649-2-ruxandra.radulescu@nxp.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180226162807.20649-1-ruxandra.radulescu@nxp.com>
References: <20180226162807.20649-1-ruxandra.radulescu@nxp.com>
MIME-Version: 1.0
X-Originating-IP: [192.88.168.1]
X-ClientProxiedBy: DM5PR10CA0018.namprd10.prod.outlook.com (2603:10b6:4:2::28)
 To DB6PR0402MB2696.eurprd04.prod.outlook.com
 (2603:10a6:4:94::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 200e2994-cd03-44e8-6661-08d57d35f648
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);
 SRVR:DB6PR0402MB2696;
X-Microsoft-Exchange-Diagnostics: 1; DB6PR0402MB2696;
 3:matKbCasCjZ3cZNG9HpsvgXZ9v6gXIW4rKUcRiBq/1qJJvWNVxRMtxUKOhEKxy346Z7sAe/FtNJgl2tbI0BrZlvAyiGj0HC0MUwDV4Bo8VAJqSedZQGCUzd+axfzjfdZrb4P5BlvX/duUJFQMalHVGKaDOX/zIW2A6WKXxuvb61gk3bGBllJUQwMNkmqBhg/AYx16FB7DAhlh0qWZKsJ9O/+NKJuevtk/a3QNn8+HB3oFOaV9j2Dn4qy3nUS7Xm1;
 25:XHkitSXc2/Su9TtQETjHqapsgcwhQMc0mEb3ngQMWX4PLprN5DrIRk+/UJtloeea1sm8kxSkAgPrgEXFipBSHraFvbRZNZ53QYcT3xLA+g7nYoECz4Q0cLn3AgNvwag0S9YdutVBeF2Swh5IgZUb5t2+FNFsDBpk28IJlq/Td6959p+L/sSf0q8J1b9AyQaAnGgk0ytyIMCpr1uNWGCTgS7N51LTmnKSSXeYtsAPTEEF9qrsnyXXJEHDtAmiitU8dEd7JlLLYRVEAjMPtAz6RIYb23rLDGLPvewUm8eXNvESckvFTzw8chUxON0+rckRLPxufnLkbU2xiPscGgUUZA==;
 31:ZyvqZsoYdabePxH6tCqjJKKbbdqtc4cUL2uLyoybikYSm3HwHU7aFWF5ZunTiLv8P5eyc3JwIAlw6dVzQkdCHjXUgi45gQsckFTYiNUypJoo0S/vEXmjO+vlHI6ZvJTVTwnn6iCSpO8r5RFD6SQFCu1Uxwt2DbeEkwSPWonhJqlF6LTYrf0VGsDNA0TbxuUiBf2azWvD6aNAOLe1+s6evbfPQmqsUFxnCiVZvWcM4Co=
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2696:
X-Microsoft-Exchange-Diagnostics: 1; DB6PR0402MB2696;
 20:+LHQsz0MPM8ZSPSrH9GH4bdpsQgozrNlmYed0/JU2mN145efgG9pIKdIzVKhCfiOGDwvSsXyBh017ia1X8eQB25Ulj0ykb2NaJJJib8QxQZk+NM0MZRr82IcJTZ2A/l+BBp8GgN6v7e1xdqfARO6CcnbrhXgkjt6FwogMxDcFJRSoqxCgODsPQP3Y4S9iso53pLRBfU9/an+Ko5tAjw5VR8QTt2/OCBVlywl0MZnPRtdv7rK/AV/WqAaMWsfTwfWVvjX/pyOK9YCK7s938vBM9ZGybKHhHVok6SQ//Mp4QDMK/CXeQ6GDG7oy2jH+b9Ab72UOYNxEk30T0WkCweRONDmkhf+u/aZfxPimyYsssbyAzMBu39FBVJFHSgkEv2dZjlrP5e4b6qYPh1xFitXV4tbBaknta0dsEmuosI14kJSzIMsC97hvWvJXoWLsA9jzuYbRRyJy0qZ22TMBy1AmIDcqT+MHOT8QvgVa7DVbnoOgW8zXNLvQhmlwlXdfyQ7;
 4:/uHYR//d1cfLfIT+FeBYrcXgYANOhWr2V61QSDvKfowG2ABIciSzCzvf35+jFH7Ykla81u+VsFOLfhpxmEHx+6nzS2TovQw1ZQX66c/BB8aqFcscRVi92So/J5buR73wiK9rCMzHAAEUXzgXFK8Y1gAgqqoP13xFjGUqKU2kdaavc84PX7j152kEDWpVmLvPF8OhYTSNQoZUZ8qKxGpw7BhQ2yjeBMQzyHJwDs2QfJU5jEV5pOEcpywFUhnvENaXpriyFVTf0nwdj+goJzqVhoCN1w1KOEQ980qfv6owKoO13qy3ZwZpIB8lUOX72EpQ
X-Microsoft-Antispam-PRVS: <DB6PR0402MB269656A73BAB67BBEBB7BF5294C10@DB6PR0402MB2696.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231220)(944501161)(6055026)(6041288)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);
 SRVR:DB6PR0402MB2696; BCL:0; PCL:0; RULEID:; SRVR:DB6PR0402MB2696;
X-Forefront-PRVS: 05954A7C45
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(396003)(39860400002)(346002)(366004)(39380400002)(376002)(199004)(189003)(2361001)(51416003)(106356001)(50466002)(26005)(16526019)(478600001)(316002)(186003)(105586002)(52116002)(305945005)(7736002)(16586007)(81166006)(25786009)(97736004)(5660300001)(2351001)(86362001)(2906002)(8676002)(2950100002)(6666003)(66066001)(36756003)(4326008)(6486002)(47776003)(6916009)(53936002)(48376002)(81156014)(59450400001)(76176011)(68736007)(6512007)(8936002)(386003)(6506007)(50226002)(1076002)(6116002)(3846002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB6PR0402MB2696; H:rhuath.am.freescale.net;
 FPR:; SPF:None; PTR:InfoNoRecords; A:1; MX:1; LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; DB6PR0402MB2696;
 23:w3i4qgfh8Y8oZcu66vCqk+k3/1YuPrqCUTD4Wyx?=
 =?us-ascii?Q?00FkbVLwFMFveGEX9oRxnNZoF5tUKkcsyzg5vNo56mZaxuiZ+Z75Jirsj03E?=
 =?us-ascii?Q?C1XoQOzS6YeNt246H+dsrKkBk/WyCBZYG7DYm1R1fRBQFUuDNtATapylkH9S?=
 =?us-ascii?Q?guwSTQ10GLqTSzBQkFbICkrsGr6DPWnTk5olGFLq99HowUD818dgKXAJifUm?=
 =?us-ascii?Q?lMrm/wZaY6s8HwA/kKJNOlP5cx3XYXtvZhav1ZYamJUXjMcY1usU6df+hp1N?=
 =?us-ascii?Q?KomN7JF5Le00xvTXNo1HBIiGuhcWUsBLlfcGES+HTGNJ2rE8pkUDxn5ebjCN?=
 =?us-ascii?Q?mp9ScK2+NesTkitwb/wUjpQAgFDWutXFgAY0eA9NK99/uyRixJIs5y2K3jol?=
 =?us-ascii?Q?UKNrO48ZmoV4WtdOknWNnRfaanlV8Qc9w+gy/QQGwEK3xHs/9qIzHncf+mzi?=
 =?us-ascii?Q?E5W4RWFjClI0xqV6v/NyYwfVyhh+uYrP9ecXjMgDeAyaPCT7pEX5iJSdK0HN?=
 =?us-ascii?Q?4tveSfdZUoEXF8GwsbNodiQjFuGsZkkxeBMlmc2aMz0hJPXZSDEPObGtoMid?=
 =?us-ascii?Q?VA2ldRptQ1UlaNf2EXvP8Rg953H/3crai9/CUKvRCecnyzczb7580n1x+YvH?=
 =?us-ascii?Q?ZP6Z43A6eTSwGBqZvXIfSIz5N5CvARSY0S/WOZJG/8Dt6hP+ep+HzoEDEU/a?=
 =?us-ascii?Q?v143j30Xg2Qt5v5Vx4vq78jdKm+xMEa9299jg2RLPzTY6KYkAL9jCh66VhyQ?=
 =?us-ascii?Q?O6X6A6AbOoNf4pk5KFsgIbTBEPNHFMx90BqiLzYw56ybgplmkQD/TLu2/1sb?=
 =?us-ascii?Q?G/U4tAPgdLI0GZPkEz3rs2iQt5xrt6RO8uzaV35XDh1AAoC8ioz9I+DJfa5G?=
 =?us-ascii?Q?qhsSUWgSbPJj4G4vHsoQI3o1GHi0BMY6Pv3Lv5YQmyLBRBp6fhT9bqpZbcJv?=
 =?us-ascii?Q?IukaKX4fmS2AXMvF4q3aN+NIPtRGQw1uB1+8o2Lh2Tym0OcpD0waPKLjuj4L?=
 =?us-ascii?Q?cU5DfHgafGitqRTH8XKSlVH54FpluPlbY6IoHERL/XjZyqcJo/H0dfGpXwBz?=
 =?us-ascii?Q?CH4B5ykcT+IDX6jARQRVrRwqnUWBpS/7l1s8evVTADy79Yn4r8RDtRuu3omC?=
 =?us-ascii?Q?YoxyfnnTgK3l1aoJcTQzfA8rWIccblx4Ygf/CgSKzU68dK7yc+mT0Lz03WzU?=
 =?us-ascii?Q?65mw27UmFEDEgMw8=3D?=
X-Microsoft-Exchange-Diagnostics: 1; DB6PR0402MB2696;
 6:IbDHSlpf3pjlIaeLPkT7k/9UUQ58U0mRM9BkgP5Pgum5agxvFh9xm+w5x+k35TKemY2TE+kXDjqdrNZT4cci2MarnxLjPSDHQ1oakVQqXEwzezbmEzURxpiRozdXG+xOb4eYd544fDcRKObukJ5tmeaEi0HSkhmeGMsxFIKOxJ/m9r54j6pOB2yLh61YeqPkgcxroGrEi25+hryelQVfCUr2YLMnzWFFLFreuijP4E/d+mLHofEds9Pzn/fFyqdfTDHQoVDPN4tUqFwBkNXLm2OW78pOCENzhYsMSfwZnyTicXM2TnOm4W8Po+Zi4qxukSOi8pFIi8VsUdlT+Lyz7oM5/ndNGacsUwz8pwEkCqk=;
 5:qAYqXb7HDelLlrlPwEtxCCM1YuHN3lBbnvJUV8n485QRT+z0ezOzcrYakbJagSLAlZD/00wz1eIw/j4BzOJL86jpGrqosfCOWiiqZriax2oYmziNpJYPKqb2OWaaq+3cX3oY1WXrxWJNoxpf0+vJyUNhrmtlRRP5X+0E0uAavjo=;
 24:a//oWV4oQtKFhZfjEy0+rDqQfJp5FYZmIvm3mxLQ22Ab8CyWpEx1cu3v0LS83pTKpwMkAM51Tlk/SVku8gpVJBFdRIWOaSBfWp+bB27vvsM=;
 7:UkDgP6EN4AXJPXZ4JlE8c7kawNN8de6c1t9VKe1ySGJ2o+CXRB6qmFFDHxEPxhCaa1F9Zk6Fuq33OeklmtebOF4lGEiyZHcaXeMc8YX1L0CMLlAHUb+OLJxfk4RU0igdCahCUjqSIJrZn5xgnDEb/4t+++qAV5lwjwGHeMy0iIBUpHIg9bGREN3lKCHv8n+a2z36OVCIfr1zUF9uFzjW3WfgQOvVb/XWIwPMqtCReGq8Ne64h8gylzYBbypvM44m
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2018 16:28:24.9284 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 200e2994-cd03-44e8-6661-08d57d35f648
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2696
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
Cc: devel@driverdev.osuosl.org, roy.pledge@nxp.com, bogdan.purcareata@nxp.com,
 linux-kernel@vger.kernel.org, laurentiu.tudor@nxp.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The DPIO driver incorrectly assumes virtual addresses are always
64b long, which causes compiler errors when building for a 32b
platform.

Fix this by using explicit casts to uintptr_t where necessary.

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
---
 drivers/staging/fsl-mc/bus/dpio/dpio-service.c | 4 ++--
 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio-service.c b/drivers/staging/fsl-mc/bus/dpio/dpio-service.c
index 1acff7e..14ed2be 100644
--- a/drivers/staging/fsl-mc/bus/dpio/dpio-service.c
+++ b/drivers/staging/fsl-mc/bus/dpio/dpio-service.c
@@ -192,7 +192,7 @@ irqreturn_t dpaa2_io_irq(struct dpaa2_io *obj)
 			u64 q64;
 
 			q64 = qbman_result_SCN_ctx(dq);
-			ctx = (void *)q64;
+			ctx = (void *)(uintptr_t)q64;
 			ctx->cb(ctx);
 		} else {
 			pr_crit("fsl-mc-dpio: Unrecognised/ignored DQRR entry\n");
@@ -237,7 +237,7 @@ int dpaa2_io_service_register(struct dpaa2_io *d,
 		return -ENODEV;
 
 	ctx->dpio_id = d->dpio_desc.dpio_id;
-	ctx->qman64 = (u64)ctx;
+	ctx->qman64 = (u64)(uintptr_t)ctx;
 	ctx->dpio_private = d;
 	spin_lock_irqsave(&d->lock_notifications, irqflags);
 	list_add(&ctx->node, &d->notifications);
diff --git a/drivers/staging/fsl-mc/bus/dpio/qbman-portal.c b/drivers/staging/fsl-mc/bus/dpio/qbman-portal.c
index 376e9ed..f57c151 100644
--- a/drivers/staging/fsl-mc/bus/dpio/qbman-portal.c
+++ b/drivers/staging/fsl-mc/bus/dpio/qbman-portal.c
@@ -497,7 +497,7 @@ void qbman_pull_desc_set_storage(struct qbman_pull_desc *d,
 				 int stash)
 {
 	/* save the virtual address */
-	d->rsp_addr_virt = (u64)storage;
+	d->rsp_addr_virt = (u64)(uintptr_t)storage;
 
 	if (!storage) {
 		d->verb &= ~(1 << QB_VDQCR_VERB_RLS_SHIFT);
@@ -590,7 +590,7 @@ int qbman_swp_pull(struct qbman_swp *s, struct qbman_pull_desc *d)
 		atomic_inc(&s->vdq.available);
 		return -EBUSY;
 	}
-	s->vdq.storage = (void *)d->rsp_addr_virt;
+	s->vdq.storage = (void *)(uintptr_t)d->rsp_addr_virt;
 	p = qbman_get_cmd(s, QBMAN_CENA_SWP_VDQCR);
 	p->numf = d->numf;
 	p->tok = QMAN_DQ_TOKEN_VALID;
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
