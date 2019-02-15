Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93AD8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 03:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F02A21A80
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 03:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vNmOtYWy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388066AbfBODTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 22:19:36 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45214 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfBODTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 22:19:36 -0500
Received: by mail-pl1-f196.google.com with SMTP id r14so4205151pls.12;
        Thu, 14 Feb 2019 19:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FbnulF0jYkkLdvSRbeWLpsBAJiFxm/n1FMDU160K/J4=;
        b=vNmOtYWyWil7fBY++iqOIGnFec3KIbYkCb6gI2q9aA6nvrrt2DjXd5Qd5YzOAkHD8z
         OxNjEY5BGc+zXlXJiNyjyULA3CucOa8wh5PvYRKfdr8DM7COyc6OcwdV08JKZAMy0Zfu
         3AawsjGc+/ji+ZbkSQ81wOhQztqpNKssrQAauCw2nEf5SewqKvDAc/UZPCJWpec2CYb8
         ms5EfZnU3PwlnJxJhHGMip5Vqh4YIUvocuIJ6CyiPbqjZHlTS4wjrep/6ZISAtqsc768
         7sW7CpCf+y7RhqQAacb6PZHoqLxet/8DGCHlRkYqFl5Ja0YL0TJ5bq5tVcRLAEMhQmP9
         R60Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FbnulF0jYkkLdvSRbeWLpsBAJiFxm/n1FMDU160K/J4=;
        b=UU42gBsFWTejB9RcXrMRgTrcijSDZRSH5jXbqcBuutaW7uK5WGl1ojN7skfZxYOr78
         Cjr9wf1Mx8D0BOV0nQ9Ul1BjUTyyPjUzrxO50K1qTIeOUDr5BaFbcc6hG8Jz6sQLgA2B
         +ZmREPYlSWHdafp4CXQJcH/q3ys2zDfcqOhNHti52M1b5Tw03YGGGa/0XkZLH7Rzg8av
         vP8uzJ6Ux9LI8VLbqw23LczAurAefJFnYCFFmhZ6AqnqzRuOSIvlikH5Yo4dEry/zELU
         sa64vEzXR3J4Hesx0cdjT45FkfRWRSx8lzG7/KaaHqibuHR6FiSJxEPhP0pz9WYZl4Mf
         K67Q==
X-Gm-Message-State: AHQUAubI+j/myeCJcYyKxGZHMF1zXsllfeJqGhJYJdULUDJyYGXc7dzB
        DQpL1to/KkNpQFmhldXL5mX8w/FFUYo=
X-Google-Smtp-Source: AHgI3IaIUiSFmlQXmcQoDfl/viMUGBEdE1F49jS/kB2+TLe832J1EeKzLimXLiD7CLcjdh60fywzWg==
X-Received: by 2002:a17:902:758f:: with SMTP id j15mr7681037pll.170.1550200775392;
        Thu, 14 Feb 2019 19:19:35 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:180::1:b114])
        by smtp.gmail.com with ESMTPSA id x23sm9913931pfe.0.2019.02.14.19.19.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 19:19:34 -0800 (PST)
Date:   Thu, 14 Feb 2019 19:19:29 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
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
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        rdunlap@infradead.org, rostedt@goodmis.org,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, yhs@fb.com
Subject: Re: [PATCH v2 1/2] Provide in-kernel headers for making it easy to
 extend the kernel
Message-ID: <20190215031926.ljzluy2cfxp64u6o@ast-mbp>
References: <20190211143600.15021-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211143600.15021-1-joel@joelfernandes.org>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 09:35:59AM -0500, Joel Fernandes (Google) wrote:
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

The set looks good to me and since the main use case is building bpf progs
I can route it via bpf-next tree if there are no objections.
Masahiro, could you please ack it?

