Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752807AbeDXSNb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 14:13:31 -0400
Received: from mail-eopbgr50080.outbound.protection.outlook.com ([40.107.5.80]:51605
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751216AbeDXSNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 14:13:20 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com;
From: Ayan Kumar Halder <ayan.halder@arm.com>
To: ayan.halder@arm.com, liviu.dudau@arm.com, brian.starkey@arm.com,
        malidp@foss.arm.com, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc: nd@arm.com
Subject: [PATCH v3 5/5] drm/arm/malidp: Added the late system pm functions
Date: Tue, 24 Apr 2018 19:12:47 +0100
Message-Id: <1524593567-5559-6-git-send-email-ayan.halder@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524593567-5559-1-git-send-email-ayan.halder@arm.com>
References: <1524593567-5559-1-git-send-email-ayan.halder@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: VI1PR07CA0189.eurprd07.prod.outlook.com
 (2603:10a6:802:3f::13) To VI1PR08MB3037.eurprd08.prod.outlook.com
 (2603:10a6:803:45::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3037;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3037;3:0CXRFXAWw2dRmkauJ7KMxdMHOfBBb9vF9xtkK2cVwf3dLd/Rx94o3JHJq+qVUntCK1MjEC4SZunxtbt1OxAccE044PTa34ISD7xzy6pk9nW7Pkz23mOT36+pISBtv8Ej+KqfXpw8DwZG9URlm1u+HO0XDNnCYbThGzKWNZysDlFd6M628kwg/MMLnFA6GK/IrcktxV3Q3CW8IdW/DLb3YTq+2kfRfCpY2dd7S3+iegWlygmBBhEBy7zTI/JPF4B7;25:JMYxpX7UvfpjoRxmxpJ6c7yBK5CZ3osx0iPcYsbalg62+q1Hf4nXLSK2McYEZRqZ0fMuKoMgvJeCBQHtrsJJtNwdx6t9wBLhcLTFBdu0S8qirWVvD86uWuZuQ+2MsvbIPOuQ9fj9+PLxT6u+UuqRJcJQa4qryi82J5/9Ndesbu5UXVRmfA/iQQbxU7dqs9ohPwrKxq+E4N6fEUW+whOQmpfFjP35ovMfjG4/Syg3Z81iKulWCrn7hopu07lE4bH5Q2CmkcXv9B2Pl3Z/Gz72wWrSt0ibU8MMzCYH0hySPMheFqLANTkPTHM5fuRxCbCzEVNPsPmiSSyEV/kwdY/GbQ==;31:gob/htwOFWlK1v4TO8hc3yff0RMztyuSR6tUYeR4KNxJsACZ9ijHDh8wd0GaR11OGJxeAPcdtolzEiXSTd36htgl50hkomhEzXdaW0qGtKNFpRBKwFVK9WW+1HviCuF2AJ/BjtfFqsE2qOe1OLdVVdSM2WdHbzEzZd4uOsI43+yPan1sntNIOPBeuJ98cRrJA3rXCmxpI3eokIEn1tF4zC75Ka/9ED8jH/mi1oEIszc=
X-MS-TrafficTypeDiagnostic: VI1PR08MB3037:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3037;20:Qn/d/HA40RxOIWN6JkQIkGq54VFsT6agHThu1Lpy4EkqM0vuu2s//UGN17uZxbTWuzFwwAylWTCwimmnA68jDNIhKKOQ/k2NY9Vj/kQdo7O8RlRi5nwhUuIvv7yOqzZ17Y9xL9fsgXGGqUoYBbHFcoMr0OF5GiuojfACvkuA5vrbEYoPpzAcWaQ9ZLHHeWmXZ7ExvzBoT0mIy7zh+8WA5zVo8qRceSQ9B4Pks97BgnwxinvLJAv1Mem7BahxfXha;4:g8++sU35T+1+JuC9J1JhVx2P+pRTw/w2i/E3WxPQSOBhJiUiBntFXX+SgF9L4KaCz0EIkzfkf3fkIcJim7tN5C6stVdzmrxPbjYTsKvm1BiR/XScZWARWbVvlBRFAqBuiUYXu9zGAvHKuhomnzbEqzbzxqsyu1vIgdJAIUiUdQCJk3g7WF7VmA65XVx3RIevt0TCQ4JmBgBlM0m/9E1+JOY9Mqu7xaqOvpB7nNjI05ecvLEVIwWNznvkFynIn2lR6wHpIayYLkcLBusucajqGRIhI603UbzPWY+65Pn2u/O7M+2TQq6tfLOt0Jg9FaHb
X-Microsoft-Antispam-PRVS: <VI1PR08MB30378F792D39F50BF61C3E76E4880@VI1PR08MB3037.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231232)(944501410)(52105095)(3002001)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:VI1PR08MB3037;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3037;
X-Forefront-PRVS: 0652EA5565
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39380400002)(366004)(39860400002)(346002)(396003)(189003)(199004)(316002)(6666003)(51416003)(6116002)(53936002)(3846002)(97736004)(6486002)(486006)(66066001)(2906002)(76176011)(36756003)(25786009)(86362001)(72206003)(478600001)(105586002)(8936002)(26005)(8676002)(956004)(476003)(47776003)(48376002)(7736002)(305945005)(81156014)(7696005)(68736007)(81166006)(386003)(52116002)(106356001)(50226002)(446003)(16586007)(50466002)(16526019)(4326008)(11346002)(2616005)(59450400001)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3037;H:e113505-lin.cambridge.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR08MB3037;23:l/GPznC1Yle7/0x8csW5AAKp+4iNNQN4xHKYzk7EV?=
 =?us-ascii?Q?63o7FKk6LknrD8O1e89N9Hk0eL3AAcnW3iH+V3FpnMzkU0nHZRdxcqqkuey3?=
 =?us-ascii?Q?zmwL+qsmTjWpTPwLcm6gQg27LpOdLrGRPDb6CYfYgJeR5Xm8jVNk7FCtNYAm?=
 =?us-ascii?Q?j22UQoS/BXQOKCT7eDN3Hqup8M2ZIpRQmSD5XTc9pbspOt543SC/kUsmpdEN?=
 =?us-ascii?Q?m/VmLVhOPKU1cV7QmXQDX0dTBKME1SiOhSBeR22hD/PdCgHlMBy+qnpg5shh?=
 =?us-ascii?Q?Bn/ZjLk9mwQiCGwBlimAjeMeisiXsFtDPJXleO37BmMMYhm9UX2Fd5WGvQki?=
 =?us-ascii?Q?DOdSrdQZNAI8SVQz0AP/LMZG8D6vPonrGGOKUQpWEc6/xmklbH2yZIfLsYah?=
 =?us-ascii?Q?cSUsLCc49q8UL2C7ofqqnlC758Lbw43qdH92HjPa19WGHddlm1JPuUezQkg1?=
 =?us-ascii?Q?y6Ii/Dlm8s1zlHBchwvJL2THj1UXfg8aDop8uQVndUGWKBPhBXuqMH9ddyGz?=
 =?us-ascii?Q?QTUX1cbl2O0KQ035SGwBq7rCaVqKDp7kqSOligEDGE2A0CeX5uRlZ0G5WZvz?=
 =?us-ascii?Q?h4zGtcrz774e0JwqIJ6ZGcrh26ikjARSCZYtqi+gMid4ErWlo+BoWGL0hCF3?=
 =?us-ascii?Q?q8Fz/EmnL8jYML8R0H2bubXvF5JE/OV92rEZkaNCqICqzIvTNcT1VrwNwbIB?=
 =?us-ascii?Q?mxvE5KzIXS0LxpnOJDTKlHdvIJ2+9BCdjAeOy2XHxEYkDJE2xA/wZrX/2Suv?=
 =?us-ascii?Q?JJxbvIDkHXCixH8UYAgL4MSSkhurqQNd0x5UOhdb6DyLP1lTS1yx2NCIYBRe?=
 =?us-ascii?Q?rJqA4GdN17+/Br1ezzKYK0e45Z7G0nO8ku3JG25oizij2rH52pR9WN6f2qMQ?=
 =?us-ascii?Q?xlPJeb+JVTYwNldYz5OOFkIwte+Byi7Or/tlc3FG8y1SLw78zs+S/+1jM5cR?=
 =?us-ascii?Q?6tJsF8hQ1dfV1vkjhI87plEH4gbdz9F1Ih9A1xHQCvkEzNcqIS24C8eDgCoW?=
 =?us-ascii?Q?e0VVy3ZO3fRYXyC/8ih8Sg4UCv4MJzzUXt37p5RyFJAK8j42rN8xxHG55lQu?=
 =?us-ascii?Q?6is0IIFzEyFKC2jIWqp9DNnR+z1v7CNgV5LAVvH98SFbOfrAe4F+pGWf0kUj?=
 =?us-ascii?Q?GQugB6e1eeEULaICyq1KjX61wJMA+FevbtebwCd9i7qAEYwOjrSLg=3D=3D?=
X-Microsoft-Antispam-Message-Info: jHU3C+iG/trCyPEQnbLZhu0XWAYnv9D0YroJQoSMnoctn2ANvIdpxe3Ho6nk7L9+ypDlr0HLXzULwJMrXXp2M4fujU0ejm0pocK/9PuSPXI21LLnb8eWAM/idCs+H2DqhJ8gneCOQ8PFUdjlK8nstWHtMlMeV/qdfbLabSM6OO3KtQMmqnYUkYywp3lO0dS8
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3037;6:9ArSRPMZQZU4aQdgKKJlKXm57Mip5fo4nK4Yyp5DQQ1bx6O7QjKsDRtKOZE2Y0nzH0RkMWwRVEtQ7EureNUsEr0Sz1q+FFtlpQ7qbMUsPy2YcRlmgtwJjM3kTUuaupiJfukWUqyb7MI8cyAPgTjPeFXcvuyS6eArpNHg9hnYjTbWiS7eXVfwz86QpUDYjPv+xpFEK5M9Ql7jOafIbFUTdpqb6sU4LQyTGywUaQLT2wb9MmaKlBCSm1UacvGuCbytgirl116GwCKg0XlV0pzLz5pSbOTcfzrzAKhXSQ91zL//D7i7jDsawGMKK9/00ee4vcQ84QjO/QxLgW8/Qzjs1FCcEP0S2dNvDNh9ii0TH6H37g8DoWQN6OlFeHB+g8BjNDcmYbn6mPrqgQS6uQHT18iJlgAqY33YsUSZye0ZBzEp4t8xCnDydVy6EpDPVrpr6afcXU3N0jrPFwhgu4lxVw==;5:ldkJ0XFz7lxSFBa2Cp6j4P8Q9JSNgxfZxarqPQBA7fQyQ/ArDAAAnpX8lW8IIeDlcZY+KOnOOFAM9FiVKjXpSceDvS2frA3CLyDFmdHu5cF6sPrm6sKacf0spOoTga3R5ihb16B+Rdc4m35ze8rLibUYuCtrh6gHkOYLGNJovsc=;24:SSd0E7flffW9VwY8L2uArnXaeUHqG9Yp6ale8LPNam0+PKSRgEKSNAgi1G/cmrmRWTReF++i4LEG+z/Iyan53MBO8UUtSmOdOg9MOAQAzq4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3037;7:80RGMoKTo7OqD21K1xsK6362yNueWF0fOAONz28YBYJJM23yarjmChr9nrdY/ShA8Dp5koPogtHuiWUTWgGA+0SDraMCMo69mLi0xgaUyYvPdy3DSjECuo8dNphvTL46BzMSWPTATw8kwL4XqRvJU5aasxhYGtwYA7xKo7ISoreTgM3TiFNuP1OPpbPlmVOwJSH5RKb7lk4GnVFaUdslYBWxS3PqtFoaiPQgyvIr8JxppOtBvSGGAdihBiEuJRdP
X-MS-Office365-Filtering-Correlation-Id: c80ced0c-f27e-48f2-37ec-08d5aa0f0a64
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2018 18:13:11.4927
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c80ced0c-f27e-48f2-37ec-08d5aa0f0a64
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3037
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
Changes in v3:-
- Rebased on top of earlier v3 patches, 

Changes in v2:-
- Removed the change id and modified the commit message
---
 drivers/gpu/drm/arm/malidp_drv.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
index 82221ea..c53b46a 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -768,8 +768,25 @@ static int __maybe_unused malidp_pm_resume(struct device *dev)
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
