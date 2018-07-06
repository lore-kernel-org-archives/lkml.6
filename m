Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A39C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F3222B59
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Cg8MaHfl";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ilzYrYfx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96F3222B59
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932838AbeGFV3M (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 17:29:12 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:46586 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932336AbeGFV3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 17:29:09 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w66LSYkP014301;
        Fri, 6 Jul 2018 14:28:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=MXPrQANexsRYvruX1GfVAFSS1PrChkqnffcOoGgY7/g=;
 b=Cg8MaHflxsQHz5Rf7Lzr+atub+gOqx52mweYXFzRRY9y3tYghIoB8S3/7wADmEYpO18f
 1+/XoXW5YjX8xk9iCC7MJ3qc7zBRDSEUqtbgd4pMwLB6jO86P1IKnprb6E1p+vsYyaqe
 bEsanEWIn1nB5Y4EOL4BlNI9ospbKLLTNuQ= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2k2e6489jy-14
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 06 Jul 2018 14:28:46 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.17) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 6 Jul 2018 14:28:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MXPrQANexsRYvruX1GfVAFSS1PrChkqnffcOoGgY7/g=;
 b=ilzYrYfxREaKbKT9J/qSCUMsohPUHo4g30mRYj+7Gbzc0jpYTzxrsn1HLg1LITpT/ScH2UCwlX48DTZbW2c9IsSVNWFTNRlEDkffw5D3E048JKRP3mCI2RaNv3yC0wI3ngz9qxpHB8eQSjGU/4n5iNX9zePQV+L7WUxmFvAZxjI=
Received: from castle.thefacebook.com (2620:10d:c090:200::4:3096) by
 BY2PR15MB0167.namprd15.prod.outlook.com (2a01:111:e400:58e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.21; Fri, 6 Jul
 2018 21:28:33 +0000
From:   Roman Gushchin <guro@fb.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Roman Gushchin <guro@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v3 bpf-next 3/3] bpftool: add bash completion for cgroup tree command
Date:   Fri, 6 Jul 2018 14:28:16 -0700
Message-ID: <20180706212816.3760-3-guro@fb.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180706212816.3760-1-guro@fb.com>
References: <20180706212816.3760-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c090:200::4:3096]
X-ClientProxiedBy: MWHPR01CA0047.prod.exchangelabs.com (2603:10b6:300:101::33)
 To BY2PR15MB0167.namprd15.prod.outlook.com (2a01:111:e400:58e0::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f8ef4cf-df52-4d15-dc3f-08d5e3876dc0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0167;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;3:Bz1o6Rn71L6WlNeW/mXHg+vZdx7B/XV6ES5mkQy8Sdu7Omem+RjJJg5/8vXc7ieqW6uDX6dtHmk4wzuGl6q5Enh7YTqyucHVPQLqfE6cYtgcdGSI1CHI8f0usk4KMAYYIh/7TQvE6oZnEFBThsVVMcKFZKMtjznTLcVuoWT38PBEXBpIuSyLIGZq03BcBB0DMx+HWUma40p7qqExxseRBuy5Wf9h4vNE2/ISWDXI9XkpnDMd9yGPZauJRtTerFqb;25:tS1iXXTVACwebcOnqwMj4Z1EC2udp/melv96T9+QKUSirlNXwCSAzPqY5Uuh3rCjiI420NEgfhOaUOtVLRvJn93I9YSzFYLTPWupU9OJZchVFq4mdIOLXC3XmkNRtA3g6nOhdEUuhFIaEMljMUYEzTai5Dr9CqmmElBY5NYohT2UvkvlhmMoqOGgo/WuW6mrZIMiKwejJPkypgw4wfhRcTjDCWXBgp+KIGc1hf9PJ1ICGdvaiXrlKTiqRfdrgwIWZ7r0iOTDfuTezJpG9lYqImn9oKbTabvPDj9FnWm4AMB8z6SavlRywnCw8w5uDlM36tESxaNyELwyOGFSFdJkHQ==;31:so65VZIr12Ja5/NdikAqOUQNkuaLGLsp34Too6876tnlx9r+1STikPFvBTv9R1dztBOCSEh0rdlIZDWC0BZbg9kieHpJCmNezMexA/28UzM8VpE/67ZrsrZ2qGCjkI8nhwTM6yeTZBcoRsYunf123g1pWQxgaTNeQFRtYA8t8f8nMhJDJlzpy1EglzMftuxhL/6zS/iqNAB+ZdpHxaeYzfsp++1hIt/HBI1lIbPcGLE=
X-MS-TrafficTypeDiagnostic: BY2PR15MB0167:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;20:GHJx9LKxViBZ2GhmQWwTlffKsnVaxxNAoFkRdltYR2x9XQkVFJTbJPSB38LeTxMgFOCo32aAJ6+uePd/80fP7mOWeBmR8aRWucw2NuO3/VOWr5NTlauLBx6ERjr1lil4WjNOkSHPo9oYGoEkDscsLHA1l75yA6xHgighZnxfcDy9h01gD7oJ9oz73ddJLgPfa9QarKpCxfdM3tLZ+0H+gIsmlAr5LAGB3iBJP+1LewI3YGdXqioFzrDXZC9XIVWFSsKgyY0eBrQFi8hFksAgayWNw8b6Q2ma022hXv2EC9DFHfCS9Lx9LuTxydDRZ2WZCTLyh8zdgLLJzVDbah1mzTgmd6bNgUOHnNA1WNJSsEnp7/1GmVKWZbVO7csTS3JZpAj3oBtx5iZx39/1EY+cezG0iZWhY+6xRzC11UBE+cP3BpElUw/kmrrfwhMmR4u7DY4nabX6Vxr9dw6h73+T4ZiT0+QwjSKqd89WVJtzL+muNmXCD3IeLYPbGv8KAZWj;4:nnU156pSHWgagBSn668r1/C3M3G0SBc9PONcEUhyIhrF9WK5IcbFhJlnzJQHTQXt6Wc4TPyX74JEZXAW5VH6+HI2TZDgP3saWt9qqgGgcrf29+WqPuv6L5f12hyoNDzP1N6QKDh2TW5rA2C6jUJgHj/XFbKui1X/ZS4xA8skgSQdu3k6tHDTfjUdu5KVt7QbyLCVyLAgpFn9idzc0wLM+IXQqpGdO0KymZfIuPNDCyOnawNZgXAuJiiTHUw2yH8ISJjmoZmaqD5ZRzSPqZR2vjQB9G9gMQG8/3EfztcdrI2bCmyh+2affrnvOeBGdXa3
X-Microsoft-Antispam-PRVS: <BY2PR15MB01675B0C85E29631157444B3BE470@BY2PR15MB0167.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BY2PR15MB0167;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0167;
X-Forefront-PRVS: 0725D9E8D0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39860400002)(366004)(376002)(346002)(199004)(189003)(105586002)(446003)(86362001)(575784001)(11346002)(2616005)(486006)(476003)(50226002)(8936002)(2906002)(7736002)(305945005)(81156014)(81166006)(2361001)(8676002)(316002)(69596002)(16586007)(68736007)(53416004)(54906003)(106356001)(36756003)(5660300001)(6916009)(6666003)(52396003)(51416003)(52116002)(6486002)(6506007)(386003)(76176011)(46003)(14444005)(5024004)(186003)(97736004)(16526019)(47776003)(48376002)(50466002)(6512007)(6116002)(39060400002)(25786009)(4326008)(53936002)(1076002)(478600001)(2351001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0167;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR15MB0167;23:+wkePOmb24zeqRtKwvvFvd59Ja0pW1tOENvorrFpW?=
 =?us-ascii?Q?dUMPGW06Tm1ZauwW8MF1HG4+l/Bly4uw7LvUwsizkJEh7g2cOTKwSUzGXsp2?=
 =?us-ascii?Q?VvRzKF3vZ6PwYw1VwU1Qlw7dUCNz9Mljb995PqlQ1cEAKDUOQ5czJ4CjWRhg?=
 =?us-ascii?Q?zLzjqpqi0WmWKmK/V7w0Jr9u5Sb+1U0fUv4+P97TxhrCXMRUIAps5mKVv2kS?=
 =?us-ascii?Q?h72DEyeGGT0xEN8DYpX7lEqzP/7w71y43xvxwYWYvEuhwHnhTv/um+DS99Em?=
 =?us-ascii?Q?sjp5+pOIAaJ9QGZlOuQmH1tOvRpXk4Ukc2mbzK87ogIJIPqHXL4Slw+1VufL?=
 =?us-ascii?Q?TKDpP0trOJUyPPCihbtgCBbc/HyQ3Mh7s66wQ71gWkAYF4dUio94gCJaJ+01?=
 =?us-ascii?Q?4l3slxaT6DdP3EJjtuYrpwrnd2s2QvlDqbAPgZz9GlsTwfOSAxhwHgc6dMTD?=
 =?us-ascii?Q?K3BmLg5oU6RudFKAeV1Hx2eMsZzy6d6TnUoJ38RSlueDDWg1RKnetnk/V4NT?=
 =?us-ascii?Q?0URqSjlDWGwUyErnZ87PL8THgbYycasfhhmkh2l8rIb7q9iDnmrqVWqT8DRE?=
 =?us-ascii?Q?TgbYVVXCCEV/LT/wJucEq9il6W8GisllAyglzPgZTb3nFZAKEmDROr3kjgy3?=
 =?us-ascii?Q?eLpaGntqMiDpu0uMRXbfTHBYcZvUr2aOooaFIgmwTw+MfQTHg9GfmmSB9g1I?=
 =?us-ascii?Q?DQ4OG7fO3jwto/xB8PCWUgW/Se/8iFHZ23ZArY+KyKwJUclkmGBxsBmS7zh4?=
 =?us-ascii?Q?51JKg1sHU5ilDkZsNEPmnId89p0b83galZstDj4OtOg88vGWUrDqLH4Jga7I?=
 =?us-ascii?Q?9Bf/L48+mqLYpcwDBFmrEK0alZy7b2xOYXz2dseQvyo2XFvzfFQeTgA2E/zy?=
 =?us-ascii?Q?tU1e57aWTcbzjaiqmhShFZAamuWj56Fd/mrOI1gq8v4il1NXwE3OtYCkAFcQ?=
 =?us-ascii?Q?xM/Q8DbIushXYm4ywB0nyAEfqyu/20gZWRskx3LeQ4YnTPKX5T6DFTgeLGxF?=
 =?us-ascii?Q?EaS8weJRuQrcK25HBHdMNgsQGxcM7VffzL1lKsrdOkZyEMImNkCRzO77Um8w?=
 =?us-ascii?Q?GuktdEU6PioQQfP5omoGEUyQfRhi90BM/qrmthZukQ5EViXOIIaE7PS8g22K?=
 =?us-ascii?Q?8OkuVXE9vm/COCbwQFPIkHVxw8jiYZN8RWRKvjN+2REmAkdEsjJYa8PlLyBc?=
 =?us-ascii?Q?3MhE0tWEQTfWsE1d3WrjY2C2brtZtu6WpVGCGUdCqyS93SJ9mLc1Ds9PbZ9F?=
 =?us-ascii?Q?4AfX7n4gK3sDKMJD17+zOUL6jNnlc5UNeazLpgEFMJGKiy/V6Of6f0w093k+?=
 =?us-ascii?Q?8QEjBPDzzB8eQx9nHhqwEwaP6+UVHu61bVuNZInKtMAGMM3EulXnqL2Jb2ZN?=
 =?us-ascii?Q?t0UKQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: 63g8PwJCq+/jFCRc2CfGnUd7sQV0jZa+2Cx08qQ0PuS/05+MR+yp4Wgrt0VuZYFXYV1i058kckESH6tuwsgAxlViLAgXnOptCX4g4yd49tSOQhKAZbW/DNVweeRHG9xQIVnJeimOKiVrWLRrHRTD3Jx5onGSlRYRNjyr3dor4WtzZ2LMFsK4lPiPyBtlcOYAMkeTLrYNVTunrVcNuPrTErbFcQdFOgsdlekvkH1M9Sh36Daop7IaRRXxmK13Ptpw9ND0tOq+Gfxn7nt0M0GNtSQ8oYxCGbSyndl0H8QvlRH/maf4s34nMMmaC07NbwtfQgpMx9tBBTb90ku+YE1bRIUdwbludlpdVQ30zGsluLE=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;6:kKg58ymuyUaF4vVoDL2eJ3w4WZO8FOKJ5QoEsvMVKSaY1qQe6etN37ioK4umzJc5kNpAq4MHsdZP7gX36SdvupD8m5wzt0H+pbgJ+gzMh3AHphybiRAK1Bkwbk8s5+2g7TwV63CRqG90aVf2txhrMznAF15z8ke+4m3t+B8MGVwJM0vnC0JP6EGXUK5x0wx9ZQ4qDf8LTccaypwB1hm9B4yyPLoa1hTSNDoIgr7zI4ynf0LzDi3GcLS9qfOqB2FWwIJ3qMWMvydDCGcwDXO1aJ8HLUjHf1rVaDKr1XR6UcSnZk2x6fiaFsjWVMtdQbD1kAdGKOrK4vRNOOXvFd3s5YW5ariW7dBHe+VV4w2eipzUtE8QnSfZJt8pf9dtAYjFFDvB4hKuDD9944yiuRiTBjYj+epBXQn+PY3EZ0Po7OWCGr78ds7FvxC56GqrMb3Q/OGefyG7AG+YzkSUYDPJBQ==;5:GmczHNsxWUUFLd1JD3bbW1nN5tF2+/lwB6GPjGUnjMtcc3CTjZMBiXhssBAqC5HeL8QtvvDbzIFgtcxDn2UTX2mWuvU1BUJ5g2KSRG7gOvI2x0Qs03GFyaQtcePprO7pxoyqTJ0DnoxrgQriaf/JZE5G49nrU96Yv61RT3wH1oQ=;24:j1cWoo0zB0TlaoLzI0gMbYg/S3l4Kpz60ShRR9joyDREPMzDUjRCOVLh9h6/An0d5oy+2wuJXPe+6k//0DHJUFF4W8psBG1OLUy/DQuxxgg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR15MB0167;7:y4meyy6i4Ihy+lThVuPqIo6VVEQdtsKbix9U/dkMs/+yoLYrlOvmmVclZXURJMlSb2FgkoSCGHr3JOMH2gD45eOwSvIwYD6kE+QiNiv4nZxtlXaDLpmikNiMGleI92MD70w+D4ojPoX0TOixo5a/Duru45zg7SV9YtiitxLktaRRhi0e/A/1KYtdUURJ/WOOOyQ+9XKCrI7ARxbPPsj8XLF8OHR/QPGw1Sz1+cs6+j79/EcqW8Ehw0KDeq8hS5r0;20:6LCKHsm1SnwgToL49WcRKc+Y/GpmOMkL13Bcivp1unmwy+NsZ7IAvHjnwYMNhjMEtJ7KW5VvTga4DEhqCLK3p29t9GszWLMCkIEExI9y32mFSX4F8gcuARNQaWiDOVMmn733BQPHyIbTw1FqKIoaopYp/AdTawdSvr9lLg6uYzE=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2018 21:28:33.8523 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f8ef4cf-df52-4d15-dc3f-08d5e3876dc0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0167
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-06_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds a bash completion to the bpftool cgroup tree
command.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
Cc: Quentin Monnet <quentin.monnet@netronome.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>
---
 tools/bpf/bpftool/bash-completion/bpftool | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index fffd76f4998b..ce0bc0cda361 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -414,6 +414,10 @@ _bpftool()
                     _filedir
                     return 0
                     ;;
+		tree)
+		    _filedir
+		    return 0
+		    ;;
                 attach|detach)
                     local ATTACH_TYPES='ingress egress sock_create sock_ops \
                         device bind4 bind6 post_bind4 post_bind6 connect4 \
@@ -455,7 +459,7 @@ _bpftool()
                 *)
                     [[ $prev == $object ]] && \
                         COMPREPLY=( $( compgen -W 'help attach detach \
-                            show list' -- "$cur" ) )
+                            show list tree' -- "$cur" ) )
                     ;;
             esac
             ;;
-- 
2.14.4

