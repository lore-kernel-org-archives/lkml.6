Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5681C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 20:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A48A2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 20:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="XIIRWGCJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A48A2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730909AbeKTHUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 02:20:55 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40432 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730852AbeKTHUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 02:20:55 -0500
Received: by mail-pf1-f194.google.com with SMTP id i12so2139557pfo.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 12:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ngz/Y1cNLgES/cNFWmCB4diKECGfvsf2JLaGb99AV84=;
        b=XIIRWGCJDme9RiNStO/ZSsD0CLhn3GHALS0xIAbRh7OUna8y6ytOBfCIzDn/bqSNt/
         /ksySguTbmnYqtchvFE+0Ah4oDNmSPUPl///BXeDkXwJ+JkqBXAWMcsQlOnXxKLogImJ
         SSxgzRptXQ9uDimmq0jQTdZKlyEK102NIqbh6cyReQMF+Og2pBmjKuONCrmMrhsY1PeY
         VPCCeXu7SSUZ+rfj9QiFe5uq/lGjfyl6d5A5oR+sLLNrXbBtLSuPUfpbCNz2DtBbYZxw
         qrzAayCc5VxE5MI1LL/QQnOAqk05z7CLiOK5TC6dJI/eiKVR/tPaFFJI12Uu19n3d4nV
         T3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ngz/Y1cNLgES/cNFWmCB4diKECGfvsf2JLaGb99AV84=;
        b=r/p3plyiJV6kU6y2Zefkm9bzq0w3IXZgKFKYdF4+qWJ+R/1E2Xp+/inb/xgchyY2yt
         FAUOtyXNSnT4/hOYq6SAm9w7hB/vE8UVUtsthkHtxGrLGtru5CSyeGWWTWgA0ZNjjd8Q
         1Kk9IN45i0TQkbSxrCwUz+g+PTcEE+CYMOdGeHhhvwjtZsNW0AOsthwI7okPGzhbeLMF
         K9iVi/ni0cgsZO7tUVdM6BW451rWSwuV9Ynz9DRR7prtDjvxocmuTauhfNysiCe+5XkV
         Phx5VIKbteTbEWQ6AtP48jdDCN7z8eVelgGLWgamTt0DhFYeTFVCrjEnI0xeaSvfr14g
         utOg==
X-Gm-Message-State: AGRZ1gIRxNUEuauMPYoy2HTmoiAliVZbAN7BRbWJ8Mr4x+geARLNOE6K
        SIMoCDNjwX9IbqLDqA4XgW5sYA==
X-Google-Smtp-Source: AJdET5dO2XxRHIVXgerVFzMYlK25ZuK+qJwnz/ty9M+CS65xOphADSY4A5DJ0WKsnEJ0ghvRsLD2HQ==
X-Received: by 2002:a62:6d83:: with SMTP id i125-v6mr24919112pfc.184.1542660930161;
        Mon, 19 Nov 2018 12:55:30 -0800 (PST)
Received: from brauner.io ([2404:4404:133a:4500:9d11:de0b:446c:8485])
        by smtp.gmail.com with ESMTPSA id 11-v6sm59403212pfr.55.2018.11.19.12.55.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 12:55:29 -0800 (PST)
Date:   Mon, 19 Nov 2018 21:55:20 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        serge@hallyn.com, jannh@google.com, luto@kernel.org,
        akpm@linux-foundation.org, oleg@redhat.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, dancol@google.com, timmurray@google.com,
        linux-man@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v1 2/2] signal: add procfd_signal() syscall
Message-ID: <20181119205518.btew3vxwgva4w3zh@brauner.io>
References: <20181119103241.5229-1-christian@brauner.io>
 <20181119103241.5229-3-christian@brauner.io>
 <20181119202857.k5zw742xjfrw677j@yavin>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181119202857.k5zw742xjfrw677j@yavin>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 07:28:57AM +1100, Aleksa Sarai wrote:
> On 2018-11-19, Christian Brauner <christian@brauner.io> wrote:
> > +	if (info) {
> > +		ret = __copy_siginfo_from_user(sig, &kinfo, info);
> > +		if (unlikely(ret))
> > +			goto err;
> > +		/*
> > +		 * Not even root can pretend to send signals from the kernel.
> > +		 * Nor can they impersonate a kill()/tgkill(), which adds
> > +		 * source info.
> > +		 */
> > +		ret = -EPERM;
> > +		if ((kinfo.si_code >= 0 || kinfo.si_code == SI_TKILL) &&
> > +		    (task_pid(current) != pid))
> > +			goto err;
> > +	} else {
> > +		prepare_kill_siginfo(sig, &kinfo);
> > +	}
> 
> I wonder whether we should also have a pidns restriction here, since
> currently it isn't possible for a container process using a pidns to
> signal processes outside its pidns. AFAICS, this isn't done through an
> explicit check -- it's a side-effect of processes in a pidns not being
> able to address non-descendant-pidns processes.
> 
> But maybe it's reasonable to allow sending a procfd to a different pidns
> and the same operations working on it? If we extend the procfd API to

No, I don't think so. I really don't want any fancy semantics in here.
Fancy doesn't get merged and fancy is hard to maintain. So we should do
something like:

if (proc_pid_ns() != current_pid_ns)
	return EINVAL

> allow process creation this would allow a container to create a process
> outside its pidns.
> 
> -- 
> Aleksa Sarai
> Senior Software Engineer (Containers)
> SUSE Linux GmbH
> <https://www.cyphar.com/>


