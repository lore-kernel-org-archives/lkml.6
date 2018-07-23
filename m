Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E6BECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 19:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07F6A20685
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 19:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eJswprYl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07F6A20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388069AbeGWUsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 16:48:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47706 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728295AbeGWUsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 16:48:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KFXfBM+02EAeAzzsw2otKVz7VEkhl3Hev3vG44mC52g=; b=eJswprYl5/v62DzBvfPao2vtS
        UPVYElrHMNdGAkJRCVhWFH+td38zGMftITm0g6Ym9uQAyT3BVBFK4OwvgoiEQXfYHqzZ0J9kRdNg5
        +0lc03zy/nEAU0GeQyxvze3PsU8CO400g2QXJt12Bj9DZAZnsuyMl+o0fymrIJsHMJzF7SSCS4xhd
        E1Vfl48nTPGjwKHaTWNatiHf+NcOAqHBOL6xhbqzwyNbBxDREd0iCaOdUhKE4FktLLLM1OfSjbn3G
        DbCKIoB1XWTHTQJN0HnEmwgyLmkPa0fT2LnrDGz6v0kO3iz6v42QKnN958Cq2VOrtsRjJEaojRczm
        Sgfb9BOQg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fhglu-0002S8-D7; Mon, 23 Jul 2018 19:45:30 +0000
Subject: Re: arch/arc/ allmodconfig
To:     "Ofer Levi(SW)" <oferle@mellanox.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Meir Lichtinger <meirl@mellanox.com>
References: <e074d0ae-6d79-d21a-2278-15d516bb943e@infradead.org>
 <C2D7FE5348E1B147BCA15975FBA23075012B0724EB@US01WEMBX2.internal.synopsys.com>
 <AM0PR05MB42600653CF591791731CCCD8DA510@AM0PR05MB4260.eurprd05.prod.outlook.com>
 <DB6PR05MB4597A63819F227B17652B5B2B2560@DB6PR05MB4597.eurprd05.prod.outlook.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <82c3e518-a579-7df9-4c3f-8ecb5615b6d7@infradead.org>
Date:   Mon, 23 Jul 2018 12:45:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <DB6PR05MB4597A63819F227B17652B5B2B2560@DB6PR05MB4597.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/23/2018 01:34 AM, Ofer Levi(SW) wrote:
> Hi Vineet, randy
> 
> Indeed this structure is missing, following is a patch based on linux-4.17.9.
> Sorry about that.
> 
> Thanks
> 
> 
> diff -uprN linux-4.17.9.org/arch/arc/plat-eznps/include/plat/ctop.h linux-4.17.9/arch/arc/plat-eznps/include/plat/ctop.h
> --- linux-4.17.9.org/arch/arc/plat-eznps/include/plat/ctop.h    2018-07-22 16:16:09.000000000 +0300
> +++ linux-4.17.9/arch/arc/plat-eznps/include/plat/ctop.h        2018-07-23 11:18:12.179402620 +0300
> @@ -143,6 +143,15 @@ struct nps_host_reg_gim_p_int_dst {
>  };
>  
>  /* AUX registers definition */
> +struct nps_host_reg_aux_dpc {
> +       union {
> +               struct {
> +                       u32 ien:1, men:1, hen:1, reserved:29;
> +               };
> +               u32 value;
> +       };
> +};
> +
>  struct nps_host_reg_aux_udmc {
>         union {
>                 struct {
> 

Thanks, this fixes the build error.

I will not that outlook is not the best email client that you could use for
sending Linux patches.  I don't know if you generated the patch with spaces
or tabs being used for indentation, but above, it contains all leading spaces
for indentation, which is Not Good.


-- 
~Randy
