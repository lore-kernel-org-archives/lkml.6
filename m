Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753743AbeEHEra (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 00:47:30 -0400
Received: from mail-bl2nam02on0066.outbound.protection.outlook.com ([104.47.38.66]:40050
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751092AbeEHEr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 00:47:28 -0400
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=permerror action=none header.from=amd.com;
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
CC: Akshu Agrawal <akshu.agrawal@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 07/10] ASoC: AMD: Move clk enable from hw_params/free to startup/shutdown
Date: Tue, 8 May 2018 10:17:50 +0530
Message-ID: <1525754888-14124-7-git-send-email-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525754888-14124-1-git-send-email-Vijendar.Mukunda@amd.com>
References: <1525754888-14124-1-git-send-email-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39860400002)(39380400002)(2980300002)(428003)(189003)(199004)(105586002)(77096007)(109986005)(4326008)(47776003)(36756003)(336012)(68736007)(54906003)(305945005)(50226002)(53936002)(426003)(39060400002)(16586007)(316002)(2616005)(26005)(486006)(186003)(11346002)(72206003)(5660300001)(476003)(126002)(446003)(478600001)(8936002)(97736004)(76176011)(51416003)(106466001)(8676002)(81166006)(6666003)(7696005)(48376002)(81156014)(1671002)(356003)(50466002)(53416004)(2906002)(104016004)(86362001)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN4PR12MB0754;H:SATLEXCHOV02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM03FT028;1:uts+4SqUlNrkMlu2FDQUku9vh8aLd3eYnU6UL/art0z2Hk9m+i1zpV71Gf6s404T01yp5P/I3Of/+alWevtX4aWghKP2Ty5FGlMmomJA2IwocfQjpeg03j2SWROSzD3u
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BN4PR12MB0754;
X-Microsoft-Exchange-Diagnostics: 1;BN4PR12MB0754;3:LjV515WZGuPIlmB2tDOW2rTRhf0VwyDzuUjTIiqD+dNNJsXUN6sCqls9ccOzwXMKpoLVsMoiqWUcey6rfowrD2ojtKvR4BQLMpk/mQrVaZqxb8ViruoyVGFrQFc0a2J0n6rGd3Te/qqA2ZdrvJ18TOUm8wn1E97cCKw3y2IXlFauPA1qHnd8frBWss5h7qmISOEHgBwsLfBnHPTQ1dtVkGmFFnU/hB1y0SED6HPZWYuNLrFl9AOlawFAowv56BlZ8yKeGC2Yozdsboob4ZJiGmiLAock5UoqHKW2TBo4CvPtOiInJAXf8OI+gvugdHlSmsKdwvdptuupOLdNmQrPnTIn5HdpnGlyaZiObpKW5PU=;25:xkpwYW5cqclq3FebLVzfXMVKfllh5jw+EUk+Wkw0e8rDtYPPUYnM/anaOu057fBMbVq0hWARvb0L34+VMU0ahIANUMP2bY0fTyoWq7lIWWndkLP5ZvMekG0pJWPtTkBSHujE+HhI4lnt55e6Y/zMclVVcEtBR4AP6AjoLpn4q+ooz05Ia1sU16s67TvrbhUOXmikdvpKTYwV18TzsZKPC2BjF34t6ZCSHmxHRTJme04sLGUmZp0uP27qh6SKEAqd4pXkBHy2hi7fVk/RsXpRrUEwvuKUSueHikNU1hN5AwnlLbD4btWvsjUR6CU3sk9Z+AAPq2p+E11WYYXwznJ4zA==
X-MS-TrafficTypeDiagnostic: BN4PR12MB0754:
X-Microsoft-Exchange-Diagnostics: 1;BN4PR12MB0754;31:xUGWYDP39P1zjPLGDSdmGwX05im/0rzaLoRZYzFQbGQwvhC5EjMzUFbiJGR8p7kutS/S1Q9cujdryJozfGxSkjeLY3VGp+i3ft8xeH6PjZczrCxuceFrrz7+l+YF5yNY8WECq2GAhWUWpU5ns8948JRXVZ2tYD/Gj5OUkzbXWJJmXntPaEdqt/8lHq3elt3Ae7OeJ+fK3bfLbXl4IddS0Peaiqeaj8DvH7vFFvxtxac=;20:dzGOYkkm7wz/KDkkeHX93dHRBVfJxJ/uBPG4P2abu3drD3AVKmZBuOOxCq4hrKaTjPK5vXlH3j+rf0az6KhK1ccF/EwIBzLMZ+I5VN3FUpebog+9h/WHtMP2xnqgQXYUcKIrFr3KDcGfOSm191cDFMFVrVR3gGv4djXgz+QYD5l0ewTRXpyZqDb2pi5gAKyZklcO/ozUxo+WvM3A0A0VdZS3h00k2G/AOFZ/sm0GeEovc/VqK2uqBQtOG8vTIQ6dnE6mpch9K4o8HdU9QLr+9Dnv/FVzzrt2oCfcFqywmlHqDHA4X1Nkuy2uI7zyxPWGtpWEAnGUIqn9yEVJaC5scy4C34wP9O0T7u69H/YNFuxw2/fPpCPNqF81HAYrb2EdzrDR6sCWLM5ookVgfHETiwOdXmn6IfYNZI2S10j2d0T0mG3bFg/8D0QF3x9JSneNcNLwayNGiBg6Wg5E+HxOYTRLleZfi/OZbA6VDx7OyHUontdivlC111cjopJvwj7I
X-Microsoft-Antispam-PRVS: <BN4PR12MB0754BA40E2870FDD28F2CFF2979A0@BN4PR12MB0754.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93003095)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:BN4PR12MB0754;BCL:0;PCL:0;RULEID:;SRVR:BN4PR12MB0754;
X-Microsoft-Exchange-Diagnostics: 1;BN4PR12MB0754;4:XftzHJWWMpGWnibiQwKqNLALWZhEbn1j8Nkxm/Uh4S6NDm5xYL3WDdVDYllUW6DdzQGWImN3wwahavn63olZvsvmxw4eBYes5DQa+xjkaOMqeaExJGTEqBDkC383h11EcsPmMnAddNquT4JANG0nDUGbo1EspTUuypxDnLsUkuKCMV8mlvFRgvNx/vfK3RJy4m4g/JuS65lyuKrL3bDFbYtSj5EsU7aOvcSSxDABFroavycm5VVhPR9TBKWobAtWr+QNh4Tn684V5oIPn9slXYCC5msYPI1hqHM2qvyA7infrrhe8D8cSOIVjNfCBJwl
X-Forefront-PRVS: 0666E15D35
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN4PR12MB0754;23:sbAbQWKl20dj7YhIcjypkcLHQUNfzOHZPwuVNHagr?=
 =?us-ascii?Q?mveR5G9WIVMaB4vOkf1ueRDBnD5s+dMzOjRwE4INlZByDgRnOAN0p4KfuYFX?=
 =?us-ascii?Q?hCCiOzf/4lJF7uK+P7xRmaflL+mchv2GCTuLKFr+lXYEsIRry93LitYAVAxe?=
 =?us-ascii?Q?0wqn6rsbxaxq3YfXWP1w8r1Z+z9wthqfNW1uPNJZ6mXiaBcOZ1NkkPj+R7IM?=
 =?us-ascii?Q?iSGhP13yoOixoB2MTCOgCuDczO8sie5B5i2Z/So0AEsBCpWGuiMJndV1t6OM?=
 =?us-ascii?Q?kbVz/eU+am4mUnpRy7oKIyoSy2wFIi7fvHv4isYeBP5P+pocF7/JQCjv0jHN?=
 =?us-ascii?Q?7CM2t2TVzc5F4luV22vHyYGkDy0pTK4yEOgCq3HCAyMP+HO/A6xsi2Ss6QIl?=
 =?us-ascii?Q?7g1Tv53Mhs2Si9zaZ8REXEH9EIFwp+K1vKLvprbsV1lqw1oLf+5ICtFSacSI?=
 =?us-ascii?Q?KjeRhGl+uVLfk2D5jWKRW1uez7isFbtvp834NDhkbOE2UBnHVIRw8Q8UqCIY?=
 =?us-ascii?Q?ucwEYh9v2meMNJHSUTqRwUaHZkDgEgyna1UujIvhfHboyTTZPi/ph7YO3CRg?=
 =?us-ascii?Q?VGNGtPc4zmw3hyjolbI26KEOGG9QgqTlUeciMdUUnj2/ubtlABngCZGkUqKA?=
 =?us-ascii?Q?5AuEyi5seMVeQz0Kh+TEQ84SE5mwbn1/4eajOJJ9TFBQI6P52ESx1gf0kNCD?=
 =?us-ascii?Q?yZM1OJuzKFALJp1bbkBL+mmVKWk/L1EspVtg5Q4iw8D5U/Xycg7ksbqjK7DM?=
 =?us-ascii?Q?dhuWxizI/72Aa+cgOQc4ukaIuSu0Keoai7rH20ONQ4MbiDr2YbsBdzq0opKo?=
 =?us-ascii?Q?e6IGoqlnH8d8tntLBzuYxJH+VVjwZIzL+FVreDPzgCgTZ+xA355HK9qyxlwu?=
 =?us-ascii?Q?p04cy2QKampVKcXM9olcY23faEsZNeW5vsDIJCRyGwnuk5tylP0jylubGYrp?=
 =?us-ascii?Q?Nyour/3OqDiJ56yYmkTD0ZFRjvg3tNazZEMs98EDkc2Rd8z/02x6vdFmFjuY?=
 =?us-ascii?Q?tEQIywXw5OB+7PvliJGse2KMPd/Y97OjtFV8P2eWrU07t/xrbG5HhOTtEZQd?=
 =?us-ascii?Q?ikWwbcBl4seCyJazj5VwfBIJvr1XWUpyfDUazvaBzApBWCupzo3qR/doQ4nw?=
 =?us-ascii?Q?QkVmBHXDYyrw9m+aKauDVhhbgRPmGIShk3wAy9Ok+QQahdMV9zw7s5+sc0ca?=
 =?us-ascii?Q?XdWTkH/54vwcM0eBSDZZq6sNQOmhCD/E1n7Kisa+w6FKbCnIoXoYHcYyA=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: VjwL+5NnIzdkSPefQfMuQdTm5XXKJpo3byvivmsfiCYgHGcEVseDOIO7mD9GbBN3RjQLUWdbSNIg/59pxfLfbFmPXY+qJKMBH8IjmLzkvXo7+EvyaaGXMZiUKBMozif/fDugyYK7ZVV9GtFf9x6SUPi5jqKs2BGyRj7bnBdZpZ2N11sB4rocl9hLLsfWT2eB
X-Microsoft-Exchange-Diagnostics: 1;BN4PR12MB0754;6:9bYU23IMGywHPGviL8eZr/n01KRAhcWeQAv6qv18CitOMmw75KBPulWQoYzRSN+0SAbWKb/0EFVbd6p3M+HMkLAj07qHsoc3yeW98iAmltgGKkshylmLQ8pglJK1BoT6DNsKhqVR7wiz0BAAMAavzZbSsKDXmesO/gZNGfU+hQuwOiqONAeiuFpDp3wxnuWabCi60xKTQre14MksG5SpZDzWIH1hmOb0FpdPt3N++HS+evhRmWTK7Gj1G0bFNFwF5eBjTR8Cp0gaweXzeGoQ2VPnzH+iG8STWTwNHuRDokSxoqGUUfkg1os8pt5LTUQGAzzy4hCBIDaWZQhvFfV72o26vnlwChzX3OcYntr/5PseSZlZKm11PZZxu0Orr4HluRzUqYZ4+dPtb3+l8kTZZd3wwrfzC/6E2Di3CNbNPrkTkKBQ5HBCSx26/TJJBQrC62Ak3q+72N7AtoadpQc4Xw==;5:TcK3RbhDUM6PEBUxUDXtDjBrwBBCst3KO16QOqT/6lkyxQOukcnX5eNp7y1EB25F/BmgJG2ZdwWmVRJPSTVt0i9fn0vo8xsPXPm0NLn4lXrL67aYyLGdeqeJFmdHS2kI6s61rygwf8YEYTB36Y4eqznSn0pdjc9mNnDqs+ntR1o=;24:O4PaFH55C2jTQyBJy3vftmGaZcmSo4WBk11CKFzPlP7ElTyWkJ6jQ5c9l6OAXRG2u35wJVQd4xEeoXnHHXyBvfscgGYueojaYfBcnhAc/9c=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN4PR12MB0754;7:RwJKYGF+DCNDMXYBg3bu7k3V67P0W3R1LEiizi3dLsMS4YUJcVqysHeuPRqc/4G3OTZe4jJugEtdh8TRbeEg38YQ32fot7MHr4DFQT1+ktabMLoL7LOsymkUVn0FCWQ7WketgZA39IVi4uj12HSGMihC1KlIkWitGXU8p/2DhuQR2ax7EtAU8MmARraT8gZndrfYOp68/8F9BZfLTb+BB2UTVMpiivhapQu7kMc1E4RDS0r8AobEeDrSb39z94Hy;20:/2ZyusGqnCI4KOTOF7WVkacluosk4Uc8Lu2ba2GJESR1duSg0qFvTtinu9mJmlteFiKajrJhx+RBiidZW2PbKEvI7RGNlOcihXEQnBYyYwxD0jvR2a7CHxYFeaMS2ZmJgQxTu1LxUQ97qOhumNYrrBJTyMQVzV6lbFg381QldWwzWgPJ0vHG9HNBkbYwOYpbyOYvROdaqZ9sM6Cjg8Swh+LY0tEGZ2lfE9AfCVngVXid4QK0oADPpgX8kt+gbIUW
X-MS-Office365-Filtering-Correlation-Id: ddac14fd-7dd9-4108-0bcb-08d5b49ec9fd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2018 04:47:22.4117
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddac14fd-7dd9-4108-0bcb-08d5b49ec9fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN4PR12MB0754
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Akshu Agrawal <akshu.agrawal@amd.com>

hw_param can be called multiple times and thus we can have
more clk enable. The clk may not get diabled due to refcounting.
startup/shutdown ensures single clk enable/disable call.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
---
 sound/soc/amd/acp-da7219-max98357a.c | 49 +++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 14 deletions(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index 215b06b..6495eed 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -91,8 +91,7 @@ static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
-static int cz_da7219_hw_params(struct snd_pcm_substream *substream,
-			     struct snd_pcm_hw_params *params)
+static int da7219_clk_enable(struct snd_pcm_substream *substream)
 {
 	int ret = 0;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
@@ -106,11 +105,9 @@ static int cz_da7219_hw_params(struct snd_pcm_substream *substream,
 	return ret;
 }
 
-static int cz_da7219_hw_free(struct snd_pcm_substream *substream)
+static void da7219_clk_disable(void)
 {
 	clk_disable_unprepare(da7219_dai_clk);
-
-	return 0;
 }
 
 static const unsigned int channels[] = {
@@ -133,7 +130,7 @@ static const struct snd_pcm_hw_constraint_list constraints_channels = {
 	.mask = 0,
 };
 
-static int cz_fe_startup(struct snd_pcm_substream *substream)
+static int cz_da7219_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 
@@ -147,23 +144,47 @@ static int cz_fe_startup(struct snd_pcm_substream *substream)
 	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
 				   &constraints_rates);
 
-	return 0;
+	return da7219_clk_enable(substream);
+}
+
+static void cz_da7219_shutdown(struct snd_pcm_substream *substream)
+{
+	da7219_clk_disable();
+}
+
+static int cz_max_startup(struct snd_pcm_substream *substream)
+{
+	return da7219_clk_enable(substream);
+}
+
+static void cz_max_shutdown(struct snd_pcm_substream *substream)
+{
+	da7219_clk_disable();
+}
+
+static int cz_dmic_startup(struct snd_pcm_substream *substream)
+{
+	return da7219_clk_enable(substream);
+}
+
+static void cz_dmic_shutdown(struct snd_pcm_substream *substream)
+{
+	da7219_clk_disable();
 }
 
 static struct snd_soc_ops cz_da7219_cap_ops = {
-	.hw_params = cz_da7219_hw_params,
-	.hw_free = cz_da7219_hw_free,
-	.startup = cz_fe_startup,
+	.startup = cz_da7219_startup,
+	.shutdown = cz_da7219_shutdown,
 };
 
 static struct snd_soc_ops cz_max_play_ops = {
-	.hw_params = cz_da7219_hw_params,
-	.hw_free = cz_da7219_hw_free,
+	.startup = cz_max_startup,
+	.shutdown = cz_max_shutdown,
 };
 
 static struct snd_soc_ops cz_dmic_cap_ops = {
-	.hw_params = cz_da7219_hw_params,
-	.hw_free = cz_da7219_hw_free,
+	.startup = cz_dmic_startup,
+	.shutdown = cz_dmic_shutdown,
 };
 
 static struct snd_soc_dai_link cz_dai_7219_98357[] = {
-- 
2.7.4
