Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935898AbeEYHQM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 03:16:12 -0400
Received: from mail-sn1nam01on0046.outbound.protection.outlook.com ([104.47.32.46]:8288
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934393AbeEYHQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 03:16:09 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com;
Date: Fri, 25 May 2018 15:15:09 +0800
From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>, Ben Dooks <ben-linux@fluff.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Patrice Chotard <patrice.chotard@st.com>
Cc: bcm-kernel-feedback-list@broadcom.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] mmc: sdhci-*: Don't emit error msg if sdhci_add_host()
 fails
Message-ID: <20180525151509.0270dbe1@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY1PR01CA0168.jpnprd01.prod.outlook.com (2603:1096:402::20)
 To DM5PR03MB2636.namprd03.prod.outlook.com (2603:10b6:3:43::10)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR03MB2636;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2636;3:bmGkRS0dDkbpNLLlzmRulX11iq9O7VFF8l+2TKlZzE60JGrTV0BJq4WcYfhR2qiBcrUTQBiQlJfp08lu9xzbjLOUuPrNp2IhCd8e4IROjojbLGUGM6CLbYAVFtoxQ05wFk14jwdskCWVHOP3UkfYEuFk+GLASyqFYQyienwkxBPPS92/yJL/nkMqImkqq7LEyQq5pBnRMKf3JIsqSD4r3xKBoC2UksL3Q55LUCsdetiU1mdEo3xlj20grSOZLBq7;25:0PFcbDEMALT9HfMAe2muDopQgVZPM0NR12GsRBYps9nkJGG3ym9LXNDFomDtkrlR8AiQ9y4wl1A4ufRL9A0dT+kxt/MK+Yx1sUflrH4QoKwWzh9Xu8eR4csPhMWY58GIpGK53K7JcrNqgLrLy63ebNsF3E06MmFVR+x1fLZ9KlGWfsdxzlBwoKgSQd3urLFv4VXxJAvASXTDtFdYBEwUAkHw9v8ODKB3twVgtmni10o+xzD96Z+1oYyFPIbF5+1SGlzE41vOibj2b5Br0Og3oCRy+idV3f2HjIXdJoXfWLj9KYkosHH4E+lOgFm5KbHlf7EsWXCKDG/bz0ytZfbciQ==;31:Hh7nCo84kJJXW5Vb9VMYESC9sF6Z6V2kyRg00NVxUd2PpdzA8EjyOph2v5suey2OP4HCtEWvWFSVKPHN6C1CN4zXAA/DnKLCiyyePo/Oas3LYuyrz6rikkSeLkKM3riMEJZtR/2lksC2cDds2L+L84Wx/osQk5YUzLbLfbqtwt/J2fhEzIJge1SLm4JxmcIqDWdSSqQZl4lm6FS7q7jOiIC8MB7Jl8wriMTTZ5fLugE=
X-MS-TrafficTypeDiagnostic: DM5PR03MB2636:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2636;20:iM1hjEXk2c8HpGX3RSCXe7YlroY6In4BLiOd4Aspi43104k2o+JmXVKpdTUxtJm6JTUtw0mtxdEWF4yRBXGJsY5VNxF5AtHj/4Oc9o7elKGaUTbohQHpiobOfCtTlcTd6X2JsySq3BrmKZ5hSungDUUK7oMhE8OvVYPfgxIcMrX1MJuCSgi4nTcPqlSprm9o1P0JQXKpUgO1r7K779vcVZPZkdmufj8+ng90f4uOgTxY/3hnRz6mm0YcwXQDruxlblHpPKdDNqoA4nx4GuyExBjjzyVY3u05c3G9pCzh951nYUbx6q65kRO3YiRgqqBFJpaucb1ugpOJIDcLWQ7kkyUIBmfod1PgnT0rtWvKA2EgNBDQKfmUeC1fuFvQ8NFv+3EVHvx0rMSyxcyvJ3nIilMZrJLuY4u84V8uMWUTNyxjtpHxvnwa5LdTNtwJzqU47/o8FA6OeJ+hzVrN3aeioCbsBYvKp7/hA6wuJrTjKWBuOun8+7vWl9cWM+SSlUjx;4:1Xewt0VX3decfnrqZ2q5s2zawap4JmoQwZLTe0jg1y/xmg0aAIYB/rHdM5G23XWPHD5JexA49YgxzihX+O3hlOv/3c6EUz+10lXYAHsQhvwL1D5putr2mWBwgCnM6bkUX+igmw2ccpuqjuyVc3L3+b/bJ2N39cvmB8bHLeoNjAzf/i6vA0PjGLL7XH4H5nZwA7EpOUXqd7k9rKr2ikb+czIxxmaR0TIHqJyeCrK9MRL7ebqxWuSjRlypwRtJxwo9VW85E7MFQXQq01KOWWP96g==
X-Microsoft-Antispam-PRVS: <DM5PR03MB263622827FE17B96FCE43108ED690@DM5PR03MB2636.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DM5PR03MB2636;BCL:0;PCL:0;RULEID:;SRVR:DM5PR03MB2636;
X-Forefront-PRVS: 06833C6A67
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(396003)(346002)(376002)(39860400002)(366004)(199004)(189003)(3846002)(7416002)(50466002)(1076002)(186003)(8746002)(6116002)(486006)(39060400002)(23726003)(68736007)(5660300001)(86362001)(1857600001)(8676002)(575784001)(47776003)(105586002)(16526019)(476003)(106356001)(4326008)(50226002)(956004)(55016002)(478600001)(8936002)(316002)(7736002)(52116002)(7696005)(81156014)(81166006)(6506007)(53936002)(386003)(26005)(72206003)(59450400001)(25786009)(110136005)(66066001)(97736004)(33896004)(2906002)(9686003)(305945005)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB2636;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR03MB2636;23:j7GzBIkH1gbeQUfp7vH3d6g7/dXXDfDkcog1JYgGZ?=
 =?us-ascii?Q?S/RYdSVXu2G3kdzziZ8JS+R30n/yUTjCimc1ytdI75wh6Ks8Mklh/qm1eZno?=
 =?us-ascii?Q?N1iVWwr4llhu3p9XSMD7O06VCO8sCeThTbnr4Yl5DaLBjJ+wvBZwu7hjEhvV?=
 =?us-ascii?Q?PAWA50LerswLvLT439gFwDqlP9pPUiVwTh1icrmGxQx8TS+n1x6xJiEZCzqj?=
 =?us-ascii?Q?kYyDQrcbY8XPKs0HIiiGKbOiuU8JESz7I7h/gr1s4cOIj+GsbOxHwZRJiQHS?=
 =?us-ascii?Q?h++NiBqURCLKQTqSiCjX7Gjg9gY9a1oBA3BCPeUmLQEdtU6m0NpQWZMT9d2n?=
 =?us-ascii?Q?yWyybjFWJIUlfOwLv4Op6hOcN6f28UtSQai2aHCK4iuBY+VUyafj3WCE/hKe?=
 =?us-ascii?Q?/JqMvTU6ItmPXbwsgK32mbqQsDF2uWSxs7PO6t1yacz3wKtbDM2iEAP4onHO?=
 =?us-ascii?Q?rXIG2AlK7ny8VTounnM/I1GtoDvb0YLG56A02RkhfDaX/ocmAYgZ85FPj0mT?=
 =?us-ascii?Q?Bf89WK91VpQe4IiRhWcZE10FCku1NS+Yd/iSoFEDFb3qFxFU5ip9lscyZu1M?=
 =?us-ascii?Q?VjtBJftjJ57FKIkJ1YXCf0gEp27EJ4blABPp5qhyc+bgbgYWpe/DQAvW2Ksv?=
 =?us-ascii?Q?0J+VCDTgsSLrJFvTDMWpWYNIhmxpjtMPOgPvVRxmFoPvB0Em1KJXNkt7iAJM?=
 =?us-ascii?Q?GcVgG1GYKMu4r+u8z5IWlx9wQiCKkZHp1bk9cW4104fSaYO9MMkSl3f3D1U2?=
 =?us-ascii?Q?Xvvn0cWQmGeUVnuUQK0PJ9R8Awi9BYsrywIs15+YRgaraBKoDR8l6UdgO7/5?=
 =?us-ascii?Q?LD52gRQHIQFB6S68YQvxQqZFf//2h527gW5ChX0ACWKbSnxey2zF8jP0TxwH?=
 =?us-ascii?Q?ZmN0rslgM9Bu2KHw41DK9rZsx0mS6SZYyI0kt9aWMZBi9v1875R79AnCnUHG?=
 =?us-ascii?Q?R/LDdOyyXpXbR/MPMixzmSdDKCshpldrDzSXrCaoao7l7H5EWClWvnku+yyX?=
 =?us-ascii?Q?i91gG57tes/f7LIa6hyDj8SqVrrME1stUBLslADQ1SajqpipskUCwjloMn/D?=
 =?us-ascii?Q?ruIOvSmVfyrHKHY72r8XiJxAgBTzh+TK/MvuS+wVDV3ODxPMjgoWTAfkgjbn?=
 =?us-ascii?Q?kRN4gwJqQ7atLBZO43rqcaseiqMC8wGYeKpS81BNPI9kfL9HsqfnM9rOOHhI?=
 =?us-ascii?Q?YT9tBmERojYs4B9VKJ1BYUoTlcmYgjdGnl7ZVtex1HtcAf5ZN2oN2m+v9if0?=
 =?us-ascii?Q?F2xP/Q3CtTeHb4udOzNIpHAmqjKBg9u9mksBxRA?=
X-Microsoft-Antispam-Message-Info: KpxfwOg94KTzsbqdHZGRhKRxvVDiONFrDgLdtWiNYZ2yXLKxDM2uoR4X14fkfx5tf8htiVXPf1HIoeTWafSdjIO0Sj0xCDKq/5zJOOHAGX9tkzova/ljqzp7ONmU4PA6Ic6LVMGDdfOBWz2rGk3mDA6tWqc4R2KTj1tZ4zk205IeqpIuxWWFJOTj1aBjaVXn
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2636;6:dZl/uaYstea6mTSI2zwYbk3y6+bTVLtvvxLkps90NPgSoozw0c2x4bhDnaQ49amJYa55bF5183olO/3/W4acT5NU6f0Pn2kJIp5LFZqs2mHkfjBwBrDnc49J/5/dw/Iu6GMOmmHkcoH33UzldvydOw3C/k5WgoyqzZbYpt3Mdzd2bhwUAqjQchForjq+P0xKVA57wpHFhX0JcMwVX+waqvo3mSm1uCTBAmZlOb2fw39yQf4arugo0PdWQ2xGOyGEUz109rJ7azsJoXMAt1k1zj0SPg4wA2qxoiOcsdOn+tKfJ9reDNV4NyteMW1j0ebR14qy5Lcnk2mthwRWHh6NZAOxXQk96CEf5LsjJNG13CWDZD+91AmjxwSMH8GEUScUP3tS1k/7nWjaX7KaoCCiXPRZyYadJb5Zra0tJuNXqT7gLf8bEvvl92FdZJxA2MD4I/lo7yJIaMsaH+YIzahasQ==;5:pdp8o8k8xuLOgyDHTZwbMDW1+xtQhPN8MG0wL5je6fixdglnct+waN2E+/5kqzAgRD5dPrle8hFY3IUyfk7ivU1aTDoUdgjO2KEA0SRKyjo1GDld9JJnpvmPTLQD35H6TxH1IE/t/19g6AoNYBZtVx9x50K4LhBrYYh9H+GYMe4=;24:jp9n3+Adc1zTgQjH5aMrEGUAGBdIOjtrcfyHsOqFJ86U5d3xkIDjynTZPAgs4C72Rpfa0ZLaAjKBKEnXCzHi/kZFgMgwOAtSX8eWUp/xaio=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2636;7:5vCCcgYox8lU68u/MpFC5zgNITufBNuKgP29RcqYn2eiwsSZlDAQGO2EmHHoxjO8harZC6dP4ufMam2U2QSI6hJptogVnw21A+5Zi0qNsCVuUTI7l/7fdTsNhAcrhKdDtO/AXrpJ1bzqK76f2wFdb2lUZc+H/rwgXMb76pHj5zRQSpML8xqMGblTPFNUvDS+xK07n2x2lmEMDPiisCsMUz8hJ9/cKlijPErXqd46EwlJLJTTHblfNpzj0PtWA6Nj
X-MS-Office365-Filtering-Correlation-Id: 0f49fe59-9f78-483b-ac66-08d5c20f61e2
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2018 07:16:02.8618 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f49fe59-9f78-483b-ac66-08d5c20f61e2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2636
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4P7GHdi031928

I noticed below error msg with sdhci-pxav3 on some berlin platforms:

[.....] sdhci-pxav3 f7ab0000.sdhci failed to add host

It is due to getting related vmmc or vqmmc regulator returns
-EPROBE_DEFER. It doesn't matter at all but it's confusing.

>From another side, if driver probing fails and the error number isn't
-EPROBE_DEFER, the core will tell us something as below:

[.....] sdhci-pxav3: probe of f7ab0000.sdhci failed with error -EXX

So it's not necessary to emit error msg if sdhci_add_host() fails. And
some other sdhci host drivers also have this issue, let's fix them
together.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/mmc/host/sdhci-bcm-kona.c | 4 +---
 drivers/mmc/host/sdhci-pic32.c    | 4 +---
 drivers/mmc/host/sdhci-pxav2.c    | 4 +---
 drivers/mmc/host/sdhci-pxav3.c    | 4 +---
 drivers/mmc/host/sdhci-s3c.c      | 4 +---
 drivers/mmc/host/sdhci-spear.c    | 4 +---
 drivers/mmc/host/sdhci-st.c       | 4 +---
 7 files changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/host/sdhci-bcm-kona.c b/drivers/mmc/host/sdhci-bcm-kona.c
index 11ca95c60bcf..bdbd4897c0f7 100644
--- a/drivers/mmc/host/sdhci-bcm-kona.c
+++ b/drivers/mmc/host/sdhci-bcm-kona.c
@@ -284,10 +284,8 @@ static int sdhci_bcm_kona_probe(struct platform_device *pdev)
 	sdhci_bcm_kona_sd_init(host);
 
 	ret = sdhci_add_host(host);
-	if (ret) {
-		dev_err(dev, "Failed sdhci_add_host\n");
+	if (ret)
 		goto err_reset;
-	}
 
 	/* if device is eMMC, emulate card insert right here */
 	if (!mmc_card_is_removable(host->mmc)) {
diff --git a/drivers/mmc/host/sdhci-pic32.c b/drivers/mmc/host/sdhci-pic32.c
index a6caa49ca25a..a11e6397d4ff 100644
--- a/drivers/mmc/host/sdhci-pic32.c
+++ b/drivers/mmc/host/sdhci-pic32.c
@@ -200,10 +200,8 @@ static int pic32_sdhci_probe(struct platform_device *pdev)
 	}
 
 	ret = sdhci_add_host(host);
-	if (ret) {
-		dev_err(&pdev->dev, "error adding host\n");
+	if (ret)
 		goto err_base_clk;
-	}
 
 	dev_info(&pdev->dev, "Successfully added sdhci host\n");
 	return 0;
diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
index 8986f9d9cf98..2c3827f54927 100644
--- a/drivers/mmc/host/sdhci-pxav2.c
+++ b/drivers/mmc/host/sdhci-pxav2.c
@@ -221,10 +221,8 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
 	host->ops = &pxav2_sdhci_ops;
 
 	ret = sdhci_add_host(host);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to add host\n");
+	if (ret)
 		goto disable_clk;
-	}
 
 	return 0;
 
diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index a34434166ca7..b8e96f392428 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -472,10 +472,8 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 	pm_suspend_ignore_children(&pdev->dev, 1);
 
 	ret = sdhci_add_host(host);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to add host\n");
+	if (ret)
 		goto err_add_host;
-	}
 
 	if (host->mmc->pm_caps & MMC_PM_WAKE_SDIO_IRQ)
 		device_init_wakeup(&pdev->dev, 1);
diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index cda83ccb2702..9ef89d00970e 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -655,10 +655,8 @@ static int sdhci_s3c_probe(struct platform_device *pdev)
 		goto err_req_regs;
 
 	ret = sdhci_add_host(host);
-	if (ret) {
-		dev_err(dev, "sdhci_add_host() failed\n");
+	if (ret)
 		goto err_req_regs;
-	}
 
 #ifdef CONFIG_PM
 	if (pdata->cd_type != S3C_SDHCI_CD_INTERNAL)
diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
index 14511526a3a8..9247d51f2eed 100644
--- a/drivers/mmc/host/sdhci-spear.c
+++ b/drivers/mmc/host/sdhci-spear.c
@@ -126,10 +126,8 @@ static int sdhci_probe(struct platform_device *pdev)
 	}
 
 	ret = sdhci_add_host(host);
-	if (ret) {
-		dev_dbg(&pdev->dev, "error adding host\n");
+	if (ret)
 		goto disable_clk;
-	}
 
 	platform_set_drvdata(pdev, host);
 
diff --git a/drivers/mmc/host/sdhci-st.c b/drivers/mmc/host/sdhci-st.c
index c32daed0d418..8f95647195d9 100644
--- a/drivers/mmc/host/sdhci-st.c
+++ b/drivers/mmc/host/sdhci-st.c
@@ -422,10 +422,8 @@ static int sdhci_st_probe(struct platform_device *pdev)
 	st_mmcss_cconfig(np, host);
 
 	ret = sdhci_add_host(host);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed sdhci_add_host\n");
+	if (ret)
 		goto err_out;
-	}
 
 	host_version = readw_relaxed((host->ioaddr + SDHCI_HOST_VERSION));
 
-- 
2.17.0
