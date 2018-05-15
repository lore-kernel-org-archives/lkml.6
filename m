Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753838AbeEOQEu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 12:04:50 -0400
Received: from mail-he1eur01on0054.outbound.protection.outlook.com ([104.47.0.54]:19657
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752537AbeEOQEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 12:04:45 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com;
From: Ayan Kumar Halder <ayan.halder@arm.com>
To: ayan.halder@arm.com, liviu.dudau@arm.com, brian.starkey@arm.com,
        malidp@foss.arm.com, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: nd@arm.com
Subject: [PATCH v3 5/5] drm/arm/malidp: Added the late system pm functions
Date: Tue, 15 May 2018 17:04:19 +0100
Message-Id: <1526400259-7573-6-git-send-email-ayan.halder@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526400259-7573-1-git-send-email-ayan.halder@arm.com>
References: <1526400259-7573-1-git-send-email-ayan.halder@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: LNXP265CA0095.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::35) To AM6PR08MB3029.eurprd08.prod.outlook.com
 (2603:10a6:209:45::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3029;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3029;3:c7yo7zaB/Px4yFyesz5sRuMpycNyRvR7a/0cSHb+uwRA622S3i8cFYevYp/G5GSYEW+Cm3ljdnFL1fJ+ExugThzl10q9ntc3ce9dNCeHY+wGRoKcS46UFYDelQ6OCkZDIP6rIbh6COvw5c3BQAGXAIxvFMQiyClxdo5Hl5LQOqJx/Wd4QJdFPrqnQOuVFwb/QxOuaJuVpTvBM7XahbZpTiBUL+cEmE4LDrgdCu/MXD6hl75H1IqXAi4rJBab7Kj0;25:seMb8+Kch5OgAr2KiGlZjJc09+aB2OJGjm+IS3+g6Y1fKxYDs8zX/3gOXcsQBHU+LIdtgeoW/9Bsm5RAZzP67xkECY3l3R3eBiiszScZVTJqAb2+aQOxJR0FaP2j+Po64AOF0duEbfmv//8yEZnBCOC+/07Vn/6/Mp3mCZq2+A+1+WkzrYHAx3CtzgR4RbyVUGIQfUJ+Dsuo/pZmuJEVElRRXetcwVefa6+DKbfAgAwOy5z9DYjx57c1kI6thy3laHa1WLlmFVW/27fD6kUPVEmjTIwEYYcg4I+YuQCeK4J9Ts7iLNtT7NG5dQAelBPgA8nxjyGqGjBwB2g5CHxW0g==;31:MsSaG2DBXylqpRqPI+7oE3f4BLlBTXEdCxIXdaVRZ+oB/JN3ao5qHKSw4XqQ5gOrHkOtBJ7crXFxaxzZ3jKLhsZoLMEdvhmewi2u1UWjmSIfLjpAremlQSVDR+624n0AtLgRHlTlULv544odYDoTJEyUT2fs2YHxCsBDfqYsJz0okDIK+i6rt+6/qX5y5uZPSLOklqF4L5u4xkULENFmaAVv8tA10f0DVGQVvcdlriU=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3029:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3029;20:Evf36ZcSPaCEtWwMGCzMMdv/IXre8lh9N9gtofzOC3oAt+KTX7sh0FdESHS8Uh6ROb/Vcpj4LINWtyCBlxenc+ee5Wyuzhj+4G4N3NdImcEz1rzvlwLmCouDb7kXL4AtlXaaCcehi8q5myyjnn5OfYAMKoApJdcDTzID2q1FQ6LgTQQCGFw64VwZzj/PnfxuakHhhuHGY/5MJ0WC1z7F1Ov/cG6URM+OdKFFxwq/PHMb+qtCET0ZH8Qc3uX7uGUY;4:WbKqoiwEz8UYL5OeJcC0sjifsN/NpkV3Nt1SMV/zBR8Najob4H6O81hGhZQ7PSnEXxVbkpk2kWCBjci9XU7/SeRH6i8uJ67dYhTkCYhDLmfb6Nu3h7uhhL3m0IutUYoFlNgj1Je1UR/ic8TsH4ZwhxtSHvoTWru9nYEHc1n5499L/ePHb02iYI17cpoBWrGijBZHe515wO7PdggyaY8NRPr3qyYpxRfdVnIiwvPcMYi7C8Aw/mn+WhN9HQxoFLKTEv47aEXEfHEwO1d29o8h1qVueLMFnBmBoeNm0d5l07I3Mux+wh0+MOhDDbVh/8bD
X-Microsoft-Antispam-PRVS: <AM6PR08MB3029B1169B20F3DA7875BB45E4930@AM6PR08MB3029.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM6PR08MB3029;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3029;
X-Forefront-PRVS: 0673F5BE31
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(376002)(39860400002)(396003)(346002)(366004)(199004)(189003)(3846002)(16526019)(68736007)(53936002)(5660300001)(8936002)(2906002)(50226002)(59450400001)(86362001)(76176011)(52116002)(26005)(7696005)(51416003)(6116002)(386003)(446003)(2616005)(316002)(476003)(16586007)(81156014)(106356001)(105586002)(97736004)(81166006)(6666003)(11346002)(956004)(486006)(478600001)(50466002)(6486002)(305945005)(48376002)(4326008)(7736002)(25786009)(47776003)(66066001)(36756003)(72206003)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3029;H:e113505-lin.cambridge.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR08MB3029;23:7+tBYMrSEE5KLSgs61zrGaeGPqE3pOPYn39+TAndX?=
 =?us-ascii?Q?pkvaNUcuSxLgVgLufd9ocaknedzz8QguyLzF0O6fX5iogZ8grLaiSGo83dzY?=
 =?us-ascii?Q?xgJQxeVW5WFZW78qhNg+aSB0mkgSF86yk6RRzymu9yWbs5mn/trKIRAPDHB2?=
 =?us-ascii?Q?7nQradfaHLXd1azRBAQ9porJI/YRQbiKAZQVshAeWgcuCnK/zpa0hkoFawgK?=
 =?us-ascii?Q?h/P2mB9DoEX9GyloJiViTmm08svvUDnpUvnpd9eM9RPlOpGmYax5szUpqUv/?=
 =?us-ascii?Q?otuq2KIOpaR3hBtLkfG+wivAFxnS2S4tD0iOO62CXAaLE7q4z5k4eQr0iWO/?=
 =?us-ascii?Q?w7djvOPsA/+0uryGpGcAIidPJ6QOkdpyj+kpUDH8gXTSGhTiyx4WlwC/S+SS?=
 =?us-ascii?Q?2L0zmP0MsaHBB7+sTTm1KPZOlxeLOhoFeiZBy3EZKflXQbzL8xr7Yo7J3B7t?=
 =?us-ascii?Q?/gHtc2WFbYmwQJY08Ti7FWPJ/K1bi/rx7EWStujLrj+1v1FNvyrLovVwRbll?=
 =?us-ascii?Q?o3WdnrJZXYhGU1abEZTRLflb3kdLVYUQ9ImcTe/tZXTGVSKzEHz+fvJieLN1?=
 =?us-ascii?Q?sxMrWYTCn9Zo3kKyYgYQOOtZqH7rTbTuqLLyOrTYhekrd678ZqXVEMEGp97Q?=
 =?us-ascii?Q?AZ01D5XAtakhb84qs0ssQb8hHObngEOQbaOYM0LK3MJGf7sVeZt6Iv2Lh1st?=
 =?us-ascii?Q?FTNcuXrUNll4KR9LZUqP7dcggK6rnSMz/QLJnFQPzOW9xMwXYp54MqZcAqqW?=
 =?us-ascii?Q?+47QEmWLo1lrPWGJTs6YnYUOZvRF+5rvDWmtpKdhtbFt/q9U9syN4i9sgVKe?=
 =?us-ascii?Q?RQjfh0ieorlpWJBvG653QcNGL6vrAUFezPp5q+Hel/viY0mcUGHRVHw1nwef?=
 =?us-ascii?Q?oDa7p2kruuDjQapQaDw54qjS1DBdp5hx22BFOkAFdZs9iOhISjZCv0+DFxeF?=
 =?us-ascii?Q?5u6kXFWUqhEHRHmye+g7bsGNvttgHY/zSwK+4DrcrKII/XvTpTvRC0suv7HA?=
 =?us-ascii?Q?ULtzjVTkMqYz1yA58kic/BCOvOzkBM0S6su4+CsyRvdYLokKeRtLmycITggy?=
 =?us-ascii?Q?PCutqBqhxYsdhImUImpoIEmlt9prJxZqC+gsWddQrnC4bxTmZ6SfwlOiXBIY?=
 =?us-ascii?Q?hRK2hKH+7fBpMzYD1jnK1hH4Gb5EwRxbm+b3xNPRmLnWfLFUrkWTg=3D=3D?=
X-Microsoft-Antispam-Message-Info: bmseAF1MIod7j0GRoHsNtFiUO3OKI0K8CqOGUgFJHDmNZDKgOBRUBpskefx6Y5iVA5bkG3OHT+itQ3jwhCzxgqO73B97m/dpjiBkJ3k17ZIlEPxKIX8+qd/j9wLxXTypv2vw21nZVYJVnphaF+RQwT6vh6+k49eXSU5RTIu4A64E9sXCjx322v7KlydI8Cvw
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3029;6:9BCPdeD8g+gjqSgBk+1+uF/T/BN6uL+D1AkAvz/RL46uImA9NzhcNxbIwz2FAmOizbvhs3SRo8okxgs2o73ArAYgrUbQfy82KGvi6KlavdnXBWjGYKeThQEoSnupB6TxYLGCSx9pHvafF6bRpp6MYEJEVeOAR5Ayle6pZkAj3GKwhCJ1A9EQn/oCPqxEVEWzO0OFP+CRtnAKoo6mpbw43i3fZBdOp9tO4SU9vEOzL9xhK43ssh+1ygv3M68T8/WBWZFK6lepeQQcI2sMG1Yc2PpmBkqpThBFrxUMfcyXXR02HnSqlEgY2X+5i1tF1kgcd8n0zOWXd5WZVaKydqzuBWq+BY4sH+GYDIyPmb28OHALZfk895SQFazFBE9DunDpZOx9a75F4yia9fIR+oZLoLy6nTfLhEl35+m2ohhH55qmul9SReMf2WyRvf+wSgYTHynPUfb4+cD0XXo91Nie7w==;5:Yw9V6UpekHpxlPjexgmbxGriyab2k3feKzlulb9yarQZYE0gAD0wKPweNQH/gQI7JSpGt8kkw42zK9dL1pzT0n6Z4BppoK71vLAcRAyRIS8zASD+DIDAc4ceEBNXuy4WK9yNrQq8mXPe9MfWItvPIFjtaDaBXSmX/knQKAjLutA=;24:Y2amHtJyz2T2uJCVy5JWIHlOXuJVk31ujDnNEg4+UsYvSsX4cbVBPKLPDgy/279KjRfQcJK5YcYHPTH3Oq9Fzx29WYrG+YVoLY3nAYbg84k=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3029;7:BI0O2+R6oy9RDo80B1/VBeh7awIy8xKkJCszIr9wVaGb03Fi+K3Bq3nM++eGFlvv1nHVQPbG4IByJmtWlwyU7rIsXt6xMyzfQqBu+A98CnyzdC0EsQkGXxsZvVIPKr1lSWaP8hvjmZNorclGvQm5pWrknBkZkLQjvqGCbO3JWc+E40u0its+C3SHV2Y8B9tVoqbuWJJtMNrrO3g1WvbAzXz75Y6FSHLkgFJRy8n6wdvIF00wY2iLyjz7QPQ/WQhV
X-MS-Office365-Filtering-Correlation-Id: d136530e-7189-4b73-0e98-08d5ba7d8dec
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2018 16:04:35.5497
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d136530e-7189-4b73-0e98-08d5ba7d8dec
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3029
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
