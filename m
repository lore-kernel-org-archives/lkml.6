Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753630AbeDQNMP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 09:12:15 -0400
Received: from mail-he1eur01on0139.outbound.protection.outlook.com ([104.47.0.139]:21734
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753146AbeDQNLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 09:11:48 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 6/6] drm/atmel-hlcdc: fix broken release date
Date: Tue, 17 Apr 2018 15:10:52 +0200
Message-Id: <20180417131052.16336-7-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180417131052.16336-1-peda@axentia.se>
References: <20180417131052.16336-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0270.eurprd05.prod.outlook.com
 (2603:10a6:3:fc::22) To HE1PR0202MB2778.eurprd02.prod.outlook.com
 (2603:10a6:3:e8::20)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0202MB2778;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;3:J1LI6hnh2EVYdGSlBlzrKlpHtYS4r+gP8FQd2QdVbF0s8S444+5T2M9Ct5+H6YGoKU6BjYmeqCM/anE4m8WIQxI1DC+NZotMC/7uEcDp/965sjtEKvcwNCKyAUah9ahlmYWB8wld0OLrayKUv+23hCKwSMwEgUOcYQi6XpYnSl/S7cihFe9nrwUL3Yj38QsdOF9SPTbdQ36nusVPr4cofC5YNZgyVgCoYfYZkohtIVuWof4eqBt1AFfWEladZd7M;25:Mb1wchqVbHBj7NfN6SmJQtXr7PVXL/IsgoIdIGJefLvOqy2uhd35KpvwPJHM1WZeFbJ7O52bXnpsEWk/zgo33ffMN0bbjmxPG6K1XYS6xfjumZUUhC8IVTT/COxDXV6mGG/p0cT49Vpks6PdBTEZAaQtWjnbPTvRZRtrDDOgGiohw87fb701wZllneFHfT+gX0jAuqtAShDd7Z/Z2dOz1JUwIrpmHUuwLe/2sx8p6a/ZRftohAxnySgn9uZSnxzgroeNY0RbwlI5KeFOhijuz+7kRgZXytO9ZsToZs2r0HqT4gSRIf82hv7j4OuD1hgY+2tBVK0UkZHfPaH5Gtxxfw==;31:740pEoIVktrG3CFB3XKc0WRTgs+MebZSWR1SNFTY31ttRs6/HvnG0CGpxSXyuBX32Py/5GXGkTPr2svPJZ/8Nxmlr8xP93TJqVN564r5gPdw5eo2/ioUK9XmpEHM12aXAM9GUAz5Zi42GveWXDijrHcCRvCoPdgpnWHSE95e8cI1hVQjWgUYJ70vAGva6M7/yTRDp1cA2WZSsCGmrZVU+oFGRYqjxYN2eQ38Cecgl5g=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2778:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB2778CC28D6FFEE08610B80CBBCB70@HE1PR0202MB2778.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231232)(944501327)(52105095)(3002001)(6041310)(20161123564045)(20161123560045)(2016111802025)(20161123562045)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:HE1PR0202MB2778;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2778;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;4:gZJxxkp1zdR25vrtx5WuI0AYKaNxT8vpA8pF3HzXoSYCmqo2CMQl4gq7NKOAJE9LuyUx64rCsZv3v0P3BnEmYgvNvJoDh/9xBQRJMYEblZpGapmtIBMuiMOxBjPnPRivSPwzMhp8iMoHZdWc0gMIspEc2/olAq1FjkGHPudnHZ61XDlGsg18Tw2CRRbnhKlv00kSTdQn3UYnDT2lG6EjE8PUlOeVA7A6GuhCLNSofF+IMjhRLnQsubHVe27k4Vb7Ct/rSdt7vu7IO3RzFwErTQ==
X-Forefront-PRVS: 0645BEB7AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39840400004)(376002)(346002)(396003)(39380400002)(366004)(189003)(199004)(47776003)(81156014)(36756003)(66066001)(74482002)(2361001)(2351001)(50466002)(105586002)(316002)(48376002)(81166006)(478600001)(25786009)(54906003)(50226002)(16526019)(186003)(68736007)(7736002)(16586007)(8936002)(5660300001)(6512007)(3846002)(4326008)(53936002)(956004)(476003)(486006)(2616005)(446003)(11346002)(106356001)(97736004)(76176011)(386003)(6116002)(51416003)(6506007)(8676002)(52116002)(26005)(86362001)(1076002)(2906002)(6666003)(305945005)(6486002)(6916009)(7416002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2778;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0202MB2778;23:+bwqiK7Vuukqe2gE2++qRYtWZmA0EhFBN25V0yw?=
 =?us-ascii?Q?OQr8ckkubQyRITV99gdZcXNcHn9BN5gcjPviEwQXXARhcgUVQ2LIYm7d77CE?=
 =?us-ascii?Q?l/2chvszAIehoLnH5021VuyXOBZ4WA2rEWe3a4BA3SnzAUC0KDGZJnmsdzIj?=
 =?us-ascii?Q?sDC+up8oQk9nDMB3q7kOKg8Fp+ZSlJyyqJCm9N0PpGOimuEmCw30K2if5A5Z?=
 =?us-ascii?Q?CBdObwIck1vViabuNwqwECjfTGjHmdgv42+I+J4cmEJU5yv8okeURYrp1+R6?=
 =?us-ascii?Q?bxoncAdvaljsh3qRXC4Ozb1OWQQUoLBl+bArmPMygx/Bunikxf5NQAipuGPs?=
 =?us-ascii?Q?USzyL5d3EP1SVgtQu0Oj59MXzbxTaQxd99vesGRghqosajHjApvYewD9TdE5?=
 =?us-ascii?Q?V7kWZ7PxbFRj/W3S2jCnOqcM3M9ZC+mpNcQiOeensOXF1l9SuARysSL1lgLL?=
 =?us-ascii?Q?VxOKBF71wWYHE4MQyvSsJecsL5ZFQy7m7v9APxNEj0LRemw7WWf0wTSvWhkg?=
 =?us-ascii?Q?Qi0QJPIBLHNpjp7klibCCNKsUwinIABk4lOVcTKPqes+CBYH7nA8lxxhARXi?=
 =?us-ascii?Q?XFSR2Sy/STFZqgNgSi3MrKfVpYoUSe7vjSMFyPjIqD7ErXQU2t5YMGxk567d?=
 =?us-ascii?Q?mjlxLMI086H5blysogEinLbABiwyqBKnbu78g+xgfp5Sbt8pVFwnBqx2j1eM?=
 =?us-ascii?Q?X/PGV2oWFu5wUsVjapnM92SAhMGw5f5CqjUUyXfZRYj0UnH0J7now8+H/lk5?=
 =?us-ascii?Q?FCdJpXqlS5X41pFQ9dmM4Gi1j83XWXZJky0NQ8/OkjZ0xZZ5dP9RrXM6G4GR?=
 =?us-ascii?Q?iUNoKkCjMW2BVnU03dcMth2j3PuoDcqDX67AcRzO2awo9ik3gwuhVt8EQFkZ?=
 =?us-ascii?Q?ieISqxKs84K4pfUSwUVyGJ4hAR5eKCluC953GppwXts7NMpI54GjGiE9zljR?=
 =?us-ascii?Q?mQ9qcvr3oMN852Bcb05XcivC23nfQN+a/fm0Dq++AY8R4TTIifTeIhdsyt4+?=
 =?us-ascii?Q?cGcpwMiOvaG2jqtxCAMUwVIHEGBV/VSfGS4SHI1+KVFZWOGktO/vY+lUY8wP?=
 =?us-ascii?Q?N43OJXn+cZZaBlQkzQKxJ1R2ivQ6ZFGOLWKNT0OTdkBfJ1wFcIsec9lP7+7P?=
 =?us-ascii?Q?Olg1kaI5eex9/D91T511AIddoxHc9IjN8rqBpmEOvQB6F/nAgWLkEh4R2krh?=
 =?us-ascii?Q?8zWzVwLjya3xRhBKMAXGxngCyTf6WazPJn4LLbBjpYEbX3ROx1twIC8lkSS7?=
 =?us-ascii?Q?lsoisuuu6hTuJPQGbPtQUxyshCBm7xwd/WFD3BLBvk4tyN941nxopA5nM4tK?=
 =?us-ascii?Q?4pbNVGjJ5ZA2Qu5WhlhlAo34=3D?=
X-Microsoft-Antispam-Message-Info: snqk1/9uG2W5Ecvg3ujyn/+utB1BTXs+/j5tmCJStha6zOfrOfik14QTbWVc5vJfLlc4rPkIp9QknxyUFgvIopE3eamzyYgb05F10giu7Sc5EmV2hOLH4i4O93DoZm6zcWHHj1NefQdMz/qH0cmgmQWqVdFJZc5+9E/+nKzuVj4CCRiT2OS/SFLV/ZrKJ4U0
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;6:YQ72t/QkLcUfOsxkA4nh+I4x6u+1cEHzPSwWpsXPDthXytIZFgyoYYDrWZD77pWSu8fz9onlSabn7IRLFSr+jc1vemqywwssAnrw+hGv74o7rNxayjzx0DU9fj2UmeXur3OEEJ3QTO9wlE/ebmddlF1NBEMVdX/7cl0r1nhrrLXewGs8npQ6pfa9nXOrZcmWXoSixi2lGyyxYd1ieVAAXp0MtIJQryfT6LrzBmhnZjL2iWUetwTppFN84S+/2QiJ0cOjWSc8OEi8es4Kc+wN6oDVIWX2QiK6hsuoZaxywfIb+k/TftMB2udaqinyED7MYqFVajhcjegae61Y2rK37RrAcc8rbKNLjbAiTlIzuSa2fx/7QMPYWnkOB2vSMAPcIA1gx3Xw3QmCT4WYWDN91R1gdXUQgldMAEtNlC8XuSncM8fjzlIweaKCShwKfdOnwAx/nwMq+LheAHjR3dijyw==;5:JqIp1fjyf1mmeHxmwUewbM5gnrf17VWMI/98lxceWcvx8qPe9Ql8oA4ASYsmesSxR58jfuXokqqnWnM/Nf/VcjJWeXoXA/Uww/BUlsNGaOt7sravJlgy3xFL40m2SRU7WgkDSAbLoOChKx9DETpPCqQPKflv0GBFBiyxm0psiGc=;24:8M1JJ5PUryYtk9waW74xzDv2Z5ZdCEH41qYyqdrCC9cY0g5d2snXGgSwa5/bSb2CEtV2vIh5PxRXyTbk0WNwECa5tYiZlA0YcxLTsc3Wafc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;7:59JFSYJDhr9lisoD9snd00aq6O7tQx0LSFpQEMWgZu54s1fazeFkFQmqC5zJNMZFhkQ0HpIRbGU+mrJ6x/1XjB85q6tJ4jYNp84+hJlLK+qy5m2QPcpzfPnWkk/a08ABpdtSoPk5p7iZHEQ6KWyUQLoy29iU3MAXcUxsGlEJVoBadLwqFWG9HM5/c0Q8EzowMW3NAmjO8tA0qhUnt1o7/QwFdH4CU4tLvYYgRbK+vABuYdbhZ9TXpwlM4AW+JYDs
X-MS-Office365-Filtering-Correlation-Id: 8a5c0eb7-54a2-47fa-49b4-08d5a464c49b
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 13:11:44.1083 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a5c0eb7-54a2-47fa-49b4-08d5a464c49b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2778
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bump the minor version while at it.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
index 8523c40fac94..aa48f287b5ca 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
@@ -763,9 +763,9 @@ static struct drm_driver atmel_hlcdc_dc_driver = {
 	.fops = &fops,
 	.name = "atmel-hlcdc",
 	.desc = "Atmel HLCD Controller DRM",
-	.date = "20141504",
+	.date = "20180409",
 	.major = 1,
-	.minor = 0,
+	.minor = 1,
 };
 
 static int atmel_hlcdc_dc_drm_init(struct platform_device *pdev)
-- 
2.11.0
