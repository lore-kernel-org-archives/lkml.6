Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67507ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FB57206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvtetOhz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FB57206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731522AbeISRzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 13:55:04 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40953 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731206AbeISRzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 13:55:04 -0400
Received: by mail-wm1-f67.google.com with SMTP id 207-v6so6636222wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 05:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eEtanngYucKEj9fkajY3fDP+jgpwSMKcLCQ9a7mePtc=;
        b=NvtetOhzmVZ0JXUhhS/HA9/HNfK0IjkSwNVPwOCPrQDA2NvKaDcZU79IItinhby8gL
         JFMA/f3b3Id7jR2MuYu/tYcRx0hvlSTRPuoCwv/GrlRlz4eW7o5fycWnDoVwsi0Z2X3E
         eOvKGrMt9IEbrx0FW0fXc2TppoMb2f8egy4KUZRv0xD9kIbUf1z71UsuTmrxPAyRQZKm
         4oZzyICguN9XUWN470/z8NFQjLd8UOo4EjxrjZppeYeHtVcfxWoyQL5+Ow+dV+TttvlC
         KL/Eapx3CUnPtV6MXqZvrLqbhJSJ/4Dtdcj0jXeZU5MQ3J3F1uXxmYlGfbvm2SSNgwlR
         K6oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=eEtanngYucKEj9fkajY3fDP+jgpwSMKcLCQ9a7mePtc=;
        b=BuerJ0rzW8cYMFBtO/2RX/AED5jfLYOV126SmOnByC1J9/3YjBjA1P33v0eD9HhvsP
         QQFrTi/Yu0ugWTDornv4jFJhyvDPwr1PZHcYKTP7IlR/vIdb3oytdd0VoiKxufnD1VAr
         ovypJNeWqSQh0tOPmAUWPssxGMgU5BXEF2ONC5DEt9Pzeo/BPON9eQL0uzmUsFaYca6k
         JlhkRK+qEyIJXgY93QmcSN6p/SbkjbMfZM9yVnthUe00ImrP66/pP7aUMhqh+6EYIN9G
         u9z66Rmd31YFdKlGrzeKlJhhSlbI5J5sbOHRKQv1wwleEhqiBVEmGIHst39l9+liOgEL
         XCdQ==
X-Gm-Message-State: APzg51AsE1Hp93O8pTY/KWZhMCEipOf6hfyjkUejuXT2Wl9hgCjn3fHY
        JufTA5qrvobhIWBSMBCIKnM=
X-Google-Smtp-Source: ANB0Vdb7VJHV9FNpBaPqLe5SSqKahMwkPaHdSJFHgTRqefqm2J50UZnr37Vkj1rUqXJ7WVpCITR0FA==
X-Received: by 2002:a1c:e141:: with SMTP id y62-v6mr19328125wmg.138.1537359443115;
        Wed, 19 Sep 2018 05:17:23 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id c19-v6sm23082198wre.86.2018.09.19.05.17.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 05:17:22 -0700 (PDT)
Date:   Wed, 19 Sep 2018 14:17:20 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Baoquan He <bhe@redhat.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org, mike.travis@hpe.com, sivanich@hpe.com
Subject: Re: [PATCH v3 1/2] x86/mm: Add an option to change the padding used
 for the physical memory mapping
Message-ID: <20180919121720.GA47424@gmail.com>
References: <20180904151141.20264-1-msys.mizuma@gmail.com>
 <20180918133026.gzyix3oyrfcsrdcx@gabell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918133026.gzyix3oyrfcsrdcx@gabell>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Masayoshi Mizuma <msys.mizuma@gmail.com> wrote:

> Ping...
> I would appreciate if someone could review it because this patch
> fixes the real memory hotplug issue...

Yeah, so I generally try to resist random new boot options that
work around real bugs, so please convince me that this patch
is the best option:

> 
> On Tue, Sep 04, 2018 at 11:11:40AM -0400, Masayoshi Mizuma wrote:
> > From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> > 
> > If each node of physical memory layout has huge space for hotplug,
> > the padding used for the physical memory mapping section is not enough.
> > For exapmle of the layout:
> >   SRAT: Node 6 PXM 4 [mem 0x100000000000-0x13ffffffffff] hotplug
> >   SRAT: Node 7 PXM 5 [mem 0x140000000000-0x17ffffffffff] hotplug
> >   SRAT: Node 2 PXM 6 [mem 0x180000000000-0x1bffffffffff] hotplug
> >   SRAT: Node 3 PXM 7 [mem 0x1c0000000000-0x1fffffffffff] hotplug
> > 
> > We can increase the padding by CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING,
> > however, the needed padding size depends on the system environment.
> > The kernel option is better than changing the config.
> > 
> > Change log from v2:
> >  - Simplify the description. As Baoquan said, this is simillar SGI UV issue,
> >    but a little different. Remove SGI UV description.

Could you please explain it a bit better where the higher padding requirement comes from?

'system environment' is very opaque.

Thanks,

	Ingo
