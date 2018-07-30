Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60BA13F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FAC720893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CRdS9fws"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FAC720893
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731600AbeG3QKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 12:10:30 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42518 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbeG3QKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 12:10:30 -0400
Received: by mail-pg1-f194.google.com with SMTP id y4-v6so7362483pgp.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 07:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2DFafv1YkSRfeJeGHgpSV4L24ZM3a1fagdm8earY2BE=;
        b=CRdS9fwsXfyClho4NXDRr1xB8ZD7RZMpIBcHoIAtE3VmRWjcc44aW/QixdL1iHPT7s
         jUx1zB1q2XXSTvV6Qzh2s2hAFUQq75zh4yqH+fBsRoKwNYmSFh4XicSgHfAZOWNJarsT
         FsXIHVFIIXpa3P/5zYtRaoHhggR/Z83njadTuZKb8srNRcW+tHrivhDF8vZS7+Vk3eXx
         KzvO4kcHoaJrdvGf46m5xOjvluPlHR73SHAIyL645ylCaSV13sJMcqk+cUPck60+1ciD
         a0G2Znowh/gOr4sT7UyZ0lxJBD2QbP9aJUtAdlKCcz1BAhjvjA31fLF1nLaiR5l25F8g
         6QEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2DFafv1YkSRfeJeGHgpSV4L24ZM3a1fagdm8earY2BE=;
        b=bDFJXNSW7ubwZQ+l4He4W0QxMPP6oHLsl53P56IN0+eusBsbyACV4vGxtToS2I6xjU
         fXW5r5Upr+OnSAIDFMaDQPyLHq53vts9UK2qCgXfJvJo4bt4i/Hs6BT1s/jVFkw0snUD
         zoxh/qXfGTMjKmZZkeAd4+RgdYUsnxL2mglfMkEUKA+n82Bu6zbGGtx+ZQ7SwILWCbvr
         vWVqVoE/V5I2WZO7JswubukHXY97NLqx7CCYi9ClmDmpTyZi8DEWruaWsOB+O97iBDKC
         gaqwIgzSobBtIuNzhzYVkfa5PxYSmMX812RL3jZCT9P2DciZqru5uCwlqfSrIhhPTUER
         tNog==
X-Gm-Message-State: AOUpUlHvbI7g60uDsYej2qmoiY99g+hHt+xHLON8CgdCTkqWVCvsqm7l
        rMUWG8AHRpMRVI34VUAHJlYeSg==
X-Google-Smtp-Source: AAOMgpcfrh6X2dIYdXPulG5gME3S/26iqlo2LU0mWTRmMUSEefPB/35SEUHR1PZXD9NdJq4mSIBBBQ==
X-Received: by 2002:a63:e914:: with SMTP id i20-v6mr16709126pgh.10.1532961312997;
        Mon, 30 Jul 2018 07:35:12 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:6e29:33f4:7c9a:4918])
        by smtp.gmail.com with ESMTPSA id s27-v6sm19824220pfk.133.2018.07.30.07.35.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 07:35:12 -0700 (PDT)
Date:   Mon, 30 Jul 2018 07:35:11 -0700
From:   Sandeep Patil <sspatil@google.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jann Horn <jannh@google.com>, salyzyn@google.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Golden_Miller83@protonmail.ch, Greg KH <greg@kroah.com>,
        Kees Cook <keescook@google.com>, salyzyn@android.com,
        kernel list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, kernel-team@android.com,
        stable@vger.kernel.org,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Jeffrey Vander Stoep <jeffv@google.com>
Subject: Re: [PATCH] tracing: do not leak kernel addresses
Message-ID: <20180730143511.GU190909@sspatil-desktop.mtv.corp.google.com>
References: <CAKwvOdmg4DSSwy9YBccYWzc+6ZU2yKSSFmfnj72wqbYDJU0gzw@mail.gmail.com>
 <20180727143141.4b53d554@gandalf.local.home>
 <CAMx4XWv3OazvURuN1XU2+5C5tNDzPuTniMn_T=XTA4P8_uwS_A@mail.gmail.com>
 <CAG48ez25zgjTQRux_rk1fn2DUVthtK31dRU9cxE+55pBGmYjXQ@mail.gmail.com>
 <CAG48ez1MdupASE1DMt0OWXv+rqZO-2GAbfDthEQcvNXrc2pTsQ@mail.gmail.com>
 <20180727195416.GF13922@thunk.org>
 <20180727161103.797f12b7@gandalf.local.home>
 <20180727202114.GH13922@thunk.org>
 <20180727220543.GT190909@sspatil-desktop.mtv.corp.google.com>
 <20180728000428.GI13922@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180728000428.GI13922@thunk.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 08:04:28PM -0400, Theodore Y. Ts'o wrote:
> On Fri, Jul 27, 2018 at 03:05:43PM -0700, Sandeep Patil wrote:
> > On Fri, Jul 27, 2018 at 04:21:14PM -0400, Theodore Y. Ts'o wrote:
> > > On Fri, Jul 27, 2018 at 04:11:03PM -0400, Steven Rostedt wrote:
> > > > That said, I would assume that
> > > > other Android utilities are using other debugfs files for system
> > > > status and such.
> > 
> > As of today, I think a lot of information in 'bugreports' is read
> > out of debugfs (including things like binder stats). We do have a plan
> > to change that.
> 
> Hmm, if it's only for bugreports, maybe it can be only mounted when
> about root processes getting tricked into reading from debugfs.

Yes, that's an interesting idea. May be a quicker way to get ourselves
rid of relying on debugfs. We need some platform cleanup to remove
all debugfs accessing code that's not "debug only" first. That work has been
ongoing ..

> 
> 
> > Indeed, I think it can. However, the problem is the last time I tried to
> > remove this a whole bunch of things just broke. So, it wasn't about losing
> > a functionality here and there. Agree, we need to clean up platform to not use
> > debugfs first. Then we can expect Apps or other native processes to not rely
> > on debugfs at all.
> 
> Is Android controlling access to debugfs files via SELinux?  If so,
> then access to debugfs can be gradually cranked down as use cases are
> removed.

Yes, that's what we've done now, so we know where the code is that depends on
it and working on moving it out. New domains aren't allowed to rely on
debugfs now.

- ssp
> 
> 						- Ted
> 
> 
>    	   	       
