Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752179AbeC0Vj7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 17:39:59 -0400
Received: from mail-cys01nam02on0062.outbound.protection.outlook.com ([104.47.37.62]:44256
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751008AbeC0Vj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 17:39:57 -0400
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Leonard Crestez <leonard.crestez@nxp.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
CC: David Airlie <airlied@linux.ie>, Liu Ying <gnuiyl@gmail.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/imx: Remove last traces of struct imx_drm_crtc
Date: Wed, 28 Mar 2018 00:39:47 +0300
Message-ID: <ed466ff48d5b23a6225ee6c270d70cf3923dfe05.1522186448.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.7.4
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131666603956689253;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(7966004)(376002)(396003)(39380400002)(346002)(39860400002)(2980300002)(1109001)(1110001)(339900001)(189003)(199004)(68736007)(8936002)(575784001)(508600001)(53936002)(106466001)(51416003)(86362001)(26005)(85426001)(110136005)(2616005)(126002)(956004)(97736004)(336012)(6666003)(54906003)(49486002)(1857600001)(26826003)(356003)(316002)(50466002)(118296001)(104016004)(50226002)(4326008)(2906002)(81166006)(81156014)(305945005)(105606002)(47776003)(8676002)(5660300001)(48376002)(36756003)(476003)(486005)(486005)(16586007)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB3116;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD010;1:nIfahxHVt+AdeXnwBCd1o29fZt9augGICcZPFj0IgioH5MXF7nbrVl0K4zUpmMFNozo+WDXg5V0wzokBb4oc7HbD0GJm6RGg3Vto5vy1DYlPSMXKR81cqVLZ6S503ir/
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ebeebc5c-22e6-44dc-7806-08d5942b4813
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603328);SRVR:DM5PR03MB3116;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3116;3:94IzUH2NgOkb/RJi+OCcS2B5AZxsMhGhswQImGi8iQNl4ufVQmbnXXpVGM6CgEqqri3mzeWWgPqw5qOUT0Nhssox3GFqtQhPa1ZVLihYrBeJXn9mHEC3gg/2ZtOSKBmvYFkRhiwzkPxsd+oH6Z3Iaim90Oga3lnCFG19EDkHQXpNOvc0RFY9foRx8dhrFIhK181VSNdftmLt1Y0sqwsvxJ97+x6ecKFMNNfNywfSuFN6kJhTfWcCosCAayuWMtEuf+u1PCU7e1oGy3kfWYUwsqQpgCJGYZBLHAakKceS0sf8De08wDqI0L0aWMO0eOVvGfN+/AwU/LeaG4lsKCTfAOSESKai/RYGmaMBXMlgFtA=;25:w0IRNKb167d9gLoFvYwXSjJ575+Anq+UtNv0LFEf/5JhoX63jaoAkGkw3myIaS88n4iTY6ox9yK8vocBEtQL+TMlYgYc/1/yz3IaZTtbU5CBo3GKvUb9SA1rGkOo0AUYjTvPshBxEQKGe6Kwd9v7oEvQ1rNXBJ9DnKehzEQs9zt76o6BBZTESN3QYjQ2gXjYFJ0ofkjQKyxmwLJn5t/a83myoU1x6lcqawUX0U/FH4XzAGTxbi+59f0MAOK/1HmrL1at9SErmhxxDY5LT6QEk/dlY6/7hGGN1Z8y2edD32bf2kYvodFwa+xxpJ8mLZULExvtdtjmWpOneV3CmJh+cA==
X-MS-TrafficTypeDiagnostic: DM5PR03MB3116:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3116;31:evIPT1xezuUUMmHU+/qWxXmapc6+ukzA/iXQOXmtypDmIWfMKHmgVT6YpLdOcszHji2oVClgNDDOGNGxkOu4Dae+XBVEhFxsJbsLi1twvTHkvdTWOZ0lncAeMhHI4EwLvuavdjnEUtT3DWFlc6IGPPkVdXLh/PT+qp0UYgQ+fDUhsXRAa7N9FvRZ45zBPhUCVdwhj/6xM4ngpj+/5rFA3NLsYzTh1o15IJ5eWwnQfFE=;4:sp8plkzjuFpWEJS56EZlL6IJOtl3skxszQ8XqgN3TkbC+UijwmWQKYvYYfQuBrPQdBjMAgNN03aVj8qzUJPxd8X2ApHBL2nKqlVu2wh+tftyI3KVzeWAaAPveLOCBXSHatXPvZVfRfz5oim8CCZggI7aORYCeG5ohiJwEIa8Wvhw3cZix8iPp58dFr0fIUGMmthFIGQ5jVGe7a8SRszh+OollJqQD1H2s0B4m5C93+aJv9Is2oGO9/2rq11ltqAZ88rzr60zOW+5ajk1YdFs4NKWR/3ntIGIeDZK4ul+eWcUQlf9JYvyzVT3o+MRzpbm
X-Microsoft-Antispam-PRVS: <DM5PR03MB31165DA423F972A079C057A3EEAC0@DM5PR03MB3116.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231221)(944501327)(52105095)(6055026)(6096035)(20161123556025)(20161123561025)(20161123559100)(201703131430075)(201703131441075)(201703131448075)(201703131433075)(20161123565025)(20161123563025)(201708071742011);SRVR:DM5PR03MB3116;BCL:0;PCL:0;RULEID:(400006);SRVR:DM5PR03MB3116;
X-Forefront-PRVS: 0624A2429E
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR03MB3116;23:Fxov8pTTz3hTdUxlGPNCZbZFYzOUdGhCOvx9RzuOP?=
 =?us-ascii?Q?zYOTF6Q8gBwHbQprxLXt3jah4Vu4eoY+gPnb7fdG45XbYFbnjgzZuzKu1eG5?=
 =?us-ascii?Q?N0il2oIbyNSDLvlQIB6DvHC7ICERT3PUmkdQVLMyHcQqTjugpZckleR9VcDV?=
 =?us-ascii?Q?8DbxX37bNGzKMwJlUbF2jQzEK3kF00eYeLwM+mf2L+U0ytAycZJCjIlpbklr?=
 =?us-ascii?Q?En1KW/uab8Mj4K3qOyYJhuQDz2D7vfuV30oSVMWFvcD7f3+U5S/WJ7VtVLVO?=
 =?us-ascii?Q?dqU6OL9fht9hR7eGRe6fm/Vi0nBTFC0qck2jlghnD5X8dM1ynDrfL6P/kJ3Z?=
 =?us-ascii?Q?hD9B5i48DDkLN+OKCKOIBPuJvKdFAkybE0sIDd+WpI/PhqWF5XbVA+aAt7OP?=
 =?us-ascii?Q?8NdnBDdp7iXppnndpcqF2UwsyeG0xkK3h0gtwwgitTRc4vTmELsi71L/JJO4?=
 =?us-ascii?Q?IOIDn8ZhOmcmGS4melOmS6OO+rPCA210zo695qw2HWabDT+UOCbmcszyCgon?=
 =?us-ascii?Q?j+rqryGdTRA1kzB+jFQVWnXaZfGKOAcdpBsP8K3AVdJP9MdnMNSKSedVFKl8?=
 =?us-ascii?Q?GlHwh7wVzlldoYokrWr/xxBL18NFl1vclV4A1opkTnPt7ZoPi9J993aBn8/m?=
 =?us-ascii?Q?62EdZ/D51DeZd/MIVyOphOVKdQDRfkW6YNZAO0xn2hbrOCZ9c6+JaE3GU59M?=
 =?us-ascii?Q?/SRwYE49BNjGnmHpRNde7OJjSkF6Dg+qtyD/JqqxqNM7tHQPzPy30lGHLd9W?=
 =?us-ascii?Q?KQ1zsYW9V6qsFEW5n6Tji7LVy7Vu5KZyHwuu/A+ljFUvG6vHNH4yD4cL+HC9?=
 =?us-ascii?Q?KK+HiDBUGxQl4nr0i6t2Uc8aoYiWL81nsDnaAjmBwLy8Tj/W7X0f+MauqAWx?=
 =?us-ascii?Q?GZeBzKLxt4i0KunI6PmWa6uQRH3+sJfOSREoDWifIJ3tHSVB2ammmhkU0Zdx?=
 =?us-ascii?Q?SxHaWUTrn5LVEUuNlDzQ2MIl8jedovA+KIKEcz6Kg/yx4i41FSD3L2REw4gN?=
 =?us-ascii?Q?CMAYZfGNHx5cfC8r/uPCsnRNNGl/EWUJ0vL+PNO0+4T8zV5I3/avX80qCpce?=
 =?us-ascii?Q?FJhew6ouJTMFp62OGRbtYfRFjztCPK6btU7ySbqeSzznPPnKxe3MrHcqQRIt?=
 =?us-ascii?Q?9pRoRDlVbXj7173T77xZ9pFOVD58LpeXaSVRSJBVTmFJ74MqYGy3RjCy3Ao/?=
 =?us-ascii?Q?yJnPTvL555grQy3T5SvF8DH1NliB8acIgr7aodNEp4mNjKAWt5ZMSbEyRB0v?=
 =?us-ascii?Q?amLOBgZYxFES5i4EGU=3D?=
X-Microsoft-Antispam-Message-Info: KokS+DCdLo2BZL1nzFx7tR6jxNR6+t9WykjC2r4GX75plYwD0O9Z0IrJ7SHIkG8h8+aVwRJI6MTIheN6R0DJTQLHG47hS1drLvx3xAFfeuPBw9bNQMNNMexPhIGDGZyjyKmim+aUKZ5/eX0vkeMafiJ01sLHktVuZ3Fg3a+Qs6J9yH+Gq8iM92/56eh0lVAd
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3116;6:L+LzkSnXmk3YzMovnDSMCq2hYj3s59eKWj+KudQdyHzctCDgwfg5GygwOICld1EFefGu65B7OD6QthySORX1lTnnRO7hzWXmPbVbww63r+4UteclG13hvaeIoBG/Tv9WZOxKJ7PW7RPOE8zssIvb9X3lKr8ld61D/L4IVLXmR7D2JkQ9oIhS1fTaG4LV6ElKK/xLSTXJIAv7aPvWKMspetSPvgTdr2mGjTygUhj+wo4/T8CxElSS8zaSHvls5as+/IXRmy0cg9VjqAvD1T4Yca5RhnH/iKbCCK79HgSas/hvJbWbM02vWJyc2GwxyzaMEMkWpsqikMyBtJy2HoExLPT5HcJWy2I1Qpu5l5alO1oTwyd3WRpCzbGHhN0I6mAUfvnQH+rxfsZotgW00gQfUTCnU+t7Ms36yx272eBgDI7bhVAig1SEjGzrB7gnhwpGxhiODoXG0yqzxC1tauYw2Q==;5:CoLZaQawDzTZS+9NbAqbTwo8UHnj+g/S4Gg9Rhoxz8wGptKLxSmJWpEa/Ki3oeDqf3OWXDRnWQyEyrexQzQ2ABvJgOrmo6DE7tLlaKEEBM6NW2uAYej5zRUz8j09l7o98mfWp/C/EE2RuGYBGmGK+NvspQ0042sxzybVzi04D1Y=;24:7JjSvzmhKbB0xozCtffRg/SdCOR6Kz6s/+Q9QTMLFkGuft9+NXcrMaDmgXcQvrAytMrYPitfFt/XNIM9DAk5f5NlFTGDh61pBm5jAzn1asg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3116;7:SWGtYUjgX43m+P4XoAfTl6ptg3KJW+mycVQUxe1SPtT5AcqqbmeRv8xpQzZyTSY2NWVCUtrnhy3jLB12NjDB2rJ0vAcZ9zYMlnBzAOyrjGECWOoXxcAXKQmGJ0ER6VnD8twFRJ79o1LKwSr2PRHvOPXbSOrwAhiJneCnKWmc6l85yew1Kkgg07hQkmrmD4ZCrynOTMNArX9UfBL9nkKIQh5XzC2TT3OWqyXQjn3sw1t3XtSzQCv/9xNtsRy0tgmj
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2018 21:39:55.4973
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebeebc5c-22e6-44dc-7806-08d5942b4813
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB3116
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the definition of this struct was removed a forward declaration and an
unused struct member were still left around. Remove them because they serve
no purpose.

Fixes 44b460cfe554 ("drm: imx: remove struct imx_drm_crtc and imx_drm_crtc_helper_funcs")

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/gpu/drm/imx/imx-drm.h    | 1 -
 drivers/gpu/drm/imx/ipuv3-crtc.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/imx/imx-drm.h b/drivers/gpu/drm/imx/imx-drm.h
index 15c2bec..ab9c6f7 100644
--- a/drivers/gpu/drm/imx/imx-drm.h
+++ b/drivers/gpu/drm/imx/imx-drm.h
@@ -10,7 +10,6 @@ struct drm_display_mode;
 struct drm_encoder;
 struct drm_framebuffer;
 struct drm_plane;
-struct imx_drm_crtc;
 struct platform_device;
 
 struct imx_crtc_state {
diff --git a/drivers/gpu/drm/imx/ipuv3-crtc.c b/drivers/gpu/drm/imx/ipuv3-crtc.c
index e83af0f..50d9f2bb 100644
--- a/drivers/gpu/drm/imx/ipuv3-crtc.c
+++ b/drivers/gpu/drm/imx/ipuv3-crtc.c
@@ -35,7 +35,6 @@
 struct ipu_crtc {
 	struct device		*dev;
 	struct drm_crtc		base;
-	struct imx_drm_crtc	*imx_crtc;
 
 	/* plane[0] is the full plane, plane[1] is the partial plane */
 	struct ipu_plane	*plane[2];
-- 
2.7.4
