Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB44BC6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 20:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59570205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 20:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="hdzRHGDj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59570205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbeKBFiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 01:38:05 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42236 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbeKBFiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 01:38:04 -0400
Received: by mail-qk1-f195.google.com with SMTP id u68so9512699qkg.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 13:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8glHKttFH9I5zyY3UWTD3U/2jmUFuiCfepetv/PmuPg=;
        b=hdzRHGDjfBw3ggtuhLbxOpNjE05mbddOfhPBO/ZW5fJyxG8zibFyjPSmJqA0+9gu7X
         nlYOO3jRk2SRPMp4mvTnPUTB7xpYhdUNcgEW0Fezh+fiFFZseB+5gR/3jFrEGtfDw9xB
         pCYD4rKdFnW0nrtlZ2KzGsnfRRHJ2BYfQKkCKoCBgPl2CkaFhBRKU9PVcHhkTOw1ISJH
         fKhQ/+Nn1cPejwuBnvUUOoHdU6gJ4dFq07xHg5QsKOe6bSwPUk9oTfttFiM1XBAbhxK4
         /DTVDRmCjelWVBuFkAy71ye/T0trlz2Vhs0jwEXvYqLor4kNXR4hLHk/ROnUIOm+/cwj
         ZsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8glHKttFH9I5zyY3UWTD3U/2jmUFuiCfepetv/PmuPg=;
        b=CxFitkh8Tluj8P1VlSZTuDSexghsQdN0FsqqWU1ZMK7Dr5qrOk+eiLSVlTZ/7Ufpnr
         EORtoQcLz5QSkDGhDSPfk/pt4qUcgJZ/DVH8AC7Crb9LbTyrWtbngG/obBIUHCNpR9V0
         x5dfQROPeMAkU6BJtZVqubaEywJcwwgARzdk3D+R1G0/KpGopGHGSFNEj8oqQSySMfpb
         1CXM0k562pH0TWBmPRfwxSJuPkB+IdSmZFyaMWlp2NdKjKgSSQx4etQe+yG/WOrJmoOw
         /chq5Uhs5WqbIBRaPy8PwOExZd+4hJEVCpaJWk81LG6U/SKEdkFOHGIZ7hpN4zxvNZXb
         BroQ==
X-Gm-Message-State: AGRZ1gKvf5ZHppnG7anxqgo/gbCXhlUI6y+2RGptPgNpgQtL2GclzYm7
        YbzXq4QIteLo6pL+3+guZ6Dw9A==
X-Google-Smtp-Source: AJdET5ew9D9zzs2mJncxavhVPn87vmHDtvDzRNJJAgnQnMvgRyzUC2FDTiq997zllGhRTfSIixcvYw==
X-Received: by 2002:a37:8b84:: with SMTP id n126mr2955520qkd.355.1541104412116;
        Thu, 01 Nov 2018 13:33:32 -0700 (PDT)
Received: from cisco ([173.38.117.87])
        by smtp.gmail.com with ESMTPSA id i65sm30423807qkh.49.2018.11.01.13.33.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 13:33:31 -0700 (PDT)
Date:   Thu, 1 Nov 2018 14:33:28 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian@brauner.io>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Aleksa Sarai <asarai@suse.de>, linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v8 1/2] seccomp: add a return code to trap to userspace
Message-ID: <20181101203328.GI2180@cisco>
References: <20181029224031.29809-1-tycho@tycho.ws>
 <20181029224031.29809-2-tycho@tycho.ws>
 <20181030143235.GA3385@redhat.com>
 <20181030153231.GB7343@cisco>
 <20181101144804.GD23232@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181101144804.GD23232@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2018 at 03:48:05PM +0100, Oleg Nesterov wrote:
> On 10/30, Tycho Andersen wrote:
> >
> > > I am not sure I understand the value of signaled/SECCOMP_NOTIF_FLAG_SIGNALED...
> > > I mean, why it is actually useful?
> > >
> > > Sorry if this was already discussed.
> >
> > :) no problem, many people have complained about this. This is an
> > implementation of Andy's suggestion here:
> > https://lkml.org/lkml/2018/3/15/1122
> >
> > You can see some more detailed discussion here:
> > https://lkml.org/lkml/2018/9/21/138
> 
> Cough, sorry, I simply can't understand what are you talking about ;)
> It seems that I need to read all the previous emails... So let me ask
> a stupid question below.
> 
> > > But my main concern is that either way wait_for_completion_killable() allows
> > > to trivially create a process which doesn't react to SIGSTOP, not good...
> > >
> > > Note also that this can happen if, say, both the tracer and tracee run in the
> > > same process group and SIGSTOP is sent to their pgid, if the tracer gets the
> > > signal first the tracee won't stop.
> > >
> > > Of freezer. try_to_freeze_tasks() can fail if it freezes the tracer before
> > > it does SECCOMP_IOCTL_NOTIF_SEND.
> >
> > I think in general the way this is intended to be used these things
> > wouldn't happen.
> 
> Why?

The intent is to run the tracer on the host and have it trace
containers, which would live in a different freezer cgroup, process
group, etc. Of course you could use it in a situation where they would
be, so the concern is still valid, but I'm not sure why you'd do that.

> > was malicious and had the ability to create a user namespace to
> > exhaust pids this way,
> 
> Not sure I understand how this connects to my question... nevermind.
> 
> > so perhaps we should drop this part of the
> > patch. I have no real need for it, but perhaps Andy can elaborate?
> 
> Yes I think it would be nice to avoid wait_for_completion_killable().
> 
> So please help me to understand the problem. Once again, why can not
> seccomp_do_user_notification() use wait_for_completion_interruptible() only?
>
> This is called before the task actually starts the syscall, so
> -ERESTARTNOINTR if signal_pending() can't hurt.

The idea was that when the tracee gets a signal, it notifies the
tracer exactly once, and then waits for the tracer to decide what to
do. So if we use another wait_for_completion_interruptible(), doesn't
it just get re-woken immediately because the signal is still pending?

...actually I just tested it, and it doesn't. So it seems we could use
_interruptible() here and achieve the same thing.

> Now lets suppose seccomp_do_user_notification() simply does
> 
> 	err = wait_for_completion_interruptible(&n.ready);
> 
> 	if (err < 0 && state != SECCOMP_NOTIFY_REPLIED) {
> 		syscall_set_return_value(ERESTARTNOINTR);
> 		list_del(&n.list);
> 		return -1;
> 	}
> 
> (I am ignoring the locking/etc). Now the obvious problem is that the listener
> doing SECCOMP_IOCTL_NOTIF_SEND can't distinguish -ENOENT from the case when the
> tracee was killed, yes?
> 
> Is it that important?

The answer to this question depends on how we want the listener to be
able to react. For example, if the listener is in the middle of doing
a mount() on behalf of the task and it gets a signal and we return
immediately, the listener will complete the mount(), try to respond
with success and get -ENOENT. If the task handles the signal and
restarts the mount(), it'll happen twice unless the listener undoes
it when it sees the -ENOENT. If we send another notification with the
SIGNALED flag, the listener has a better picture of what's going on,
which might be nice.

Tycho
