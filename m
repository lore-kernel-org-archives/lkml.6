Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DB5C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ED8E20851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="UqZKWOxp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ED8E20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731012AbeKTHjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 02:39:22 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40758 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730991AbeKTHjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 02:39:22 -0500
Received: by mail-pf1-f195.google.com with SMTP id i12so2161583pfo.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 13:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fEEg2WNOcNo+Ih/ksZyQnOBrN9skA3eo8Nn8WHRkp2k=;
        b=UqZKWOxprVwV1F45wiIlsZWNpjSLT4jolf0AYZL5+eebee6CDOnHF0LHrWAMpMBW2D
         xNu8HcUpLA7LR6GmlL986yJahL8dW7uN9D9v//gnDIRM4HL85jrS2XjllTHAsc7/W14X
         x+XACwVxR4it+KKxMZckXhe7iByozaItthsxmP+SluP0c4C2ben7Y/ZP1uaql7XnsFDZ
         oc/WehvQzLZGCn4voEkF7vDkalJD7fxye6bKKSnp82TKy7kT4tZmNWnQGHn84cYiGQUe
         S+3g0xS4c4+3/eTXEYYFqFFopN7dfghRjQrDkC5JLBlhHX9FVVccDqDNLmqQPyKSJO17
         grnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fEEg2WNOcNo+Ih/ksZyQnOBrN9skA3eo8Nn8WHRkp2k=;
        b=DHi7kwAWhTACwHnuuq9nVhFHIi4N/OgPacavp91gJQ4/nG6DN0WOiUll/DJw7o/g2h
         hJkNNiOIeZpUHAGlygIBx5NsbOtj0ByHm6HUvgMP42AExPZafpRwOwJ6seMcdxgIpAhb
         qigfzTycqDWu/GMRH0FOzuFVHCRZi9NQh+kc8Nf/CuA4UZgt+EqyalKZ67+yprwdMre6
         lkPRObhwFNzthH1Ll1UyZqkfxJkcZM8s3xTvv/eHNgb6laLoU93cnbIYQ+MQDIttTYE7
         d/ehbSqosHptzw2NDwAWAGHSE11k5zN555dftIRd6EN4w18tNivNj4c7K4gt+a9so/vr
         +6PQ==
X-Gm-Message-State: AGRZ1gIPU2eyYwbe033HVN3wUJh1EsACLXbXwc1fQ+EcX7SiEKlq2JLY
        ENXCQkl4l6uj2MYQtBwOTwvtfw==
X-Google-Smtp-Source: AJdET5d3vN+iMtJU44MudQkmtVoKpwYTzMZb9CD6SaSx/z01jfxE3bA5gAAMS1wOsAe8aJJcKa74mA==
X-Received: by 2002:a63:a552:: with SMTP id r18mr21606958pgu.176.1542662032915;
        Mon, 19 Nov 2018 13:13:52 -0800 (PST)
Received: from brauner.io ([2404:4404:133a:4500:9d11:de0b:446c:8485])
        by smtp.gmail.com with ESMTPSA id a10sm26203738pfi.138.2018.11.19.13.13.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 13:13:52 -0800 (PST)
Date:   Mon, 19 Nov 2018 22:13:43 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        serge@hallyn.com, jannh@google.com, luto@kernel.org,
        akpm@linux-foundation.org, oleg@redhat.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, dancol@google.com, timmurray@google.com,
        linux-man@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v1 2/2] signal: add procfd_signal() syscall
Message-ID: <20181119211335.tmoycnu4r2ob6cda@brauner.io>
References: <20181119103241.5229-1-christian@brauner.io>
 <20181119103241.5229-3-christian@brauner.io>
 <20181119202857.k5zw742xjfrw677j@yavin>
 <20181119205518.btew3vxwgva4w3zh@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181119205518.btew3vxwgva4w3zh@brauner.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 09:55:18PM +0100, Christian Brauner wrote:
> On Tue, Nov 20, 2018 at 07:28:57AM +1100, Aleksa Sarai wrote:
> > On 2018-11-19, Christian Brauner <christian@brauner.io> wrote:
> > > +	if (info) {
> > > +		ret = __copy_siginfo_from_user(sig, &kinfo, info);
> > > +		if (unlikely(ret))
> > > +			goto err;
> > > +		/*
> > > +		 * Not even root can pretend to send signals from the kernel.
> > > +		 * Nor can they impersonate a kill()/tgkill(), which adds
> > > +		 * source info.
> > > +		 */
> > > +		ret = -EPERM;
> > > +		if ((kinfo.si_code >= 0 || kinfo.si_code == SI_TKILL) &&
> > > +		    (task_pid(current) != pid))
> > > +			goto err;
> > > +	} else {
> > > +		prepare_kill_siginfo(sig, &kinfo);
> > > +	}
> > 
> > I wonder whether we should also have a pidns restriction here, since
> > currently it isn't possible for a container process using a pidns to
> > signal processes outside its pidns. AFAICS, this isn't done through an
> > explicit check -- it's a side-effect of processes in a pidns not being
> > able to address non-descendant-pidns processes.
> > 
> > But maybe it's reasonable to allow sending a procfd to a different pidns
> > and the same operations working on it? If we extend the procfd API to
> 
> No, I don't think so. I really don't want any fancy semantics in here.
> Fancy doesn't get merged and fancy is hard to maintain. So we should do
> something like:
> 
> if (proc_pid_ns() != current_pid_ns)
> 	return EINVAL

To be more precise, we need to detect if fd refers to an ancestor pidns
and if so return EINVAL.

> 
> > allow process creation this would allow a container to create a process
> > outside its pidns.
> > 
> > -- 
> > Aleksa Sarai
> > Senior Software Engineer (Containers)
> > SUSE Linux GmbH
> > <https://www.cyphar.com/>
> 
> 
