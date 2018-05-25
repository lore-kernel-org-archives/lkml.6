Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967075AbeEYPgD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 11:36:03 -0400
Received: from mail-db5eur01on0057.outbound.protection.outlook.com ([104.47.2.57]:58944
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966725AbeEYPf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 11:35:59 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com;
From: Ayan Kumar Halder <ayan.halder@arm.com>
To: liviu.dudau@arm.com, brian.starkey@arm.com,
        alexandru-cosmin.gheorghe@arm.com, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org,
        airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc: nd@arm.com, Ayan Kumar Halder <ayan.halder@arm.com>
Subject: [PATCH] drm: check_pixel_format() should return true if no modifiers are passed for a supported pixel format
Date: Fri, 25 May 2018 16:35:41 +0100
Message-Id: <1527262541-13964-1-git-send-email-ayan.halder@arm.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: CWXP265CA0063.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:2c::27) To VI1PR08MB3040.eurprd08.prod.outlook.com
 (2603:10a6:803:45::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3040;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3040;3:kgg4fIjA7WVEE8IIId4RmcrrhP7iqJnaNz7p9if3u/4BTc5gT0deAI4VCkz2nVFgxY5YUB+ajOfozlhVAFeoVaX5/byLBAE5mNLc0QloUSEBblTWwod0hFgHPTkKHp2HmiLKv6noBwAszYfcP+PFEk+3XReyyLK0b+Lrs19plr1t5lN9eof7wDVGp+TIPbkE9/4YqC0AkWxceSFI3ltMPdXCTPauy67xvCmB6OEpMeRa1mDVtMAQcDObTqoNAByt;25:CGLYvi4qw5NSIQrVD3LdVCeTt8z9PygvBWj+REyeEtkQPNGVVwNmToO296GyNOI7tmRTX3FxxHn3lwVSUzDZaScPtRTBERupVoZDi49bFVwt6atnXmgiEwhC+1Am7Xn70eldAnNOc5t5m9GRzrkGlpkYv2UUs8vyD28XqM2GNa33ZaTgFwYO1DBcgGmbk/wpvRkTQl6fG+icz51jPz9MnapK44+i176b1yynAMxXSJ6ePyFRpv9vcXVXqw/3uJ+5w9O0WPMFUa300vuqU9xIRf4zJ6ELeGUhyphgwJWlcYD9R6CzhuDP+A+YeDEg7DX0Tr4TnsqtDZMJ2WAJK1Z03A==;31:pPknXViKp9Fo6VpDw77piONClFbOnb4K1VNAmfd3KsIXmrEyipb5h5kz5Er0WJD25WFYK3GAAnw7o3THvokjYb/idMD+2cqYwdEFgXbQ4Zn7fzlspJ6Fcai5KV3+Wo7qd9d7Y4bamShqcG8/YoiNCS6A55QQxH8Td78RMM5x+yPNrESpEEEMi8S3p4uRIP68roXWuf7RUOCn1ei4617i4JD0Z8EHEeYaAwkj1sgGXzA=
X-MS-TrafficTypeDiagnostic: VI1PR08MB3040:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3040;20:um/CJfv4PpQ40dz9g86hxRjYjUp/d/aXbQird9SwQ+xGMaTwtcal+ShX38/LSahXFjANCZyIaMBB5sEBWYZ+bLnLRjbeaPCIrkxtI5CYM8Wu2gPCkJJ5x8synJALZdvS4vO/jMrdgz86zGxxt43YFu9smaJfSfZydim0AqZI9BfmBrUS5YS8vWmPRfPqJykRbltM1iorrl0jb4j9mnbepVAz+W2YQP9YL/bqgRWDxu/JN9592PhgI8jW/LnKw84z;4:SrKp0HHqdBNaySEB1WQqu5mPDhU9Xxo9tlYE1LdyvT2IlAW2dxWLyyDeG7nh39uVe6weOUxmA2s7AFKe/EuPRu96E7AJzDcI43ZJoMNvdPF2vhMcBBVYDXrw7PSH0CqHrUPl4O3sSjTdlL42t7bUYnyySb5v1bpL/j43iSMTCxSyjJV2t/2zv0DJyexfz4Kh7jC5b+Iv3SJjdSag61mmFuYOc2EqfOn4whM5SZvGLu3IaRya39kcpSJmFyDTIHJdE+5o20LBqccdsJXPBeUeJ2XEV8CE4FFFDgSiYBLg9VUQl/BSJzI6iU4P1Jr1IjK9
X-Microsoft-Antispam-PRVS: <VI1PR08MB3040A7FCA17ABD825134B7E8E4690@VI1PR08MB3040.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:VI1PR08MB3040;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3040;
X-Forefront-PRVS: 06833C6A67
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(39380400002)(376002)(396003)(346002)(199004)(189003)(86362001)(2906002)(52116002)(6486002)(25786009)(81156014)(48376002)(81166006)(105586002)(316002)(26005)(6116002)(16526019)(106356001)(3846002)(16586007)(6666003)(50466002)(8936002)(53936002)(478600001)(36756003)(5660300001)(2616005)(8676002)(7736002)(386003)(1857600001)(68736007)(7696005)(305945005)(47776003)(97736004)(956004)(4326008)(66066001)(486006)(51416003)(50226002)(476003)(72206003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3040;H:e113505-lin.cambridge.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR08MB3040;23:nkZQbeo8GqT1pQJWiXFcYF8d26UNhXn5TEqSCYgMy?=
 =?us-ascii?Q?BF8/e1Rvbv5JYNq6eNbXLGam7BhjryMdROvJC1CQvWnrAeRC/2ChaQ4zulzJ?=
 =?us-ascii?Q?4FgjECgm0xk5qW5+/XW59M8/0QgB7FqMkWecQF7d+CNnGvLZ/g5XSzQmCOZE?=
 =?us-ascii?Q?+xv8L2iP9RccYnMP7Y5Ywy91hWEJh65MLycCae6toxJoSuK3CNuJlgE5MvKe?=
 =?us-ascii?Q?PvfWDmeeLYXOqY7rscU57kuE5r6OGCijjl73gJKnvHTDQfaD/oGbIuElgo8v?=
 =?us-ascii?Q?K5Lu3Ulxv+wtFLwN7v2FEkxiBxo1XGlAdusAP077BNLG8JeDHYnAFU71XU70?=
 =?us-ascii?Q?VIb7PZfjPrviRILUKVpj5DoyXLxAmb9omWAIz7Q6//HgiQ9ny5HG3nwXc0k/?=
 =?us-ascii?Q?QIrLw15EBKhAn/RTrZ5VsSCLv38M6vwPZRuLMs2obLlpIcx8tS1DNyoisd13?=
 =?us-ascii?Q?FL7gLDxeLfU1+txhiu69wkP7Dv4JumGm5b3um4v3sRO7E+ghF1mFTodBRGcj?=
 =?us-ascii?Q?Z0Gcdr0ZPateoODaOwi6/A93JLtqQuOAdkTwLQvukj3PIlB8opYEX5KYOAtf?=
 =?us-ascii?Q?axfjMK4qoBtoLAzcy4F3Jev+L8Gd1spGn3Ckb6cC6VRNvTWCkksaUayh+ihN?=
 =?us-ascii?Q?eU6D7D+gb/hNWRya6rigWgaNmIVvh95IL63jlAAVIN5xg1VDHi9z8REmYVS+?=
 =?us-ascii?Q?mLtSmeiLgo51ED4/q8a6gZPHW3L47A4rC3quZDhOvkFqXK/aZbgpwj6ouX1/?=
 =?us-ascii?Q?9skB8BKKjdzANrIeO4f4WkWmJ3Xl8bv6nxH6MLxrDTY8S2L2IIOkSZVQpQby?=
 =?us-ascii?Q?Gw457LZJopykkhxk8WTTE+TWUx0gaj9I8OGJkjdGeYC4MY1ovYVILJhl/okx?=
 =?us-ascii?Q?gsCi7ja85Jrnv/uxkI4eopK6U74cC7upKPU5VKyldH7WkdvFsn1fcJ0m8LVW?=
 =?us-ascii?Q?gnlg3VhJ4pduF4lZZwg3DMwRye6hZNKbVMqOeD5+wwaGj/8eUYNFcn/bnqMG?=
 =?us-ascii?Q?SoLZudCYi0YL3QvCwGcIjy8tw9PTGnsEfEJOIZTa4+rNdnaZCoff4cr2Gs/b?=
 =?us-ascii?Q?7xLN8LDKBYK4WlLPSPj5mhwxH90yjUc4cq8WPf8vMJoOy2PyUi07rWkJB+To?=
 =?us-ascii?Q?cKkWZDq0+A=3D?=
X-Microsoft-Antispam-Message-Info: ZA6OQvXcxqweB61cjLH8tfBfTcN61Apbq+YbObh510YcmOAvcl/MiMkwkvfngHsxmuVjmVomaySdyCHM7PoP4IfAdu+VT8ymJ7oC87SsTC3L8WHnWwL7KwtBCTcFX9rtpGs78zfvr1CLIL5SKnCSAiquPrXrswO9VukZ3ukeK+R2MKtBBYJe+kbbzHAs/mIi
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3040;6:A87nyQaij8WwdrQvXnyAyFnr2Fl1+6n7RA2IoeVpwyqd9+o25rhnasy1xIeRs80MR1DSKy0ItgPSDsMmyX3YMWeZgPIH2e6wEunABDSiDJo8t2NH0/gZXMqWhZaPKpCSsevKIDBbPFXNCjQVlGtuLpnSkDaXuR7gpq+GmJmUjL0e1yH1gRL4wmFimMdQqsP1XOi+aOOnMt8xSFC+PVQQjjv3RhjojSNoSLAJvwzoTxTjCD3wq4m4NzEkwCQGxXNbgg3ylOtgHD606aNQadhr8ml5wlxgnjpzClqJfnkz0nGEvvs6VmBnTFz5NNLtAgU/hQCmDfql7tAKuPkQaHPpdQI9r2ckhLtZP0fDCvnV14ieFN8RTMmEjuC9HaxpMJoyyoU/o7cD2JdM2GhbwRYyecojTXsV/FRNGbHQPECWF8lbSIfzkJIDgtiTmL+MsoB3zwf4SJlRpX+yYA2UtQHpzQ==;5:s1sgAUB2MhIP4z024pTHnmOOJVKQ7oM6OJ4ydljhnbndEp4BAJBoiqytbcw77eUbMStuH4AAXRJfxgxY3RWSaw+qmp45wPtUHh3zehmMBDzf3DiB9kOvZDOQATiF23Via0sWhBDkCgJ9GM2H9HkhCAnv/M1gHioE6XiKjkaOzaM=;24:+zk4Oq94zhQ2NCD6fmH6/IZwSGdrkp0k7zWf5RAI/q8FVS0iBmjF7o7prs8PCJgDZiLX4Y4h+O5O9/+p9oWbbw3wIUkzL5JcfFa3N9m5zew=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3040;7:S5WZ5cGl0hXPwk28cZkO+OX2Q/e3SyUHj4WFM74B+9iJYytD39NjhRKcToGjy8jxH7dX5UqXaej4hvf4MwZ/bFSbBJtfe47z5pZdLa1gumovphraVDpyFEfiFP2amUO9WNmpyckHb4jFnIN/Jp6x3kI7ZdJLUIoo308o8jZRADiz61wqft3zrKwDvbcBfq37rHOaKCIenPOTczlJedqGGnPxMOwARyeskcrwDhPCdNm0No/RLh7lnr4+ScSNsEMo
X-MS-Office365-Filtering-Correlation-Id: 9e681517-d2de-4c84-9941-08d5c2553523
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2018 15:35:55.7014
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e681517-d2de-4c84-9941-08d5c2553523
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3040
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a plane supports a pixel format and the framebuffer does not pass any
modifiers, then drm_plane_check_pixel_format() should always return true
for the given format regardless of whether the plane supports any
modifiers or not.

Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>
---
 drivers/gpu/drm/drm_plane.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
index 6d2a6e4..873c084 100644
--- a/drivers/gpu/drm/drm_plane.c
+++ b/drivers/gpu/drm/drm_plane.c
@@ -564,6 +564,9 @@ int drm_plane_check_pixel_format(struct drm_plane *plane,
 	if (!plane->modifier_count)
 		return 0;
 
+	if (modifier == DRM_FORMAT_MOD_NONE)
+		return 0;
+
 	for (i = 0; i < plane->modifier_count; i++) {
 		if (modifier == plane->modifiers[i])
 			break;
-- 
2.7.4
