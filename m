Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C42C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0368B20827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="eXrDTXKV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729643AbfAHSAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 13:00:18 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:55080 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729293AbfAHR6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 12:58:46 -0500
Received: by mail-it1-f194.google.com with SMTP id i145so7544011ita.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 09:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gVDRi/JLGdyGL6YIrPZDBIDy+di0KS3eFVrNqypvHU0=;
        b=eXrDTXKVI3pfRUsm5f4XO0Z+8XyLx1z46EjxsvVjI8KbikiQ8v+LUoFydIpJ0+byE3
         OqtFBDzdy9EfKZ2Y9yQcvvL2VBZ/1ERpk9dqcb+LUrfewYWcF68pSjgDCNcdYDRQC441
         76NsZnOrJfQ+JGCdfLNBxPVjSrVtzQ+1dRLgWJLJUQXyRDmbq3M32HPIqrO3M9/64PLG
         uwN2Lg6/aWmsipsgpr/Iz+a+3kl/LQXOWAhYAgjw6kLexA3RIIg+P24dQv75HzCyrX5A
         XuZWonRGIEaEjsP/DHNxG0qf47kahJxWfNUEwhDWu4MUaj4c14OeBILX+8tCOwtl0W6l
         LKjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gVDRi/JLGdyGL6YIrPZDBIDy+di0KS3eFVrNqypvHU0=;
        b=Td40XDYY/PuAKnCNrwtTV9gJ/7nLDpBWSzD6YodX7Wv4xs5eUIA11UfMMjdyplvmeQ
         +LfP5MoVwLJeZB9MmOFluXW4X2Vps5NqwGQJP3gh8lo0N7wwUmQxZMBvw6ka32/UlB3g
         q9BTfhE9S0DlDL7q3P20JP7+hVtqL8EX8B/H4bQ68A7JA9dS7DrZFN2pRv63kK8kG4io
         kq0u0ZCCJ8zQlsLOvv3P99kTCrmc1syUjPCKFXoIJM193j5r+d4HPqTQh0t5MQ5pLsrQ
         VuanKZmu+GDn+r96k+2J8g8NFe3BmdDgmfssP/UVJxKt3YMcn3xvIoGiU1YqAst7GUZp
         M0fQ==
X-Gm-Message-State: AJcUukcfXacOSaKz9IYQVfw3ZQV8+D+XXDIiD24Qiho62/RrueESo12s
        8Ead4uw/bm0zm72FtpAIPU4cmw==
X-Google-Smtp-Source: ALg8bN7MMZNesUU4PTfZWH24pmARvoxeUCb/qEJMmuRN/SHFIaXSSxla5IsyZe9biWseUH2G9JgbyQ==
X-Received: by 2002:a02:242b:: with SMTP id f43mr1724459jaa.144.1546970325637;
        Tue, 08 Jan 2019 09:58:45 -0800 (PST)
Received: from cisco ([2601:282:901:dd7b:c092:9114:ac14:211f])
        by smtp.gmail.com with ESMTPSA id b192sm6698879itb.12.2019.01.08.09.58.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 09:58:45 -0800 (PST)
Date:   Tue, 8 Jan 2019 10:58:43 -0700
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
Message-ID: <20190108175843.GA26016@cisco>
References: <20190102161654.9093-1-christian@brauner.io>
 <20190102161654.9093-2-christian@brauner.io>
 <20190108175306.GF29009@cisco>
 <20190108175415.GA22353@mail.hallyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108175415.GA22353@mail.hallyn.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 11:54:15AM -0600, Serge E. Hallyn wrote:
> On Tue, Jan 08, 2019 at 10:53:06AM -0700, Tycho Andersen wrote:
> > On Wed, Jan 02, 2019 at 05:16:54PM +0100, Christian Brauner wrote:
> > > +			/*
> > > +			 * Stop the child so we can inspect whether we have
> > > +			 * recycled pid PID_RECYCLE.
> > > +			 */
> > > +			close(pipe_fds[0]);
> > > +			ret = kill(recycled_pid, SIGSTOP);
> > > +			close(pipe_fds[1]);
> > > +			if (ret) {
> > > +				(void)wait_for_pid(recycled_pid);
> > > +				_exit(PIDFD_ERROR);
> > > +			}
> > 
> > Sorry for being late to the party, but I wonder if this whole thing
> > couldn't be simplified with /proc/sys/kenrel/ns_last_pid?
> 
> no, bc it's not namespaced :)

Huh? It looks like it is...

static int pid_ns_ctl_handler(struct ctl_table *table, int write,
                void __user *buffer, size_t *lenp, loff_t *ppos)
{
        struct pid_namespace *pid_ns = task_active_pid_ns(current);
        struct ctl_table tmp = *table;
        int ret, next;

        if (write && !ns_capable(pid_ns->user_ns, CAP_SYS_ADMIN))
                return -EPERM;

        ...

Tycho
