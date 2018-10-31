Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF28EC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 802AF20664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="xgijD/OV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 802AF20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730085AbeKADQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 23:16:31 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43226 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729206AbeKADQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 23:16:31 -0400
Received: by mail-qt1-f195.google.com with SMTP id q41-v6so18187283qtq.10
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 11:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sVaziTIpyUOUhUsbSepg0EQX77ZWmo8ScVcNxR9osZ0=;
        b=xgijD/OVOgAc0SQX/5mYIq06iHb6LjH6PBZ6R82PCvcdT59FUdhYGYeDjUOFS+aQ1f
         4mCH8fRJ1OfFQm+0rswolmbp/Fx+59FafilfqEmmZEA8Xmx4301ko1ym5md1QVVaJR8z
         2I+9XakAe7EIP9kwqh6ekRsKUFta9tmeyQq/9/BQMY6VerRnArbyEAx3KjMlW5Qf/uGV
         AXNvYqV2B4soSquR23dSapdS86ObzIWz1O87OoODPbBnq5CEAGh8f2t8aZbRDHEPejRp
         +Sfi3uibi9SuZJAIaaWRPaA8z+seY3ej/aWIEwZQ7t0N5M6Rx3a3yp0uPIKutHbSbDqN
         O5uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sVaziTIpyUOUhUsbSepg0EQX77ZWmo8ScVcNxR9osZ0=;
        b=Z0LBMqDIHFH7eJG61TSXbYfDLOlpszBGVoRFyfs+qdON90BI052xHWyoBYE29HLyH2
         QcwsOjRez8lfLz+5r0RGWyjFhG1AKCWI8xDVRwifVUuXcAYzJv17nt6pOcNkzBJGPmVN
         5Rz934Yhf1zGVg2GHxUUKm3AC+k/n+FWdJMlH7M15wjmibJDO277sJcR2xCgtd27y01G
         kMojxcDmiqdbk9MmQFpvAYyEoa0C/JcSgk841ldBItaALFyXOpMy3SENLqVjkZePhQwQ
         QpZXyP+gGZsKiBQwwy8zMHw4fDFx1UMyrwS1UCpy7MVbY01hAkz8/hTf0dAtEenWgBCO
         Ly9w==
X-Gm-Message-State: AGRZ1gKIQvK+nC6E2nJ7/N53EW8kjHSFcqzBchbufiG9FKdPuP24maVs
        +I3XdadoCEDmoqdrWi57Ngp53EnuU5UTVw==
X-Google-Smtp-Source: AJdET5f+nMO29x2hDNE6UtERRyrLn6uYHkzjK8aFp2MoWg0/8af/z18mG3W+eW/umE8W8xfo7Qrytw==
X-Received: by 2002:ac8:2381:: with SMTP id q1-v6mr3811219qtq.322.1541009841894;
        Wed, 31 Oct 2018 11:17:21 -0700 (PDT)
Received: from cisco ([173.38.117.87])
        by smtp.gmail.com with ESMTPSA id o49sm6702779qtf.60.2018.10.31.11.17.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 11:17:20 -0700 (PDT)
Date:   Wed, 31 Oct 2018 12:17:17 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Daniel Colascione <dancol@google.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian.brauner@canonical.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v3] Implement /proc/pid/kill
Message-ID: <20181031181717.GD2180@cisco>
References: <20181029221037.87724-1-dancol@google.com>
 <20181031155912.45088-1-dancol@google.com>
 <20181031175448.GC2180@cisco>
 <CAKOZuevrFxWLY1J1DVPNGaEy8UbkD1r_M9T9FQTOtSrqp-G0qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKOZuevrFxWLY1J1DVPNGaEy8UbkD1r_M9T9FQTOtSrqp-G0qw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 06:00:49PM +0000, Daniel Colascione wrote:
> On Wed, Oct 31, 2018 at 5:54 PM, Tycho Andersen <tycho@tycho.ws> wrote:
> > Why not just use an ioctl() like Jann suggested instead of this big
> > security check? Then we avoid the whole setuid writer thing entirely,
> 
> Don't you think a system call would be better than a new ioctl?

We already have a kill() system call :)

> With either an ioctl or a new system call, though, the shell would
> need a helper program to use the facility, whereas with the existing
> approach, the shell can use the new facility without any additional
> binaries.

...and a binary to use it!

The nice thing about an ioctl is that it avoids this class of attacks
entirely.

> > and we can pass the fd around if we want to.
> 
> You can pass the FD around today --- specifically, you just pass the
> /proc/pid directory FD, not the /proc/pid/kill FD. The /proc/pid
> directory FD acts as a process handle. (It's literally a reference to
> a struct pid.) Anyone who receives one of these process handle FDs and
> who wants to use the corresponding kill file can open the kill fd with
> openat(2). What you can't do is pass the /proc/pid/kill FD to another
> security context and use it, but when would you ever want to do that?

Perhaps I don't have a good imagination, because it's not clear to me
when I'd ever use this from a shell instead of the kill binary,
either. Using this from the shell is still racy, because if I do
something like:

echo 9 > /proc/$pid/kill

There's exactly the same race that there is with kill, that $pid might
be something else. Of course I could do some magic with bind mounts or
my pwd or something to keep it alive, but I can already do that today
with kill.

I can understand the desire to have a race free way to do this, but
"it must use write(2)" seems a little unnecessary, given that the
shell use case isn't particularly convincing to me.

Tycho
