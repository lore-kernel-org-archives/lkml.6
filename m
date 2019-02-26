Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64123C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31A6121850
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551200626;
	bh=fKGB1TJE5yji9gi3887SX6WSCY64pLGlWcEW2m+m+dw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Q1HbVY+MCj3DASWXgt2/4rEoJFbafys+Cb25XlUeGMx4q2k8A0V9xG11x+7bEcW/V
	 OuN6on6sYEfQ8P6tDwMdjKn+WsDFmC9qnfkLzhAD+Lp8jGfQ0GwN1Y+E8QN79kysDM
	 4ugc0FmxJbYlWhqTTqm9c3VGPMjqmnXD0PLSfy4o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbfBZRDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 12:03:44 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:35641 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfBZRDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 12:03:43 -0500
Received: by mail-yw1-f67.google.com with SMTP id s204so5733515ywg.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 09:03:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AYQDhdjbYQUyfL+3XviMbb8a/BeQjAxJJtDJUDHwgLM=;
        b=qVlInmvQYzPWKIN+Ybjlitxi/iiXbBiGc7fBZ2l/3uEIVKzMZ+Ghf2lrY4HZ4e1UYj
         zoek3c8pd1V5xRAgUd5ul+k0UYYjf1VSz4nSGfzbR/usZFcrpVz8R2ls1ny9ZAQHSWtX
         kug1Mj8o4JlckSKUnuzTSES4P5BOsWCccdZ+onOmGIZ4/Hmk0PedMNv3U09/jpyrrqYz
         UunXIRQUiuW9UMxXG+3LRzhGU2X2OFk4+mUaXUoAlEbGHJmy4xs1EkAsnHJkT2zwtdkZ
         yupyJ2soOvYDpl4FdWmIlf9Q7S0Xsu16CiR0/cWsZK/qeZ2uD1ZdNde5nqup6rsQiQH1
         y1JQ==
X-Gm-Message-State: AHQUAuYliHUcQQ8XpcQDlJQKdp4DNtYF2PgqPeHYX2pso89Q4741SDIz
        Tf/kEwlQP7SIXyTrRgYIUyg=
X-Google-Smtp-Source: AHgI3IbqGExLy62XrfPHcYlcJbEhfIUGhyPvfdWuLAX37FLp24NgOgc5mpag2drjeqrr1nXDyPE1Cg==
X-Received: by 2002:a25:d44c:: with SMTP id m73mr18018663ybf.349.1551200623043;
        Tue, 26 Feb 2019 09:03:43 -0800 (PST)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:200::2:7f17])
        by smtp.gmail.com with ESMTPSA id 207sm3527372ywm.67.2019.02.26.09.03.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 09:03:42 -0800 (PST)
Date:   Tue, 26 Feb 2019 12:03:39 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     Christopher Lameter <cl@linux.com>
Cc:     Peng Fan <peng.fan@nxp.com>, "tj@kernel.org" <tj@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>
Subject: Re: [PATCH 1/2] percpu: km: remove SMP check
Message-ID: <20190226170339.GB47262@dennisz-mbp.dhcp.thefacebook.com>
References: <20190224132518.20586-1-peng.fan@nxp.com>
 <20190225151330.GA49611@dennisz-mbp.dhcp.thefacebook.com>
 <010001692a612815-46229701-ea3f-4a89-8f88-0c74194ba257-000000@email.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <010001692a612815-46229701-ea3f-4a89-8f88-0c74194ba257-000000@email.amazonses.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 03:16:44PM +0000, Christopher Lameter wrote:
> On Mon, 25 Feb 2019, Dennis Zhou wrote:
> 
> > > @@ -27,7 +27,7 @@
> > >   *   chunk size is not aligned.  percpu-km code will whine about it.
> > >   */
> > >
> > > -#if defined(CONFIG_SMP) && defined(CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK)
> > > +#if defined(CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK)
> > >  #error "contiguous percpu allocation is incompatible with paged first chunk"
> > >  #endif
> > >
> > > --
> > > 2.16.4
> > >
> >
> > Hi,
> >
> > I think keeping CONFIG_SMP makes this easier to remember dependencies
> > rather than having to dig into the config. So this is a NACK from me.
> 
> But it simplifies the code and makes it easier to read.
> 
> 

I think the check isn't quite right after looking at it a little longer.
Looking at x86, I believe you can compile it with !SMP and
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK will still be set. This should
still work because x86 has an MMU.

I think more correctly it would be something like below, but I don't
have the time to fully verify it right now.

Thanks,
Dennis

---
diff --git a/mm/percpu-km.c b/mm/percpu-km.c
index 0f643dc2dc65..69ccad7d9807 100644
--- a/mm/percpu-km.c
+++ b/mm/percpu-km.c
@@ -27,7 +27,7 @@
  *   chunk size is not aligned.  percpu-km code will whine about it.
  */
 
-#if defined(CONFIG_SMP) && defined(CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK)
+#if !defined(CONFIG_MMU) && defined(CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK)
 #error "contiguous percpu allocation is incompatible with paged first chunk"
 #endif
 
