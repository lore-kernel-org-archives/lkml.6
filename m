Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01E3C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57F992073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3LjZSaR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57F992073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbeH3RPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 13:15:43 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33631 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728273AbeH3RPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 13:15:42 -0400
Received: by mail-ed1-f65.google.com with SMTP id h9-v6so6502323edr.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 06:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=shqp801gxGgttkh+vfo02+52v2YI5Uvaa05tuPvvFOI=;
        b=U3LjZSaRm5zwofF/cG3/KeFEyJEYMSKv21rqdEV+kNTa20LkoWoHuNdyhcpmQEC7ho
         dkw2M0xAFuJs0tLpY+Ob5Ot6+GGsIGkuaoRFEoqpb7K6GdRHl3/DjW71JiohjnDFXYx1
         HUZLRkR6LGDtwfJWwuFQRzSlVHoeamFp518sQCcjAcloAy7fKN3vwk6W7+86p6teQjCs
         VmBnM780hiEPfuIfhBXZ6svvu7WHC3UZ6Gedn4/Knn7arzmQgni/5yFeAGBVzAtG1vSN
         f1QFI7mgxpPLFpRW5Iih35+3frJFu6zbuPlYrBziD3ck2al71DyFePl2qnFUEY0/21O8
         VQSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=shqp801gxGgttkh+vfo02+52v2YI5Uvaa05tuPvvFOI=;
        b=rougvoKADRadK1hpbAIw3Xr5S60bd1jI1m6787Zc99ALr5PVmtX2JsWlsvdOJa9YaI
         EccW0guxI6MjY883QuSLHedW//8HrkLtB3CJQimLdJXejyPOAfBrNqbxJgGzy35wqEsC
         T8zVCInsuGwGMdYkp5QOJGLAIWBc8UAC4/gdxbSYRs39gbgWZ24qpsflpOhE94rB0As8
         ur1N9G0MfDhMxm5St1K7hE6XGPV59oq9+Q2Vp9dReokKwZ3V8/NV0y3wUBQGvMo4XomF
         8E1C6b8uwXKTPjSapfUCR3Y7zV4+64uRuqoQUDPn2Wz+C5NIdtTxrYyJwqGTN9yQaPz/
         qhvg==
X-Gm-Message-State: APzg51ACDMr2mEPyNQd3bh5VpboFEz7U18wYvOJoleYMoPlcMYgyHu34
        0O3xqnmJzxYuIV/pP7QcRFaPUZY=
X-Google-Smtp-Source: ANB0VdY3ByWnkqQVLNCWQjsF4zUZIg1K+6R/Hd3TIYRKaoe4N9Nz4fJopdb2w6qhhWh1gqc35cvgzg==
X-Received: by 2002:aa7:d141:: with SMTP id r1-v6mr13304282edo.83.1535634816063;
        Thu, 30 Aug 2018 06:13:36 -0700 (PDT)
Received: from avx2 (nat4-minsk-pool-46-53-177-92.telecom.by. [46.53.177.92])
        by smtp.gmail.com with ESMTPSA id j10-v6sm2946845ede.5.2018.08.30.06.13.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 06:13:35 -0700 (PDT)
Date:   Thu, 30 Aug 2018 16:13:33 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/13] proc: convert /proc/self to _print_integer()
Message-ID: <20180830131333.GA31422@avx2>
References: <20180827231503.26899-1-adobriyan@gmail.com>
 <20180827231503.26899-6-adobriyan@gmail.com>
 <54cb86c6d96b47bc8017a69be124c105@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <54cb86c6d96b47bc8017a69be124c105@AcuMS.aculab.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 09:50:50AM +0000, David Laight wrote:
> From: Alexey Dobriyan
> > Sent: 28 August 2018 00:15
> > ---
> >  fs/proc/self.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/proc/self.c b/fs/proc/self.c
> > index 127265e5c55f..b2279412237b 100644
> > --- a/fs/proc/self.c
> > +++ b/fs/proc/self.c
> > @@ -14,6 +14,7 @@ static const char *proc_self_get_link(struct dentry *dentry,
> >  {
> >  	struct pid_namespace *ns = proc_pid_ns(inode);
> >  	pid_t tgid = task_tgid_nr_ns(current, ns);
> > +	char buf[10], *p = buf + sizeof(buf);
> >  	char *name;
> > 
> >  	if (!tgid)
> > @@ -22,7 +23,11 @@ static const char *proc_self_get_link(struct dentry *dentry,
> >  	name = kmalloc(10 + 1, dentry ? GFP_KERNEL : GFP_ATOMIC);
> >  	if (unlikely(!name))
> >  		return dentry ? ERR_PTR(-ENOMEM) : ERR_PTR(-ECHILD);
> > -	sprintf(name, "%u", tgid);
> > +
> 
> Best not to 'hide' the initialisation of 'p' at the top of the function.
> Much easier to see what is going on if it is moved here.

It was written that way to have initialization near the buffer,
so that it is obvious that pointer and buffer are connected and
making

	p = _print_integer_uNN(p, x);

standard building block which can be copypasted left and right and
still be correct.

> > +	p = _print_integer_u32(p, tgid);
> 
> or just:
> 	p = _print_integer(buf + sizeof(buf), tgid);
> 
> (What a horrid interface ...)

It is. The problem is that adding bound checking will get you current
vsnprintf() and number() and num_to_str().

> > +	memcpy(name, p, buf + sizeof(buf) - p);
> > +	name[buf + sizeof(buf) - p] = '\0';
> > +
> >  	set_delayed_call(done, kfree_link, name);
> >  	return name;
> >  }
