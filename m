Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476CBC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 129BD2175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t29cHPz1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfBGQME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 11:12:04 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37082 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfBGQMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 11:12:03 -0500
Received: by mail-ed1-f67.google.com with SMTP id g4so332475eds.4;
        Thu, 07 Feb 2019 08:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6nxVUppBpENDxTwe0cb9oFIh38FqM9pqwgAM/5LCXF4=;
        b=t29cHPz1fcQXK2fKdPZLJ94j8pxbVIKTfbJNstO7/CgNFVfmyUL2fks7V9/lFlfcEU
         h/O6Pbf+3gz5jpYwZHVIviUAOKVGXZOq4Wj/xlxbGJ6IYbe6VUtVbCjlKXWNUFcl7uds
         WZYeJp8lSfbNulwo/4ymSJ4u13ZUnY4SHjGjG1/5DHmIlFfxyI0cHk/g1NBVfNRvt8nf
         NKu5/LyxR6Jk7t4lijKtR8sJ+Fa5ir7O9h6cxTwtUNH02u4ZbsQe1vS831fGt2gloL4R
         xtafXnwvwfScdDsdduBTMZQ3brKeJ5AjDodFDaa45oYK9H1MdwRvwCIhEsykkcbT6F0B
         VqeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6nxVUppBpENDxTwe0cb9oFIh38FqM9pqwgAM/5LCXF4=;
        b=f99Vf/kbReDKOk5laGUc1NA9XKi9IRrlVFmqGXiGVsRHgQoSRrr8EUvCHEALp7hH4E
         QzT42bJfOPcuhxKDCG4OdPKZaPJxWbnOqOOS/y/dC7aXDD9kM9YU8aSEj49iQrTX3zx/
         eke/tL8bHfqcCS0wR33JzBNr4QwaWEj4VLtBR4suXhARnZaVRGoZdWAUHy7Yomv+GST+
         N9ZHEUcuZdWtfjQWUnQRQgLe1lqToK4Zn6d8pCHZtEOogLIK5Ub1HZzPHjEQlNQAFQkC
         EsAaXRMLdc+8VIPhT7IUZ/17Iwg4y4Yfz1fIhfUykpwIJLYvuk8D247vLcT8dHoVon63
         Pu1w==
X-Gm-Message-State: AHQUAuZbBNdiboiPtvKRyewfIUHjibNokLDO5jXi40T1QTrwT04xRiea
        BxUvWHNvOfvkjQ5s7FF8OiilQ2m2rHE=
X-Google-Smtp-Source: AHgI3IZnNda4M/7xJsdRnOyiv4p5J2U6BWX+RC4+BPPePTKO/S1QICSllBqgeKnZu8s/rg6TDhlHlQ==
X-Received: by 2002:a17:906:3ed0:: with SMTP id d16mr2094204ejj.138.1549555921961;
        Thu, 07 Feb 2019 08:12:01 -0800 (PST)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id f12sm1239462edr.76.2019.02.07.08.12.00
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 08:12:01 -0800 (PST)
Subject: Re: [PATCH 16/32] x86/vdso: Generate vdso{,32}-timens.lds
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org
Cc:     Adrian Reber <adrian@lisas.de>, Andrei Vagin <avagin@openvz.org>,
        Andrei Vagin <avagin@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andy Tucker <agtucker@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
References: <20190206001107.16488-1-dima@arista.com>
 <20190206001107.16488-17-dima@arista.com>
 <a2bbe610-7553-0ba6-b58b-1013e034b8f6@rasmusvillemoes.dk>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Message-ID: <0ff2890b-b6f4-1fe6-bafb-1bdb7bd21d26@gmail.com>
Date:   Thu, 7 Feb 2019 16:11:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <a2bbe610-7553-0ba6-b58b-1013e034b8f6@rasmusvillemoes.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rasmus,

On 2/7/19 8:31 AM, Rasmus Villemoes wrote:
> These (14-19, if I'm reading them right) seems to add quite a lot of
> complexity and fragility to the build, and other architectures would
> probably have to add something similar to their vdso builds.
> 
> I'm wondering why not make the rule be that a timens takes effect on
> next execve?

I believe, it would make setns() syscall much tricker than wanted:
At this moment the only exception is pidns which changes ns of the child
and not the process-callee.
If exec() would be required to join timens - it may be a challenging
problem for container systems: in order to enter it one needs to
exec("/proc/self/exe") and add some new arguments/options.
Furthermore, it seems to me that to enter container with this semantics,
one needs to enter timens before entering mountns.

IOW, I believe, this would move complexity from kernel build time to
userspace ABI. And I guess, it would require much more logic to
re-create possibly nested namespaces hierarchy.

Rather I've considered using some kind of dynamic patching on vdso_init():
o static_branch - it would add some nops to !timens vdso
o something new like static_retpoline which would put RET over call to
  clk_to_ns(), shouldn't be a rocket since.

But in my point of view, if something can be done in compile time
instead of patching code dynamically - than it reduces the complexity
(lesser depends on what compiler/toolchain does).

Thanks,
          Dmitry
