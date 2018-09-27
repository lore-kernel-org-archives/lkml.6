Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8506C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 897BB216FE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="lhgOjqtf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 897BB216FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbeI1A3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 20:29:12 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39795 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbeI1A3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 20:29:12 -0400
Received: by mail-pf1-f195.google.com with SMTP id j8-v6so2463363pff.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 11:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g3nXO2b01c3gJjfiAhZLNr9nLLCLhOURHg4Sg4kcG4s=;
        b=lhgOjqtfP50FOb7jR9pEGHFRtolEYBWkkjgyg6FK+W+vIQqjEDGVk9MTBBcz7Lct46
         Xhq9cXSdbARNUu6AOUv5CaNIWbAYXRKWB73sY4SUHASQNBXs3lo47OWVKF9BYOAziDsB
         opag2ZwWF0Bquy1n9znMpoI7phSNuaTK0SB408YxWCHP8x5MVGZO9xGHWWk0HhGAVNG/
         zrBi6ul72CIXcYsfsMLNAYN2QRTgGovl7UzzHIzCwhYJXWfCl95SKmJDDSCzI6NX/rMI
         3NY2ZUMwEkmOEPHOQz0Y8ZNPqw46tsavqVRX32RgRHerkPdvqew2VMOflCweeZ1HZa2J
         y91w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g3nXO2b01c3gJjfiAhZLNr9nLLCLhOURHg4Sg4kcG4s=;
        b=KZSUVcJUTGKRZvtZ+Wa30fuoI2yJqYq3N1iTGYCD0MJQzMbT96GPU9FglA05FLzBKH
         FOGrtP3TiwaRPzt+sujUy3dZTQI0JUbkFm7Jgq13u1tSVMZYH84QpsQvygljNWweGkaM
         4IZAafL6UutVpFhqN04njyFDWAXZbN034mgwJMQxwdXe2la2vSSbyn8oLPRcl5gADyxo
         UwiWPEyPaJyj66+z9+Z72Ba8b9ncbDrjf99FzGhArhPjaK4vIsxFkxLpBT0gvPWWE2Yi
         D5Q0AVxI0hLjLwRSI3Av8ghgbThQ8pU59BKbn4dt7Njm6W2Yoy9Bo6r9bXAXZwFm5DTH
         psYA==
X-Gm-Message-State: ABuFfohLWxJG8rio4XIduCpwhCB1lvHOvg4kpwwzisdNYx06dVKL0mge
        lLi1fdNTtrCj1567e6UUV9J1og==
X-Google-Smtp-Source: ACcGV61Typxcsk8bCqXKRJygm8u3fGglGE14glUiJtTLGK/XD98J+Crs+bBpSJEDpCqCWtoSZzmeRg==
X-Received: by 2002:a65:448a:: with SMTP id l10-v6mr11559978pgq.382.1538071782786;
        Thu, 27 Sep 2018 11:09:42 -0700 (PDT)
Received: from cisco.cisco.com ([128.107.241.165])
        by smtp.gmail.com with ESMTPSA id 71-v6sm4018217pfx.182.2018.09.27.11.09.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 11:09:41 -0700 (PDT)
Date:   Thu, 27 Sep 2018 12:09:39 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        containers@lists.linux-foundation.org,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        suda.akihiro@lab.ntt.co.jp, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v7 3/6] seccomp: add a way to get a listener fd from
 ptrace
Message-ID: <20180927180939.GB15491@cisco.cisco.com>
References: <20180927151119.9989-1-tycho@tycho.ws>
 <20180927151119.9989-4-tycho@tycho.ws>
 <CAG48ez14hkjQr8_ysg13Ax9uc+abKeTtN7pCxuiJ83Ms3Gbo5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez14hkjQr8_ysg13Ax9uc+abKeTtN7pCxuiJ83Ms3Gbo5Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 07:35:06PM +0200, Jann Horn wrote:
> On Thu, Sep 27, 2018 at 5:11 PM Tycho Andersen <tycho@tycho.ws> wrote:
> >
> > As an alternative to SECCOMP_FILTER_FLAG_GET_LISTENER, perhaps a ptrace()
> > version which can acquire filters is useful. There are at least two reasons
> > this is preferable, even though it uses ptrace:
> >
> > 1. You can control tasks that aren't cooperating with you
> > 2. You can control tasks whose filters block sendmsg() and socket(); if the
> >    task installs a filter which blocks these calls, there's no way with
> >    SECCOMP_FILTER_FLAG_GET_LISTENER to get the fd out to the privileged task.
> [...]
> > diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> > index 21fec73d45d4..289960ac181b 100644
> > --- a/kernel/ptrace.c
> > +++ b/kernel/ptrace.c
> > @@ -1096,6 +1096,10 @@ int ptrace_request(struct task_struct *child, long request,
> >                 ret = seccomp_get_metadata(child, addr, datavp);
> >                 break;
> >
> > +       case PTRACE_SECCOMP_NEW_LISTENER:
> > +               ret = seccomp_new_listener(child, addr);
> > +               break;
> 
> Actually, could you amend this to also ensure that `data == 0` and
> return -EINVAL otherwise? Then if we want to abuse `data` for passing
> flags in the future, we don't have to worry about what happens if
> someone passes in garbage as `data`.

Yes, good idea. Thanks!

Tycho
