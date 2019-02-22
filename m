Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC1CC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1B5F2075C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgqrZ+cf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbfBVX4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 18:56:24 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36289 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfBVX4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 18:56:24 -0500
Received: by mail-pg1-f196.google.com with SMTP id r124so1814371pgr.3;
        Fri, 22 Feb 2019 15:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mkg2VpjpwPJPr7Lg52Rm+42NYyTkxhC8oRjlcmQOnik=;
        b=RgqrZ+cfxb2vooNPNauODzGehh0Hb/Mbb2zmCFiJF+zujlkW8j+9jumAOXIC00lWC9
         S735CA+KGBf3FJLo1XagUv6+hWQU9rjMMzu/YLJVODUmRzTc+QD9lcmvROzHwDw3e5eL
         tgwiivEqu+f4Qr3FzeUuOM3ZXhY2Kjg801VwCEA9mf4lpDZFJDtfPVDB/hDOfBWDQweK
         h6AbojOSjCU9kcT49R9bx3QCgFuQN4Ka6TN2kDj76NN7YJZqnMLo8+Y9vH8A5MQTHEH8
         WFy8kGc24G9en/tVihZsVNf4RIBcQ4vDNupNysJ/K1CzoBqSCbDvfb4dRlPeoskvgOmk
         yWiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mkg2VpjpwPJPr7Lg52Rm+42NYyTkxhC8oRjlcmQOnik=;
        b=E+alhvREwW+hvH6vmkWi2Tt6NCLrTP2FUiKjYD82XLFqVMi//RFqxjGE7cqT7hRD9q
         8e3KgtfUlsF1IgdFGOaSTGP+0PqBP942L6SO9u+h98EjR8WujrZIZS/riTtArwjuclvg
         2gCxeeUqYkCQRqJJ8p4W6Pv8G9yAIfrSk6uq9L0fqqPLvX/moPkqou3rU023nbhkBJDb
         q0klTJRSAfg50PVIeKpWXNRSiY3zfqe8+DCeyRpM1xq45UtY4heVm+p3D3eR8E5rJJ7f
         Qh8L7fh6ZeKJYf8ucKhn9ihMQ6NCCnpsEwOVzDxPCyETe4BlEwXSo6t1kETLE24OKaXQ
         TZWQ==
X-Gm-Message-State: AHQUAubL9SigjLnYwyMGEjsmWMQ0V6gx0PhWI0Q2b1OVkW5aZFVTgyjS
        OkfDmudn2pSynrIBvP+nYZk=
X-Google-Smtp-Source: AHgI3IbJWNu5xeY2MzkYfmy+LlHQlnOsQVpWY5DifxPa3L7OOPGRgRLUZXCdH1/KmH79772uYkpIWA==
X-Received: by 2002:a63:2bc4:: with SMTP id r187mr6384261pgr.306.1550879782631;
        Fri, 22 Feb 2019 15:56:22 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::4:1d52])
        by smtp.gmail.com with ESMTPSA id g3sm3507364pfo.125.2019.02.22.15.56.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 15:56:21 -0800 (PST)
Date:   Fri, 22 Feb 2019 15:56:20 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Miller <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org
Subject: Re: [PATCH 1/2 v2] kprobe: Do not use uaccess functions to access
 kernel memory that can fault
Message-ID: <20190222235618.dxewmv5dukltaoxl@ast-mbp.dhcp.thefacebook.com>
References: <CAHk-=whNf_n1WXWW+ugAVeL5ZK0GcEP3cTYocju1nS85VtMjjQ@mail.gmail.com>
 <20190222192703.epvgxghwybte7gxs@ast-mbp.dhcp.thefacebook.com>
 <CAHk-=wib9VSbwbS+N82ZPNtvt4vrvYyHyQduhFimX8nyjCyZyA@mail.gmail.com>
 <20190222.133842.1637029078039923178.davem@davemloft.net>
 <CAHk-=wh9uWJaih5i6qBPer5rzcs=A+yb_ejU093b1esAhoFveQ@mail.gmail.com>
 <20190222225103.o5rr5zr4fq77jdg4@ast-mbp.dhcp.thefacebook.com>
 <CAHk-=wjJqVXydQf_dprBmr=zXsyNVrB9mBCmDL0nGmH_b0vY5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjJqVXydQf_dprBmr=zXsyNVrB9mBCmDL0nGmH_b0vY5g@mail.gmail.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 03:16:35PM -0800, Linus Torvalds wrote:
> 
> So a kernel pointer value of 0x12345678 could be a value kernel
> pointer pointing to some random kmalloc'ed kernel memory, and a user
> pointer value of 0x12345678 could be a valid _user_ pointer pointing
> to some user mapping.
> 
> See?
> 
> If you access a user pointer, you need to use a user accessor function
> (eg "get_user()"), while if you access a kernel pointer you need to
> just dereference it directly (unless you can't trust it, in which case
> you need to use a _different_ accessor function).

that was clear already.
Reading 0x12345678 via probe_kernel_read can return valid value
and via get_user() can return another valid value on _some_ architectures.

> The fact that user and kernel pointers happen to be distinct on x86-64
> (right now) is just a random implementation detail.

yes and my point that people already rely on this implementation detail.
Say we implement 
int bpf_probe_read(void *val, void *unsafe_ptr)
{
  if (probe_kernel_read(val, unsafe_ptr) == OK) {
     return 0;
  } else (get_user(val, unsafe_ptr) == OK) {
     return 0;
  } else {
     *val = 0;
     return -EFAULT;
  }
}
It will preserve existing bpf_probe_read() behavior on x86.
If x86 implementation changes tomorrow then progs that read user
addresses may start failing randomly because first probe_kernel_read()
will be returning random values from kernel memory and that's no good,
but at least we won't be breaking them today, so we have time to
introduce bpf_user_read and bpf_kernel_read and folks have time to adopt them.

Imo that's much better than making current bpf_probe_read() fail
on user addresses today and not providing a non disruptive path forward.

