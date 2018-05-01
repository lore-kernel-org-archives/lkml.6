Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751414AbeEAUuA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 16:50:00 -0400
Received: from mail-by2nam01on0045.outbound.protection.outlook.com ([104.47.34.45]:38304
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751310AbeEAUt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 16:49:58 -0400
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; renesas.com; dkim=none (message not signed)
 header.d=none;renesas.com; dmarc=permerror action=none header.from=amd.com;
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
CC: Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        "Jason Clinton" <jclinton@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 06/10] ASoC: amd: memory release for rtd structure
Date: Wed, 2 May 2018 02:20:00 +0530
Message-ID: <1525207810-1305-6-git-send-email-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525207810-1305-1-git-send-email-Vijendar.Mukunda@amd.com>
References: <1525207810-1305-1-git-send-email-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(39380400002)(346002)(2980300002)(428003)(189003)(199004)(97736004)(54906003)(106466001)(39060400002)(5660300001)(26005)(7696005)(104016004)(305945005)(316002)(77096007)(47776003)(16586007)(2906002)(336012)(109986005)(59450400001)(53936002)(68736007)(76176011)(486006)(186003)(478600001)(86362001)(72206003)(51416003)(2616005)(426003)(4326008)(476003)(446003)(8676002)(81166006)(105586002)(81156014)(11346002)(50226002)(356003)(53416004)(1671002)(126002)(50466002)(36756003)(6666003)(48376002)(8936002)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR12MB0332;H:SATLEXCHOV02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM03FT020;1:KVjuI6EpdpeVMHSWsDhwf3ghhA6NWdwMiIY5TXaQ4eXoXG1pbJuE8WO0k2RPuZpaknRFeBQIQCl95m/pPis3XgEw0h4dtXALYQ1YXO7i+XNzR4AX7vIwTkCt2F8z08XA
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:DM2PR12MB0332;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0332;3:uXBSDlfrgL6z0t985hroWj0S1MH/g1dgmwwV3EGf51Vn0goEDxHxPkSpYlkSSsGWmCq3TQmw/aTv17RGAbaV8DfMMNBZ6ycOAfQTR9MP/4QPO5NCK6qCPgNg3eXNU6EM8ojMB6hpnDrBtSeY2xs1g79f0G+o87mi9vy5VZXvHGvMNmwHXqYUEIM3299iLT4vWcnlNvNEGcKlx9JCjCq1gW9B24usdSvPNr+faGyGOqnO//2zXtWovrK7A369PC7R/Hi+ZTBaaGAk7aHGadQRzNgXa2ZqikTCqZppdo5WGYvk3TV1vV47ToQ9sPOKUxKDBgUIMbfuGPqXKc1fLMam3A5Svn3IRcWPB+dscd7dImY=;25:EamtinYRI8qMBQXuT3t1qrhYcMwzxyHqKR5aRVwvIlN4FS75DMD2gzqhSgDwZnODkt9vpbtLrPQOuU2tnpiQBD7xuavyAUNpYGV9wtdOU4HmNOmIISlM2WkGELaLX9wL020wx+fluuCTxNDfaa4OEbGXpj+Z3NwWubJd+LLeRw3n6RMoy1CV+iAmW/R0wdXqTM5cdbAiutumzslp4Y+3CxGYAM02lFJae/vfTtb2mZ2jaBqbAmdNdRcrTYBWwcrIc2m/vQ3oVQr0PggsMi6BHLeY7QYbhFgqfYvvvdLw82j5nlUCgDuvdsU1Mmxh23R8+7wFSRhhQMguBsG7INZuxw==
X-MS-TrafficTypeDiagnostic: DM2PR12MB0332:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0332;31:zKDd3njDlixf6L/MBSIykm0EnJxZmTJZmB1VINsbuM05d+5o5rfJmB2GNG+Ae/OrD7zde3jWvSZ57nzHnujR5OwTkC8w5VYkNuPHSGomO8QGoc9HMF/3sh6KaBF2vyFssYorOChvtrD4YjIqH88Dk5q2RgQjtA0uKEMN1nrOIfGMGn3FfT++82QRG0rp0UCWfaiIINVjLKArDJKLQdujKuKWTJheXnfvBrAkwee2tbE=;20:1zNLm1z1oo8FUSREBxMYZ2pBSuFI7FOGl7xqed+x57YVx3cO80VNjmANDr18VQZtaxO+Y03lYYRpElqXAfH8dak0/bCTin9tFTlJgVouJwB22hCuUP4zisZGFnOuPzidJ2DC+Yk8R+AmvVj7s2He8XblB19Jr3n9qP2mM1+BJIBZOEROvbxn4TOA0OnDKmLLmuLRKbQ6i15HTEc2ctgx4NvXDve2AfcpISBZqOOVIx2CCcTPUZ3HSzLGA81vuzq5H19hjDXdic6l4CV7iu4UokO7JWuR8FUJuRWbUVOrq3yXPWBZ3xeVF9OhJ9IQuBBl0GfGYegxi8fAGE0fIMGEkjK0ROjY3NVlC+inHSWzvE8CQtW2xcGWqmTvqXEMBPupy/64s6kxSLX5qMul6nLa0+rKSlpaQ7sBUvWcuS3hY7sMJ2PSHFHYIIMmevNlsBkcHG2KA0ByQdzfqPjGWKcNuMKMKyMDIsuMVKyUmd3xQf4nyZNNiGlSO9w3Jay6yO+8
X-Microsoft-Antispam-PRVS: <DM2PR12MB03323AEB0273E3F7F102925C97810@DM2PR12MB0332.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93003095)(3231254)(944501410)(52105095)(3002001)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM2PR12MB0332;BCL:0;PCL:0;RULEID:;SRVR:DM2PR12MB0332;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0332;4:xlrt7gCEP550lL3V4Gt6YaZAZxMbqKSUUfePc+FFj63JfHxVC40tCPrNytrgtV0I5KYHwnyS3c7E6/VSePiVbzRYwnwzpJZgxBIsdnZOkQB/pn/bSonAyfpX8ZYTiRXwaS5oxR1GhKpvmVCXdxge5lF9gtk9qBA8mysqIOCXh0y3OMfeJgRsYMd3smh/Iwxsy6PAXxAFSb2WRIDRSrtb88SZ9oeCb6TGUzZUZ6aXaev7yDyGM2KwPTdjIIptOecuIA+7lPpReQvfzhCDCtYBDZO1Ftua+5SwwpZV/8UQ9vcGsgIgXphNWJ674fjjrYP6
X-Forefront-PRVS: 06592CCE58
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR12MB0332;23:UGUHUqMxinkyYZmpwjKSxkd3aEcCGzdCzMMxqcig+?=
 =?us-ascii?Q?DRmuz9fKavSDH5fu372JyI5ZRU3T1m8GTnqUYe6rioso1VoTfAdrDs4kln0e?=
 =?us-ascii?Q?CdoAbS4eayOQXsyfj5Tt3n5Ie0dtD4/6sCRYtb/QFmw3/q+ZTZwRb6vkaqHu?=
 =?us-ascii?Q?lpm+qUcqeXx/R6gLhymdjvES9Ej1ogUpeXQuXcL0AR/fk6v7gK/pcTieP3uO?=
 =?us-ascii?Q?IRjbn6ZQndGqJAvgtikDowP1iKwf2gfSmVyGISXXZBkDiM1yAYvBd3MCYjgA?=
 =?us-ascii?Q?h8/i74kxwtbxYUYyRZ41ZKa7yxNLepUOSvFUM7NfrgUelAuxGG721erSLvcE?=
 =?us-ascii?Q?VoImqQDzFLpFFYK7MMoJSxweKL5mGktWvX+aFcNl/8EnGDu9h475EfT9hCsY?=
 =?us-ascii?Q?1rKfj3h+j8nG8UVjpAWedrH7CPXLIJ4iaUw5ioUR83jeiJYpUXcUn2D3STDB?=
 =?us-ascii?Q?Ysf0F21VuQrO0unCUvL7r6D8pFZNcWyQqoTOPeTebM2smrBSCcwPeGanGk6M?=
 =?us-ascii?Q?VLvKe0jxL59S/9E+hS5ICmPFnzK9lOz3EQpJcpLJV/3qWEeWgqYuBRiW5HlM?=
 =?us-ascii?Q?DZKa4+Rt15aoPORnDGs+qOJTGsR9U+T+neNCRqfUJ8LXRpodPVOcRUtd5jDS?=
 =?us-ascii?Q?lHaTaHOD2dsbaki5IEA0peYRwuxnR7EylROh5OUJuYHq034bqZfL6Dg0nMpG?=
 =?us-ascii?Q?jW/yJu0FMTH2UNEvG07nfMIVQq/+Gz81h51LSLK9bU+KvMDSE0zBG02wonlM?=
 =?us-ascii?Q?28NdOQWr7QEDKmLL6uTx0xt+z5KlZ9m6Ft99EwBP50KR4YScLnts0L92B5XA?=
 =?us-ascii?Q?Ynl6elvpQRseg9ca0if+bKpbJSbGt+cjPD3EL6nXq5mG/caEdnEiL+ikzal1?=
 =?us-ascii?Q?4alvRSfdPIP7w8nm43F6hV+FoC81oWPhGywJaeEykSjp5A/IF9++4elSByvh?=
 =?us-ascii?Q?ncRBUESrUS7d0XCiK5lgBfSrsSNHYOBi1QoxKwN2N8KnnDsh5N3La4Wp6vFV?=
 =?us-ascii?Q?afmxB/nfVyYhKDBDX/65XKzWP4XSTyf78PrE6/GnUTj+pBwNQUQyC+j6rB9m?=
 =?us-ascii?Q?zdI6UKSjeniBTed7khcFmaW1teBPxSa6NgOWnvg5XK+cJtEpOLRXfdRWOyH4?=
 =?us-ascii?Q?RV0yoCeI1xKWAfgaMS6FeyU3TIq74ee9QgsIOPfvsuKvhZ2b9cnOMn7O9tqf?=
 =?us-ascii?Q?HMrdFlnjG/5WWWUe43XG2KZBLaR22XA9mJjU1cmDdJCOyd3CjfJjP3QTkR8f?=
 =?us-ascii?Q?4YKNOLPc13IUb/i5Jw=3D?=
X-Microsoft-Antispam-Message-Info: 5tZMJm/ykfbGNvXQ2tSAOTnTmteK1MQhB65yv2KrsQMV0JaF14b/Jpqr8180dX4fcRXQeK2NpLWk4kty3OaAzEECL58I5Tg6Uli/fAFuIZI4WZ9SCN2aDdJthtDdxaJVl2voziqC7LGia+/8eOasLZ/FCegI2zPyCpYmxwllrKyuWBzRLxShfU+BsY2AZvlE
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0332;6:w9hg/tkvVw0UyXrsJdWc0JoEzpaGpDU9iLy2JZsPirKPMxNesXhcAbpKI/a1EMJu3cgxvRVV9it8kAUc+2rsz9s94zNDg+YckDwLJkIU827DhqhMkz5ZdzPVrGLqa+ruDEeo2ULGupklS45OSCxC4rbJboGjV2gQexXFRdIg/x5IY1+s2XufJVSANATROphnsyQFyvQxHYaYqtNYAJd4Hn+zh5CW0tzDVrqm2z+CY3oHykKRrfSGch3aAstNmQ0f385MT/djILuwD1Qhf9WFtKet5vSCqC3XAD3n3yYalSc2Is51cemUC3M5I6oVbfU76oWhL4cXdcNRsIgxknqFaGnDMSq+xxBZuRvvNtsG4lAeHgNJrHtgBq01Xxi8JAKRhxIsvv/JuDEfQNjWLsNO4c5lMXcpssL7PnuQckdsE/N51lngaD956LIcAnHFuF0uF8CsIwnpDZyMpq5cl2o7rg==;5:EcaJ0eQxhDbdj4kMlbQTsoUWVx1Xx2IjFUX2oWuxGylLjAYAE+/ILd2xiBS8c4cGRe4N5xqu5Fs4p6RjVWa18+WCzPt/w3m/wUf8hZ0RZE8FyCvZqVvTr/hHIFUJaHchbDSGq0GNamkSdD9dJ9+902TsNfjT0tjP6gNNtmBAiU4=;24:RwCb9DpInf9dOUCAXNDxd+Vtv3uIKuR6uewKXrxITWrvq4BImrCs+S9UiYzEYOsHE6cBtC+guVIMLO0HWUAYTtufrX5I16+a+AEJ7u/z2UQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0332;7:089SpBrFqXd343qHLL9PbMwH7wg4joK5pmnJxsgkXcb7Iydvjw6ZKwiA4ANrqsRPwR9PA27trFozjpG/4QtRgDF/i9yHkjvUk8h+1H1mUq8t14y0Ki91VMA55G3suzSReKbaiCMgszJQ10cToNC0Ofc5v6IUtosZneOqsHZhBpn9vASbwVOBYAAcqB54hdO3yTYsJTjS0lErcQlpY3EZL4OsPz5eLGEURcJfT2B0bLRaSajpa0eSGTChAhcsTrY3;20:gwho9QVOBI/uyanjtEvGFiWO8N9LPalY1XOt6WnlZwwlBukw0wEGmX9lNAJfeU4xy2fN9HPA0Po87d5akt8KeAlrOV0Xuw9s5T9wCwBAtxPUJ0bk/NwZ0f9KIVYhbtGfs0wiJ4RRfBnmYr9UkzwakN9V0HQUNj1a8y1381kvSj8T3nlVpPFGHNFPdKWaaT8YqDlp5ACPNmCjZYQIny9F491chwO/3ri+Hh+l7Sw05rZrCyEl/uV5dRklOL2Bpcxn
X-MS-Office365-Filtering-Correlation-Id: 269f0126-c5c6-4f9c-0c6e-08d5afa517ad
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2018 20:49:54.0412
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 269f0126-c5c6-4f9c-0c6e-08d5afa517ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR12MB0332
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtd structure freed early may result in kernel panic in dma close
call back. moved releasing memory for rtd structure to the end of
dma close callback.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp-pcm-dma.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 8236116..ec9cab3 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -998,8 +998,6 @@ static int acp_dma_close(struct snd_pcm_substream *substream)
 								    DRV_NAME);
 	struct audio_drv_data *adata = dev_get_drvdata(component->dev);
 
-	kfree(rtd);
-
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		adata->play_i2ssp_stream = NULL;
 		/*
@@ -1028,7 +1026,7 @@ static int acp_dma_close(struct snd_pcm_substream *substream)
 	 */
 	if (!adata->play_i2ssp_stream && !adata->capture_i2ssp_stream)
 		acp_reg_write(0, adata->acp_mmio, mmACP_EXTERNAL_INTR_ENB);
-
+	kfree(rtd);
 	return 0;
 }
 
-- 
2.7.4
