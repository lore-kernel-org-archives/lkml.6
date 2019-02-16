Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260D8C10F00
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 19:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAF0D222E6
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 19:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=manojrajarao-com.20150623.gappssmtp.com header.i=@manojrajarao-com.20150623.gappssmtp.com header.b="zWmTgeqt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732557AbfBPTMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 14:12:30 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46183 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732506AbfBPTM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 14:12:29 -0500
Received: by mail-pl1-f195.google.com with SMTP id o6so6620805pls.13
        for <linux-kernel@vger.kernel.org>; Sat, 16 Feb 2019 11:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=manojrajarao-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=Eh1jaq667dFAHSieu8gZf75SHj7h+C4iXs741KKYZic=;
        b=zWmTgeqt2+3yz7+adKjkxVdqtrHNSVPem7jiAkNHzD87UcdwrflOAOCYk3Z0TC9+h5
         uGLd+crEIJu5Zqw2831hyEkDZEkW3qGacz+qBvdt7r67ZSC9Pit+Fm8+ncoeq9kPAjVF
         enSGTQ5/Grdn+UkYrhx70x6Sq07H2glO2DIk0Z/o0J8IrccVYkyXDk2e/EOQNs/GFeWN
         gd4i5/5n08kbzi3NSz89Y5YTwTCB1uIHsuLal2jKmKuYZc+9qwAQt2RGNMyZWIbI+ZVY
         x6dX+70kVO8od2kfYn4S5883eTuZHh5KeI1BZ9ShDkaViQMFva/lq593gMnho4RIdXda
         UH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=Eh1jaq667dFAHSieu8gZf75SHj7h+C4iXs741KKYZic=;
        b=djSYh5BAKdUa/FbWWQaab9Gzn/BrMK+eHHfWF2YJ1ruvgbZ8x5l7ygN14qLRajQQ4J
         iL69ZritgdxWbX6+kc8NMfUhATcxjvZRRTvjRCV+dlZGtATKmH8ygXxHlDcXjuAmlUWO
         bUPwx4pYVUwdrs4WlpZ283UdVHm0bpNPvxBbl+Ql7Dv893SOVUOLzlQCFutEpM5PEkaR
         GOv8QasAiECRTlsah2r2Tc8gtM4TA1fS/JIy9nwaV8Np3qxXvFG2DKcKDzGrD9GjnBmv
         C+c+qV5UpfFpl0dGRQ3VZ30R3NBbWY4CyX7hyMmvnbjjiIXiNFo/6VeMRrabnM1XEySZ
         LHGg==
X-Gm-Message-State: AHQUAuY85FLy+Vw6btu6LJq+jDpcO1808QUxD3OGHzg4E0DzjK0Y5j1C
        k/l4QR2zR7UGbiZKCIXSRoltMQ==
X-Google-Smtp-Source: AHgI3IYlsna5bj9z/49J72uEgB2M+65urVU5vViJfxmEWJP34JVhGKQeM9ZMrrdWytajrsh6A+08sA==
X-Received: by 2002:a17:902:6949:: with SMTP id k9mr17003011plt.188.1550344348855;
        Sat, 16 Feb 2019 11:12:28 -0800 (PST)
Received: from manoj-desktop (c-24-6-55-244.hsd1.ca.comcast.net. [24.6.55.244])
        by smtp.gmail.com with ESMTPSA id b9sm11267019pfi.118.2019.02.16.11.12.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Feb 2019 11:12:28 -0800 (PST)
References: <20190211143600.15021-1-joel@joelfernandes.org> <20190215031926.ljzluy2cfxp64u6o@ast-mbp> <20190215034720.GA230433@google.com>
User-agent: mu4e 0.9.18; emacs 26.1
From:   Manoj <linux@manojrajarao.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, ast@kernel.org,
        atishp04@gmail.com, dancol@google.com,
        Dan Williams <dan.j.williams@intel.com>,
        gregkh@linuxfoundation.org, Jonathan Corbet <corbet@lwn.net>,
        karim.yaghmour@opersys.com, Kees Cook <keescook@chromium.org>,
        kernel-team@android.com, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Manoj Rao <linux@manojrajarao.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        paulmck@linux.vnet.ibm.com,
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
        rdunlap@infradead.org, rostedt@goodmis.org,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, yhs@fb.com
Subject: Re: [PATCH v2 1/2] Provide in-kernel headers for making it easy to extend the kernel
In-reply-to: <20190215034720.GA230433@google.com>
Date:   Sat, 16 Feb 2019 11:10:14 -0800
Message-ID: <8736on1re1.fsf@manojrajarao.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Joel Fernandes writes:

> On Thu, Feb 14, 2019 at 07:19:29PM -0800, Alexei Starovoitov wrote:
>> On Mon, Feb 11, 2019 at 09:35:59AM -0500, Joel Fernandes (Google) wrote:
>> > Introduce in-kernel headers and other artifacts which are made available
>> > as an archive through proc (/proc/kheaders.txz file). This archive makes
>> > it possible to build kernel modules, run eBPF programs, and other
>> > tracing programs that need to extend the kernel for tracing purposes
>> > without any dependency on the file system having headers and build
>> > artifacts.
>> > 
>> > On Android and embedded systems, it is common to switch kernels but not
>> > have kernel headers available on the file system. Raw kernel headers
>> > also cannot be copied into the filesystem like they can be on other
>> > distros, due to licensing and other issues. There's no linux-headers
>> > package on Android. Further once a different kernel is booted, any
>> > headers stored on the file system will no longer be useful. By storing
>> > the headers as a compressed archive within the kernel, we can avoid these
>> > issues that have been a hindrance for a long time.
>> 
>> The set looks good to me and since the main use case is building bpf progs
>> I can route it via bpf-next tree if there are no objections.
>> Masahiro, could you please ack it?
>> 
>
> Yes, eBPF is one of the usecases. After this, I am also planning to send
> patches to BCC so that it can use this feature when compiling C to eBPF.
>

Tested-by: Manoj Rao <linux@manojrajarao.com>

I think this can definitely make it easier to use eBPF on
Android. Thanks for initiating this.

> Thanks!
>
>  - Joel


-- 
Manoj
http://www.mycpu.org
