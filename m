Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752037AbeDJSZX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 14:25:23 -0400
Received: from mail-eopbgr50053.outbound.protection.outlook.com ([40.107.5.53]:8667
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751929AbeDJSZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 14:25:18 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com;
From: Ayan Kumar Halder <ayan.halder@arm.com>
To: ayan.halder@arm.com, liviu.dudau@arm.com, brian.starkey@arm.com,
        malidp@foss.arm.com, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc: nd@arm.com
Subject: [PATCH] drm/arm/malidp: Preserve LAYER_FORMAT contents when setting format
Date: Tue, 10 Apr 2018 19:25:03 +0100
Message-Id: <1523384703-17621-1-git-send-email-ayan.halder@arm.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: HE1PR0701CA0070.eurprd07.prod.outlook.com
 (2603:10a6:3:64::14) To VI1PR08MB3037.eurprd08.prod.outlook.com
 (2603:10a6:803:45::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3037;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3037;3:tKzpaEu3LzilqhezD+doD6PZLi/1oS+ZpqXVYkLMhJ/PB1m1TT6AfdbMvol3VUAgTGG/AqrFTPPeq2RtSe48k4V7HaNmpTiulF7RNVflMfVA5ZcHFPXhuD3a7vd6pvfidaI3T/Bi3018HlyByfsj6mJ9555QIv1a2yr0JgqGQpBEXAydRlWtXFgJ/YNRpSfK9Zovbc4IBCSJsFp5cneG+LkDGew9jXgcFQL+BRnVSBXhvUrdXdgPjTiuVbFMtjy3;25:OPoliLL9hTwC5+ALChucRwhHPenCGlIjj4Cose5BXB/uTav5mX1Ar2CTEIwfvF4qGv7Xl31hQY7F/4wpFilJm/Ew3yLjcYTx2kmu+TxI4HeXhvAlIKobJtYMUTtHqfJaJNbi03tFoLP1AADI1uxNT3gIxy53/nZEad8/CNgDclaigPWby8QTwYm1+474GenSpp46uthT99pke7gE9CIEo5ADcjGtl7W8o8gXXAnyGOUccVl53i1zrSSPoD/rWfDsAPp49urIBkPTwOc4LeKSp3/koW/U0Z7TGoBV6eDL7c4PmiiUYjdgNxomA1bGIqyEXqEMil2eYntvoNDaDn4BLA==;31:9gv/BlfYKJ7f+nY9iD7Nrhhdyq5xW3k8RG4pbC2h4lCMRphiqxJnfTbSq/ZAEsjIWR4vVKi2IsdIsLlNoyb1Ft0Xs9G7v/H8eHdMD17q8VP1iWNgWW5L6loJPxi9hAnRP0GDh/ZmH5+Ck/GtiMM8q7U3eeboElKexVbnBN1PP5aZFc93qIGUgfmLZVigGHJWRDn/9YhxQJeF1dnLJDgojaW7p5sbPqMBzJ+ilvqUGKk=
X-MS-TrafficTypeDiagnostic: VI1PR08MB3037:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3037;20:9meL02b4VOTrpmYlZpiCYxHS9n0TQB3ERrD1tcKWGjotw7vkotseTQ7OUw8G0aWsaUPpf7UZ9uprPBxpnt97+L3qlV49GgJl/JygAT7re0RpWgRnEqEXW6C+cOy4HHw33g6GC5hoUUzYh2xlrVn2ZSZfdWmQAec5bdBlGwMv8uU=;4:eqrAxendqk3pQX7ntIf4z+l9ZU3kyC6PPtIWiKFe9tysoVZLysjfLwxPISltrKVxW8W7lU9gbEaKND4ZpY2SP/asir5z85GywVo+C4Vqy6TFLr66UevYhzxB6Y66PRNjv91/y1PNXOX82dp6nDJS/XpSs/mKMhQ3LDAkBBI/QzlfZbYUpuKuIRW2SKEk50lYqVz4Tt0WIfu903EZqqBLJvbyGe6oUlnLrhVY0kiG9bIzjL+zjFGq3AR2aWSw+V5BWDUA8bdCKRS+JWeR8Opf8QmxrXdtis3lyZH4SHZ3IU9rQdU07TBq2sAp4PqJu9cA
X-Microsoft-Antispam-PRVS: <VI1PR08MB3037C83D695DE349B21D14C4E4BE0@VI1PR08MB3037.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:VI1PR08MB3037;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3037;
X-Forefront-PRVS: 0638FD5066
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(376002)(366004)(39380400002)(39860400002)(346002)(199004)(189003)(48376002)(4326008)(7736002)(53936002)(106356001)(16526019)(50226002)(68736007)(6486002)(2616005)(16586007)(81156014)(2906002)(81166006)(316002)(26005)(105586002)(956004)(1857600001)(8936002)(305945005)(476003)(36756003)(8676002)(50466002)(5660300001)(45080400002)(47776003)(52116002)(7696005)(51416003)(66066001)(386003)(478600001)(72206003)(59450400001)(3846002)(97736004)(6666003)(25786009)(6116002)(86362001)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3037;H:e113505-lin.cambridge.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR08MB3037;23:2ahyZpfHF0goWPfLGQmWKNcboez2ntn1S8ENq+5vu?=
 =?us-ascii?Q?izlm/QDZDxpGpVNz5I0nnlggrwyCw+lQcCXHHStWZ8pRB0hA1lD/hfNpXthg?=
 =?us-ascii?Q?Qin1CsX9NL4TbvEZS9tohdmvT3ltt6/Vzp/C/+zn97ZtZFLZlA5+5PMQ19gs?=
 =?us-ascii?Q?OVddSKFE0YjQgUTEQACDazimNr8dyBG3ca+9/oThJSvgJL0UDiayCQFdggc2?=
 =?us-ascii?Q?q/pMn8m6m5Xq/XmPapcDogCXNW2GCOn87uSbtX4wxZV0URhjwERA2AqwcQJK?=
 =?us-ascii?Q?KKQqvSPkSwC402S9ZD32ZI1J+cuY4nZWSOS/xoQjQfcyl4mWIY0RGUTcHNfc?=
 =?us-ascii?Q?8AMerwJyUI95BWdB6RbfbER51XATFrU6TsBGzXQKH6TCe6YGJyJ/hTjU/YoS?=
 =?us-ascii?Q?nrzsGcT96xQnNQwVMggt4RfpKp0SqmWIXTpMcQ6LPmQk/YHXIjCygIMhCTFt?=
 =?us-ascii?Q?1VVGVynldhtpm6PJkjInj1E0HciOUACEM6hvqMCFqWuXGbdr1WpKgEehi5Aw?=
 =?us-ascii?Q?T0xoqHJcE7c97HSTVC9DB3jnzUmLIImsi6SFhP7FtiAjhNuYlQWYlgkbn/I3?=
 =?us-ascii?Q?nprnBBKMpL+xVzGBqR6bzLMUXWvaNKC8ofZhoj1EYs8TJ8kGLq5hO8nL7424?=
 =?us-ascii?Q?pzP2nf0tIq2770nOon8QEVFnboOVUVbtXBZrk+VBFigx7wG9KgFV+j0A7RyN?=
 =?us-ascii?Q?3ZmJgwpNUKE48RDudDoT6DExHDNiZoSwFAhegD5AB6yjUbvm9EuUXjGzyOMT?=
 =?us-ascii?Q?s/eHGUF+EXDmNPKgSlEyrBNdcTIi2vE2z9jmEeb4acWMDUcnAG89VVjPxN8b?=
 =?us-ascii?Q?Cs2Fx+uN/jj5g5pmX940POoQSuWZFaPj0s2aGhwFliltjBXPdQDFTrgvW143?=
 =?us-ascii?Q?TYdYu+E7Amzobs7dwcE8KS9xEOGiZLWYAulb80x4ndvbtuyt4TUaQFrmaPl9?=
 =?us-ascii?Q?Q5mhbqdb0MeVQWEKdkq3/xIrqhAxZ4oXO8rbi6s3mSIWM9lKrvdP5/77HVmP?=
 =?us-ascii?Q?HvcDHoZAz9gcazTgbz0cTdAP/Gpc/URR6+OxlGTLYQEvTynsenQdEsy5ViXJ?=
 =?us-ascii?Q?UuXCdnfxhozeyjsZZ1xcCx4GA/YlzL2afxRjh5y6JAdQTjAJpNzmwe1pccPB?=
 =?us-ascii?Q?JXCxYoR2/h5ySkzAtuY4SZV09fahnWgp9qEMUo6KwTyndOG3nsRFg=3D=3D?=
X-Microsoft-Antispam-Message-Info: r3Wwz9GZvWneAT5kAiaYDiWwFTvxX3123hnYfF+t8NIIPMc2neRCvCpYYOsp8Xre/2lTgQvS5/3r1tpKOcFFuM1C18uVV6mfNxuvXG/ZEXphs4KcBrhEq0JfpK1NZdmE3in0e1q6VrdWnW9utqAAyt1hDeZcT2V7oG6uxBpfz+pj0bQ86AURnPktOlMFgJAK
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3037;6:pRS5D0IOChBdsm3vCtEvG+dc2gaNy6lHFj5xCNEP/q/tfCA5GSazxQR2dBXwdXvawgsuI9LnbfdyJguS9artbr/NX22v+vaJ6h3y+3oO2NOgUmOyMm7nnPcFow5klGKFb8Mnc74yra824SP5gySZb7cm8dHy4ga2gaRPEVsaL4lFFUkO3Mg10+TzK6Ms3IRp+de7h6+kEhLpzyr2C3BF0ik1UqcEZA02AddNhnFwqhNDSyvUI+aOYdQjMk6xD/MOFcK0sX6QNsIbBX89pl7HyMMxHhw9taoiJAOSvIWwwVTDBdpbpgivN134fZ5XyXCZL8MtxxddK3aCcDqiplPDJUBguLLhn1NSv0AAAtCTl+miFz6ULmpKpzpyS59A3f0Rjc2L/tMVmvvGuroYYNRAb2Tog2JhwCaz9/x5BQyXQrRNa6cNSpI1b3UF5nEedAnajYAanrbgHVDP/jSnVqs1jg==;5:23wkZY9GyLJCUCHlU6gIPtR22STwS7Maw843/K3q36K+Sa7ez9tEMc2Oot2ALU21WF6qbxjuRRCuad2O17yGc7QBIQ7m8qMziGmxQIfAp68kV4fdSUDTBcU4mOu9bQTC2T0DYpEytSssZs/BmUCvWwMnre8d35EdXM/S0NF5y2w=;24:Lt0eGYEVpHHnTOsM2E8c1PDdBckDVD6viPt/MihcbDpM6ahL5xm+7hRPWKq6cCXnG4+RgP1GxMMUFGvZlqpzWbmd/izsDSxczfMEv4TvOfE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3037;7:JWJsifsXgj3E4rFhPgN6At3rX4zuLRnRhFMu/XInY6qxAP88lK703dhyQmbpWO4tg7yEKkYgOAw22Bf4rq8366oo8fOezS0LSj8Ivew2xodOzFuMH7/N7+nLm1t3l/A3Qt57WOGx089zjwgpZredq5Jk71aU/Sn5MUwD+8f+MScovywWmUg+96DazTSURcLbzfy0EsKINN0KuSycK8quEpUWpYSLz9fLV1XxvTKvlPtcZo9JdUnxfnvp/NCxXMbj
X-MS-Office365-Filtering-Correlation-Id: 1eaf3065-bdee-4d3c-8dc3-08d59f10679a
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2018 18:25:14.0986 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eaf3065-bdee-4d3c-8dc3-08d59f10679a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3037
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some Mali-DP processors, the LAYER_FORMAT register contains fields
other than the format. These bits were unconditionally cleared when
setting the pixel format, whereas they should be preserved at their
reset values.

Reported-by: Brian Starkey <brian.starkey@arm.com>
Reported-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
---
 drivers/gpu/drm/arm/malidp_planes.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/malidp_planes.c
index 7a44897..4af3c1f 100644
--- a/drivers/gpu/drm/arm/malidp_planes.c
+++ b/drivers/gpu/drm/arm/malidp_planes.c
@@ -23,6 +23,7 @@
 
 /* Layer specific register offsets */
 #define MALIDP_LAYER_FORMAT		0x000
+#define   LAYER_FORMAT_MASK		0x3f
 #define MALIDP_LAYER_CONTROL		0x004
 #define   LAYER_ENABLE			(1 << 0)
 #define   LAYER_FLOWCFG_MASK		7
@@ -337,7 +338,9 @@ static void malidp_de_plane_update(struct drm_plane *plane,
 	dest_w = plane->state->crtc_w;
 	dest_h = plane->state->crtc_h;
 
-	malidp_hw_write(mp->hwdev, ms->format, mp->layer->base);
+	val = malidp_hw_read(mp->hwdev, mp->layer->base);
+	val = (val & ~LAYER_FORMAT_MASK) | ms->format;
+	malidp_hw_write(mp->hwdev, val, mp->layer->base);
 
 	for (i = 0; i < ms->n_planes; i++) {
 		/* calculate the offset for the layer's plane registers */
-- 
2.7.4
