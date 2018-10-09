Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18957C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 09:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA6092089D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 09:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XmDcZNfs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA6092089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbeJIQXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 12:23:13 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40690 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbeJIQXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 12:23:13 -0400
Received: by mail-wr1-f68.google.com with SMTP id d2-v6so932315wro.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 02:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+Dxn/NDMZ2Y87/vHF6GC+D2GUo1Sd4tLcXImcdpzS+k=;
        b=XmDcZNfsnIvleGLnEWQhPzhceWc04bYjaUfOh2OZJ8Yd21kfM6zG1VoIHH+gnXVAuW
         DlJyu4RNLJU+Ju9rNwaKX7eWQyX1n9N4DwQ1u7rEpCx5dxpbW9Z2cPVUCsjg+TwnTbH9
         smk1xOKTySCJYlYbGg3266898LE8pMQGzPTvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+Dxn/NDMZ2Y87/vHF6GC+D2GUo1Sd4tLcXImcdpzS+k=;
        b=MdC4MIwJc/M/CWf08E/zgGUjOi3S5tIuCAIc+RY/9nT/9VcAKUoDX29grJYqiqATx8
         bl+wxgtRuNso6i0F985uR37aCPhhriIzE9zmT6Q14Y7HHgLpVWYndtzcpQySzFs/Uf7k
         IYbpSDAOff6K+Se+aFF4/Hj0/CJVYjXShd2W4DOJ6HrqZmtJn7SYhN+HEQttVfA8A620
         PWOT1ZVKTHfqhouqQPaSNy+5bHK8NbCvGcFHx/peQBuWKMi8TpNN5HpQlIaSPzDbYWKo
         VSV/GLLl7+fBLP+oODOmtQxJhPHIpABkZ5d8HkJnEsRdvnCejjZpzgSEt6JQYZqSlsy+
         NeEw==
X-Gm-Message-State: ABuFfohkhVqtyCq408HFEptqcusX4xFCVKbomnINUun44axJqNO7cYeb
        3k7jqTsmVT1eqqSQbGDdGfxQAw==
X-Google-Smtp-Source: ACcGV60Etqgr2WGEtG2R2frofVh1sBihV6DYNnBllU9/4GpUHkrtyEjwbYseZpZBc6CTFdZPjdrhyw==
X-Received: by 2002:a5d:6a4a:: with SMTP id t10-v6mr915609wrw.78.1539076037525;
        Tue, 09 Oct 2018 02:07:17 -0700 (PDT)
Received: from dell ([2.27.167.111])
        by smtp.gmail.com with ESMTPSA id 195-v6sm18495102wmx.21.2018.10.09.02.07.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 02:07:16 -0700 (PDT)
Date:   Tue, 9 Oct 2018 02:07:15 -0700
From:   Lee Jones <lee.jones@linaro.org>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] mfd: ezx-pcap: Possible sleep-in-atomic-context bugs in
 pcap_adc_irq()
Message-ID: <20181009090715.GE4939@dell>
References: <f83a444a-1943-6c8c-5cd4-88e2acb17fa6@gmail.com>
 <20180917010340.GA3900@dell>
 <e371a365-7dac-8e20-4823-f5395602211d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e371a365-7dac-8e20-4823-f5395602211d@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Sep 2018, Jia-Ju Bai wrote:

> 
> 
> On 2018/9/17 9:03, Lee Jones wrote:
> > On Sat, 15 Sep 2018, Jia-Ju Bai wrote:
> > 
> > > The driver may sleep in an interrupt handler.
> > > The function call paths (from bottom to top) in Linux-4.17 are:
> > > 
> > > [FUNC] mutex_lock_nested
> > > drivers/mfd/ezx-pcap.c, 272:
> > >      mutex_lock_nested in pcap_adc_irq (interrupt handler)
> > > 
> > > [FUNC] mutex_lock_nested
> > > drivers/mfd/ezx-pcap.c, 100:
> > >      mutex_lock_nested in ezx_pcap_read
> > > drivers/mfd/ezx-pcap.c, 281:
> > >      ezx_pcap_read in pcap_adc_irq (interrupt handler)
> > > 
> > > [FUNC] mutex_lock_nested
> > > drivers/mfd/ezx-pcap.c, 85:
> > >      mutex_lock_nested in ezx_pcap_write
> > > drivers/mfd/ezx-pcap.c, 285:
> > >      ezx_pcap_write in pcap_adc_irq (interrupt handler)
> > > 
> > > [FUNC] mutex_lock_nested
> > > drivers/mfd/ezx-pcap.c, 244:
> > >      mutex_lock_nested in pcap_adc_trigger
> > > drivers/mfd/ezx-pcap.c, 299:
> > >      pcap_adc_trigger in pcap_adc_irq (interrupt handler)
> > > 
> > > These bugs are found by my static analysis tool DSAC.
> > Not sure what you want me to do with this.
> > 
> > Do you have something in mind?
> > 
> 
> I find some possible bugs in this driver, but I do not know how to correctly
> fix them...
> Could you find a good solution?

If you have found bugs and do not intend on fixing them, please report
them via the 'File a Bug' option here:

  https://bugzilla.kernel.org/

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
