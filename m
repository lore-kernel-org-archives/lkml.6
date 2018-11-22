Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD50CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 839792081C
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tNV4Pr3J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 839792081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436950AbeKWARy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 19:17:54 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45350 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436758AbeKWARx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 19:17:53 -0500
Received: by mail-wr1-f67.google.com with SMTP id v6so9292092wrr.12;
        Thu, 22 Nov 2018 05:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aGf6iSkZLEQaXiYl1k8Acjxk4k+FUv2w5HCHkpUT0Jo=;
        b=tNV4Pr3JcQAWRDoHl8Bxx08etjeq9iurir0kzoSpJSccARokPcJkHOBK74SUeMyXLr
         jd8g1WafDSFyN5uA2/ryxK2JnYStTgDZR4ZSTja6AScc0lHMw7WSTv4Tswh32Xhu/b76
         PFYI6NgL8zm4yGOzZ4vX3cG10kMx2lpLTka7BN2pzRrADQCW1e7Rh7BTXLfkW55CXAWr
         S27DFOECuqI25KN4XFg5+lxVctLo0KDAzC0Oss9YT4Yv4JRE03TFrR9+yUezrXFlipC/
         cg+UHTDDib9W34/TTjqq+LG8Qh5ao4AbKpldEcT2s2PIpkkFWx4rU07lovT7/ljr0rAM
         np8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aGf6iSkZLEQaXiYl1k8Acjxk4k+FUv2w5HCHkpUT0Jo=;
        b=qIaOVZxtKl6Ec72B53ZjssxnLWdGi6CWN0wXM9AfBY5D6njx5+lqQBfARTrUo9gPTp
         oMLU3bxYZ4HPPZ9WnobMMAWRqN1zY16IEdDEhDEhAchsv8IupXVwcG4vr8PoA05RPuuY
         KA5qTfnt2sIxP+wdhp1bz8p5Q1HA6HXfadHyAYVjSfX0Ubvcw4H40blhtfqtMB6mPG/R
         PpiNf7tbcQslmp8uxW26T/HCe/1Rh5IvUBLi2yXDRk1fxkIHBDQYriQvUgEydGZTztxj
         G+F60FixsFm1yEOk8E0Yu10THoz0WlnEvW8FCgiZhGcjF/PaFvHE91R9ldyGPk4M4LOE
         I9lA==
X-Gm-Message-State: AA+aEWbEtCsZ0l4lOR+7CIYkeFkHkBVpbaITD5fWEq4Spv2yxreZQT38
        Uu4HY4282o0rqhWFpPPCKg==
X-Google-Smtp-Source: AFSGD/UXaAaWEPtEjlRoe0Ecg7XgXDyYm2JCacg+3O5561Q9zRee8UKXPTquxZTfkOHWimnsO8Ryqg==
X-Received: by 2002:adf:c647:: with SMTP id u7-v6mr9476724wrg.174.1542893908930;
        Thu, 22 Nov 2018 05:38:28 -0800 (PST)
Received: from avx2 (nat-minsk-pool-46-53-201-92.telecom.by. [46.53.201.92])
        by smtp.gmail.com with ESMTPSA id i16sm6080036wmd.28.2018.11.22.05.38.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 05:38:28 -0800 (PST)
Date:   Thu, 22 Nov 2018 16:38:26 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, viro@zeniv.linux.org.uk,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] procfs: fix the output format in /proc/PID/wchan
Message-ID: <20181122133826.GA14139@avx2>
References: <1542626272-29129-1-git-send-email-laoar.shao@gmail.com>
 <20181121192844.1cd1c2fa4801a324d059176c@linux-foundation.org>
 <CACVxJT9ns2XGeE3FUwNT2J2Fn2s0YuHPQT-z6yg2RE8qzK-ssQ@mail.gmail.com>
 <CALOAHbBaR2GB1Xtzzi9bNprfCWSP_PV5FCfAG_xK=jqg8uuong@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALOAHbBaR2GB1Xtzzi9bNprfCWSP_PV5FCfAG_xK=jqg8uuong@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 09:29:52PM +0800, Yafang Shao wrote:
> On Thu, Nov 22, 2018 at 7:40 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
> >
> > On Wed, Nov 21, 2018 at 07:28:44PM -0800, Andrew Morton wrote:
> > > On Mon, 19 Nov 2018 19:17:52 +0800 Yafang Shao <laoar.shao@gmail.com> wrote:
> > >
> > > > Just add the missing newline.
> > > >
> > > > ...
> > > >
> > > > --- a/fs/proc/base.c
> > > > +++ b/fs/proc/base.c
> > > > @@ -370,11 +370,12 @@ static int proc_pid_wchan(struct seq_file *m, struct pid_namespace *ns,
> > > >     wchan = get_wchan(task);
> > > >     if (wchan && !lookup_symbol_name(wchan, symname)) {
> > > >             seq_puts(m, symname);
> > > > +           seq_putc(m, '\n');
> > > >             return 0;
> > > >     }
> > > >
> > > >  print0:
> > > > -   seq_putc(m, '0');
> > > > +   seq_puts(m, "0\n");
> > > >     return 0;
> > > >  }
> > > >  #endif /* CONFIG_KALLSYMS */
> > >
> > > What is presently wrong with the wchan output?  The changelog
> > > should explain such things, please.
> >
> > It is just newline to make "cat /proc/*/wchan" output look cool.
> > But newline can break something.
> 
> Could you pls. show some examples for what the newline may break ?

	char buf[16];
	rv = read(fd, buf, sizeof(buf));
	assert(rv == 1);
