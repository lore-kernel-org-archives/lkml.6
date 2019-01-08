Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFBBC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FC9820685
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="iXsZyNBt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729405AbfAHSU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 13:20:27 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:33430 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729168AbfAHSU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 13:20:27 -0500
Received: by mail-io1-f65.google.com with SMTP id t24so3922738ioi.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 10:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GoZZb+GZECSGn7r2Db9cIHtoybIpjfjGF6PsAUEXfZI=;
        b=iXsZyNBtX3esfm9yvpb2yZk0zgU823/fSKfrkMQpv/d8Iosc7UhNIq2Aeb87A0MJm6
         QcjIk3ElqSHgnuUTl6n5f/YZNKNGO3grcEC6Rj0l+XgdtCS9N07fiM6WxZrlA9EEdQlH
         VCtH8bNO6YBqIhEOpPTsL05lasmTNXfBuZjefndvPa7a0w549ISdYOQDOedIIed746zS
         K1uDgj4qsMsRgSVbwk0ZshWrR/2fgbnjSLtZ94ndHdrWgXCLysvbuqbCzwRkW0/j498f
         xUxdaaTdu1s+QldDBMd+heM09smbVIVvfVgKEHEcJSXdiubKkq2uDaIHsjrJdNmKNUnQ
         VZmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GoZZb+GZECSGn7r2Db9cIHtoybIpjfjGF6PsAUEXfZI=;
        b=aNiPSH2ec6NTFI5qbo9GXQU6qdk+EdZnkaQwwptTz9Oexkv2b1+kf0briOZolY38P6
         q0fsOYjW8CtQXoj6VmDYl7/yBZXOWyHh/C0MtYi8LjqaJ6FkKlm8YUZhLgFfAHvxgryZ
         mmjYNM2DKVLmWEaraYYHlzg5PtnLGZimcR/Iebxa34g1ZqBHXIC3vEXPf4ZA8BNGuudz
         MPOwQ9W13lCHRfXo6nmfANL37EE+XfG6odSLBxvIHhZtBRwDg7MEDjtqnDQ9OOyTfkuV
         0yxD1E8DDjopu8dnU94GDLlvGUXkasF58VsPoq+AJoSr0pChPeiid1Ra3Mpdm/OSSczq
         9bBg==
X-Gm-Message-State: AJcUukfjwEK8ufoJghvfWeVEUmdIAB5d+VKJvJPJtbnTc0QFlD5YFmw5
        V1cOyPFebU00l1Ic0W2y8vQomw==
X-Google-Smtp-Source: ALg8bN7bfFUCXYeGHcvkqk8/fOMH/lEj9OCuA+Ii66khZPNjZJ3TLTzffjJor9ofrr/3b5knn2RBGQ==
X-Received: by 2002:a6b:c3ca:: with SMTP id t193mr1622195iof.269.1546971626076;
        Tue, 08 Jan 2019 10:20:26 -0800 (PST)
Received: from cisco ([2601:282:901:dd7b:c092:9114:ac14:211f])
        by smtp.gmail.com with ESMTPSA id 85sm31471927iou.8.2019.01.08.10.20.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 10:20:25 -0800 (PST)
Date:   Tue, 8 Jan 2019 11:20:23 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        luto@kernel.org, arnd@arndb.de, keescook@chromium.org,
        akpm@linux-foundation.org, jannh@google.com, oleg@redhat.com,
        cyphar@cyphar.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, dancol@google.com,
        timmurray@google.com, fweimer@redhat.com, tglx@linutronix.de,
        x86@kernel.org, ebiederm@xmission.com
Subject: Re: [PATCH v7 2/2] selftests: add tests for pidfd_send_signal()
Message-ID: <20190108182023.GA28330@cisco>
References: <20190102161654.9093-1-christian@brauner.io>
 <20190102161654.9093-2-christian@brauner.io>
 <20190108175306.GF29009@cisco>
 <20190108175415.GA22353@mail.hallyn.com>
 <20190108175843.GA26016@cisco>
 <20190108181742.GA22614@mail.hallyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108181742.GA22614@mail.hallyn.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 12:17:42PM -0600, Serge E. Hallyn wrote:
> On Tue, Jan 08, 2019 at 10:58:43AM -0700, Tycho Andersen wrote:
> > On Tue, Jan 08, 2019 at 11:54:15AM -0600, Serge E. Hallyn wrote:
> > > On Tue, Jan 08, 2019 at 10:53:06AM -0700, Tycho Andersen wrote:
> > > > On Wed, Jan 02, 2019 at 05:16:54PM +0100, Christian Brauner wrote:
> > > > > +			/*
> > > > > +			 * Stop the child so we can inspect whether we have
> > > > > +			 * recycled pid PID_RECYCLE.
> > > > > +			 */
> > > > > +			close(pipe_fds[0]);
> > > > > +			ret = kill(recycled_pid, SIGSTOP);
> > > > > +			close(pipe_fds[1]);
> > > > > +			if (ret) {
> > > > > +				(void)wait_for_pid(recycled_pid);
> > > > > +				_exit(PIDFD_ERROR);
> > > > > +			}
> > > > 
> > > > Sorry for being late to the party, but I wonder if this whole thing
> > > > couldn't be simplified with /proc/sys/kenrel/ns_last_pid?
> > > 
> > > no, bc it's not namespaced :)
> > 
> > Huh? It looks like it is...
> > 
> > static int pid_ns_ctl_handler(struct ctl_table *table, int write,
> >                 void __user *buffer, size_t *lenp, loff_t *ppos)
> > {
> >         struct pid_namespace *pid_ns = task_active_pid_ns(current);
> >         struct ctl_table tmp = *table;
> >         int ret, next;
> > 
> >         if (write && !ns_capable(pid_ns->user_ns, CAP_SYS_ADMIN))
> >                 return -EPERM;
> > 
> >         ...
> 
> Oh - hah, but that's ns_last_pid.  You'd want pid_max.  And that one
> is not namespaced.

Perhaps I'm misunderstanding, but isn't the point of all this code to
get the same pid again? So can't we just fork(), kill(), then set
ns_last_pid to pid-1, and fork() again to re-use?

Tycho
