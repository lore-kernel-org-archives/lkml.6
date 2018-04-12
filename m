Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753691AbeDLVPi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 17:15:38 -0400
Received: from mail-eopbgr30115.outbound.protection.outlook.com ([40.107.3.115]:8544
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753639AbeDLVPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 17:15:33 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Subject: [PATCH v2 5/5] ASoC: tfa9879: switch to using .probe_new
Date: Thu, 12 Apr 2018 23:14:37 +0200
Message-Id: <20180412211437.21599-6-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180412211437.21599-1-peda@axentia.se>
References: <20180412161601.GI9929@sirena.org.uk>
 <20180412211437.21599-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR02CA0105.eurprd02.prod.outlook.com
 (2603:10a6:7:29::34) To AM4PR0202MB2770.eurprd02.prod.outlook.com
 (2603:10a6:200:8c::20)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2770;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;3:sqyal9f4mQf8Q5SltMNIewbti466yVbJrUoivM9Ih63FQ+IXbDIe8kctW+E+TY6gvIGqHhVPSNAhU7o8BUJ20jsqbaBdXoIhUrko9CSFCoEpU8Gz0x78bf5JtxqZ9acqe744KJWPfmupMY2yTOAGjSg+Gn+nvCp2bYVoWo59rAq4v2yKhDMk+ZrpFo/DHWaqR9gqK2aP/0UEyhVkChllY4p0/8RsqQTmmkY01OYdKuHva7fiX2tKTkDkyrTtT9VI;25:1iIQQ/RVZGegPPnhaDuXFiDDQPtfFuovVPSZRLYxrJ34iyU7qCpyinwEVMvvIwxVa52fG/WSEzmCKtzdFR8kTPRYN3MnFxFhpbBhBwoqZ8htBAxwzyQNtXBV0OIwosK/Eh64s9HkUWQu1KczI64ncaYtk/RUFCyChp0IunyFtXNyPJFfxtIiRjal2XzqWsxJx2BZudz8wX5tjAGmBbbjdp8dDpHU4C1jpO5SFfBsy9g77bBs8xnAv3t5FIzoL5lceGZ4jXBk+51k2RrDF7XgNvgAewvAQ9uoGtSEIuL89gNmPeeaAeGK0BSFz9mIXpiE6t8wvQS1WxD32G+TuDsmuQ==;31:MW4XWSCS10rOsq7SujIRRUSRsOGvy96WGZ9zkUwBmrpeYh9h4luXtTds0EOCXZQ3dPr/rD68F5ZHmlFEn7jfGI5Vr6Ssg/F5nUIKm0jHq8m9fcvmu6ykFjXToVtIln9yxDh/90zG66RPuhT509U+nBi9L1vih7C1uqa/kcZUsHd5lzDWIwhKGJqCxudTlLYksd/6pasbt/XfNNLKoywW5MbiNuit8u47+qn2c48rFac=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2770:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB27708F2DB2A6DB2CD205D145BCBC0@AM4PR0202MB2770.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231232)(944501327)(52105095)(10201501046)(93006095)(93001095)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(2016111802025)(6072148)(6043046)(201708071742011);SRVR:AM4PR0202MB2770;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2770;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;4:d6Vh9DyrhAaZLwPZkmn64rTMQ3k+ZCNgagUwvxOqi18qxtgiS+I3Co4uvlQkQmf09ylvvKCMCqe0BzKFo+Y9+R/SSx1OPEK0lZVRblHsL2xj6jVbNaAziCl5VQ9/KTKysy9k0/CZA8kfjldD60rgVlLxQZ60zG2eZaE4MKaTuwSgnfj/CW9/FfecFFm/MJ4z63LKfvLDgkYNR2sOFQXC7ohxk6GOn/rEWPfxOM22Oa46ON6P3GC6+XW/9ZI2dgsQU+lTesbACOqMByfjUvZ+eg==
X-Forefront-PRVS: 06400060E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39380400002)(346002)(39830400003)(376002)(189003)(199004)(97736004)(6916009)(2361001)(36756003)(2351001)(68736007)(6512007)(66066001)(86362001)(11346002)(2616005)(2906002)(6116002)(7736002)(47776003)(478600001)(1076002)(476003)(486006)(956004)(446003)(26005)(54906003)(3846002)(4326008)(8936002)(25786009)(6486002)(51416003)(39060400002)(186003)(316002)(386003)(53936002)(105586002)(74482002)(16526019)(16586007)(76176011)(106356001)(6506007)(50466002)(81166006)(5660300001)(52116002)(305945005)(81156014)(8676002)(50226002)(48376002)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2770;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2770;23:8HI9G5FDUQ8q8aHT+RoK+pbCLiJoUFNYRUiVphb?=
 =?us-ascii?Q?nKZzhDRK+gonaADWaWxuuVH/PQz7IffM7NHqYz1uoYuPqMBmfIaG/HqYtMFu?=
 =?us-ascii?Q?VMixEBzE6A0pryfx2l2A7TXRx10zRdE16VCNvKZowKBuWMk1AlCyxg3LFJp3?=
 =?us-ascii?Q?rBSEqJT968PclFl52FHY243g8TVrqQjuKWGsFfTZb+7YyDQ8pHr8dv+JSG+L?=
 =?us-ascii?Q?sGSX2qF2hnj9iL3lGSdzJyt+0lBa43UrjQDN6bam2vrDdzc6sCI5FdTWQPhD?=
 =?us-ascii?Q?pm7PDWIzLJaRvUFJtrig4PrECJ+FeqCGuJXwas9W07TcKf1NkrXDbS4JgU3S?=
 =?us-ascii?Q?sYP+t45/M++wK9OzxZ7R6fhvmGOWHRn3tWOslBSSO3RznOWWNGmSUMcP7/52?=
 =?us-ascii?Q?O6LSHNYAqv2EAOg8L21jpLyZjQJuPp3ZKRvPfiqu+kdfCOpmc3xCWXSlO4+H?=
 =?us-ascii?Q?+PpZl7l9FBmlv/o7yE6QdEI3+I7DQ06p6NDrRlAxFQfQUtpdgObejctKn/n8?=
 =?us-ascii?Q?OHL39bA/RkbkKo1umjqN/8n5hw78kRqax5lvLhCLMaaXnSAW1kz5NJr+poXF?=
 =?us-ascii?Q?B3S/rjSd/zUkCIp1OdM35d6BrHV1EEzjdgnjd762YjLwDM20ql7F+B+jKR6n?=
 =?us-ascii?Q?EOla4mtOjWikZwd1r9reNa7f9Cd13KVRt9Ltj45IMEgUthycL8SsByEUk013?=
 =?us-ascii?Q?j8/y53vJPvN+5LSZUyqs0PWxNvPVDfyC6DZB8JRpDeU5Xxo6ofqc07RMxEXy?=
 =?us-ascii?Q?JI5mJFSAJbcEnPnHo28uI0qNGT0mdjAI4hd3QCivlpSr/EHAStwOUYMOMlAa?=
 =?us-ascii?Q?UXbtsK5Gkyepx3hITd/7mC1gSebEpNVcRm9qQieqluCTmn4OAbHUW5GGX5iE?=
 =?us-ascii?Q?nIMQyx6L/EgYgqVZ0vOPfZQBlQa4rr8o/qavnXYHB4m/S3WE94/ARNWwX59D?=
 =?us-ascii?Q?2P3WV18tdHtkTfazOkdAY95stZKchhDChIvxFMU4V/XiOyuZN3pXIzuD1UeM?=
 =?us-ascii?Q?nWJNO3l6J2o7vyA0wa+BFJu96q2QuTsVqdZ74e5/F9JdaeJjW4aF9qMd2yia?=
 =?us-ascii?Q?fR3QDvSPgqgJp2vHnM6uKLNzV9Xqy8gtgdfWkRmHAhKcQbXilJEe7WmfoWa+?=
 =?us-ascii?Q?v7gt2YO2atLPGoDa2kA96Ip+1Pekw6HrVWeQCQVx2mGimvE1ZVxxSLo1YgrG?=
 =?us-ascii?Q?ku0A/6gTFhoc8/3dLeAnKvewi3p86Kb3KnyH2lCrIrCxLaOkDPMIbbq/gGcH?=
 =?us-ascii?Q?SjJ7V+tYKDrIksVwSiprqkJL4az3ofA5sxImZgAU7mguue2GRxOWdnQTNi8C?=
 =?us-ascii?Q?3Dm84uPv6vKgUAaBzMxYFqGmDGl558zDhx1psgJWgn2bx?=
X-Microsoft-Antispam-Message-Info: PBTqrvhdh0bODf86riLMaCFpNd2n1k/Afm+9c+dCw0OTidZN48sIJ+8v1KC9SNf3yBcTUju+Hr9GsymSiZLGg13fcdD8d01JZrSt2gEUESk2A7JVZwfzWzWz0flJIVkQyRluB2sEFEaEkdO+dr/oJSe4azuUhZEVI/77UCRAgAsv4iMInIIr7NbOYny9C0mE
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;6:EbN0vUrgF6RhKAuSWFazYb8JE555jTBVaUFFthc2rCA/ubYYdi7vSa/2u7lrX2Kr9ofztK6ku6Nfw2S0jvNBGrTDpKeD8hkcTk2JK/17Q0SzZL4rJZPX8/zDRy0+OrZt+xVvrWKVGUUBcO72YJuYF21dY0Os2DW6+476H64CYJM8RWdlaFZYVA1+IdJJIcDXVtQezu8+8q5zFfGzbhlgPzeE3/NV00VZqKl+sz92j/jbZGlKaBSDyZ7m0DfmWp1t+sT7jcidj1i0YW8HBf/I8Y9g8AQ55YiSP5WIMO+IVWdZ8zn5wGoH80r65R/2i0bLBrPtR+6eTTyv7W3/LyVtQmvBwA3OZ2+l2QMLUrLL/cW7hzQthanpGAOZebVYVNRyyE6FJ1Ymo/dTEbhkJC5qY5KGoEDIXp+25URFwyzPkQfut0wB+Dj58zvKDCzwMv4My/rtIr4PhSvhnZ04104j5Q==;5:VKvphFaI0FAUYfwctt+jBbeoluRCnC/X9y5+bIZok+l70IeSOcXvHm6vMO7dZVNSxOl8ZIx1n4P1O7oChDAiypsfZpbaf4sM46JOK8mOJsWiGTB+8U/t0bVraJrK1zP4quE0EhJIIUP9XNb/dYT4wruffsAPuRzK4zmEsUUSxEY=;24:ZmFvd3jJBp4gMWS9MH/Y5IAR1JlNvlM+LERA/0swgIkLgrmkpUCk8vmFPw1gart364iz/CrkMVjL5QlXENu0MvMFnLtUiD0fUfKcti3bVKQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;7:3udPTtsQtduGk+fmYWeYHvq66fQNFP7raviyoVFARNt8WYOjtuYf0aqCXs43whEvzeQQL/D3kGZmUJvslFHRTv/2Rdf4iL+tprdGLXtacBTGvaE0z8wRGiDTqevKHlOyjuLlkoDzzvGyt7wJtEWBBF0EzX7/SxDFPqT1VUWPVibKZVFEQL8b5OucVe0+uUx5S9LbUZJkPCXk9/pZ85kzHczAbl1KaWBODul9lhIJuHJjz+HDWua4NGI2nhcwybCE
X-MS-Office365-Filtering-Correlation-Id: f5e8be23-7cdb-4d1a-3656-08d5a0ba8614
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2018 21:15:31.1782 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5e8be23-7cdb-4d1a-3656-08d5a0ba8614
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2770
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new probe style for i2c drivers.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 sound/soc/codecs/tfa9879.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/tfa9879.c b/sound/soc/codecs/tfa9879.c
index 4d9b3f393808..d686e04bc5c7 100644
--- a/sound/soc/codecs/tfa9879.c
+++ b/sound/soc/codecs/tfa9879.c
@@ -272,8 +272,7 @@ static struct snd_soc_dai_driver tfa9879_dai = {
 	.ops = &tfa9879_dai_ops,
 };
 
-static int tfa9879_i2c_probe(struct i2c_client *i2c,
-			     const struct i2c_device_id *id)
+static int tfa9879_i2c_probe(struct i2c_client *i2c)
 {
 	struct tfa9879_priv *tfa9879;
 	int i;
@@ -314,7 +313,7 @@ static struct i2c_driver tfa9879_i2c_driver = {
 		.name = "tfa9879",
 		.of_match_table = tfa9879_of_match,
 	},
-	.probe = tfa9879_i2c_probe,
+	.probe_new = tfa9879_i2c_probe,
 	.id_table = tfa9879_i2c_id,
 };
 
-- 
2.11.0
