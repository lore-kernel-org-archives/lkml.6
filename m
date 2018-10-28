Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C90C6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 13:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0320620665
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 13:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="swV2dR80"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0320620665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbeJ1V7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 17:59:17 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44918 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbeJ1V7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 17:59:16 -0400
Received: by mail-pg1-f195.google.com with SMTP id w3-v6so2579612pgs.11;
        Sun, 28 Oct 2018 06:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VUFcxAXNVjWjZk6FKAKGjp0X7ZDdt9e3a7qM6aXtSqk=;
        b=swV2dR80fLp7lIgBePWtGtd48LOFSbaSJ4oqAyNN+mSEj4wtspJ/w1OUMgETYBwNM2
         QWtjqG4NgnWSLfC7/s7dH+MtHuenUjVMCx24dIv8yDUBra57Gsl3RixzQhoAjd8mVKTN
         Foq6pymMLui6Hc2ANWZTr/UZeQzF14owaYqu3U3MlLmpHedyOroOD02vBCpIYyXiSvfV
         dcQRCdZLsPZqUt745FCv9YQzu2P4I5N4Sn07tbBVOCKcJyFVXkOnwGnhx+Tj3mp6uo28
         DRJbf7qQGVAlmpqfg5ChfjQ9SkoX12cuj1weNFgpOr90CKNxT8kplfLcSQaw+7KdVcWY
         jzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VUFcxAXNVjWjZk6FKAKGjp0X7ZDdt9e3a7qM6aXtSqk=;
        b=Wzbk5ZUT+uSwX+DUYaaxd2Sl8bGvmwCecrbmxDdOkIqtQHdIvdc+Qua3td4d7TMXDr
         RkcSTB94Oah0/XJzvTLLgMPmaHiXcRCOsxGKlAva2cjA2eGoX/Vyzgjfdco/Lc8q/xSa
         Yvx4xRYo+ggk+80fEYhAArhsMGUq4fnRaQI6sz7/5cTX0SOT0yD2Hk+fJKM/uK+XyV2H
         QBlFl/0CNAmFVg8WALS11NenVaBcYy6lliEDuOzLEn05wIHNMhYQomJmMHidXyhOV015
         0xj/Y9LkoKHpcuHaxstK1nyyymPTDHQRoQdi5EefrYgnC8aQnetXgfwhe/7+id7Vbiae
         N1kQ==
X-Gm-Message-State: AGRZ1gJOmbUEzAw/+SfQGeO1WMktb1+F+xNe8rvtA4j3QRB3Wc631HYB
        K/YaB0ivOhBiEu+2VNk0s+A=
X-Google-Smtp-Source: AJdET5fl5zfLIXy3BhN2eer5kU+gSGxjD8q/Aiu3QdreQG9hLw1lto09htaVfmXnoyBnzU+wS5c6aA==
X-Received: by 2002:a62:6f43:: with SMTP id k64-v6mr10841627pfc.87.1540732479611;
        Sun, 28 Oct 2018 06:14:39 -0700 (PDT)
Received: from mail.google.com ([2001:19f0:6001:4ff6:5400:1ff:feb7:a195])
        by smtp.gmail.com with ESMTPSA id w66-v6sm22993683pfb.51.2018.10.28.06.14.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Oct 2018 06:14:39 -0700 (PDT)
Date:   Sun, 28 Oct 2018 13:14:36 +0000
From:   Changbin Du <changbin.du@gmail.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>, X86 ML <x86@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sparse@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 4/4] kernel hacking: new config
 CC_OPTIMIZE_FOR_DEBUGGING to apply GCC -Og optimization
Message-ID: <20181028131357.parhzj32feapxncb@mail.google.com>
References: <20181019124921.13780-1-changbin.du@gmail.com>
 <20181019124921.13780-5-changbin.du@gmail.com>
 <CAK7LNARW0=0d7m5DAgZOir=h0Y4tssqZoQRGasnGPNnvNf_+pg@mail.gmail.com>
 <20181028125106.azcn2dxia3snplin@mail.google.com>
 <CAK7LNARr7bE=DVuzim5771heuN5os0=5-D+jXfUyBb2e1xYoRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNARr7bE=DVuzim5771heuN5os0=5-D+jXfUyBb2e1xYoRA@mail.gmail.com>
User-Agent: NeoMutt/20180716-508-7c9a6d
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 28, 2018 at 10:09:21PM +0900, Masahiro Yamada wrote:
> Hi Changbin,
> 
> On Sun, Oct 28, 2018 at 9:52 PM Changbin Du <changbin.du@gmail.com> wrote:
> 
> > >
> > Thanks for pointing this out and kind suggestions. I have tested with your
> > modification. Will update patch serias soon.
> 
> 
> I have one more request.
> 
> The patch subject
> "kernel hacking: new config CC_OPTIMIZE_FOR_DEBUGGING to apply GCC -Og
> optimization"
> is too long (83 characters)
> 
> 
> I'd like the subject to be within 70 columns or so.
> 
oh, I just sent new version. Could me update the title if there are more
suggestions then?

> Thanks.
> 
> 
> 
> 
> -- 
> Best Regards
> Masahiro Yamada

-- 
Thanks,
Changbin Du
