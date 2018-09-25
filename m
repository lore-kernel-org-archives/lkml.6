Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DA5C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 08:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD2992087A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 08:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMWg7S+A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD2992087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbeIYPC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:02:57 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45120 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbeIYPC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:02:57 -0400
Received: by mail-pg1-f196.google.com with SMTP id t70-v6so6227554pgd.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 01:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v3O0XEloPAczl33h3GvWMDaZAi60SKFwl/Ir7dAh7u4=;
        b=kMWg7S+ASD6lMfiWAZlGHGBqzsOdzGWXYu2WxJKuhzcsu/Csa3bS2PbNNc5O/KqiXA
         oaYcp+QCLGjiJI72YUlDveI3d9TvSHdZaDSIiqq0cquNXqfMki2FC6hVxxDoX/Iqbbvb
         eA30n1YAjNUJvXtpa9zIZWl2OYHA5QwvcmfrjhTFoJp/GDSDELjTuyTSD4Fr1gECDBTv
         /aC4GGgU0xdfXU2S5rnwAI5hPQOX/51GwAc+6wNLApDT6W5zlOYolaAOa9ARJZtBhmt3
         qTe9zbNUa6VpguOP4Zc7zQqR5JTeai+W3eW8fHu3b7guy7MIfVB97H2r0qYsE9XNwWg4
         CPpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=v3O0XEloPAczl33h3GvWMDaZAi60SKFwl/Ir7dAh7u4=;
        b=n5BrzxnnBbE9hPbwDryt7LLo0OFEjbPO4+7MOSNQrddImzHHyoLW4oN27xXlIxXmdI
         Gk3s586ckqUTXnEDoJ8I1Sx2Vwy2piG4iMmrx+Op8vbNrz8Rjwi0YKt+VMtyb/5hyXTi
         6FzOskfbR9N9vViv0GEgVCB62DH0xgw6Z5mylpIuTqg4hxFFJMiV/YE1vVwSbLMGnjt5
         Mu8iSDX03ExKSFM/GHZAumT+H8ERdSZt2GtpfNAz66mOPiQVpDsry+w538M7lzHAwARx
         LEtIQfANpbdvbMdlG+6hN0/0z0j7/gfB1GrA6uNv/53h4BV5JmnRDPTFayB8lqfE2BPE
         Z6/Q==
X-Gm-Message-State: ABuFfoj0UiwMWirLei53XMbnIXN8oZ8vCNSAP4MtgRLSOZjnQPhWPPf+
        7o5OFWdghj4ZwymD6HvdJHM=
X-Google-Smtp-Source: ACcGV60otQ1mBoHCFYCvdTGz951+aChl4Jfu4zm4n0di7sBkuMHz4PTsy83hvbsvzgibwtAGx79Mlg==
X-Received: by 2002:a17:902:3fa5:: with SMTP id a34-v6mr63181pld.244.1537865786844;
        Tue, 25 Sep 2018 01:56:26 -0700 (PDT)
Received: from toy ([104.192.108.9])
        by smtp.gmail.com with ESMTPSA id b126-v6sm3567297pga.49.2018.09.25.01.56.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 01:56:26 -0700 (PDT)
Date:   Tue, 25 Sep 2018 16:56:18 +0800
From:   Jun Yao <yaojun8558363@gmail.com>
To:     James Morse <james.morse@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/6] Move swapper_pg_dir to rodata section.
Message-ID: <20180925085618.GA26696@toy>
Mail-Followup-To: James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org
References: <20180917044333.30051-1-yaojun8558363@gmail.com>
 <2f97b06e-ba36-4f6f-e29d-a9747ad9ec75@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f97b06e-ba36-4f6f-e29d-a9747ad9ec75@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Fri, Sep 21, 2018 at 11:26:39PM +0100, James Morse wrote:
> Hi Jun,
> 
> On 09/17/2018 05:43 AM, Jun Yao wrote:
> > Version 5 changes:
> > 	1. Correct spelling and indentation errors[1].
> > 	2. Update init_mm.pgd by assembly[2].
> > 	3. Simplify set_p?d() by introducing set_swapper_pgd()[3].
> > 	4. Reduce unnecessary tlbi for every write to swapper_pg_dir
> > 	   during paging_init()[3].
> 
> 
> For the series:
> Reviewed-by: James Morse <james.morse@arm.com>

Thank you very much for helping me improve the patch and tolerate the
mistakes I made.

Thanks,

Jun
