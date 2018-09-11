Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36937C4646A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1F32206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZC6FR9F3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1F32206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbeILB7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 21:59:34 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:39177 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726850AbeILB7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 21:59:34 -0400
Received: by mail-io0-f196.google.com with SMTP id l7-v6so4752200iok.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 13:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2ykk3hzudbtvt9XvgwFOwS/kR2W14+9osgiEVDfXUjQ=;
        b=ZC6FR9F3vXuyGWxyuR0mBkAg41IHQ3cN4dBehwSstI1wlc6w98lE8psCVQmy3Qus9X
         qcHOFxxzN6+oCbsN1NtY+SuGhSYvvx9PUzOV3gbxzwmBleKi7mweDi3uiVRfsbczskBk
         fsNvXXByRkXJBpD1qAqn/kc/hisDal/8fGjmG73aqbHN4PT1NriT8z0fv10v+Sj7DEQC
         bzqhh681Yim8fevxWKuxS+2uPV+1WB8KN78KsL0fDRikecH0hF/pmJ6l5CLqplHMH37y
         BFOhY9mXkR/VmX1C/ouEaIgNI+X1fQSeimq9zx0pThy3kQvoctLNbGWUDqDTcJN1eElI
         q03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2ykk3hzudbtvt9XvgwFOwS/kR2W14+9osgiEVDfXUjQ=;
        b=e+dwZL4Fcqv7jLluExDhSetHpU8Oo1ttyOUpiZAuoFxng1GQGvQB61pE1HiOdJ9qpt
         UFIs28z8HHMtH/iUzZ90OBDWIeCjCeVg7Za0MEBcTZbbjvFY/7wrL4IL9Bh3EZYylFTI
         zetbVTuUMG6jxwlB+SS0zrZOXvLP43FrgySNVnuJ9pgax9byaBy5HhIMcSfRg+aHziWt
         a/m8jClXGDkOgXQdsr2jKY7TZjpa4eQrJxHxcXX/6lWxh9E/0mGt5ji7vm4VKYqLDq7k
         moM060bjmsVs8r5aWUyjw8Ny7hV49zWeqnqQTE+5i5b+bOs5VPlGlWcDkHdi5VoCfRfD
         +OXg==
X-Gm-Message-State: APzg51Dk1L5uz83iq3dxYeilRwBaInc899fIuEdoG/75gGvZ58U5t/a8
        tJQbkJF2uOhaBA89zCGkkhxnUg==
X-Google-Smtp-Source: ANB0VdYcS493MYFC3EWFcVl65F+8QzpCtp+lWfPDDcCGV6j/IBadajwAsbQffKc5UzFMFbbPCUGj0g==
X-Received: by 2002:a6b:9e91:: with SMTP id h139-v6mr23140225ioe.185.1536699508760;
        Tue, 11 Sep 2018 13:58:28 -0700 (PDT)
Received: from google.com ([2620:15c:183:0:a0c3:519e:9276:fc96])
        by smtp.gmail.com with ESMTPSA id d63-v6sm1561055itd.33.2018.09.11.13.58.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 13:58:27 -0700 (PDT)
Date:   Tue, 11 Sep 2018 14:58:25 -0600
From:   Yu Zhao <yuzhao@google.com>
To:     Takashi Iwai <tiwai@suse.de>, Vinod Koul <vkoul@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Rakesh Ughreja <rakesh.a.ughreja@intel.com>,
        Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] sound: enable interrupt after dma buffer
 initialization
Message-ID: <20180911205825.GB18086@google.com>
References: <20180910211718.200802-1-yuzhao@google.com>
 <20180910212150.202655-1-yuzhao@google.com>
 <s5hbm9436va.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hbm9436va.wl-tiwai@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 08:06:49AM +0200, Takashi Iwai wrote:
> On Mon, 10 Sep 2018 23:21:50 +0200,
> Yu Zhao wrote:
> > 
> > In snd_hdac_bus_init_chip(), we enable interrupt before
> > snd_hdac_bus_init_cmd_io() initializing dma buffers. If irq has
> > been acquired and irq handler uses the dma buffer, kernel may crash
> > when interrupt comes in.
> > 
> > Fix the problem by postponing enabling irq after dma buffer
> > initialization. And warn once on null dma buffer pointer during the
> > initialization.
> > 
> > Signed-off-by: Yu Zhao <yuzhao@google.com>
> 
> Looks good to me.
> 
> Reviewed-by: Takashi Iwai <tiwai@suse.de>
> 
> 
> BTW, the reason why this hasn't been hit on the legacy HD-audio driver
> is that we allocate usually with MSI, so the irq is isolated.
> 
> Any reason that Intel SKL driver doesn't use MST?

This I'm not sure. Vinod might have answer to it, according to
https://patchwork.kernel.org/patch/6375831/#13796611
