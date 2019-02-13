Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C1AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 029B5218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=opersys-com.20150623.gappssmtp.com header.i=@opersys-com.20150623.gappssmtp.com header.b="XrjhqvAS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404304AbfBMWuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 17:50:15 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35827 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730560AbfBMWuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 17:50:15 -0500
Received: by mail-qt1-f194.google.com with SMTP id p48so4718201qtk.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 14:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=opersys-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=876lWphbsxP4xAMtmnbDcEkFfg0qKgoTXqyTwzzagIU=;
        b=XrjhqvASFrVKmiqZk7sOFHUF7I/3BDq5GEkoxMoikC7eHs75vtU3RAEHNBqWNpDLcB
         85lBEgNOXU/J5HRBslvy/KcSHWnONNlQNhwhAksUvnN87crjaaSmgzdTY42RzEpNwhbd
         Ov4PK3yqP8OPCp0Lr/b9Eibrxu1as+br7jH8xD6il6KKVePwI03khUNjXKEPowFemUhm
         VFU1yxxOcTmzrrP6Ywe+MgSo9xVsdKvhNRgx+4AsRwbaZWDKSCqBs9sN4JVvdFN80Nt8
         xTORa4ut6mfmHv763tKKK+OZiyapJY77HTbgTBoxrXmJ88/0Dj2Z4Rr7mYvlRisbIhrM
         JIoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=876lWphbsxP4xAMtmnbDcEkFfg0qKgoTXqyTwzzagIU=;
        b=iMzPXhNXUXSXzPEfJSxzV23nJZpXXjJQwsrGq3lHYOk30cwIxDeyXjInZ+5ikHyYIY
         Z4jWiau5gV8C+xCjqG7y6FrpK24xnJrJSdntzEZaVCp5XyDHMZFSiMCL/QuMidiJoAfA
         OBp/RvXjh3QMu+g/lwpNZgO8MN/URfXtcfVPezUVDgwQIBpJEHytP6BjCiuvhrUc/8Zx
         dqcLJQrDeeBtZfWdUhV8YcTIC/yMZSYdyTK6Nl9ccYHIuyspfF/bqEOTZkSPGj4SG8zq
         OiiUnMGmtLktrIA1lyLcc4uNSIn83HGWyZsI2PWgsQ3hUj57eWodoYhxpqnRRRrN/2FU
         FIJQ==
X-Gm-Message-State: AHQUAubUp/BBw1CghCRJLqrCYhooRQSrbtkQiFqIWvkUYQnPm75kNsOe
        nDep2RQGpgS8KSS1+21C3QqbxQ==
X-Google-Smtp-Source: AHgI3IYSi+vYRWpJBkv/89G2267qmoOOtNbwDomi2zgUIy4ifLEHjEgysSrqJGJPdws9hgVv3JQnaA==
X-Received: by 2002:ac8:3fa1:: with SMTP id d30mr451389qtk.217.1550098213753;
        Wed, 13 Feb 2019 14:50:13 -0800 (PST)
Received: from [192.168.202.103] (modemcable170.15-70-69.static.videotron.ca. [69.70.15.170])
        by smtp.googlemail.com with ESMTPSA id 97sm264352qtc.83.2019.02.13.14.50.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 14:50:12 -0800 (PST)
Subject: Re: [PATCH v2 1/2] Provide in-kernel headers for making it easy to
 extend the kernel
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, ast@kernel.org,
        atishp04@gmail.com, dancol@google.com,
        Dan Williams <dan.j.williams@intel.com>,
        gregkh@linuxfoundation.org, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Manoj Rao <linux@manojrajarao.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        paulmck@linux.vnet.ibm.com,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        rdunlap@infradead.org, rostedt@goodmis.org,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, yhs@fb.com
References: <20190211143600.15021-1-joel@joelfernandes.org>
From:   Karim Yaghmour <karim.yaghmour@opersys.com>
Message-ID: <c035159d-3a56-61d8-bad6-79401b25a227@opersys.com>
Date:   Wed, 13 Feb 2019 17:50:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190211143600.15021-1-joel@joelfernandes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/11/19 9:35 AM, Joel Fernandes (Google) wrote:
> Introduce in-kernel headers and other artifacts which are made available
> as an archive through proc (/proc/kheaders.txz file). This archive makes
> it possible to build kernel modules, run eBPF programs, and other
> tracing programs that need to extend the kernel for tracing purposes
> without any dependency on the file system having headers and build
> artifacts.
> 
> On Android and embedded systems, it is common to switch kernels but not
> have kernel headers available on the file system. Raw kernel headers
> also cannot be copied into the filesystem like they can be on other
> distros, due to licensing and other issues. There's no linux-headers
> package on Android. Further once a different kernel is booted, any
> headers stored on the file system will no longer be useful. By storing
> the headers as a compressed archive within the kernel, we can avoid these
> issues that have been a hindrance for a long time.
> 
> The feature is also buildable as a module just in case the user desires
> it not being part of the kernel image. This makes it possible to load
> and unload the headers on demand. A tracing program, or a kernel module
> builder can load the module, do its operations, and then unload the
> module to save kernel memory. The total memory needed is 3.8MB.
> 
> The code to read the headers is based on /proc/config.gz code and uses
> the same technique to embed the headers.
> 
> To build a module, the below steps have been tested on an x86 machine:
> modprobe kheaders
> rm -rf $HOME/headers
> mkdir -p $HOME/headers
> tar -xvf /proc/kheaders.txz -C $HOME/headers >/dev/null
> cd my-kernel-module
> make -C $HOME/headers M=$(pwd) modules
> rmmod kheaders
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Acked-by: Karim Yaghmour <karim.yaghmour@opersys.com>

> ---
> 
> Changes since v1:
> - removed IKH_EXTRA variable, not needed (Masahiro Yamada)
> - small fix ups to selftest
>     - added target to main Makefile etc
>     - added MODULE_LICENSE to test module
>     - made selftest more quiet
> 
> Changes since RFC:
> Both changes bring size down to 3.8MB:
> - use xz for compression
> - strip comments except SPDX lines
> - Call out the module name in Kconfig
> - Also added selftests in second patch to ensure headers are always
> working.
> 
>   Documentation/dontdiff    |  1 +
>   init/Kconfig              | 11 ++++++
>   kernel/.gitignore         |  2 ++
>   kernel/Makefile           | 27 ++++++++++++++
>   kernel/kheaders.c         | 74 +++++++++++++++++++++++++++++++++++++++
>   scripts/gen_ikh_data.sh   | 19 ++++++++++
>   scripts/strip-comments.pl |  8 +++++
>   7 files changed, 142 insertions(+)
>   create mode 100644 kernel/kheaders.c
>   create mode 100755 scripts/gen_ikh_data.sh
>   create mode 100755 scripts/strip-comments.pl

[snip]

-- 
Karim Yaghmour
CEO - Opersys inc. / www.opersys.com
http://twitter.com/karimyaghmour
