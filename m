Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C16C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 23:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A9F62086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 23:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="PpHogQZM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A9F62086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732074AbeKTKLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 05:11:36 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36452 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbeKTKLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 05:11:36 -0500
Received: by mail-pl1-f194.google.com with SMTP id y6-v6so42012plt.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 15:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9/g3EJDVkYjY4dj/KiOcMvdB33M/FOhNbEHIxHey6lI=;
        b=PpHogQZMDnkEuYruUzolvmNIk4m9j01GWYVgBFT2HemxF6evhCVkKoLfEbkvnBoM1S
         nBgOGgyxdbrauclNdAONxpKesny8hQ1kza6FiGw5v2/xXrk9QJEH3m6/GJ27ZemfzIzd
         Dd7pJClRu4E8dtuLXiGbyc9Gi2vQSaGKPl7oLjlqq2NAnZI3qEGFMQaOBozKLEgkK0cS
         AQbNisugqUSc7LzSYTmpmLuWZ/tKdyjK+m2pJMWqBmOHk6OCr/4LaipeaSPpL3tD5DZQ
         JQ6hR4CP7Pqp6E4v4EOnfaqEL2tj0zKL9HqZ9EHiRahdPQUOHE8mVDmzBbp8bSye00c2
         M6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9/g3EJDVkYjY4dj/KiOcMvdB33M/FOhNbEHIxHey6lI=;
        b=GZjZUDv5eajIqzSLvnVZhfKrM51iqtiqS4o84ZBl8k9Hz9VT9BUDJMaUeCbR9CCKk6
         tWrvBUCUE554O56PRm+ZtDHWdQgiLLaiB1TYxw5g22lPtvbHkZCpwcm//UMcMsyZeWPo
         J5MTje6gswsiPhs3Dlpk4CkNx6IxlIsU1snag9CFvIEdBsx4wglHGPcHAMRcZCz3GVS6
         54MYk3TbOnOCHGfrKN/rgzx59WoBRWAxSkbRFY2cdMC/PvXxk3xYW8PMctyP7S/c8Yyf
         AsneQ2tloTmkk/F5GgSDM1dQ7ZnRE63OkJU8BFkXhDbLTyUe2KFdvxqqqErMPBOBejhY
         o+Gg==
X-Gm-Message-State: AA+aEWaC+AB4MaYtiDGRMQYpZAXtfdo7b17gU8C6LZtuuFcwHZI33MvF
        dscrwOljcHXgZg6qQ3vqRFSW2w==
X-Google-Smtp-Source: AFSGD/V3QCtS0VJ1zPIyb1U6fTaXt+kzmjWg1N28HW55N5YHiPGuJZpAlIHIBx99kvS74Jnqo2zzKw==
X-Received: by 2002:a17:902:14b:: with SMTP id 69mr9335062plb.52.1542671128951;
        Mon, 19 Nov 2018 15:45:28 -0800 (PST)
Received: from brauner.io ([130.195.55.139])
        by smtp.gmail.com with ESMTPSA id i1sm1612628pgb.46.2018.11.19.15.45.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 15:45:28 -0800 (PST)
Date:   Tue, 20 Nov 2018 00:45:18 +0100
From:   Christian Brauner <christian@brauner.io>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org, serge@hallyn.com, jannh@google.com,
        luto@kernel.org, akpm@linux-foundation.org, oleg@redhat.com,
        cyphar@cyphar.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        dancol@google.com, timmurray@google.com, linux-man@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v1 2/2] signal: add procfd_signal() syscall
Message-ID: <20181119234515.o5dg5s2wtu6wl6m3@brauner.io>
References: <20181119103241.5229-3-christian@brauner.io>
 <201811200755.avfmktKQ%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201811200755.avfmktKQ%fengguang.wu@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 07:37:58AM +0800, kbuild test robot wrote:
> Hi Christian,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.20-rc3]
> [cannot apply to next-20181119]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Christian-Brauner/proc-allow-signaling-processes-via-file-descriptors/20181120-063836
> config: riscv-tinyconfig (attached as .config)
> compiler: riscv64-linux-gcc (GCC) 8.1.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=8.1.0 make.cross ARCH=riscv 
> 
> All errors (new ones prefixed by >>):
> 
>    kernel/signal.c: In function '__do_sys_procfd_signal':
> >> kernel/signal.c:3341:7: error: implicit declaration of function 'proc_is_procfd'; did you mean 'clockid_to_fd'? [-Werror=implicit-function-declaration]
>      if (!proc_is_procfd(f.file))
>           ^~~~~~~~~~~~~~

On my radar and fixed. This happens when CONFIG_PROC_FS unset.

>           clockid_to_fd
>    cc1: some warnings being treated as errors
> 
> vim +3341 kernel/signal.c
> 
>   3314	
>   3315	/**
>   3316	 *  sys_procfd_signal - send a signal to a process through a process file
>   3317	 *                      descriptor
>   3318	 *  @fd: the file descriptor of the process
>   3319	 *  @sig: signal to be sent
>   3320	 *  @info: the signal info
>   3321	 *  @flags: future flags to be passed
>   3322	 */
>   3323	SYSCALL_DEFINE4(procfd_signal, int, fd, int, sig, siginfo_t __user *, info,
>   3324			int, flags)
>   3325	{
>   3326		int ret;
>   3327		struct pid *pid;
>   3328		kernel_siginfo_t kinfo;
>   3329		struct fd f;
>   3330	
>   3331		/* Enforce flags be set to 0 until we add an extension. */
>   3332		if (flags)
>   3333			return -EINVAL;
>   3334	
>   3335		f = fdget_raw(fd);
>   3336		if (!f.file)
>   3337			return -EBADF;
>   3338	
>   3339		ret = -EINVAL;
>   3340		/* Is this a process file descriptor? */
> > 3341		if (!proc_is_procfd(f.file))
>   3342			goto err;
>   3343	
>   3344		pid = f.file->private_data;
>   3345		if (!pid)
>   3346			goto err;
>   3347	
>   3348		if (info) {
>   3349			ret = __copy_siginfo_from_user(sig, &kinfo, info);
>   3350			if (unlikely(ret))
>   3351				goto err;
>   3352			/*
>   3353			 * Not even root can pretend to send signals from the kernel.
>   3354			 * Nor can they impersonate a kill()/tgkill(), which adds
>   3355			 * source info.
>   3356			 */
>   3357			ret = -EPERM;
>   3358			if ((kinfo.si_code >= 0 || kinfo.si_code == SI_TKILL) &&
>   3359			    (task_pid(current) != pid))
>   3360				goto err;
>   3361		} else {
>   3362			prepare_kill_siginfo(sig, &kinfo);
>   3363		}
>   3364	
>   3365		ret = kill_pid_info(sig, &kinfo, pid);
>   3366	
>   3367	err:
>   3368		fdput(f);
>   3369		return ret;
>   3370	}
>   3371	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


