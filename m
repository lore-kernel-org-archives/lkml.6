Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C97C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 15:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DC06208F7
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 15:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7wr6N1/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DC06208F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933346AbeFUPtX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 11:49:23 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:46095 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933246AbeFUPtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 11:49:20 -0400
Received: by mail-wr0-f194.google.com with SMTP id v13-v6so3694037wrp.13;
        Thu, 21 Jun 2018 08:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hL2fCLFP4Nm3BRIEpmfKGO+hjvYCtu0r/ai5Qd+NVJs=;
        b=V7wr6N1/lEg0WN9LXnvswFou6YvbkjU8xaatfkQngz1mSUsDsODr04FQ75EQTyuACk
         WditeHh2vpv6r1eNMSAX7UV4YqEVSuzrBvXmNWDePNx+is9OCBahh2qlYiFkrpdV1dXO
         yjKmJ7QyjOrXtaxede/N3DpDmmeGlA+wjl247nC8YAcNiilijD5RJhxCUFms2W+cx0X3
         dxf0XaQit6d8sD6CVUVytPOezSIvjRLdzkMuljanb5b8B4PBaWxPse+FPXjiBxEtYSB/
         Rh4fxOJEPTH4gy5rwM8v/syV6cDKL3406Ud3e+jmo/JyBigOYvw5bGp1s3gi3zzSB2bk
         zksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=hL2fCLFP4Nm3BRIEpmfKGO+hjvYCtu0r/ai5Qd+NVJs=;
        b=YuSSAXd1fugBvvHTID6uu0XTOPyPFj1oOR59Nw90s8/LWrSWAv3Kn7fGicdlv7YRw9
         h6FMxH/Z7VQliAYzQSN9UR06pgm9JgBVrTomtn4UdYyh26SXmoh8C3LhaZDlAWVsla6z
         r89Snn6xlX6fqelC3HyGEMwN/rSdUQyxWKCFKAG3fbQbV0g+BRUrxmlao57GiMLfb/58
         zyIvE7fKmU0kUAmUosoLjI2x4fOb0vqWDYqcXZXcpX29IRFQqDQaUMqL23jGJqP8qnSS
         fHZR8i/zsOr7cVhRSc9yHc8GcQu3ARuzX/e5o9ozO6OuPNNDJqBAPRYjMe5xUY0D5fqI
         u7CQ==
X-Gm-Message-State: APt69E3CZWe14nmZCOXG2By0xhZwB7HYmv1LhDC5k553VjbTMnRB1S0Q
        9PimDAB0kQAHZKGke1r9ayw=
X-Google-Smtp-Source: ADUXVKKlovp7SnddGL6YNo0PWz2UP+RCT7tO9hIosyN22zEN5fPU0AaPjnQsI5aj9F+19l7aBW68fQ==
X-Received: by 2002:adf:ad2f:: with SMTP id p44-v6mr22865639wrc.164.1529596159125;
        Thu, 21 Jun 2018 08:49:19 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id x5-v6sm5720127wrr.3.2018.06.21.08.49.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 08:49:18 -0700 (PDT)
Date:   Thu, 21 Jun 2018 17:49:15 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, Paul Eggert <eggert@cs.ucla.edu>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-alpha@vger.kernel.org,
        Deepa Dinamani <deepa.kernel@gmail.com>
Subject: Re: [PATCH v2 2/2] rusage: allow 64-bit times ru_utime/ru_stime
Message-ID: <20180621154915.GA31947@gmail.com>
References: <20180420120605.1612248-1-arnd@arndb.de>
 <20180420120605.1612248-2-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180420120605.1612248-2-arnd@arndb.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


(belated reply)

* Arnd Bergmann <arnd@arndb.de> wrote:

> +int put_compat_rusage_time64(const struct __kernel_rusage *r,
> +			     struct compat_rusage_time64 __user *ru)
> +{
> +	struct compat_rusage_time64 r32;
> +	memset(&r32, 0, sizeof(r32));
> +	r32.ru_utime.tv_sec = r->ru_utime.tv_sec;
> +	r32.ru_utime.tv_usec = r->ru_utime.tv_usec;
> +	r32.ru_stime.tv_sec = r->ru_stime.tv_sec;
> +	r32.ru_stime.tv_usec = r->ru_stime.tv_usec;
> +	r32.ru_maxrss = r->ru_maxrss;
> +	r32.ru_ixrss = r->ru_ixrss;
> +	r32.ru_idrss = r->ru_idrss;
> +	r32.ru_isrss = r->ru_isrss;
> +	r32.ru_minflt = r->ru_minflt;
> +	r32.ru_majflt = r->ru_majflt;
> +	r32.ru_nswap = r->ru_nswap;
> +	r32.ru_inblock = r->ru_inblock;
> +	r32.ru_oublock = r->ru_oublock;
> +	r32.ru_msgsnd = r->ru_msgsnd;
> +	r32.ru_msgrcv = r->ru_msgrcv;
> +	r32.ru_nsignals = r->ru_nsignals;
> +	r32.ru_nvcsw = r->ru_nvcsw;
> +	r32.ru_nivcsw = r->ru_nivcsw;

Could you please vertically align the right side of the initialization as well? 
Much easier to check at a glance.

> +	user_access_begin();
> +	unsafe_put_user(signo, &infop->si_signo, Efault);
> +	unsafe_put_user(0, &infop->si_errno, Efault);
> +	unsafe_put_user(info.cause, &infop->si_code, Efault);
> +	unsafe_put_user(info.pid, &infop->si_pid, Efault);
> +	unsafe_put_user(info.uid, &infop->si_uid, Efault);
> +	unsafe_put_user(info.status, &infop->si_status, Efault);
> +	user_access_end();

This too would look nicer the following way:

> +	user_access_begin();
> +	unsafe_put_user(signo,		&infop->si_signo,	Efault);
> +	unsafe_put_user(0,		&infop->si_errno,	Efault);
> +	unsafe_put_user(info.cause,	&infop->si_code,	Efault);
> +	unsafe_put_user(info.pid,	&infop->si_pid,		Efault);
> +	unsafe_put_user(info.uid,	&infop->si_uid,		Efault);
> +	unsafe_put_user(info.status,	&infop->si_status,	Efault);
> +	user_access_end();

Which tabulated form made me notice the info.cause / si_code asymmetry - and a 
brief check of the source shows that it's correct. No way would I have noticed it 
in the jumbled up form above, so I think aligning such mass-initializations makes 
sense.

> +	memset(&r, 0, sizeof(r));
> +	r.ru_utime.tv_sec = rk->ru_utime.tv_sec;
> +	r.ru_utime.tv_usec = rk->ru_utime.tv_usec;
> +	r.ru_stime.tv_sec = rk->ru_stime.tv_sec;
> +	r.ru_stime.tv_usec = rk->ru_stime.tv_usec;
> +	r.ru_maxrss = rk->ru_maxrss;
> +	r.ru_ixrss = rk->ru_ixrss;
> +	r.ru_idrss = rk->ru_idrss;
> +	r.ru_isrss = rk->ru_isrss;
> +	r.ru_minflt = rk->ru_minflt;
> +	r.ru_majflt = rk->ru_majflt;
> +	r.ru_nswap = rk->ru_nswap;
> +	r.ru_inblock = rk->ru_inblock;
> +	r.ru_oublock = rk->ru_oublock;
> +	r.ru_msgsnd = rk->ru_msgsnd;
> +	r.ru_msgrcv = rk->ru_msgrcv;
> +	r.ru_nsignals = rk->ru_nsignals;
> +	r.ru_nvcsw = rk->ru_nvcsw;
> +	r.ru_nivcsw = rk->ru_nivcsw;

Ditto.

Thanks,

	Ingo
