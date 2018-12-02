Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3575C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 12:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74F632081C
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 12:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grYuPt+u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74F632081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=darnok.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725857AbeLBMam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 07:30:42 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37458 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbeLBMam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 07:30:42 -0500
Received: by mail-qt1-f195.google.com with SMTP id z16so10860897qtq.4
        for <linux-kernel@vger.kernel.org>; Sun, 02 Dec 2018 04:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=px0ldm/IDOFB1WWV1D2qz0WktHoFTvg41ZitMVargg4=;
        b=grYuPt+uO91AqpbuGnu+6bdFhgOf5XIw/SQ/X6qsoCZBy/bIMzY7x5omICCVQtfGk0
         M5jr0wDDz3LRFK3R9AEtjrthTIfCfmzOjMjHEIIsCGsmClaa9SesodNX0qco9f4a5RET
         YQ2chV6wmDLnEqR5j5BiM+07BlzgEEA2IUtR56TTo1Cmymqvd0sJ+O1uy1dF4C/gpPK3
         PJltUUZs1JC8xe+zXzEvwSQGh/erbrkysNw2p6Uj7E9HsMc4ahG5s6pIRhmL0FfDx9Lh
         5+9hm5afbE8+SJnxFOUqa/VvWM5mnd9fJEbyQXxI02pvWMob0sY5ICGb6R9aOIH3waVI
         RMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=px0ldm/IDOFB1WWV1D2qz0WktHoFTvg41ZitMVargg4=;
        b=PgAw7JG4r89WV4K5MeJdeKP5021mhXY05zuMQXYunUgN2Uqj3HfdpNMnIHImizlCI4
         h9M5gSCN8cBNGkB3WToX2sXHFPshhz6zJ5dNrZ1DARuVabtmGLErpHAZPhg+KCUszMgd
         WVL3KppBZe4B8Q1/CUN/EiJGTE9M1wPMNlDCkDEjv/ANswZnkY33n6WX5B0ovpjDzj7s
         s4anD/1kk0byYHHuqVlj8FADth+bSVDF1n+GBQDXqi/g0Vadd5r6+JTsX2jaxCPHOXva
         cbzz/+uiI0GkNwjTt3kXneEvAMmsSUSAZwZBylOIrzOjVaJK3uxnJ7wNtb7q2HUhg4UR
         h/Hg==
X-Gm-Message-State: AA+aEWa/kGe5fu3mu0E/mJyCPSd5WOvgQ9hpICdkDmoq4IIaMNyK07+i
        GsePLpTUz1/ucNUqdXnyBf0=
X-Google-Smtp-Source: AFSGD/WHw3BL/eKJ+O8hW2okvLhfvPE14kVQMrmI1TY5UozMHNFDluw9Qim5JIVfJVxAfi/e1n1O7w==
X-Received: by 2002:ac8:6892:: with SMTP id m18mr11584608qtq.157.1543753837242;
        Sun, 02 Dec 2018 04:30:37 -0800 (PST)
Received: from localhost.localdomain (209-6-36-129.s6527.c3-0.smr-cbr2.sbo-smr.ma.cable.rcncustomer.com. [209.6.36.129])
        by smtp.gmail.com with ESMTPSA id d78sm5454819qke.94.2018.12.02.04.30.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Dec 2018 04:30:36 -0800 (PST)
Date:   Sun, 2 Dec 2018 07:30:34 -0500
From:   Konrad Rzeszutek Wilk <konrad@darnok.org>
To:     He Zhe <zhe.he@windriver.com>
Cc:     konrad.wilk@oracle.com, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/dma: Fix panic caused by passing swiotlb to
 command line
Message-ID: <20181202123032.GA3166@localhost.localdomain>
References: <1537154831-447363-1-git-send-email-zhe.he@windriver.com>
 <c3536f4f-9bde-4f7f-a180-aa569d4e786d@windriver.com>
 <20181022192921.GA20677@dhcp-10-175-29-12.vpn.oracle.com>
 <87ee40fa-7a01-4d4c-7fa3-81aafc93e14f@windriver.com>
 <5fa82cb9-bd32-8a3f-ddca-053f544e2883@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5fa82cb9-bd32-8a3f-ddca-053f544e2883@windriver.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 07:06:10PM +0800, He Zhe wrote:
> 
> 
> On 2018/10/23 19:14, He Zhe wrote:
> >
> > On 2018/10/23 03:29, Konrad Rzeszutek Wilk wrote:
> >> On Sat, Sep 22, 2018 at 08:56:58PM +0800, He Zhe wrote:
> >>> May I have your input?
> >> Alternatively would it make more sense for it to assume some default
> >> value?
> > Maybe, but the original code has no default value and I have no idea
> > what default value is proper here.
> 
> Can anyone give some suggestions? Though I'd prefer to do nothing when
> no option is provided.

One provided the paramter for a reason. I would just do a small one, say
4MB.
> 
> Thanks,
> Zhe
> 
> >
> > Zhe
> >
> >>> Thanks,
> >>> Zhe
> >>>
> >>> On 2018年09月17日 11:27, zhe.he@windriver.com wrote:
> >>>> From: He Zhe <zhe.he@windriver.com>
> >>>>
> >>>> setup_io_tlb_npages does not check input argument before passing it
> >>>> to isdigit. The argument would be a NULL pointer if "swiotlb", without
> >>>> its value, is set in command line and thus causes the following panic.
> >>>>
> >>>> PANIC: early exception 0xe3 IP 10:ffffffffbb9b8e9f error 0 cr2 0x0
> >>>> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.19.0-rc3-yocto-standard+ #9
> >>>> [    0.000000] RIP: 0010:setup_io_tlb_npages+0xf/0x95
> >>>> ...
> >>>> [    0.000000] Call Trace:
> >>>> [    0.000000]  do_early_param+0x57/0x8e
> >>>> [    0.000000]  parse_args+0x208/0x320
> >>>> [    0.000000]  ? rdinit_setup+0x30/0x30
> >>>> [    0.000000]  parse_early_options+0x29/0x2d
> >>>> [    0.000000]  ? rdinit_setup+0x30/0x30
> >>>> [    0.000000]  parse_early_param+0x36/0x4d
> >>>> [    0.000000]  setup_arch+0x336/0x99e
> >>>> [    0.000000]  start_kernel+0x6f/0x4e6
> >>>> [    0.000000]  x86_64_start_reservations+0x24/0x26
> >>>> [    0.000000]  x86_64_start_kernel+0x6f/0x72
> >>>> [    0.000000]  secondary_startup_64+0xa4/0xb0
> >>>>
> >>>> This patch adds a check to prevent the panic.
> >>>>
> >>>> Signed-off-by: He Zhe <zhe.he@windriver.com>
> >>>> Cc: stable@vger.kernel.org
> >>>> Cc: konrad.wilk@oracle.com
> >>>> Cc: hch@lst.de
> >>>> Cc: m.szyprowski@samsung.com
> >>>> Cc: robin.murphy@arm.com
> >>>> ---
> >>>>  kernel/dma/swiotlb.c | 5 +++++
> >>>>  1 file changed, 5 insertions(+)
> >>>>
> >>>> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> >>>> index 4f8a6db..46fc34e 100644
> >>>> --- a/kernel/dma/swiotlb.c
> >>>> +++ b/kernel/dma/swiotlb.c
> >>>> @@ -109,6 +109,11 @@ static int late_alloc;
> >>>>  static int __init
> >>>>  setup_io_tlb_npages(char *str)
> >>>>  {
> >>>> +	if (!str) {
> >>>> +		pr_err("Config string not provided\n");
> >>>> +		return -EINVAL;
> >>>> +	}
> >>>> +
> >>>>  	if (isdigit(*str)) {
> >>>>  		io_tlb_nslabs = simple_strtoul(str, &str, 0);
> >>>>  		/* avoid tail segment of size < IO_TLB_SEGSIZE */
> >>> _______________________________________________
> >>> iommu mailing list
> >>> iommu@lists.linux-foundation.org
> >>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> >
> 
