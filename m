Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755725AbeDWOvo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 10:51:44 -0400
Received: from mail-he1eur01on0056.outbound.protection.outlook.com ([104.47.0.56]:26568
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755684AbeDWOv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 10:51:29 -0400
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
From: Ayan Kumar Halder <ayan.halder@arm.com>
To: ayan.halder@arm.com, liviu.dudau@arm.com, brian.starkey@arm.com,
        malidp@foss.arm.com, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc: nd@arm.com
Subject: [PATCH v2 8/8] drm/arm/malidp: Added the late system pm functions
Date: Mon, 23 Apr 2018 15:50:51 +0100
Message-Id: <1524495051-3891-9-git-send-email-ayan.halder@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524495051-3891-1-git-send-email-ayan.halder@arm.com>
References: <1524495051-3891-1-git-send-email-ayan.halder@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: VI1PR0701CA0055.eurprd07.prod.outlook.com
 (2603:10a6:800:5f::17) To VI1PR08MB3039.eurprd08.prod.outlook.com
 (2603:10a6:803:45::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3039;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3039;3:Bf2+nIJGld03A1pJ+5EO+B8swZjeWAVdvCdvApJpr/+b7iJ/Ud2iZvkSYh42kUWPg7I5hYl5PrMaQyBiV7Dsnl2aq9YcaN3RJAXtt9lKHM0JCCLvb/TIJHpVsBj+9DuoJJ43jFBLXiFJgLUKxSY37TlPXyvIAcMX5CRtdrnkkOJd2kOFFPwwve4CLAm52ssnWdm4i+w4fVzAearuLFXEJIQgAE6GDGPCTSRQW1UCthz/cXl9CmU8pRCVQ8h2sj0B;25:yO9lzBdX46IrJRkOLpj5YFuI97+Rz/G9v5TEOgt4l7voj2LbKfvzfzKJ2JQF4YU1UHPIey++6BVnW0+Tep+GzBr2uHTNF7VpMhuZ/X2/5qH9l37zQniiOQBYM6vxrxDtFlIYaEnFXLAcuic0tE5T5JMHck1AO2bb7JyzO9AzblcTbKiN7PY5KTsaLIp1xrenD8Ox5GtT16j62YmHIIiyZLDJ5+YPKFcPSHFjWd6FvbfRakB+5muEPKbiuYwnBVtu6qPFVBqJFy2DTlNN59MutF6ezcEIpyUYrlH1/GZsmMfFRfcXKK54j9SjAtXdgo8PCcefddk5dh0dC+1RPyV8CQ==;31:SN6SDmYO2iUdTGjErCEm476k8RjDfrydbm92JAtZ2tkGSQoVDH9nfQ13ZxhxiJnEuUkDYg2UvJEaqfRP+CkI963cuvdTih2RdnMyYwvux9zAz/SYUA7J4Wh6BHsE4K5t1uzpZyW9QLxYcjmD41aIwjQGSaHtppGzDmkaRIZg9B5rO83kb6qIIl4MC23K/ZXlITS1UzexUnONHCbXsOb29HAGz5vTgKIzUVnu+UqOpsM=
X-MS-TrafficTypeDiagnostic: VI1PR08MB3039:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3039;20:RBZBiiT/JHleI0N93JtGeyV/MCmqc4u4kTtDQIhAy/xwQB/j114HrBYkSp6eDjHvYJNErxMjFcUwhD2K4OE8e4ZS+X6ytWZrL+HtWCYwrf074YhukbbAt47Yqv72XSDIlbSVVolldJeBFbJbiT7EvFDYFiCjfKxaupzNdvTJtB6JvzNzSICUFeGYa4C878dNqEHYqw8JnfHGlIR3kGigh5A+zvQqNbwIG2snriuQa5fjEuukhlibDfOFVMDNTW5V;4:fGP5r2L7G57G8GZDRzKcCE2uthYuJvZ0637rl4tveBzSnKLJjhHTPQBljAEfy9Obv/cz2qKNonZsuKIneHjifqdfpAReMKvzPFaVsMeRS8msmxKUmcvf9MMjjIaDLEz2uhzNfkDelQpAvnl+xzXmIKoNWUcfxw0l3QDPw+Z438VjYhIrJ5M5H7ZP9bJggs5Y6gkPduTL/hjSiYORyVnvmlf/blinqTyN76om5jyqz3yCtiDgQ1LJMp396brRx+ozWAbAiJsxc1uACzDr7eTxo5NX9YI0jAJAVmQUmTOi5T61fzxSWvOZyLKQhUDkCV8t
X-Microsoft-Antispam-PRVS: <VI1PR08MB30397CDBC0E87E4D087163D8E4890@VI1PR08MB3039.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231232)(944501410)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:VI1PR08MB3039;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3039;
X-Forefront-PRVS: 06515DA04B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(39380400002)(396003)(366004)(36756003)(47776003)(50466002)(6116002)(26005)(81166006)(3846002)(8676002)(48376002)(5660300001)(7736002)(66066001)(305945005)(16526019)(446003)(478600001)(2616005)(956004)(476003)(16586007)(52116002)(76176011)(59450400001)(316002)(4326008)(386003)(25786009)(72206003)(86362001)(6666003)(7696005)(11346002)(6486002)(2906002)(8936002)(50226002)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3039;H:e113505-lin.cambridge.arm.com;FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR08MB3039;23:owfuhh5xjXpnZDIRIKw3v03Om7YDtWpn+38McCLKq?=
 =?us-ascii?Q?66ZMBSKpR2hI1ogVj5GTQpzzCofQgtJurBaAvHGpGzQt9EJ9E8uP/wMTZlsX?=
 =?us-ascii?Q?gpPoIkz6etNRwYo8NdxyDv0JTFj1YstP4oZvNbVonnzUk/3T7gJjE3DnQaPx?=
 =?us-ascii?Q?ntmGq6bbx2X1X3dnUacqpvOqDAWSNtrV9msGj4z5tJeo7Tm1hWUGarytRDXU?=
 =?us-ascii?Q?Wjz7/nWQpXqC/Jjevl7iBo6zzMTrS4tJB3RzBpHX4luWDc2tPgiK7LU5w7wr?=
 =?us-ascii?Q?UjDfVHO/qFkyeudd1d32vlMXnkgDD7vGA+Jiy6GMVX7z2ewXu3pXdYIe7Xx7?=
 =?us-ascii?Q?5nBPna7fVgjDfIQaQCPxjHatOmFtjjhvOMSuIqg0bxq2mqXl4Gh+gEWDTSoD?=
 =?us-ascii?Q?8+f3w/QlYZI6oJmdPSDPD+66xGLDjKEbhb3ueAUJGMm2u1kITF85BpnEyTBp?=
 =?us-ascii?Q?upYOn1dZrj1uETyrU1KTZu1YLn9ZtkYnpgHuD+teYgVj3DQ2E4SvHAq3ro/v?=
 =?us-ascii?Q?xrolG32wCtQ+1OoH03VIaPxSdO7gyCCA0rzSrFLXdBjq+Xh8NHR2/bDMnbLO?=
 =?us-ascii?Q?DOVmCmpuyUcgzVon61gGRRZ1z2MbMmkOFtTFCVnwmrJi1I49j5pDusHHL/DG?=
 =?us-ascii?Q?zAhvsI4/NYBerTPah8JZOluxGXH9kMcWTVHW3AD/Bu9KniBA0oJQ56L+0yNE?=
 =?us-ascii?Q?L46Sg87QrcSkxFDwxKYS03Qm+kXZ61qVGW3y610yQ6iWnW+TT7AXzBy75aeU?=
 =?us-ascii?Q?DFTnHspmWCEM+zQlaznMXW17T4ogyRtt4/IPDFpMrFTiN8DbrMJYRXyQ0KGO?=
 =?us-ascii?Q?6djt1CwaFpCSMrtZrHnBBfzhn9zXUZZQQDR5o+eWGSgpMmijO7cTnUv9uLMf?=
 =?us-ascii?Q?rW8UrJLK1olR1dcjISmXh62+tua05d3ChUMi8nl+YtSuS1cYMSsxKNsB7+4U?=
 =?us-ascii?Q?ikN87vW2+eBm5/f2pWmeJbXWpNswdxkbeynYLAH/Wo8TZL8iqMQHah+Yj8jK?=
 =?us-ascii?Q?gI=3D?=
X-Microsoft-Antispam-Message-Info: Csc3jjK4h65RY1LZt9CZ+8yFS3APlX9V8dTzyS297FRGk8dknwAaupdWac+EBEaGlfCBHWLLFELQK4UJ45Vd04DAsYzfb2WS4Eqh+ZWUQxrgblkOPxaHokAhDUpW7ihuw0gTviTkiBJIuZSzBLH6ZxPDna5dc3cp1oB9YaDde6S5D3rkvhsihaP8aJ/Q9qFw
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3039;6:G42hUpALKAjtr0uUVqAAoDa4qfob7MYoXrbjXirCFEgSWyqfl7aOaP+zVbbOa6c9pJXgj6aG6JlaE5S7zdfw83xQI7/qAX0oBfx6MKBRYbHuYm1jf1wL9IdFwlndCADPR9DF+UVX8ynV4uAkNwgL4XD8+TuFAwD7lAalDUtHUNDKuO2Cx/95U3HvpgsO6w5hhMvHogOT2LKCcKKfugHn+LzhH6NZn3RHDsBMfGQuAJHcOQhyElo/BrdP6Bg/epoQt62cfujhNH3A6/aX8Ywtzepa+V5jL58InsGYVM7xJM0sSLITkgDeywuj2gLnd3cULmuXGLsq1KHfo0i2ef60DlHad3CQl7lvQp70jNebhb9mATxZmz1V9fwvHOEISCGaZrs0DiwBiTmln5hVZQd5+YPKUtMzHQlo4lNuYLiidNH2exScBoP5K9nbOuzwomZnsATJDdGvSQi+Wgp8K8DLpw==;5:xE/MFF47KkvtHN9VT+klNWZIaqNzxvUtdNQ2mUwMah+pjdMhlOTB/PmksczYjhkRbtG+24Hav0TNFsuKvBPvmuE8NMIrQmIksEucqgyMapa6WZiPdqPl08JIv/px719s894dRqGzHz/HwF5WZGSDn85JPzfC+S6xpq3dFGrwO9Y=;24:uNvzfzoFtVoTtJtfHOVQN7XdzEEOymYBEUNdC2zO/15ZOcpUnWhaB3Of0TvWh8WcXHynbgCPVYT1dE7pi+WJr3s2AizdFsjt0S3RPPMjLe0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3039;7:mmRtCsmx84BQIvrq70vvIDUDq8QWE/eAfU6+IiBazecCE/uz09PZvyPLGg4H4shchtMef1SaMDY80pCBz8kGMVdYCczaA2Nvq+a+4jZ+b2xRQ9HHodzI3K5mhRPNuOt/NvnLUQvKjAZXC4dHLpnikP0mRFiFrZCGtbdZk0K4orJADkNun//Zb9+6HMyvQJ71e4GvvStywAi0NnQlVUW8irgvuiaSqkQl00g86EqLkCXuv4BGC2I8vcFJwmUmHC6p
X-MS-Office365-Filtering-Correlation-Id: 2b722f64-651e-4b4d-b7ae-08d5a929a850
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2018 14:51:12.1658
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b722f64-651e-4b4d-b7ae-08d5a929a850
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3039
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

malidp_pm_suspend_late checks if the runtime status is not suspended
and if so, invokes malidp_runtime_pm_suspend which disables the
display engine/core interrupts and the clocks. It sets the runtime status
as suspended.

The difference between suspend() and suspend_late() is as follows:-
1. suspend() makes the device quiescent. In our case, we invoke the DRM
helper which disables the CRTC. This would have invoked runtime pm
suspend but the system suspend process disables runtime pm.
2. suspend_late() It continues the suspend operations of the drm device 
which was started by suspend(). In our case, it performs the same functionality
as runtime_suspend().

The complimentary functions are resume() and resume_early(). In the case of
resume_early(), we invoke malidp_runtime_pm_resume() which enables the clocks 
and the interrupts. It sets the runtime status as active. If the device was
in runtime suspend mode before system suspend was called, pm_runtime_work()
will put the device back in runtime suspended mode( after the complete system
has been resumed).

Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>

---
Changes in v2:-
- Removed the change id and modified the commit message
---
 drivers/gpu/drm/arm/malidp_drv.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
index bd44a6d..f6124d8 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -766,8 +766,25 @@ static int __maybe_unused malidp_pm_resume(struct device *dev)
 	return 0;
 }
 
+static int __maybe_unused malidp_pm_suspend_late(struct device *dev)
+{
+	if (!pm_runtime_status_suspended(dev)) {
+		malidp_runtime_pm_suspend(dev);
+		pm_runtime_set_suspended(dev);
+	}
+	return 0;
+}
+
+static int __maybe_unused malidp_pm_resume_early(struct device *dev)
+{
+	malidp_runtime_pm_resume(dev);
+	pm_runtime_set_active(dev);
+	return 0;
+}
+
 static const struct dev_pm_ops malidp_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(malidp_pm_suspend, malidp_pm_resume) \
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(malidp_pm_suspend_late, malidp_pm_resume_early) \
 	SET_RUNTIME_PM_OPS(malidp_runtime_pm_suspend, malidp_runtime_pm_resume, NULL)
 };
 
-- 
2.7.4
