Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751077AbeECIA6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 04:00:58 -0400
Received: from mail-sn1nam01on0076.outbound.protection.outlook.com ([104.47.32.76]:47584
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750781AbeECIAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 04:00:54 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com;
From: Akshu Agrawal <akshu.agrawal@amd.com>
Cc: djkurtz@chromium.org, akshu.agrawal@amd.com, Alexander.Deucher@amd.com,
        Adam.Thomson.Opensource@diasemi.com,
        Support Opensource <support.opensource@diasemi.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org (moderated list:SOUND),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3] ASoC: da7219: read fmw property to get mclk for non-dts systems
Date: Thu,  3 May 2018 15:58:33 +0800
Message-Id: <1525334313-28661-1-git-send-email-akshu.agrawal@amd.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: MA1PR0101CA0001.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::11) To DM5PR12MB2359.namprd12.prod.outlook.com
 (2603:10b6:4:b4::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2359;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2359;3:sR/ZSTfXiqUsKLpcx5Zzy1t83tgspgOGGPhQ65xAAOpWVsjtOXy/1bNl2RTkdvLhxnPg/egi4VTH9/eivEHO21FibApAw6Cg/XKfXEzciPsLgw/TkHgnZC/67lUs74k69Jjn0T1g8/bX7GO97TDa3WjEMkRJEFww2je06r0AAAKwgK1DEKB1Y7/y6NsWBCL7Ai0B2LErnKMdR3axGgLwsETSKXQusxaZmYvmHgEldrkGg9F20jC34yo6DvUlYT99;25:QSxerLKQ50LPQ5YTqsBZ2GhQ8dt8JkNthnCqn+FRVcqWFGHeA2yjlqT+ZMoKL7FPggr349sc+6bFiAdJhK9iX6FR3sQUzwZ8sxJMtK5AfDIkEVz59MPFIdZL0OmuRgY9YtL8rxIf7NFbwAAedN++VDNCu4VvtVR6QXH5rPzqF43M7fOWjE+frbu6hAPOrf+D614sC7jFRUYvK3xHNn0ios/fQy82C5uQ8RDcSzXgfkojxDTfEvJp1YwNcSgH11jc/TH+cwaZLqOpk+i7Vo008TV1FKAYGARTu1DpE06jI24s7kiDpdbxnFi/Rl3P/OmAqb6SOj4AJCNvlidzGBqOPw==;31:uolgFBXwt/G8o4M12pUHIt2ZXUQHyjSB/ulpsRL25sS1UaqC7ctapGEbBrOF8zZp6PXInCQS4MINazP8XaED3A2hjttyMaoTdkqdHgksiFCXwMG9OAxgCVWgVakXzIdltig7iVAbkvooazLvLdIxNkwKPbCHgiApF/tXrcjNElkxADM7pSv4FpgcM91FX/VzJMLW5bk9ZCCMH88aatYzEnZhrfTUiLi4wLlMpJdIhNE=
X-MS-TrafficTypeDiagnostic: DM5PR12MB2359:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2359;20:8R/wr0T0hOIOFRWS17yFlUZOFQJlQR1huYsxdOCm4JnDFP2zoD0aYoIXtzL1wUn5jxCwcrgsiW/UXh6o1IKN580Xd17Qy1NbF9BANVS2dDAgT59wwEsoX/52gU8CG01hgwy5TV8az4s7QdHupLmCE/0+R6SwfCHf0GqeDpPSICvVpVm3kg56oWcfCS3D9Knj99eMdoSnNfyeiWM+4oHQo1foBj8SHXuYSpnQGb80FfeKVumnWpHl7HLOUOZuM94jItgT4/G5o65a8rce/3ewaD1LHbOU/UdQsh/bBQwo2TqcdTtiovRYETMWM2kQAYQdlAfA7RDTG+xb+UFb8heVHECbHSUlV1A8q+QeQzcXnP2snzCmsUcNJnvk1NyvdtU3ILA72ut5o56cm3w1Hf2IMbZA7Ra49qTLA9kTlx/BFbXFbqVRb/xKfgXY+4+zETbRm+7er1Ks95/82VNl6bY3eOUoJTXUy9Q+4J7NtIBDWzyh1siVPJaopnKptn4z/vrT;4:1JQe8x3AwiIMTwETYgABABkWzYJ8PaRTDJNIvcNSZi9hUoPuffxpYIhMsoqIACgCUfbCLMunuWppIEv+GJd6GekMq6AgpSUkyYsnVYzTokmKkEafKWHvFKQGCVfme7CH6zA71jQlCvtcJaTYygrZ2SodKLPdDsYRfp+CMbk+Ok6bZ2iOjuFVPykMc8qY8F1mqdT49ozYKpBVAm9bwmWEwn9ZMNITt3SkRPPyIFxncDVwmJ+IT37873MOIr/UatDTalVIOxG6fQralqbs7YZ76a+aluiFpWuugVYpdnZmvVnIdOfF6rt8VN/c8A495Ish
X-Microsoft-Antispam-PRVS: <DM5PR12MB2359A2909EEBE5D5163513A4F8870@DM5PR12MB2359.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6055026)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR12MB2359;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2359;
X-Forefront-PRVS: 066153096A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(346002)(39380400002)(39860400002)(366004)(376002)(199004)(189003)(51416003)(1671002)(50466002)(6512007)(8676002)(81156014)(81166006)(105586002)(50226002)(48376002)(109986005)(52116002)(16526019)(386003)(53416004)(86362001)(53936002)(186003)(2906002)(59450400001)(25786009)(26005)(44832011)(6506007)(106356001)(305945005)(72206003)(486006)(97736004)(39060400002)(16586007)(7736002)(476003)(6116002)(3846002)(69596002)(8936002)(6666003)(68736007)(478600001)(316002)(6486002)(54906003)(66066001)(2616005)(4326008)(36756003)(5660300001)(956004)(47776003)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2359;H:akshu-HP-EliteBook-745-G2.mshome.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR12MB2359;23:cbLCeGzy5LZdtcaSKVz/GAao3DLDDAaV3wRyJqeVP?=
 =?us-ascii?Q?sZk95QQRxFT6nU7eAENRF9gPIGdRepSTLaPNOd4UirpzDD4XwDmMGt070v6A?=
 =?us-ascii?Q?VlPcjtZCA1fN9JHsn9ghiQNlvojapHowOlDsvoieAaZrs7FZzLakb0gBlWbg?=
 =?us-ascii?Q?Kl1eLOpdk5Gogy873HwgnBYySzkuF+AT6e1PJqdqL9/KPIgCEm0GzMf88UpQ?=
 =?us-ascii?Q?SRTCxcjHZsIZCbG8FDzyNFcb9dxRDVzLQgl3bQ6TcodFq3fb4yt+EASTiehR?=
 =?us-ascii?Q?n6wXgLVqHfXrcU5skM6Pfxt58h1kqiYzSPq2LcbbP0YZEFlVYTclOzWbFt0U?=
 =?us-ascii?Q?SpCYT/CzroXVOl98yUJM00epy3lMk0gWTvkPPihft6Vid8HCOPqxuNICh0dY?=
 =?us-ascii?Q?eWig27ahU1dKV2lobNlX/arjwP47eZd8N13qG6vcG7w6O2AruLF+9tIaZpNB?=
 =?us-ascii?Q?Z+qc28v3omyROX8Rozo9racIM+JnNYOc89K0jbztkfpvpw3lP6mo14CwLo7z?=
 =?us-ascii?Q?NLy5FvVcrj9m0bFlQEefhYX2vIr+ETplcejx7JQyxHBq3wMXbQYpljdOcr/F?=
 =?us-ascii?Q?VBdL/xrWUIXI0sI+WABvXi2wo3lAAyyxgcqNSZyvjOZDLPQGKotyqsvEt+Y5?=
 =?us-ascii?Q?LIjOcGCaUj3xJwT53Q1ZdTITYNX720MZ5SL+RO6rc0I9FvhKbqPVJ+nsdIV0?=
 =?us-ascii?Q?ooTpfTf9py6nA8Fa3p0+4QnLZ1yKiJ8kHqoHC8S/E8XJIZzI/8V1HwMVN0C/?=
 =?us-ascii?Q?Ns0eijUysel8SbRYWg9BTzDp4Uz0XQyJR9Ecd5dBiLAwt+MCmkQnjgkBmWNK?=
 =?us-ascii?Q?/Zz6MHc/62YxUUJ6m97UMF/OueYBe3QQebQoIpmP0XjYBe6fkv1uY7fcR20a?=
 =?us-ascii?Q?4a67yzF6YR3kXeKCWLzASBBUKoxxhZMt4pUrnZfCrKmuababC9eXNQb7sVHI?=
 =?us-ascii?Q?ZINzvywHPrm7lKhR/a/hEj9i1NdqFxBAI3BTqiFtW41gxY2WVOQgbxuDyUwx?=
 =?us-ascii?Q?2gHH1JqlfxGPa0BCML77mxzAWbcLTcbDSG01L9Eyo4XMuk3I7WkXvwC1Gdye?=
 =?us-ascii?Q?0j2g9LpBhmX8QqgHIh1Ki57/KY2/EasBsuklkMk84HKCdyKh6IUpbvg1Ul1c?=
 =?us-ascii?Q?NtNHEszg5+EebzSLGfEZKB8HUl/FglTZtwsM52bW2eqJxnPgYaHE9eduSCGo?=
 =?us-ascii?Q?7XkM85pOf65dAUXzyEYGwlYyWMfZurjGemtllCNmPWwzenCk3t+UiczmX00v?=
 =?us-ascii?Q?4QZ/X0td3orjKKDFWcBZtvnUqa2Zyp4FGHG83kwSj9ZUI5RPhVSx0k1jHtq3?=
 =?us-ascii?Q?VehYvYgJyCWq/F9OYpDGT8=3D?=
X-Microsoft-Antispam-Message-Info: o4TEkgGxrXUvHf1n3vMGLQQB7UX+1t/3JXqq7CCHELWCrH3rKMmHBDbEHqU2pVp+yGS2VFwCQewxhtp3NbP/wdP8TRvm9WK8v7vCI7nRi2SAfyavWEYC88eiavVDapFOYviOC0B6ZC2z+2LSNfy5FWgo+ban2D3tGdKt0N3P/R5jbrF4Hv7Wf2n8dxAI1imY
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2359;6:vJXzSleHepuB4A8DjPsRyL1NCwX69AAmmmK4Rkvte5Stwz3nseQJXVazXaDF8T6lqKLAsHKfF9wOYGy7T7OdBU4e/HnquL+mjeXhq110YaeRpM4Q+rNo9GkdOBt/194xyaPlhWAco/rX87g+XNhkbE9xbYMD7iayKcepjMYWD0NUn1K1zZiJ5c3zWvPHSVb81cqJ0Q8vvCInt0nyFXc9KHStJ5Zb+NGW2k5dB8r6ilICyU/Aic+8oTiX3DENayhuZfoHAl1n+8fE3E3E4HM5UZTrmJ2PjJXsKdc58+fOl5d71OyznTylnYOS85MUty+lNT+l3PSbXGKslHOT+6KuH5eePmsq4x0AtBeq/uu2xV72G2IQ23jlZf3cPfsrg7ttFM/qiX59qDFgGBFFEdhYWP1lZAF4zwwpEWxatKDvijmHdJjIDyRYXD8KfGWfZHeHGCbuaAvT+k6Lq5bgTs31aQ==;5:MfWUYvyLMzXfPVhDaYQFwmYcvadZbOYxf1WLhjNzIPEk82NLhbWhmoZ8GcaUem6Yw4X3dMxflV+k0y+sS8ed7n7FNd+W5QFUuJGUlCLCbUP7+ngJ3pXvbO+Kpm5mEBhvQGuoEZyJfsCPLKYWZtK+4IKlRzWmK/r12cVpgA0wtpw=;24:e9EllfR2kkkBF4iibTmvD8DI3nwhYNLOdVhhAYkHkYp9M5p6xrvzz1vCB+b4jx8PXFewr+ZRVm/dAKgHqAZOZelcTt1b6KHCR8apFJrXCko=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2359;7:SNnO+14l3Lb8eorctoBlZ/81WVBa9APC4KEw3po5azdD+poj9xVTmrhy57H4JEDbbBL+gV89NhAnF15h5VTFWfK4pBiNQ08Jg/azIvqYuIwiCJuINahxzFoC0ArvuPqGOK2Uw1PgNq4QZxtY/t2txukVORjwFHH4XPNhytbUs0Wwte2xIhmX/wzAqrjOV5ZZr7jovaObNyO7OvfRCkvyUiqaiSJMZWsHlcCnI/nmdTXfWF2WT5uy/MQ0A9AvRlom;20:nPlcIGLUbXxY0k6t1AtjvhdZZQWWSsNOdI1vx2imOPjspksMT72pcDf4MqDL+PZfTgIABwpTvJvahO3EvG13si2ndCghAoeCwnG3SbUQLjTHisr8dOjGqXYqA+YrFr2MyWAiIvdbfqG2WXLD0d3OYsD6v2OUxJt40il85q5pd+uXmp9IADSOnzErFrKNWsKtMxSuNwHYwOrLyBcID1/MkXvpNw0bE4aSfORuorCPwJtHNdwORHMtBQsKSyCm+RAF
X-MS-Office365-Filtering-Correlation-Id: 24d0fa8b-2427-4543-287d-08d5b0cbfdba
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2018 08:00:49.1196 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24d0fa8b-2427-4543-287d-08d5b0cbfdba
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2359
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Non-dts based systems can use ACPI DSDT to pass on the mclk
to da7219.
This enables da7219 mclk to be linked to system clock.
Enable/Disable of the mclk is already handled in the codec so
platform drivers don't have to explicitly do handling of mclk.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
v2: Fixed kbuild error
v3: Add corresponding clk_put for clk_get
 include/sound/da7219.h    |  2 ++
 sound/soc/codecs/da7219.c | 10 +++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/sound/da7219.h b/include/sound/da7219.h
index 1bfcb16..df7ddf4 100644
--- a/include/sound/da7219.h
+++ b/include/sound/da7219.h
@@ -38,6 +38,8 @@ struct da7219_pdata {
 
 	const char *dai_clks_name;
 
+	const char *mclk_name;
+
 	/* Mic */
 	enum da7219_micbias_voltage micbias_lvl;
 	enum da7219_mic_amp_in_sel mic_amp_in_sel;
diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 980a6a8..ecd46fc 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1624,6 +1624,8 @@ static struct da7219_pdata *da7219_fw_to_pdata(struct snd_soc_component *compone
 		dev_warn(dev, "Using default clk name: %s\n",
 			 pdata->dai_clks_name);
 
+	device_property_read_string(dev, "dlg,mclk-name", &pdata->mclk_name);
+
 	if (device_property_read_u32(dev, "dlg,micbias-lvl", &of_val32) >= 0)
 		pdata->micbias_lvl = da7219_fw_micbias_lvl(dev, of_val32);
 	else
@@ -1905,7 +1907,10 @@ static int da7219_probe(struct snd_soc_component *component)
 	da7219_handle_pdata(component);
 
 	/* Check if MCLK provided */
-	da7219->mclk = devm_clk_get(component->dev, "mclk");
+	if (da7219->pdata->mclk_name)
+		da7219->mclk = clk_get(NULL, da7219->pdata->mclk_name);
+	if (!da7219->mclk)
+		da7219->mclk = devm_clk_get(component->dev, "mclk");
 	if (IS_ERR(da7219->mclk)) {
 		if (PTR_ERR(da7219->mclk) != -ENOENT) {
 			ret = PTR_ERR(da7219->mclk);
@@ -1971,6 +1976,9 @@ static void da7219_remove(struct snd_soc_component *component)
 		clkdev_drop(da7219->dai_clks_lookup);
 #endif
 
+	if (da7219->pdata->mclk_name)
+		clk_put(da7219->mclk);
+
 	/* Supplies */
 	regulator_bulk_disable(DA7219_NUM_SUPPLIES, da7219->supplies);
 }
-- 
1.9.1
