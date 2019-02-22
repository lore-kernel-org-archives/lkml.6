Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE25C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDAA52070B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWj9fvTq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfBVT1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 14:27:09 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41418 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfBVT1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 14:27:08 -0500
Received: by mail-pf1-f194.google.com with SMTP id d25so1536531pfn.8;
        Fri, 22 Feb 2019 11:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nDHebHk2FC9eL64ZE7wNCWO/8mfhIQQ7cEirqiHiwl4=;
        b=RWj9fvTqifjlVod1DoeN8yqfePcxUKvomRdwyx95mvQxdPQ5r4SraA/ZyTNtK1FpaH
         EIQOx7D9DGq/vdoIyMYxtN+VSxZyYB3MKRmRvzjPh5DnH5SKo6j/okNYT1RQyR7FlS0Y
         utH9J6WeyBA8lrWVhVII8WG0XUZzHKklXDtwniOuQtipMnvTgLz6MouTc5qHIrK1wsZC
         zOuJg0f/VHYEdSFYmHZzU/nwGY806tnX0WFV2rMprtvuTFGPTrOnkT9GvPfBWOHiUM1T
         3Q8PSCBsSugmZjcSxa/9K9Ag2VxMnH50CpUuVaH5jXrIdtoGDO8b17CzIGlQxgfV7OEu
         U/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nDHebHk2FC9eL64ZE7wNCWO/8mfhIQQ7cEirqiHiwl4=;
        b=tP3Y0wdEAXHDEL5C5zLXx16Mv470MUFJ8h7FxVkL4ehOnbuoyKS1Yb2OJzkd0+RwYl
         1G/5Ihjf6LZBNxVADTjtp9KCnhDY9bT5kObjsQ1jba8fjC59aBjv88mqoKOu8+YC0iyi
         FZ8MjcOUUra46UHDro9OoJG9WwhhxaOtZec6VeZofPIS12MHfG5eWvHIE1ELktttyCX9
         mIJFEbtydMFNV9SfZrhohSfty8FXKyUSJEwc8b3vEe2OdNHvoHOsnGyZpVla4Bj9UHec
         DCvIwDh/MB6X8c0dpraJQUVNoAFWXtdDBSu/RYOx7eRLhuzCglHyjU6CGJKBl6pwyNSD
         KqBA==
X-Gm-Message-State: AHQUAuYa6A1aB5lxaOsCgTe8FqtDsJdLrPow0S6rTpBFs3MdytM7YcjX
        5lZlFFn5CmyqE2+9D2eQJJg=
X-Google-Smtp-Source: AHgI3IYDAFz3KSagVk467uzqYpf9Q7FvboS4Iq8CaDA5sX/ugTU8fu1JNoLWBGBgLnxl36oOa6uRjw==
X-Received: by 2002:a63:6a48:: with SMTP id f69mr5372116pgc.7.1550863627877;
        Fri, 22 Feb 2019 11:27:07 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::4:1d52])
        by smtp.gmail.com with ESMTPSA id t10sm4813299pfa.151.2019.02.22.11.27.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 11:27:07 -0800 (PST)
Date:   Fri, 22 Feb 2019 11:27:05 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>, daniel@iogearbox.net,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 1/2 v2] kprobe: Do not use uaccess functions to access
 kernel memory that can fault
Message-ID: <20190222192703.epvgxghwybte7gxs@ast-mbp.dhcp.thefacebook.com>
References: <CAHk-=wgJzNp0R3cVhjBPHTR4X9sOvHdqK4UVFfbsOKQ6L=A_eQ@mail.gmail.com>
 <CAHk-=wh9XrOykA5J9RQ7zaBio-S_D+1AE+rGnBYWSd==pCXh+w@mail.gmail.com>
 <20190219111802.1d6dbaa3@gandalf.local.home>
 <CAHk-=wgTuK3kAduP-gr10vykT1uG=B2VpdffvmyBuTQ1UxPpMg@mail.gmail.com>
 <20190219140330.5dd9e876@gandalf.local.home>
 <20190220171019.5e81a4946b56982f324f7c45@kernel.org>
 <20190220094926.0ab575b3@gandalf.local.home>
 <20190222172745.2c7205d62003c0a858e33278@kernel.org>
 <20190222173509.88489b7c5d1bf0e2ec2382ee@kernel.org>
 <CAHk-=whNf_n1WXWW+ugAVeL5ZK0GcEP3cTYocju1nS85VtMjjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whNf_n1WXWW+ugAVeL5ZK0GcEP3cTYocju1nS85VtMjjQ@mail.gmail.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 09:43:14AM -0800, Linus Torvalds wrote:
> 
> Then we should still probably fix up "__probe_kernel_read()" to not
> allow user accesses. The easiest way to do that is actually likely to
> use the "unsafe_get_user()" functions *without* doing a
> uaccess_begin(), which will mean that modern CPU's will simply fault
> on a kernel access to user space.

On bpf side the bpf_probe_read() helper just calls probe_kernel_read()
and users pass both user and kernel addresses into it and expect
that the helper will actually try to read from that address.

If __probe_kernel_read will suddenly start failing on all user addresses
it will break the expectations.
How do we solve it in bpf_probe_read?
Call probe_kernel_read and if that fails call unsafe_get_user byte-by-byte
in the loop?
That's doable, but people already complain that bpf_probe_read() is slow
and shows up in their perf report.

