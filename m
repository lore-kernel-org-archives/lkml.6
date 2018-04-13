Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751947AbeDMPaI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 11:30:08 -0400
Received: from mail-eopbgr10089.outbound.protection.outlook.com ([40.107.1.89]:38112
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750885AbeDMPaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 11:30:07 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com;
From: Ayan Kumar Halder <ayan.halder@arm.com>
To: ayan.halder@arm.com, liviu.dudau@arm.com, brian.starkey@arm.com,
        alexandru-cosmin.gheorghe@arm.com, malidp@foss.arm.com,
        airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc: nd@arm.com
Subject: [PATCH v2] drm/arm/malidp: Ensure that the crtcs are shutdown before removing any encoder/connector
Date: Fri, 13 Apr 2018 16:29:48 +0100
Message-Id: <1523633388-15112-1-git-send-email-ayan.halder@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20180412154727.GJ16141@n2100.armlinux.org.uk>
References: <20180412154727.GJ16141@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: CWXP265CA0015.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:2e::27) To AM6PR08MB3031.eurprd08.prod.outlook.com
 (2603:10a6:209:45::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3031;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3031;3:xoebhdrTEoTB+cVjmKwB2tz2j62jkyuVg+vT0COf6U6EYjKBBXA4e9o65HZRAHCmyRel66qGklDmamV+xSlOmM66MZ7/FK74yujXROhtNAD9pXt53ZrcKPgV72LjzFdQYPmrNwtWwX/elrnpfkQ8nEgADwhaPReNQtSUkNC9nxvPQRI9B01KZfk4uctljJCqGscHLXk7dekj0yZJzal+c80Z0T0wTjSiZXNzhd42MkadEYKTKZkiqJP9ppIcC0aR;25:gje5HwjFIoLThiCLYvEAjSuPPqAwh3xhV6uzOmdeVgX15BVw1qfn+KO9MpSUBpMHLrJYkJc8IHJfLicUxC7jvQl8e3Ijhez+L4gYc7buFnND4hggzJysee1fvOuUw59SlAirOuyVgLi2zlbBv5yoiYfOzUCCP+aqJsmEuqzgajQda4prz8Ae1OaWRpf3rx3UbN2WCEQVDFuINfLGB0rcx8C3ZuUwl5zsfUvKll9uLMjUJ3qlPJanhRd+wNlYdoEE50v1SSWbv+6eIPi1A4mnvnN8pm/k/uSugwRNaMDpxNbmTRsJgxeFk9Bv6DBoySfFIQJJMhp+2fjztA0mb5X/Bg==;31:6cmFgfAdwOvPiI7uY+m3USM2132QDcpfUq8oh4u8sdoAfMwUFw39rjQglqsx/hIGbaEmvK4QI8+iCSHFM/TU2uoa0n7U0wq0STOtB2UcmSZX67EiOtJzuDRSRQwXwKrfX9UKWpPcLIEWAiEh/rNOhsVxD6pqP3CIAFKIzhiWhYsjb2/iPqCfovnT0v3H7yrpEPTZK+X8HRWN9R8qqcqBXoFAaigdyE2dAPE3v4inE74=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3031:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3031;20:YL+qSdoMNiRWi6zUNI5n3yt3ilx14uLwvRO7UzQFZSNlboRGNvdCCnbPrHOy0qClsh/6UiJZhhu5laehl6ApWdLrnShvBGKb4z6YgNwXYUHxy2zsUIqJc50PFBdsHWiOUW3y65gPjqzZsx2ipnbahN8ZeuraDD8A45xYR8Kmqtg=;4:G78ESkluvo6PsKBzqfcp6oAiuHxq1N2OzP0VQZ0AHNExpAUAJJcPNolj+WLYYyZQCtBbwQZCFTqxqS9qRRpjx6iA9dqV9nhprjehNpwHaBgShszKm0sYVxE9iX84OzV4QlcnYR5MRIjJVK+Tc0tuGkvtZ6uCNQjAwB2qV0oaXYJh2qaOxCBtUvY8QZmL+PID8qntWN9U0MiOAKrTWcCM2BSirMuGLBjA8HaAGI124wlIkHU3gsbbbeR8tlsKhuL3N1YXVeHJ1PPItafNPKeMIdclVBFK3Nr2nupAWDbEnbCsFO9TBN0yl5tzaTeQe8/m
X-Microsoft-Antispam-PRVS: <AM6PR08MB30317844381D07F0B9D16081E4B30@AM6PR08MB3031.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231232)(944501327)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM6PR08MB3031;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3031;
X-Forefront-PRVS: 0641678E68
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(39380400002)(376002)(366004)(346002)(189003)(199004)(72206003)(105586002)(59450400001)(2906002)(52116002)(76176011)(7696005)(51416003)(386003)(53936002)(16586007)(47776003)(316002)(50466002)(25786009)(8676002)(81156014)(68736007)(66066001)(81166006)(8936002)(97736004)(50226002)(36756003)(4326008)(2616005)(476003)(956004)(446003)(11346002)(3846002)(6116002)(26005)(16526019)(486006)(106356001)(5660300001)(86362001)(6666003)(478600001)(7736002)(305945005)(48376002)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3031;H:e113505-lin.cambridge.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR08MB3031;23:HWgRnzpM6iD44wumUeHwRnl6b8U/txT2urLrwcrZr?=
 =?us-ascii?Q?a/A81u5s7r96swjprvF0Sh/RVa/DTVNdC39RCfIVDyLTpS28Aiu/n8gf5ugj?=
 =?us-ascii?Q?RJmSf4EH7QG4y/5KdvxD+idgyHBLeWn7A9i64V1i7B+cg0FP7sDEDpIRPqVw?=
 =?us-ascii?Q?3SWdveq4WwvRLWTz0cnnqlhX1c/yahHEgd2YtI6bzDARIG+bTEsovrdYFwHt?=
 =?us-ascii?Q?ax9jb5DkhKehpMb9n4EGr9VhEem10yLBw1HhatTxhma0NVftdSLvd0qWLPzo?=
 =?us-ascii?Q?HLiRaG5yU9cmBpJ3ddQ3tjAZLtoLncJXevQZ/WB03cRXPVpMgq6KzSAaiTuo?=
 =?us-ascii?Q?DAavEEjofxFm1zun5oY1ijTn26qZB263UB8i4jOacih+xuMJYc8iUvKCJPTX?=
 =?us-ascii?Q?lD0PQW9vceenbaQ9X6WHD+kROnSbPXnot39VVDNx9Gzx46hzU3lPidsrY2zI?=
 =?us-ascii?Q?WfxBG1XG2Kmkf3PheS5wOhs5jyQ98KwJPp9oIijLgwid9CYBLeSeRgcu5+yH?=
 =?us-ascii?Q?YRw919sNtDeyMjgTU8QJU34xELmPiPIXGQuwp4w5BDB/L+u62NBr4zw7wHam?=
 =?us-ascii?Q?yqc/0ef1UemX3dRzcKkFT+gm9VwSa41swuq26F6CtAnsey6uDl0ameSzVMDq?=
 =?us-ascii?Q?+GtstAGg9GcE6y5ifjMO4Oil9USL9F4JktV0j45P3GGrExQT1uwVeJUadrKP?=
 =?us-ascii?Q?oVshJCcygHomZbyICqugOAd8s0/1K7x4wCaWBU2VTBReF9Ffw62Ivwu7Tgsv?=
 =?us-ascii?Q?CfcN+5VIHb5lVlqvtkG2j+3I9rOI7lVFXylQ1l5Dbk1vdSVACAsrM1zYkX8O?=
 =?us-ascii?Q?crUzAf2FKMdUFP5jRBn5kgp//6l3EqygHGVEJEpVaT16E1CxGjB+OhoYr4uc?=
 =?us-ascii?Q?hmoAzhf522vnmx+bKvxnVMqOFnO66/FxiWnwRDnV5rLy/KNrzNus5jICbiA+?=
 =?us-ascii?Q?b5v65yHpXam+I67kGqx8EmrlIPhJkecpP5qXiDTPOOAxO82R+q70YaSyJPdo?=
 =?us-ascii?Q?BunpinLCGqppyvnYC61OlqK0NgmxlOljkV87H8f/5FMRmI2AhXIyMbDZtB/G?=
 =?us-ascii?Q?AUgC5HV4YoGs8kDhOmJl9FREAmadpHRj7tm+8yx4jkc2xLKgajUn9Iy+EP61?=
 =?us-ascii?Q?gfb4LwPzghVIWs9YXJzPqX+RRHkUVgmVOvpbxZWRQzGexhL8Xlu1A=3D=3D?=
X-Microsoft-Antispam-Message-Info: /ez4psLtw3HtjVpRZxPNEKW+Iz2Ql3ackkVHbulPFcw57ezhYbP3gIbsHz/EeLOJ01BUov9WBUYvbJN23qgdcr0dwN1NenMzUpsDsp+dMEcSRt9oMwbloKZ2YMH/v0bz/pTh6MTqj58PNiBUNYYTwngtcAEeoEw+tda+QlmWy3YnpV8+C4HPqN9LBoHPWWz9
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3031;6:3gp13P8ChU26RvILFfoJc5pcJ1OVeRmEp9qQRW+hhL6Lzx9F3L/LhJMTtvGhHlpOE+nKCU/pWUU9KvJFoy28IY7WPRoAn+Y2TUGWwdKMFsJvHLu0dvTobfsaQnFbeshPaLph4i9Wj6nn2iSFHVGYa7+x3lNRN0YBHqeV5Oq8njBmw6r7gueRN0DL8wNw1WEWMw33ECpUPTKl1/03tbZYdm7Wb5aCkmRsrRc/5Ukil0eCLc/0tEh1Frq7huRK6AG+aRKv5XRHp3xhTpqyd+PrTQFFQ1ymo+NAPdoQPaRbOtvpD1+XcklhF3acfH1VVAyA7mBjMk6EEt66J2g0OXDCDEMfX9RLmINv3vpKMKLydEBbOMRijB5nkoAwXtkXjmgJspIgxTL0h3HeGioss6wicJEkCN8PQrTmoD+N+K8lqKh5TA4pCvgxftZX64OmW5paAjhaGSw5RlGABEPHHUWtDg==;5:DsrDTHD9B3xZMVpfrckWkVxk1oygQR7JghHPZz5ZWVOQwWW1JIiPJdCYGeBoq6XfPnMQAlI7/EmqFFqKWSff3ISg54o812fepAvKiQSXpmYCmKKX4Gt79ZamAo7+0D84WP9HSWr5SRnXfWNrfTMp6pMY/nhHQN4CiG+hAzxBFis=;24:IcLQLgXHBKlvJzIW1LHfsIczniuPmQPv1Q9SzeYGxOA9/lCO3vOhc4KKQKuqxmu7Wr9Vi/ovbX54tDXESX4I2dwuL2QF3deyqtcXSQEFgPc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3031;7:4J3nL/lc5sLjIpX8gZX0XljmlCBBGcxwnWbIwqeNI3nKKmxvFb98y0ige/jBR+FqCcr/D9N6cACgkiRta4L/XLEigof/Iq7FQDqUurvLVqDQFAQlGqliPf9C2FpPgJj2i1D8oww5WYQ5SR7ctMMWo2M5SG8unhUdPoKVQMRQkUg/cLHpDMy9Y6NSI4LY2WcpgUJrA26Z6+IiluvHKnS6+rNLhmFiDD/iMDKhb6myTIRIcD/jAwh6m7o3QvLnXl1e
X-MS-Office365-Filtering-Correlation-Id: a38c01d0-8588-403c-b63b-08d5a1536e16
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2018 15:30:04.1164 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a38c01d0-8588-403c-b63b-08d5a1536e16
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3031
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One needs to ensure that the crtcs are shutdown so that the
drm_crtc_state->connector_mask reflects that no connectors
are currently active. Further, it reduces the reference
count for each connector. This ensures that the connectors
and encoders can be cleanly removed either when _unbind
is called for the corresponding drivers or by
drm_mode_config_cleanup().

Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>
---

Changes in v2:
 - Reset the connectors' mask and the reference counts in drm_device
before unbinding any of its components (ie connectors and 
encoders).

---
 drivers/gpu/drm/arm/malidp_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
index 8d20faa..0a788d7 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -278,7 +278,6 @@ static int malidp_init(struct drm_device *drm)
 
 static void malidp_fini(struct drm_device *drm)
 {
-	drm_atomic_helper_shutdown(drm);
 	drm_mode_config_cleanup(drm);
 }
 
@@ -646,6 +645,7 @@ static int malidp_bind(struct device *dev)
 	malidp_de_irq_fini(drm);
 	drm->irq_enabled = false;
 irq_init_fail:
+	drm_atomic_helper_shutdown(drm);
 	component_unbind_all(dev, drm);
 bind_fail:
 	of_node_put(malidp->crtc.port);
@@ -681,6 +681,7 @@ static void malidp_unbind(struct device *dev)
 	malidp_se_irq_fini(drm);
 	malidp_de_irq_fini(drm);
 	drm->irq_enabled = false;
+	drm_atomic_helper_shutdown(drm);
 	component_unbind_all(dev, drm);
 	of_node_put(malidp->crtc.port);
 	malidp->crtc.port = NULL;
-- 
2.7.4
