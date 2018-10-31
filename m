Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95142C6786F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 01:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 389232082B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 01:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WO2OzfpM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 389232082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbeJaKzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 06:55:35 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:44711 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728341AbeJaKze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 06:55:34 -0400
Received: by mail-ua1-f65.google.com with SMTP id i30so5305589uae.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 18:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Lyu9KCi+MzHiyQ39Z2tQjEYQpsqwkrB+OjxLY3Xas9k=;
        b=WO2OzfpMr8lWQ2T/SOPZVe5nobGWoueT6/eSqslZ3cAaAGcqA42a40FVXbYe1NZeRZ
         jM+HOCbBY2rsss0KP8NRyoDUyRqLJrBFOGl5Z0UuX33Mud8vuB/8eo6Z4TTiBxVp1VEp
         0oMj9NAQ86k2DuTCfePvJJN8hpw2GyEZbXxQiJdSUilAKbySE//Ehu+l35NnMU3k6QXl
         E/IYbyZ+e3g2dfi16k5d4sZhaydE4EhVXO4xJZsVh1pC2DGoIO52vnfeeMzCQq7UbKV7
         rGLTPKHV1a61Amboxxu6e98ukGNbuK6GWhNOQjZu/mbALChpLnkd1CJGCUrVNlljPnxe
         K3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Lyu9KCi+MzHiyQ39Z2tQjEYQpsqwkrB+OjxLY3Xas9k=;
        b=FHhWeAFSt0qA1GofqUfoqa58qygRLMQTWF2/QwkG07ia7Bx7+HGWoR3JVvLZK8IBqk
         wVBc9+6XunCMyW5F+dGMqqUZ7Wf/fHJOBFsq9Z6HWjSkUKgj7NKySHuBlMLbpjnGH0td
         NqKPPWa3986briIANWO+Qpwjxkr9/c9dJXP2QbaW9XLkJar406MXJdDDqMB7coUzXB48
         KDtcwrLOseGWxv9dcZ4I3LMpWfjtnAR/1yfOtZlOvxErCTJtJdILyKHR6AfOQzWFSm+M
         GcP3sNOzwUHpuucy0ydirNO8LqZEuQPK/qmH29q4LJB5HIAQ2St+K/RgflqjgqKNpcH8
         eCBQ==
X-Gm-Message-State: AGRZ1gLrRtaDDns5008U68eMRJwRKhsO4HGXDlxSZzDDf6hJ0ZjqJ5MW
        hOWOis6jvMl+0Pd5h0jW4GZucy0o4Rlwb8DkZV2rsw==
X-Google-Smtp-Source: AJdET5dPxr88RcYj3PmcpVJ7J1xTwtxdFatEUMqEzRpSbJJBu8z3m5rRzKqzIyHE+BmGJ1weD0XnAB2M1lwpS21P9Xw=
X-Received: by 2002:ab0:648b:: with SMTP id p11mr545166uam.128.1540951178964;
 Tue, 30 Oct 2018 18:59:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:f48d:0:0:0:0:0 with HTTP; Tue, 30 Oct 2018 18:59:37
 -0700 (PDT)
In-Reply-To: <20181031004216.GC224709@google.com>
References: <20181029221037.87724-1-dancol@google.com> <20181030050012.u43lcvydy6nom3ul@yavin>
 <CAKOZuesKVic-5epRj8XcFNR_63SgvaPcbjDQuSLxNrEfS=O=Jg@mail.gmail.com>
 <20181030204501.jnbe7dyqui47hd2x@yavin> <20181030214243.GB32621@google.com>
 <20181030222339.ud4wfp75tidowuo4@yavin> <20181030223343.GB105735@joelaf.mtv.corp.google.com>
 <20181030224908.5rsldg4jsos7o5sa@yavin> <20181031004216.GC224709@google.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Wed, 31 Oct 2018 01:59:37 +0000
Message-ID: <CAKOZues-+RB3-Eq26p2BGY5JiaFPBiV1FXn4FTqSFcnb2S2CJg@mail.gmail.com>
Subject: Re: [RFC PATCH] Implement /proc/pid/kill
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 12:42 AM, Joel Fernandes <joel@joelfernandes.org> wrote:
> On Wed, Oct 31, 2018 at 09:49:08AM +1100, Aleksa Sarai wrote:
>> On 2018-10-30, Joel Fernandes <joel@joelfernandes.org> wrote:
>> > > > [...]
>> > > > > > > (Unfortunately
>> > > > > > > there are lots of things that make it a bit difficult to use /proc/$pid
>> > > > > > > exclusively for introspection of a process -- especially in the context
>> > > > > > > of containers.)
>> > > > > >
>> > > > > > Tons of things already break without a working /proc. What do you have in mind?
>> > > > >
>> > > > > Heh, if only that was the only blocker. :P
>> > > > >
>> > > > > The basic problem is that currently container runtimes either depend on
>> > > > > some non-transient on-disk state (which becomes invalid on machine
>> > > > > reboots or dead processes and so on), or on long-running processes that
>> > > > > keep file descriptors required for administration of a container alive
>> > > > > (think O_PATH to /dev/pts/ptmx to avoid malicious container filesystem
>> > > > > attacks). Usually both.
>> > > > >
>> > > > > What would be really useful would be having some way of "hiding away" a
>> > > > > mount namespace (of the pid1 of the container) that has all of the
>> > > > > information and bind-mounts-to-file-descriptors that are necessary for
>> > > > > administration. If the container's pid1 dies all of the transient state
>> > > > > has disappeared automatically -- because the stashed mount namespace has
>> > > > > died. In addition, if this was done the way I'm thinking with (and this
>> > > > > is the contentious bit) hierarchical mount namespaces you could make it
>> > > > > so that the pid1 could not manipulate its current mount namespace to
>> > > > > confuse the administrative process. You would also then create an
>> > > > > intermediate user namespace to help with several race conditions (that
>> > > > > have caused security bugs like CVE-2016-9962) we've seen when joining
>> > > > > containers.
>> > > > >
>> > > > > Unfortunately this all depends on hierarchical mount namespaces (and
>> > > > > note that this would just be that NS_GET_PARENT gives you the mount
>> > > > > namespace that it was created in -- I'm not suggesting we redesign peers
>> > > > > or anything like that). This makes it basically a non-starter.
>> > > > >
>> > > > > But if, on top of this ground-work, we then referenced containers
>> > > > > entirely via an fd to /proc/$pid then you could also avoid PID reuse
>> > > > > races (as well as being able to find out implicitly whether a container
>> > > > > has died thanks to the error semantics of /proc/$pid). And that's the
>> > > > > way I would suggest doing it (if we had these other things in place).
>> > > >
>> > > > I didn't fully follow exactly what you mean. If you can explain for the
>> > > > layman who doesn't know much experience with containers..
>> > > >
>> > > > Are you saying that keeping open a /proc/$pid directory handle is not
>> > > > sufficient to prevent PID reuse while the proc entries under /proc/$pid are
>> > > > being looked into? If its not sufficient, then isn't that a bug? If it is
>> > > > sufficient, then can we not just keep the handle open while we do whatever we
>> > > > want under /proc/$pid ?
>> > >
>> > > Sorry, I went on a bit of a tangent about various internals of container
>> > > runtimes. My main point is that I would love to use /proc/$pid because
>> > > it makes reuse handling very trivial and is always correct, but that
>> > > there are things which stop us from being able to use it for everything
>> > > (which is what my incoherent rambling was on about).
>> >
>> > Ok thanks. So I am guessing if the following sequence works, then Dan's patch is not
>> > needed.
>> >
>> > 1. open /proc/<pid> directory
>> > 2. inspect /proc/<pid> or do whatever with <pid>
>> > 3. Issue the kill on <pid>
>> > 4. Close the /proc/<pid> directory opened in step 1.
>> >
>> > So unless I missed something, the above sequence will not cause any PID reuse
>> > races.
>>
>> (Sorry, I misunderstood your original question.)
>>
>> The problem is that holding /proc/$pid doesn't stop the PID from dying
>> and being reused. The benefit of holding open /proc/$pid is that you
>> will get an error if you try to use it *after* the PID has died -- which
>> means that you don't need to worry about explicitly checking for PID
>> reuse if you are only operating with the file descriptor and not the
>> PID.
>>
>> So that sequence won't always work. There is a race where the pid might
>> die and be recycled by the time you call kill(2) -- after you've done
>> step 2. By tying step 2 and 3 together -- in this patch -- you remove
>> the race (since in order to resolve the "kill" procfs file VFS must
>> resolve the PID first -- atomically).
>
> Makes sense, thanks.
>
>> Though this race window is likely very tiny, and I wonder how much PID
>> churn you really need to hit it.
>
> Yeah that's what I asked initially how much of a problem it really is.

It's fundamentally impossible to use the process stuff today in a
race-free manner today. That the race occurs rarely isn't a good
reason to fix it. The fixes people are proposing are all lightweight,
so I don't understand this desire to stick with the status quo.
There's a longstanding API bug here. We can fix it, so we should.
