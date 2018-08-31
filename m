Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9BCC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F55A2083F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="PtRgqFEj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F55A2083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbeIAAdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 20:33:03 -0400
Received: from mail-bl2nam02on0119.outbound.protection.outlook.com ([104.47.38.119]:45376
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726869AbeIAAdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 20:33:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nznYOGtk4qZu6av87MxS+/ApZn8zljXrS9zZXfIeHvc=;
 b=PtRgqFEjS0a73ABNdMykIkcmYVZr75+Qdhb8vdxLnVguZ8cmx4x/E3a5bwpu9v2+L+KIWZKWeU9rgFjTsUDBJgAowO4Z+9lugl0zBq73hMF9iO5Fb39S+EbPVFD+DxBTadXbWqckoO0Vig68O29LRDcjiWnP0vZZ7/adKyFj+xU=
Received: from localhost (4.16.204.77) by
 BYAPR08MB4933.namprd08.prod.outlook.com (2603:10b6:a03:6a::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.15; Fri, 31 Aug 2018 20:23:53 +0000
Date:   Fri, 31 Aug 2018 13:23:49 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: your mail
Message-ID: <20180831202349.xcz45jjcy7xvx3yk@pburton-laptop>
References: <20180827145032.9522-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827145032.9522-1-hch@lst.de>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: DM6PR08CA0036.namprd08.prod.outlook.com
 (2603:10b6:5:80::49) To BYAPR08MB4933.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1214694d-0cd2-468d-efdd-08d60f7fabf8
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4933;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4933;3:qdZZUpgKHXqCBqatEY+U5dS+oEB3w6nkMSVg5FkFLwLR9U0rs1gENoiXQYWTsXWx4n4FXw82hpnGB/u1xa6nhzqratpOCifWobXHOrH5JnVgb3N9LP7NPmdjRqagAJ9CTxnZSf0I9vimWSOT/onVCwvMDK27Uqe0Mrv0r+MENynmTOa40atF7OA8WnhUQg98DgzAsFbnkQtmaDTE3Sm/H1RKXWYy4kcpgLKPrrCJCfjJ4IDHaSNvyj51gZxT7P3E;25:tmrHqxtIY6+CnLwgd7A0stFCiDG3VJlMfVzgfcmvM5NHGKy+MxE1ceL97r9n2/RxMGND+RKr1RQhnfMiCVDYuPHa4x57a3gLVzJRBb1CoSqSPPAdhGwtaTJloAh24M2rmCaKdIsyoxtHQ4xAicw0rcZZ6y3vOeB8mJ3F0zjIpy2aMtGeamJ0dHyRiJR0a+NT+6T4mfSwcM9/2yxs7zd5lBcOYvwad3J9odPVU/4Q/TITSH1c4KvF62yldhkuwaIs2DhUEqYQqr0gyuUjeq8K5MAW/Bf4c+6yNtMiza886gCf785gA2kwcuOn7PnzmpQATdsSNgnQCHGC1tMq8WcDTQ==;31:yfpIJnjhylev9EUGXMEyS+H4EYVXQyZPW8TzLsu8GUYQg7kECtyl+RMUecxHYgmclKBHSiBx3LFRnNyPDTKiwsuwlrUGo+zM4r+bqJUv0ngyvicx/rzdGd/bQdtuh+VNh2LUFH6HuCMdG3N6+N7z9RS4M+1MNTjsIgJMKhV5z1KrIoeVtxlc6o3XhaX7l7R7gEEgoZHjdzm5534OpAJ5bEIws114ThQRBE+Yr6t4I+c=
X-MS-TrafficTypeDiagnostic: BYAPR08MB4933:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4933;20:6B00CnnT2/pNY4/L/h1SdTWxUYA1o+/FlV0LFoq9ZYFZHfvQq/YBm3SfE+QWnllf5fb/rhQBDT0jlK2NoPDpgaXjBYv0kQwdjfvyzMbby3lW//SaWP4KFgkKNMtNVqyzhGjmIhdH+ZMj73RYsE3wkgto35e8KXCDglIyTCJNvPvMpKUipF8sBAihCUoeGoc5Uhh9TYM8xEJRTr17Rd8cQPYUlsA1pFkE0MNVM2DkTYmykTbxIPgY3CTU9MkXuyUy;4:cXGtAahbXahQSgkGjjUBb9WwPTm2S6Xlv9lbCmL7Oez/N+4O311y3OScsKWjAXV67Cfi/F4gAo4wIUnYjp3UGY0HHUcst+kw1fse8xQiu2TRM0wFjL5CtG4eRo4XqfvvrfpuzhYUe0u2u8btesyz8zCSgRVQnfRNTUE9PO5jVNSIRnqElN0IkrU+UUZQwgRlUMH/Um8MehHwdWVb+34TBgTsGhuCM5Q5dWn9UPp1n29zG3o4T1wm/oZowRVBoZMaBnMa+dBRhYJRBGw6y1pvNw==
X-Microsoft-Antispam-PRVS: <BYAPR08MB4933AA2D982C4F38AD250C33C10F0@BYAPR08MB4933.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(93006095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:BYAPR08MB4933;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4933;
X-Forefront-PRVS: 07817FCC2D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(366004)(136003)(376002)(39840400004)(346002)(396003)(199004)(189003)(97736004)(33896004)(44832011)(11346002)(956004)(47776003)(316002)(54906003)(26005)(7116003)(305945005)(76176011)(6306002)(58126008)(53936002)(6666003)(68736007)(66066001)(478600001)(6116002)(3846002)(33716001)(221733001)(229853002)(23726003)(476003)(5660300001)(486006)(50466002)(446003)(2906002)(1076002)(42882007)(76506005)(8936002)(16526019)(25786009)(81166006)(186003)(81156014)(105586002)(52116002)(8676002)(386003)(6496006)(16586007)(9686003)(6246003)(966005)(6486002)(7736002)(3480700004)(6916009)(4326008)(106356001)(111123002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4933;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR08MB4933;23:keU9RdKCMYAF+VQyE9JBYAneB1LTI3SB5dc05HUD7?=
 =?us-ascii?Q?8HRkO+uI5GFxvNs5L6JArXGVZo69L7aLUa0BxArg3srS6AdCm476L6spAS4j?=
 =?us-ascii?Q?+LiR0C7jvaDZ1btvBnGRmvq/bX8a2agzA4D6pfO2tCGmu9N9dwRr+rbzUXMF?=
 =?us-ascii?Q?/M0hD0iDG735irQIJQcJJRmIWf+smjvH7dFKGajPpheA4Io728mbgwgpuEr7?=
 =?us-ascii?Q?0TmAnsjik1oHzcIRIkA06zgSdowGdQuvMTep8p4NUv5y8AXK2MKFTztP3fMg?=
 =?us-ascii?Q?IQ3r3ULdutM2qkYgNYlATZ8SuXId5iZCKJo1ef4/Ye4ffSz46YasVyh3eMqC?=
 =?us-ascii?Q?EgAFiH/S6wOGGg/L5+sXDATIC6W5vmhNzIT6lLSWQgrveab79qUdebEz53Ws?=
 =?us-ascii?Q?eMPageMwtbxGjnu1clSSAxM6svskeGo/KUZ18MXaj4TRbz4fTCfmy6sUEigs?=
 =?us-ascii?Q?Ld24u7/DF/SoEc6aE17sIyPymqEsSzEwum+C8QaRf7PpSQwl8EnO+GxzFRUn?=
 =?us-ascii?Q?j/40Hs50xQdZLcm8ymHYKxKRU6oBTTEZs1cRMZ36t1VrcfDLI5mqUdABRrpl?=
 =?us-ascii?Q?taAszTbE8z9Ej6KyF7LNRxrN/uiP4/C9KAo9jzra3scFAk5qtvARTmVqataq?=
 =?us-ascii?Q?BJJ83bYipi9Jc/RLFO1jJQtwLhhEtDcja9Y/5Af3yGHTlGw6RUPCQJPb1mfV?=
 =?us-ascii?Q?vulV0xGhfZsnGqsCmFBot2W30Ko8QkvbPqhcMy60ydduIl8w14BaSD9YcEo7?=
 =?us-ascii?Q?hb7bke8FP+sd4nRCtGW6BNTJ30Cy9UIQAUnCo8CcyDLtXHc7s0z01egq0cob?=
 =?us-ascii?Q?6rhnUojxTevRRbHZ48FerO7C5PacRSlr/BylSoIXCuH5ljxgs+jW9cXTyGA3?=
 =?us-ascii?Q?l675SzcZpYAX1bWTcKQxkkYEUyRoymvG/2teecGaODMaRxR9ecFOkpriFBn8?=
 =?us-ascii?Q?z1XvnRxx5ZtcrDFYnlDXow3QLkpXE5BRPO4azvdIhcAtrmxm5RgkmZWrnUmm?=
 =?us-ascii?Q?kX0nHby/VpleERAiMAg6lu+sQpbl4acsvRCTyf7HlYkLFd+GDWDAPCMyBrK1?=
 =?us-ascii?Q?XN8e2SjgyZ0Vsou3DKJ7feY1g5UDcNwHAcfUds6/2tNjKW7NUcYJ7etF3/3b?=
 =?us-ascii?Q?OmoyIa2Vg9TlspUCsN1LtlIc06YtfNRCS0uOehdWPa/xV1aMC6ITDlszvVDh?=
 =?us-ascii?Q?cwSxfLQjJmZAaWbLDsrIMogYNhb90b0f/P+1lOHiBIRZCWlLlsAV2UalDXLn?=
 =?us-ascii?Q?qSgettwdWuDDoGfrL+wCPxtfyQ725TFx3yngH4LqRF/Ghv8Yoiqa+0OQQtgw?=
 =?us-ascii?Q?+sG5NtzWlS80vSck0NMmM965tNJKkMA1edQHfdFDsU3DhujxPjbRkRAXy70r?=
 =?us-ascii?Q?gHGNt3aTcfzS/KF/aiSwt4j37hM43wJZ1yqXwswlxQbuQJSS7wIL3hXWxgF1?=
 =?us-ascii?Q?qdSx/z/ew=3D=3D?=
X-Microsoft-Antispam-Message-Info: z9/xY3ivPCBaiAlfPFOvSPeT07qNUjwPS444YOfUs18ftbSrmJzr0TlT0twZ208Qr/Nvj/d+nnxsny4zehHROQWXrRFDqbsl1gPuyRVNYcO7zUSuzEk9Y73LObYh9lJAP9AW0hWfh93NgZdEqYaXGe1i+/Xhm3vHm8wV2C7lFGBGnt892KFQrL6YJob1vhFvr/rXLkQKEHSizANvrfN7+JaHAQooTIKBidLBkSuV2xW+j8NGTdKsfIoW6CgOmA2KONyPNu+X7jmdGh88r4f9FLIFyDIYI46K1ObtzQXm4u5Lxg4s+sUz0wX9Ngi0Ql6RPCTyAmqsGSRft2CoVVD18dCBNUJsZw2ODtevBc7fONE=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4933;6:Ap86ZybY2UOikk1IXg0Z/FPjuE+PuOrZ0rL1rnK03sRBSJFamPaSBs9GoPEvzjHFLc3sJhrqMHZs/Boy5QWIQxGEhUqr3QO5ZuozHV4VFibDco/QOc71fAxDX4ptZTQzL/8yUfzYw35CohTab8qjf8WRKq929MlbK4U+WcB9pHgx+JRUV8NVB3DRtyQMUHQCEwmDK/TMaUXnwotqJ0l0tTEtSWNQn/XpLCDaUHp73vje4GAZjQ4C4ZRxXRlrGvnOnPyqkIbd/Sssr0zKXNsu6hAFvWvUZheplsqj1Gf+uXLAzaXvwi/rvb2R8Jsx7MZmrJspWT0nFXMHp8A/E1x2ekJ+fPb4kXXsLU5eYnM1dYPEQSMc03voJrLnZ10FOTZciF/AMjbA+FUnzOyv2IZv0+Morwb9GmwFbXBQ+gZ0J++Yker4ag7EVgZ2mx6+w2X2FDYUHbXt/DVi0VCM5vJywg==;5:sBvTYb+MqLtgusnCZWnDvqpPPGU/z6t15wk/mcvS2adVoRdaKEOZZQcgN0Fe44fnZej/UEYFkWh3BAGAUg7ag4nfEWKfb1l1U6i5Td/M8nPCdDZjlqcS0NCi6iK8rCnU3Jk/rHUfafjYEZi8mPRz3gEG3U4mqrnrG+fkPFFYAb0=;7:W7SS3yICln2nfTF9+x33FknPQi8vk+DSqXp8+mX2iR3fp68gujUW7+aBUlCq3oEr024S9gmQLhksls1DNavjgz307Vjpq0HXYimfXFcHwJMsM2d1Mv3ArXI2XvVonwcQAwzS+qvo/6zV3Oe9NUJ7Giz9F9mQUYXxx5CD4NTZ48MB5+MVFeWSPfBkCPYdlwSts6SLTnZORTtj7ziTsmHhk+0uaqVveRxAo3tLZFb0tvBOMMyHm2sG9x/G6YuKI6BU
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2018 20:23:53.7797 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1214694d-0cd2-468d-efdd-08d60f7fabf8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4933
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Mon, Aug 27, 2018 at 04:50:27PM +0200, Christoph Hellwig wrote:
> Subject: [RFC] merge dma_direct_ops and dma_noncoherent_ops
> 
> While most architectures are either always or never dma coherent for a
> given build, the arm, arm64, mips and soon arc architectures can have
> different dma coherent settings on a per-device basis.  Additionally
> some mips builds can decide at boot time if dma is coherent or not.
> 
> I've started to look into handling noncoherent dma in swiotlb, and
> moving the dma-iommu ops into common code [1], and for that we need a
> generic way to check if a given device is coherent or not.  Moving
> this flag into struct device also simplifies the conditionally coherent
> architecture implementations.
> 
> These patches are also available in a git tree given that they have
> a few previous posted dependencies:
> 
>     git://git.infradead.org/users/hch/misc.git dma-direct-noncoherent-merge
> 
> Gitweb:
> 
>     http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-direct-noncoherent-merge

Apart from the nits in patch 2, these look sane to me from a MIPS
perspective, so for patches 1-4:

    Acked-by: Paul Burton <paul.burton@mips.com> # MIPS parts

Thanks,
    Paul
