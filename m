Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8F2C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 16:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29F46223CB
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 16:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ucplL+lG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29F46223CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388436AbeKPCSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 21:18:04 -0500
Received: from mail-eopbgr800055.outbound.protection.outlook.com ([40.107.80.55]:27072
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729034AbeKPCSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 21:18:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7K63WKwtvYfq1bDkANer7U/a6lic+3VLqGMCZLzvm0=;
 b=ucplL+lGb6Mr4vXYBUR+XLsXe5qzWI1FyxStEFQWiFwxCV2VRHm7h2BOsMphMS7CXtEdB98xNw5XnpWjOqHftJDjFmF8EfJODyVn8dQ7t3iC3SkClUVZ5K95tQbIZQRr/HXui3NbqYg4zVFemflDBrFUWIWbs8Lxv4FAx/D6I3k=
Received: from DM3PR12CA0088.namprd12.prod.outlook.com (2603:10b6:0:57::32) by
 BLUPR12MB0611.namprd12.prod.outlook.com (2a01:111:e400:594e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.26; Thu, 15 Nov
 2018 16:09:34 +0000
Received: from BY2NAM03FT010.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e4a::204) by DM3PR12CA0088.outlook.office365.com
 (2603:10b6:0:57::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1339.20 via Frontend
 Transport; Thu, 15 Nov 2018 16:09:34 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; alsa-project.org; dkim=none (message not signed)
 header.d=none;alsa-project.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV01.amd.com (165.204.84.17) by
 BY2NAM03FT010.mail.protection.outlook.com (10.152.84.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1339.10 via Frontend Transport; Thu, 15 Nov 2018 16:09:33 +0000
Received: from LinuxHost.amd.com (10.34.1.3) by SATLEXCHOV01.amd.com
 (10.181.40.71) with Microsoft SMTP Server id 14.3.389.1; Thu, 15 Nov 2018
 10:09:31 -0600
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
CC:     <vijendar.mukunda@amd.com>, <Alexander.Deucher@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] ASoC: amd: Fixed build errors
Date:   Thu, 15 Nov 2018 21:43:49 +0530
Message-ID: <1542298434-17287-1-git-send-email-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(346002)(376002)(2980300002)(428003)(199004)(189003)(426003)(476003)(1671002)(50466002)(48376002)(2616005)(47776003)(126002)(336012)(72206003)(81156014)(8676002)(81166006)(68736007)(478600001)(7696005)(26005)(16586007)(51416003)(6666004)(77096007)(356004)(50226002)(186003)(54906003)(36756003)(316002)(86362001)(2906002)(4326008)(97736004)(305945005)(104016004)(109986005)(39060400002)(8936002)(486006)(5660300001)(53936002)(53416004)(106466001)(105586002)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR12MB0611;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM03FT010;1:pFeTW6iN8OV6gAhPReQ3Vn9CbMd9m/nkGI5R4Q8rfbb3LiZBbguqVATblap/lLd9ulgUQ8YqsyJDKWXRoYmCYMGK5f70mpkujxfY6OEDc+8PVXMg7jdbpBoO1KkonsxD
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7f0188e-5011-4106-a15b-08d64b14bb58
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:BLUPR12MB0611;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0611;3:DGTjUPV/mFzS8vwv/3pgo8KeHsMdzz5238eTdfLIwy548h3qpCWLM/ouD1bIz8b6IaO4rRlNQxsc+y8eQZlZ1H8L9/MwMsfovYj5VbnkhHLhiMqUX9KqTb+tcWaOQ/Dig0GWCFUnDRgEgUCfGK1dYbe9oq0I0w82ZDhtXyV25r4E9d+H3pLW82h64k3NVjSwHHrfK99X6snUOMYlt6aOFbo0xXhGX4ZF2nxYgsLyDdC3qWNqz5DkN8oNZvPS93mFFN0J5Bj/hiz//VTkyOoTCPDiNc5XUSRauafQEafgAYwy8UOkPGpQA1eeJVHCujTcP1g4ERgaogjBGGLvnFQh35F4/J2Ulyj95xmPSXlmalo=;25:hQqx99kMXs+BMhjdY2CnGLKiDZWxEMhpy13Oniyy+5d4SWfAAwwBTjEI5ouxYazVZ2+DaD5B3V2N7S792uFW2SQFdtZJIjC13fjSYvZteCeDWlCX3PHAxh+J6QOrInHtOrzVrY/8i2ajz7qkvHi2bMEM/0ASG9xPsZGTD945tjNUPn8CRrxJ5702+04QnyyB/WkxUBJ8LzyeFWtb14d9f0pyeAEKWVelAwWBMpkmfmQl445IPK+wOLyQ/oUFYN2U5E18T74BLrCV3gXQEJHr+zA+ae2pXXddQ7T1+zla8A3FKe++dz9tJXFiuRupj+pD94Djrwm05g3DNaPsx4PJqw==
X-MS-TrafficTypeDiagnostic: BLUPR12MB0611:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0611;31:meZayOX2Gwfa0XHxL7R/zZnO8QGhXPHWG+PtLdJvmNfPc6jZ/voIf0FFjDiv2AjT24aPF2FiZ1Ewmh2QbzVRDIqqh10S7+SRGKSgHDT0sa24SaOmjhGJD+Z4d4MLgezo7kADeQzmk80cxhbBY0nCkD1z4fMEVd/WfCkDQxJyriF78jNSg90fM/2X1xpIQc7OIFwxL90my2Dw+zU5llUB4dmvR6nqahwvmvK9PEXleZ8=;20:8EYpe31r4Ol7W1D1wPmnO1ixYApoqgDqxX3kgrhmULev+E4tLmbaHfxyd+SgXKdoSZD/OAQ7Ak9ULfFjeCqhKXK0xX3yaSepZujhY2bN/xX2lKNK8V4AVdPyvkAQ+71k7XR61pUg3z1lXVixhtmYQ0GKXhrCiZnZAOdj4afo5hPhvzbfQrqYzUaBQdboh8dGAC5PWRdS4jnaPAzbo7o7tnQCGI3PcT0HeQ/+7THbDBdtdsg0Cm1VKzKIMB/lC/Tco4UgZzlE12CrGwOtMu8q+cdV3yMsPH1oDerTKPzQ0oTuNBH117Vuij4FFUUwGAY449nwBxxIswBhihDVsub9wR5foD5EJZVzytbtwXgKpZ0NkXcR0imUG8mKsVIwWLk7JKCGtxkao1UAlvNjVBcbPR+wzoiKLOpgm7J7NduNnXHC4QdGRSIr1atwlB9KjC0BeolRDyLKHLS6Xe9H32Utw2rEaPO7X9aNFt7bd3iI8fDCzccozqkH1SNqxfBi8rGx
X-Microsoft-Antispam-PRVS: <BLUPR12MB0611C2748643BF6A61515D3397DC0@BLUPR12MB0611.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93003095)(3231415)(944501410)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BLUPR12MB0611;BCL:0;PCL:0;RULEID:;SRVR:BLUPR12MB0611;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0611;4:TK4XmxJjHiu05gU9RzHHwzsKPJOn3P7M+vPG9Ohdz0OX5KvrXgq8CPzni46r4ZsJ2RnfI+9pyVDd0ZgIiSiv/bR9WmbmyK1MoFRCjhns2+a3ekqLMonnAb9Tf/g3kZExNCTTJ1prK08ce5mbU/ln/KTsrwFxhFqMmzbUNGfHRg9MVKnAs05SnLlxOmHz1nUARlN/97D54s9iHL24Aagjo61K6Og3HeUF/2Mos5d2MpNbwLoWnENHfByQfWLjhaII5KH4bvclvatODFgfqxJAmNxnSFVtq7N1EaFsjFfpST3umhjkLaWf1+Y1ZW5nNpMX
X-Forefront-PRVS: 08572BD77F
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR12MB0611;23:/v+2sTDGgtd7hHSNnDpzL9frWuc8+jSgUE6Jaoxqi?=
 =?us-ascii?Q?fLzNVgdOrYqKv2B7QYziVcPxCdLFpWNAXr/ucbw0rFNYKDTUJ+2RNtXgmhNZ?=
 =?us-ascii?Q?SM3uOIJ9AxePSepdpsWUJ9L5pa418E8HGDNGD7filwJIu9IWQKH0lXgy1UBY?=
 =?us-ascii?Q?EvCHXGrhPbuXVIuPLhGuJMGjGE6scOkAPrEE9A/4IyOBZKoOuwvEIAEpH/ad?=
 =?us-ascii?Q?Te9MX8ld7oAsrGnueFopxi7s8u4p3wubE9IyBF7wtHt4LFx55tBxrwQdnhPL?=
 =?us-ascii?Q?mfGe9r4BjSTGWjsaQOQbm85aMirQpIUlOr54qpe1IiZimgcXGh7lez4fKVnI?=
 =?us-ascii?Q?QyGww+W/Kf0DS3URpRxrpL/zBe0D64yQJdH4nT+CSo9XBdjoXk3hL+WCvW3S?=
 =?us-ascii?Q?Io7ab81ymFIN2p0CDzuZaTMhge/zNCdTLHRR3t6Lty+TRjgFNRJqUEjmNHmm?=
 =?us-ascii?Q?YBjO/pVcwVPpuRP/f/gj76BN0BdhM7olWKMqJ4sN19/kA/AaokZnR3UULZY4?=
 =?us-ascii?Q?V6wOnkvjWWYQEmgNtCmOeTpVUO7sgi6PClAIJ566dsScBNyFge36IyJeZxK8?=
 =?us-ascii?Q?/8fgBOEo1UmAyd7AnyW95jPuU8xKc1dhYiP97j/sEaF7fNftSW1lrR8fR2vb?=
 =?us-ascii?Q?x+To6f6I9ITKXDZ6KJvNb/tDsrwvz6La9E2fSqTopoxK4zFING2Grb8oeVYt?=
 =?us-ascii?Q?qMzLl86/WoYUh8N0PgtaWqLtjT+zzoal1o/edktptK1i/9zAbuMsWBZ3I0x1?=
 =?us-ascii?Q?PFO3DZhGUFayaTjQ6dlz/v+keBga6CyhM2/O3IkNdfrTJMPB2rG0G054br16?=
 =?us-ascii?Q?DrI1UHWI9IG4ZlsaWbVHc2v1FOouXdmx7R8mZlo+gwDOAoq2QFHFkqfU1Wey?=
 =?us-ascii?Q?hNYhrKfKkNn3ccciog1P3gbLO5t1K+CVf8gp/J9NFaZLM5oS5HceicX1uwr6?=
 =?us-ascii?Q?MlqFuLFu5d57Kl/O10iy5lC0l/WQUWUHVHXzeEhvbpMrU6CWb3pejNBgolhg?=
 =?us-ascii?Q?3v3JcaW8C0kGWk8UoMi/yeIu0GNemOlwGq+1VSSgPGh5U+yzNjRf2+X7o1iV?=
 =?us-ascii?Q?AmLg9GpFowe8ZlaKlC0umIS66V6WWrAds6PmrguxlBUNaSTv5jaq4/OZrlMX?=
 =?us-ascii?Q?HDqHVmv+4sXdDTWyeVkfd6otzkc/m6z/IwS7U7iqZ7NLMUnGgxq0A=3D=3D?=
X-Microsoft-Antispam-Message-Info: lLDlGhfUl/U2n3+RPBr3aCyWYRBSHy9YH4DR/tNhIe4UK13poOmUBIJ4mxsuGs7CxLFUgR4/kaRQuyxOziqqU9SiKWF1MBDs/u/W3UbfpsJYvVJHkCep9CdGZZ40kDuzOhpRh71dhmge9CA+s254R4BUE9YikDTls+Vb87iaTJiMj9ht8nvi6FOcnsWNAy8K+VgMWn+7rND6rhC+0oninyyrNP3e4BJiaVIvrBhcwP3lk5R+9L5Nz2UdlLY9eNDJPfKaZ8JDTQODZphfaHfvN4qpac/6yBxkuG1C3KqVx1eiicOVHPOtiPbtJefwtFVLsSHp1ghuNzR7cqQV3lG4flqltigd5sNdRafI4xzv/DQ=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0611;6:h0+ZfINBALF66nPIv/vGmfGS+Fm3PJKx4RtlpSD8xjQw5tI1fAULj4sUcrpNKc5Ve0I+88KnK1cW6ClXO2J1fJXrDelfJn7vO+G3X1+2dzkRzsWiacjVZA4MSeaW3d54+AOayCI+3sZV9Yx6B/bgYNBsnO/jJVLHyf8swOyrg1k74tmcpnUo4MQAjsaUyDbcKIuFOeksHRsZkxm7DpfA9wLMwoCjbUdQQj3QDj4Rbh40yGKV3YAgjaVKEN1KwxQrihXoqDt1hd1drdL4NRllIuIoGTyRzJJsAoFi5C5DLf5v5esbpbEif6EjvhEcWCVLYfBrTXszk6Utqx6RNRUjgUAawbLcbVBPGfdqk2Yal1cq/OagmPd/9RR6jeIJu2twYg5lDnZ6b9DMQr8HIfEWQa0VnfNUrwD2iVHC1sC+zswbX3xdNcQSa0IbY4fqMrXZAHI+CLxRdPmbz61S3PKqzg==;5:LqHYTgh7vPKRRR9JwgTzD/aUH8NNryYERphHe2INBxxii9VhTMLLKkVFdGOJjeoigPVSXzRJzwns2lR2xKASWTZlLgT06V/oKX51fJmt2zlA1UcWAfqx/S0SwMylZQlOOEQWV8PJ9c5bkw5aYidMxfRD08+DzV4P8HKtJtaTwps=;7:ihz6weboXr/ZS5t0y/MJJSdddkECubc04FrJUFiRuhRFn1YLtqY9JyMzZqKKszvftMXwaE28PlUYjfMt18eJvGcH/fHtHMpx3hJiipbufSPDOnTpUzjhZvyLOpcmY6pDy3fmYmlSPkmnT3UdpmXF1A==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0611;20:waC3yCky107PpWG7XG539VKdDF3y0aKvAhS0k+TbTYyt+HME9K5gX+6lEJxVraIK3A/BgojzP3s+z+oKI1VTLeJySJlhCCut+PIdAWFtg4Q0SaJh8+1lds9P3bqmLgBEtszl0636Lmo9/iOfmIFapbmsE9siLuK15tUEA6KitkT0R+2fdxtZi/UoVJ0546d6e/awDNkcx/Yiagemi3GLjAHv3CfQ4MAVj9IHmnNttj57GfdCj9WmXD12KWSpxAGo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2018 16:09:33.2362
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7f0188e-5011-4106-a15b-08d64b14bb58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR12MB0611
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed build errors.
- Implicit declaration of pci_enable_msi() & pci_disable_msi()
api's for openrisc architecture.
- type defaults to 'int' in declaration of 'module_pci_driver'

Enabled build for x86 architecture.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Vijendar Mukunda <vijendar.mukunda@amd.com>
Tested-by: Ravulapati Vishnu vardhan Rao <Vishnuvardhanrao.Ravulapati@amd.com>
---
 sound/soc/amd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
index 5f3b560..33ebec9 100644
--- a/sound/soc/amd/Kconfig
+++ b/sound/soc/amd/Kconfig
@@ -22,5 +22,6 @@ config SND_SOC_AMD_CZ_RT5645_MACH
 
 config SND_SOC_AMD_ACP3x
 	tristate "AMD Audio Coprocessor-v3.x support"
+	depends on X86 && PCI
 	help
 	 This option enables ACP v3.x I2S support on AMD platform
-- 
2.7.4

