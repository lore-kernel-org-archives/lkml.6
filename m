Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E930FC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 21:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EA5B276D3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 21:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="aIGUepmR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EA5B276D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965664AbeF1Vc1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 17:32:27 -0400
Received: from mail-eopbgr690114.outbound.protection.outlook.com ([40.107.69.114]:21120
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965487AbeF1VcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 17:32:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYkBImXdp8+bzGiWuVnCQYOapc976odlPXejxZ3V4wk=;
 b=aIGUepmRvtnHpLvqdwwT/4vjdCxNZK1F7cggSRyrplgAl6nRSHlsszq8IQbVSPDgDMPUsaszc+uhAxznj4UC6KcB2tF1hGIAm6BhOi6JqvU2iin6k6IdOWF3M45OdhVRByB0FNG9tdw49+n3n0nH8JRMCnOXVZgattGd2QNIJ9g=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 DM6PR08MB4938.namprd08.prod.outlook.com (2603:10b6:5:4b::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.24; Thu, 28 Jun 2018 21:32:23 +0000
Date:   Thu, 28 Jun 2018 14:32:20 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: ath25: Convert random_ether_addr to eth_random_addr
Message-ID: <20180628213220.z4dqgef37ht7xde2@pburton-laptop>
References: <2a63f5c5d19e51471347a1a45b5b5cd4697dcb23.1529735299.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a63f5c5d19e51471347a1a45b5b5cd4697dcb23.1529735299.git.joe@perches.com>
User-Agent: NeoMutt/20180622
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: MWHPR12CA0051.namprd12.prod.outlook.com
 (2603:10b6:300:103::13) To DM6PR08MB4938.namprd08.prod.outlook.com
 (2603:10b6:5:4b::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56f034cc-5854-4f21-0872-08d5dd3ea312
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:DM6PR08MB4938;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4938;3:3cVTacl1ZqO1TM4h2AwhO0QNtZoZiQpchyxR8ohedXIzvAc8ddBF7biA/ZXhz4K41Nt8G0rCY5ZOoX6cexmr5JuY1jR+mtdME40NoOgZK+VR6m+rj7Bny5GYfRJcB9dYpUDQ/OQORI9tuDv3RQGKHxtKjPeouFmwLWANOFrzTQRlp3B26VbAgwWyYXdoV+86rhno0lywhKVS1CKcyiea1eXF4df7R8ACAPtywqPr3Mnr3jVDctvzJI2TTwi0HSfB;25:w8M0fHOzKOO1bA+mYXOq8cVvbWnTICFJOyKFUuPHqwVlxSo332a1WSs5sliZGu+Xn2ifRxKsWG00gh0kbBfwhLY/b6mSdKsuYvHM4vGXT4IlQDhUOEtE8S0bKmZrf9smuKTTsdWgi9JWtUaZxh9KH8bsjyZ9TtqbR0w/YH997xcFwzcMO//7mLwwhJiSfXQxIKG+IZOJgGEqiT95K6Q4/EGO8VXHsQ7Y5QbpUecup8s01hunWvELslPy/MPAtFv618X5uxNn1UvbdhGEFvGeAV81NIQJWrnzoe9RtZNAmpE2xdilg7aE7dLUGqeEexJxxOLnimRrxe34vxo01iQJ8Q==;31:xEZneTgZtWWRFbfCH6ORZR5iyXInq9sEKzrYubwHGXsoLSZwxkFrYI+zrBesL1SGCAkyfqRmoQATF6/CDwHNzaoHq24ND2kTT3k1ZnlkwvL0Kae2tR4MzoqU8yWEQDsJoHMJLhxj2Gpw/Tm4PeIC3BqMWJkQYJ/mZFZ+hAorsZ3CbhFhfIqvgxfPddpseZsCJeuw35W7mz/LSJKeWBlOkFs73mcloJYlZm0H+9Bk9yU=
X-MS-TrafficTypeDiagnostic: DM6PR08MB4938:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4938;20:+CGNgUqkDf4Azjc07lF4faaYZ8T97OrN2Rnj+YJI1yiirue2Ky6H9TzQd4UaUONKSebave+4VI1swuQlfjTqqgDzux1Evaa4lUEBdKCkQPimFBBje+ytBQTFEPfAqG+Fav/Uj2mXuN16dGvVgOy1tWjjF05a6rYLq4wsqEbBI0OS9IwcxbEslMHnjsECZ5fx8ScRD0aa6NnxmmqGe0mSqIs7UeJB46NdhlnLNFRX3vji5CH2hpAnFQvqPTbmWdf0;4:oPB3/GrqIFvAO5lKDzEZj8MDxhMxBHtleNqjtMYbDB9FGV9TlBR2I32qHsUD5+9tmRLGF5vbwY17UuMlKLFTOJ52r0S09gsjhGHebwNu85w9ns3mESoxPRZX336ASPdEDEZ9iF8QyJkD4QvpEFh2rZYbsTrzepsyV3wbGkYwm/zkRVZcAehE/O8N/RweuqvLZxHyjEvuA3d3YWjYu81wjNWmpM+BfQimJKgiXAM3VGdpDIJCRNy+x426d22aeyyMBndR8+ofisgpH/PD9wQzMw==
X-Microsoft-Antispam-PRVS: <DM6PR08MB4938374088316D3A167076FCC14F0@DM6PR08MB4938.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(93006095)(3002001)(149027)(150027)(6041310)(20161123562045)(2016111802025)(20161123558120)(20161123564045)(20161123560045)(6072148)(6043046)(201708071742011)(7699016);SRVR:DM6PR08MB4938;BCL:0;PCL:0;RULEID:;SRVR:DM6PR08MB4938;
X-Forefront-PRVS: 0717E25089
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(346002)(376002)(39840400004)(396003)(366004)(136003)(189003)(199004)(6486002)(6116002)(50466002)(3846002)(81156014)(7736002)(8676002)(58126008)(316002)(66066001)(54906003)(23726003)(26005)(1076002)(16586007)(9686003)(47776003)(8936002)(478600001)(97736004)(106356001)(486006)(956004)(11346002)(446003)(305945005)(186003)(81166006)(105586002)(76176011)(386003)(6496006)(476003)(229853002)(53936002)(6246003)(76506005)(33896004)(16526019)(52116002)(44832011)(6916009)(5660300001)(68736007)(2906002)(42882007)(25786009)(33716001)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB4938;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR08MB4938;23:3hQdlEx6x3LmNWLcWj/idKcyT7TkrEjVb7m0e7OwY?=
 =?us-ascii?Q?jFpDE2RubUhvcXWyQsySoLYV0ENydRd5xneaum7NEKZe5Qg6UM5RtdD8vWZ5?=
 =?us-ascii?Q?3ibrISrwKAeATMQYhsEbQ21EBcsBmzNrVmVctrfCh1pQvCE0L1v+h4zMLgtx?=
 =?us-ascii?Q?HrMAFBrlahWYt9gGNTkNIXvCVlH9UIx42FqdpvhEAY/tIGn7BmtJUwjVh/HT?=
 =?us-ascii?Q?mG5rtS6H8BC5P7DYr7havxYpA6sEc4szRlnHE9BSs7ACbVd3RFriBw3U/SQ4?=
 =?us-ascii?Q?UzeKjgfyje4gOhcG3D1MHxlhIvSZrXDsGQyt2RiCowM4o3/vf8Y42VFvp8R+?=
 =?us-ascii?Q?8v2iiv61+BfhHcTg7kBIi5IP3jdHwzY2tBSKTc+LnqN7ketNl8m3N/Tky4Ot?=
 =?us-ascii?Q?gNv1A82d43HS4EJFEaAWlcHmsvBSH3xTNjIxtxgpBMv602E2md3EA06z+Diu?=
 =?us-ascii?Q?1SGDhtozVP6BMc5C3SkYov/XTUsu4hMPOAwQZQeDLn//XIGSEZnVS9tYWD6V?=
 =?us-ascii?Q?y6JS32yhU2ARN4qM4pSNqJDXltTk3ur+5rfAQdxZlYUUDo8JgdAZ6OD8O7om?=
 =?us-ascii?Q?lmeNPp+4BE3iV2CQB8zxPIvBVfrdXnhNi6ucKg8xsS7F0Cpi9ZX+MpauqyqD?=
 =?us-ascii?Q?CBuiRMMgRV4gdoWqVFOSaf2T3icvrF2XjkjSQOY13F6hnRy0JIEAqIZ/3vJY?=
 =?us-ascii?Q?J0NO0mQei1HhNnol80NVAdmenFPT56FJ76tAYwDRMPoPqtqhe2M+7sdWekZ0?=
 =?us-ascii?Q?9MjC77oCUaHI9qJoZbu/jVS83NSbNQJL+6a+zn54uWWC0SVlAOmVNWXBoDJm?=
 =?us-ascii?Q?9GfuWFOgNNdF55g5qJic9OIjsOghf3brvU3QZyhqcr87kVKAy/RnxYiQVGcJ?=
 =?us-ascii?Q?DTiCOdFWvqUSXnUte56ajHVAEahxOQ0biYjozOs1++7Q4IZ1QpbXwV08Ql10?=
 =?us-ascii?Q?vNkY1MewDVYs5C7WGiFYyO4COqnoAH8Zin+fiVx4yrEbrBst9nRocsEcCxce?=
 =?us-ascii?Q?qG1l2gCV4Y84TBZept02NYckysHd+iu7bZGRGFuhaXfFOtk7eXSek0Kb2G0s?=
 =?us-ascii?Q?L6FGizEpT+uFZS5BaRfPkJ82CmSaXz7N+Kn8Sct2MZrVw2YJCgJOgurJeX4b?=
 =?us-ascii?Q?jq6xbPWpCawkX/9vZEx6jDj2l5x1SUjL4S+rIFYBcQY2ZWoSZVteBVtHVFki?=
 =?us-ascii?Q?4r2u0RIvDvvluNBF9S51MDGAfDaYd/4oCNMpdlNdXbjjEzOcq0PmCvEYlcxA?=
 =?us-ascii?Q?8WgKArgjF4kp4bOly7NTlZ5s7d4yspEJmK1FPyq3VjbGw1L9OtCe1UjzyLu9?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: E5lann8AWWoIKkbTKqvy0Fdpkb0ZZAbQbcgSR3LQinsJKgSAM6j6a8301zfAepnpOotMAmR2T1ZJc6xNBbl9wS6P5siSSNBO/xvzVoA8KP+j0SyKSOgNbG7aXT9usXzb5mI+tliV64ce23iLAl77JcKrZKCAXIEhicJ6yq96Fmzqm20BRXd7f/qCPjJbeIp8mbbj/P+9UxW0uRfgrvpKb4G1WPT6QtIe5+Nu2c18P9kumUiyDxN9crYcp/FtB0/i91k3SjtSPh1rYdoreL5fC9U7Fhhj1S8TvypY4kFGAYY0d81Bnd7vNngQcgeQ2/ga0WadC1LByj4RM2pZfuOI5abx6U+mF/sST22vy184UhE=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4938;6:bvHYF6/rqkB/r8QpXeBpf0sNYWbz8D4eXLZ0x3Mxcr7AZ5LY3quoxRnY78nFGwm6KY2VucJIGFsMP8URs+QQNTrAHsZ/cQvtZ5YoxI+owqmwWFhVkdNZrSkUDF2sB6p1hBOSAwb3Ox904X0QPPEufyTMcfVSTIlA/lm3oG2iQtBMJuOKA2HRHK6OFa9wvZOH7QEJ+OvPK4ivYxGFEHZn3QkBkfxEWqqq7/9tCE+Ll3tavWEmpkhAtYRWJRldOQ2YCOgRofZgDoSiKxU3sOJ1s3MQZnsoj0k8BTlCTxp+mkEzWFW7wdlNrUW+Mu1bz0ok/e4ZNnjRyihhg4bYj+NBJ/wcx+vXP9qhG9a+wqyu1LQBwzb1t6kbH7U/KmPyFuU/hZxJMUr0FLRMtzGLUwa2fzyvKIr/8iG2byPE7MoyyIFt6/99kYWPy1IYFO/PatG+vkz0UEJuztwMCflPhKDy9A==;5:n4gPugMmlM7JUDWNeEqXLicXOTVuS1AiDWuqEZo3Sf/pSWSRqJMgjooabjNkNAYH29VzA94b8OdXPtRkEF/d1F6RIFx18DN5V2MBZwj/bCdJmRA3Bo6I2EEOaMgCyKKiDUEgG0gKB0Z0roBGiScyx31ZleV1GzeZGPypqDnzOsY=;24:Bh8VIfqMdq4DuQeBmnqt/D4Yv70/x4AAYvJpdU/yxk65mCfzuxhbjmm8kxUWWlYEV0FXbpShC2hCV4L7+AAN3x95XXlfWXIXtawybDrmaw4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4938;7:plK9jePOvmF0pUvx6FW2gkhz/A+H3llqMjt0lgF3gjxbUkwziMfI2u0a2r7XUocGHM08U77faaSfRJtJwFtMpzBrKKrJVEDPnvkYDGwSOw6AgsasjsJWs/QPR6E7zltkk9EnUsLTvt9bb7jcCTlCg3i5ttVFv17fUm3kS6w8usiRMTTzFMdadDfqLjZ3bmUmVJJP5mveXAdYDYd5LSV5jNtLCNCzS4w/OlBfGFeidZE5g240lKreiILUHBorVaH7
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2018 21:32:23.4400 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f034cc-5854-4f21-0872-08d5dd3ea312
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4938
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On Fri, Jun 22, 2018 at 11:29:28PM -0700, Joe Perches wrote:
> random_ether_addr is a #define for eth_random_addr which is
> generally preferred in kernel code by ~3:1
> 
> Convert the uses of random_ether_addr to enable removing the #define
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  arch/mips/ath25/board.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied to mips-next for 4.19.

Thanks,
    Paul
