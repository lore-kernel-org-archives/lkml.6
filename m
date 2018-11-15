Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFCBC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 16:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39D7B223CB
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 16:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fpulxLkx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39D7B223CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388494AbeKPCSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 21:18:47 -0500
Received: from mail-eopbgr730055.outbound.protection.outlook.com ([40.107.73.55]:36322
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729034AbeKPCSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 21:18:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GaNb6AdfGFmcsscw90PivguKXSd3Y2flrkFzBdL9RTQ=;
 b=fpulxLkxFxKlIpu6yv0WS0BLUbRKjHgR67HrZ6Nhj7lao856tQDVMkqbDQYWeQThTYGgKilorTjKNJqUKX1dngTBQFkJHoNXyv2gyFpPbz756t3LpSLFzJ78W36SEBX764Huq9loSLkVHeoDZkeKgBVTBJGuAm41XqV7YmBrREo=
Received: from DM5PR12CA0015.namprd12.prod.outlook.com (2603:10b6:4:1::25) by
 BLUPR12MB0417.namprd12.prod.outlook.com (2a01:111:e400:516a::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.29; Thu, 15 Nov
 2018 16:10:12 +0000
Received: from BY2NAM03FT046.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e4a::207) by DM5PR12CA0015.outlook.office365.com
 (2603:10b6:4:1::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1339.21 via Frontend
 Transport; Thu, 15 Nov 2018 16:10:12 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; canonical.com; dkim=none (message not signed)
 header.d=none;canonical.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV01.amd.com (165.204.84.17) by
 BY2NAM03FT046.mail.protection.outlook.com (10.152.85.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1339.10 via Frontend Transport; Thu, 15 Nov 2018 16:10:12 +0000
Received: from LinuxHost.amd.com (10.34.1.3) by SATLEXCHOV01.amd.com
 (10.181.40.71) with Microsoft SMTP Server id 14.3.389.1; Thu, 15 Nov 2018
 10:10:10 -0600
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
CC:     <vijendar.mukunda@amd.com>, <Alexander.Deucher@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>,
        "Alex Deucher" <alexander.deucher@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        Sanju R Mehta <sanju.mehta@amd.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] ASoC: amd: Switch to SPDX identifier
Date:   Thu, 15 Nov 2018 21:43:50 +0530
Message-ID: <1542298434-17287-2-git-send-email-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542298434-17287-1-git-send-email-Vijendar.Mukunda@amd.com>
References: <1542298434-17287-1-git-send-email-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(376002)(136003)(2980300002)(428003)(199004)(189003)(81166006)(476003)(50226002)(478600001)(8676002)(81156014)(486006)(105586002)(2616005)(126002)(8936002)(26005)(39060400002)(51416003)(77096007)(7696005)(446003)(426003)(2906002)(186003)(106466001)(104016004)(14444005)(11346002)(47776003)(76176011)(4326008)(6666004)(336012)(97736004)(356004)(305945005)(1671002)(54906003)(68736007)(48376002)(50466002)(16586007)(109986005)(72206003)(53936002)(53416004)(86362001)(316002)(36756003)(5660300001)(266003)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR12MB0417;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM03FT046;1:TbH5nS+4jd5Xh0l8hdr2yJ3rNQT4v+sOFenzJdlkGVASOFWxueL2FJKMfbRUgUWxn8pi3gOzRh6uADklHj926h5+8CJOD+pwhtXoG3stVoUYpac62r+kQBJpwln6cquh
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b13998e3-cec2-4248-f48e-08d64b14d293
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:BLUPR12MB0417;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0417;3:lXcAGEWZkUFtvSiwwQ+oN++Hq7SIh+1cWurKsz6NgRydLp9Q0quv7n21PjmXNfZFkOOFMoUIWoI2ymudRnyUB/aqX8YU2jwMnriLJjOG1SR0E/HJvXLnzDcD2+fuA0UiKhyLAdPk6mBXJ7b0I2vF3CX/Sdpo1E1cD6wfWZZhxhHGrj0OhlFC+t4h8OQKdD6E1AYK8fvb1DqsGhbFDrg9srzksFhpV+CFq49WTBzAc+m1k1ahwGNQw92Byt41KaMVdfphLysqDWmK72nBWBsRMCAgwa/8oHZkC0NVka6SosspxPDI21k6T+uVRi3Pmpow99habmHMgmPpZfzPUqcpiXN0wxnA8zQlInv2q9csDw0=;25:rn0wGWMRAKEp19pZJMchiu3E0pThDeeSv8E3tt5GuFhQLKPNyXEc+Q405rrptBvEpCiO4ORr+KjfQIMUIkYc45eGEkr4yeX72XLh3gpz+xxP8LY+w3wfOydlqlrDxVq/j2uhs2MtanVOxTpu5ZO/Ef28aiMZ7aPaOcYB799HkCAAXtAaEYWoeJ1ji4BBNpWs/yp5L5Z7tGGZFC0eWs1yg/Tzpqy6SMSGreGhMAMkGDIj4VjFJLw8yxW11qXWUeLnzEzUsVc+igzskMoOu6kQT6+03KbLRxsQXJRTcXgjiSlK6Bvqj9rGWwJlsLrW0nzR8Tz6v7kJyR2q7VS33+eV9OYl0UtDlPO2wwvv0RQ15+Y=
X-MS-TrafficTypeDiagnostic: BLUPR12MB0417:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0417;31:GtrZywTT28ELTG6U6F0eqggAQqSTeT8fHwXdUN7L2Ef9DMmL6USuCHfz+W3ypyk5ZtaBmZ1lxEBeaokrr3mJJcNAoD/KYsV6OrFxB1Fnrb9Y7zr9NRsZSc13bL341PS4uuapCA9lshB/NON5iVcWX9kr16n4ScSSUq/TkH711t7APM+fub+ow9e8xG73zvIX+nVBmr8undms8wQsKraytaexVZ7jCewO0gn5jWjbkNw=;20:nGIIgjdqYJeZZ3yewTfDNvRev7A3ZNfWZYc61sBLHZbXMrF8wWFKl5r9u4j3e8Mz9VOk4nh6jqh5nY1xF+4yvsthd9sorfGK9RMM8yllr+DFgPY50tjiGCC1yDprLwCyS4XHN7uF2V/Ft7nujjgVCbB/64+45zJmxleZdEE7Oe19DoWEnjKtHhnW9nDlxx09pg5E3AhJzIsGl/FU9rzwmGJa3HNhtItOaYt5zArSz0xrLrKJ77Au7tFG94WB2dAJV/OoZq4T2rNMgltukLm+Qy+aLjsvKC7E5fTfxt1McXWZjFa2LuYujHT9moHKADnfGuDCE2VbL7qKiNPtrihF2Fjzu3yExXFmggE7Fa3/s2KhrSiMS81LtKYucfSvhSNJjSztFc35trpwr5ZOG8LukVIOWTvBA0++D1i8UxkPO6R90iN8G6qxAzEVAuk86bSpgaEvEWb2B2MngJxGSEKH1N5ui36CNmFKazLcXaJVTGw75/vSBZKeuvDXjqTybTIu
X-Microsoft-Antispam-PRVS: <BLUPR12MB0417A578FA80C9A547171D6F97DC0@BLUPR12MB0417.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93003095)(3231415)(944501410)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BLUPR12MB0417;BCL:0;PCL:0;RULEID:;SRVR:BLUPR12MB0417;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0417;4:nFi5l60b9YTfvCqD4ZwNmN2nMU6kJR+prZ5YXzApQ80riMxWm6SqCEk+APjP7QCmKXQ0yY2EVOLhsL54UJWjqxpNpEM91eqkdOiIf5EPndc0cDouMKsDe9uZy1W+kSnvE3e8Q9hBZZvmGksbxxGr3nEGjx6+dz0nEnPL5I+XOBaOcXTNA434/fVQztH8jqeAsSEa/wsb2yvC2spNQr658VAvvqUB7oOm3gQEvPkyJf7Jg2xq9ho0ijbdAm5jm+w2SnNVYojvd2w+mvZKjfpNB26DMQ8+b8NqajiwszlsWrn3zI78rjcqSaiV/eFHdDHO
X-Forefront-PRVS: 08572BD77F
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR12MB0417;23:h9nKzwkcEUfs+8LqA+xKny5YvwAWvk5H13X2T53Mj?=
 =?us-ascii?Q?sOC0cY/7XMH6VSvplHcC9HOWWXfiFNpRMUIqMOo4Es6J3M+v785Kf+4ol2dX?=
 =?us-ascii?Q?RQ4vmL/wLzb6AnlhYE0vdczD6QYox09G1TBvFl1abLhRsPDuE71lk///Y5if?=
 =?us-ascii?Q?rOilzz2ZU+MrGbdeQb8dtgmtmmMoJptWTd4UFEwiZ4zCeznuY0b5wkZUlrzj?=
 =?us-ascii?Q?1vIDJz5jrDOvJkZHDZqaodTOiEO20k4lwsJF7RcNrQdfc9aIT4rgw0LTXuZt?=
 =?us-ascii?Q?hCKsJ4wtY1RglSroHkTzgPjvDnS6+RuSEMXlHumOIk0DdB0gk3k+C/1SfVd+?=
 =?us-ascii?Q?5Bzu9NxCIqHytk0gDnUjAZRi2+6m0SMoCMTvt3gLPwWBEATGc4ePZoSj8nyC?=
 =?us-ascii?Q?Ls/HBfSeosLdVH0nHpi6uKtj+eWqK64Yflt48L9bU6yV2JTi/9dlF2bfJ0Bw?=
 =?us-ascii?Q?DEljZCJvs/mzt9jjWNbrct7UpQtbEImBwLeYR9c72nCHF+M7pGIz2uvToirE?=
 =?us-ascii?Q?4q++IqGKOOkRZ7sfoKY26TpD2AsYqQLiRrajgd0wgEpR9glCzmbF6AE7jbOj?=
 =?us-ascii?Q?IbxzreW3O1bW2OXHIP5OlnFJqmZH/LdXSBVIrj9aKF0Qh+28lB/fuyx6VVpO?=
 =?us-ascii?Q?zkg3ZaR7LpP9TjeooASMkbmXI/TIRI/uq6JG2Joqg0VffIQ1YyUngKkewRBt?=
 =?us-ascii?Q?d4RaFbOOD/diqqQ/6amhH2Gycp5WL/gSBKZzDl6EK+LXExT3AE2ktFPho0Qv?=
 =?us-ascii?Q?VjlN7ACiyRfTFFg3rn4QHmPub3BcaF/pd9vvI4ukWqCKS4M7ZwrW4pzW9uK3?=
 =?us-ascii?Q?QjOihiEoW1Xr3W0osUjPDxd/MNGBS2Ktuh+ToJOA2chENtI/hXWNrj7Sf4Ae?=
 =?us-ascii?Q?KKG8Avs8kvKlcZhqC5cyUMgGR6GKz0l0y4oVHRlyU+5FREyQrw5j4Bdau71W?=
 =?us-ascii?Q?FO4412Xz9P1jJisZwC0vK5qk3bViGMvzeYBF5KqjcJvZir3DlNOk7sAs4MtK?=
 =?us-ascii?Q?+4PccA7A8f4JInh+uFO+dE7xJcheqRgqYSb4b+on1pRkQQtsY4Z0RsW8O7R0?=
 =?us-ascii?Q?LU/Fy1D36LDsMde6/xyJjX1yE/xyJhlLwGuMcmQ6UmFqTZt/PhiYWSohba4L?=
 =?us-ascii?Q?XR/mveOAC0VSKzoKzT3LE9NVRDFofnbEkDXAUmK7nsaKuGR5siVbUqvHydBp?=
 =?us-ascii?Q?hWQeoPGBHqGh5LHoubJPEinpd20bsLc4JUMKACUZnUzUj0yxz2XjZM1ejfel?=
 =?us-ascii?Q?QxhOzU5uvSdraigIBs=3D?=
X-Microsoft-Antispam-Message-Info: Y5bXx1Ise1CSm+Eklp9ws6917Dp2oD49yK4u+ByceUd+wzVcxpma/GeoSHcGBRxQux38ea+E840ny5JiSMcbYBP5fhkpPtummX2GqpcxSegFYr3cbcIKDRKPGdoNwpnR0TVSPyB+itXte6uDdYr2hl8LnhNMpVVj7NlJQxdGic2LBruP/zyfWS86U2IpCAaHaZf/VCSbO7oc7lb6cRvdYacrdLwRA3jO835gainxK6jtMjmjpzh+VQrs+/1wfDHUqw4FjEAc2qDYd9Xtcqa3k+a3suBX90MMzfTKH9p6EKXFnhQTrWsRJyw2DUUd9JCqeURd7CZbMY989YNgbnbUoP4KZcQYT9VNcDzqPC0mRtc=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0417;6:U79TFhj0lTRthWx+wY38xk1cPi8U9/4smgtCoP21/i2fL24VXaUIAM5ryM6ZfQY6CdesAnH71Mox5CuHC8FAyAlHJnm7Dl2QF5otycqAOfej6QhRdbhq0kM3MIA/yuNgc6hCcpgIFdPGXrKOSCTLrV03e8V5kjGJ7UL9A6TVlCSkyJa2Ey+tn30eAp/QB5C0nShgsa/eDojA0vKXeuXxcbsgheXaZr3o1CKnUXo2qetUhneZmMh97kLpUU9ptau9eIwQDhY43xWEq3fQEBZDnyaN6ohzju4Wq3P6mOfglSlZMO7bphKg4VK3Oh4lrA95OQcfPycc1cjeM3l91lP35ggibQ0iAbNk2KyXe0NtyszUV0nFz7hTIRjsFn8AzY8PnAE+G8Lhu9JGhvoZbEdWs8aQ2QP1TO2x24uBwMuznfjVRbRaZmV/XF4WovcVn/WIL0nipVLRqT1kmjeRu1jgjQ==;5:zFjGXVBwZ0ZGzRIK3TKkw2jhhMrNgr0hGpjlmjrpQ8DIosO5JmWe5YnlR3SQ1kINXM99SWiJ0Xuz7p5MFRyiYvim82QsEE7kEJWwBvnHZ9UOCNQYSYn9vFGLTPL3ycEDrF9ILU1ZyBtIdtil9hH7HCU95eDLnlUB0ATurWpSZCQ=;7:XVcWowGU5S0n17G2EqCjL+Awbuke6sbIUZujeCfJCggiV1BcsiXm51wtJdJ/3VPS+AMR7TcScweT3Lw+lkyFp1Vu6jDskUlBDuoqkAiWlanhiAejP4TqRKSUxodZdiO8+mqr0ZwbG2dbx/wG3oWIjQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0417;20:xuCnv5l2HSwdc2n12VqG6iJm133U6jL/1SCVBTNadhQCtWYIA5TO5Kl0MMK/EvwHvuUZ7MUw5fkEMXxjBHne2Wl71EMWQsF39TYsqhNUtGk0XDSriDKf5bdRoGx5J7yRBEkCbuNHiDLQPNRbTuPH75+Lidkrd3WBHpD9u3jwF/yup1J/PhlIxibojXPG273IeyFR6W/10IQLK4GD/abcnYaw539F+PxvmUdlB4FlnKHtPvdmhkPN6hoN5V6Nc9Os
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2018 16:10:12.1813
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b13998e3-cec2-4248-f48e-08d64b14d293
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR12MB0417
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adopt the SPDX license identifier headers to ease license
compliance management.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Vijendar Mukunda <vijendar.mukunda@amd.com>
---
 sound/soc/amd/raven/Makefile           |  2 ++
 sound/soc/amd/raven/acp3x-pcm-dma.c    | 19 +++++--------------
 sound/soc/amd/raven/acp3x.h            |  7 +++++++
 sound/soc/amd/raven/chip_offset_byte.h | 22 +++-------------------
 sound/soc/amd/raven/pci-acp3x.c        | 19 +++++--------------
 5 files changed, 22 insertions(+), 47 deletions(-)

diff --git a/sound/soc/amd/raven/Makefile b/sound/soc/amd/raven/Makefile
index 8c03e6f..108d1ac 100644
--- a/sound/soc/amd/raven/Makefile
+++ b/sound/soc/amd/raven/Makefile
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Raven Ridge platform Support
 snd-pci-acp3x-objs	:= pci-acp3x.o
 snd-acp3x-pcm-dma-objs	:= acp3x-pcm-dma.o
 obj-$(CONFIG_SND_SOC_AMD_ACP3x)	 += snd-pci-acp3x.o
diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
index b16cdd1..2aa3420 100644
--- a/sound/soc/amd/raven/acp3x-pcm-dma.c
+++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
@@ -1,17 +1,8 @@
-/*
- * AMD ALSA SoC PCM Driver
- *
- * Copyright 2016 Advanced Micro Devices, Inc.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// AMD ALSA SoC PCM Driver
+//
+//Copyright 2016 Advanced Micro Devices, Inc.
 
 #include <linux/platform_device.h>
 #include <linux/module.h>
diff --git a/sound/soc/amd/raven/acp3x.h b/sound/soc/amd/raven/acp3x.h
index 95fef85..4f2cadd 100644
--- a/sound/soc/amd/raven/acp3x.h
+++ b/sound/soc/amd/raven/acp3x.h
@@ -1,3 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * AMD ALSA SoC PCM Driver
+ *
+ * Copyright 2016 Advanced Micro Devices, Inc.
+ */
+
 #include "chip_offset_byte.h"
 
 #define ACP3x_PHY_BASE_ADDRESS 0x1240000
diff --git a/sound/soc/amd/raven/chip_offset_byte.h b/sound/soc/amd/raven/chip_offset_byte.h
index fceb7bb..9c1fac5 100644
--- a/sound/soc/amd/raven/chip_offset_byte.h
+++ b/sound/soc/amd/raven/chip_offset_byte.h
@@ -1,24 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * ACP 3.0 Register documentation
+ * AMD ACP 3.0 Register Documentation
  *
- * Copyright (C) 2016 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included
- * in all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
- * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
- * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR
- * IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ * Copyright 2016 Advanced Micro Devices, Inc.
  */
 
 #ifndef _acp_ip_OFFSET_HEADER
diff --git a/sound/soc/amd/raven/pci-acp3x.c b/sound/soc/amd/raven/pci-acp3x.c
index 0700162..ef805e7 100644
--- a/sound/soc/amd/raven/pci-acp3x.c
+++ b/sound/soc/amd/raven/pci-acp3x.c
@@ -1,17 +1,8 @@
-/*
- * AMD ALSA SoC PCM Driver
- *
- * Copyright 2016 Advanced Micro Devices, Inc.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// AMD ACP PCI Driver
+//
+//Copyright 2016 Advanced Micro Devices, Inc.
 
 #include <linux/pci.h>
 #include <linux/module.h>
-- 
2.7.4

