Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB39C00449
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 00:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D1DF21473
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 00:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncdYN+Kb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D1DF21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbeJFHXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 03:23:30 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40864 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbeJFHXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 03:23:30 -0400
Received: by mail-pg1-f196.google.com with SMTP id n31-v6so5388049pgm.7;
        Fri, 05 Oct 2018 17:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=x9eQrkMyrWPMhICe83T2cY5IxAr+/4HTRZP+n1VAv6M=;
        b=ncdYN+KbfXozQv/DTKcJqLztFeqezO+uUaKCmewj2jNKoGU2UOPLBGYdxJbswsgRKf
         ODf9E4MGYZ0A25IMhW+1hiUiiUEYCXBllbTByN6YgTHhBayQB8VUKcWOI0Ox1C3i1kXp
         J1ChzwANW957jzYcaiKpE1xIP+Z1A2nUSBStySAHSgAnhoJpT7yAq3VH760TSE26gzJY
         4xtsV0NZtwskQDuAZ48SCU+Z/bzW2i9SutcRD7PfwridgcrM7AxeVoS/4Co0ZQpk+AVX
         blRlEvipTaTf7WFjqSKxaBEE2rqPsRjjSGr0Tyh9jUU3ExEsZjmMa3dSk4liKYwDWzyh
         veaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=x9eQrkMyrWPMhICe83T2cY5IxAr+/4HTRZP+n1VAv6M=;
        b=E/yKUWwZSXU/T9Ncs+9itN+rdTEZS03bUqguodtAbKeQqEYSBtF/Vntt9/hHytuG4C
         JX7yLKvEIyScVrstB15wBJA1XLobIt0RXwTMn9sM0T8smI8cDZpExoO/OXSh2PEksSfF
         FqkOmDJ/QuKNsI2Bp+2jXspDZqPMxXuBsmbX4Thoppzvbji/p0spgV7GqqWZuaIZJpIg
         4T9q8SZ9IEb+/voyGWLlJVdAPOlt9bsK618qtYWjcZGyrSRlaXH8N0MPZlKB02SHkGvb
         e/imDeWOuahKOHBy9cAhL+C29G28FCre88N4vup5vmtrlpPO+9ZUG2nFR5eThMuvrwce
         Y3ig==
X-Gm-Message-State: ABuFfoi+t0B+XkmgVs1rQUwEbh+SQVtxxk1Vy0V/8/5uJvrWO4sS6GGh
        Vd5/FIO2LTABtHiXMHK5dmI=
X-Google-Smtp-Source: ACcGV63lAKg87tm3mg3fRB1yFqfhei49tA/wOajFsDaMqJ7otBOzUevOxIgnrGRHvoA3aXVAZBKwKw==
X-Received: by 2002:a63:d34f:: with SMTP id u15-v6mr12197329pgi.325.1538785343248;
        Fri, 05 Oct 2018 17:22:23 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::4:fc91])
        by smtp.gmail.com with ESMTPSA id h19-v6sm16084779pfk.71.2018.10.05.17.22.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 17:22:22 -0700 (PDT)
Date:   Fri, 5 Oct 2018 17:22:20 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 1/6] bpf: introduce BPF_PROG_TYPE_FILE_FILTER
Message-ID: <20181006002218.amfazxko4sq32hu6@ast-mbp.dhcp.thefacebook.com>
References: <20181004025750.498303-1-ast@kernel.org>
 <20181004025750.498303-2-ast@kernel.org>
 <20181005044659.GU32577@ZenIV.linux.org.uk>
 <20181005220518.747ri4q34obrnaoc@ast-mbp.dhcp.thefacebook.com>
 <CALCETrVURVaqJChL=RwZPe74+JfX-6Zzp9kLR9-mLiownSOexQ@mail.gmail.com>
 <20181005222752.l5da54rpww6tlyfy@ast-mbp.dhcp.thefacebook.com>
 <20181005234706.GX32577@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181005234706.GX32577@ZenIV.linux.org.uk>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 06, 2018 at 12:47:06AM +0100, Al Viro wrote:
> 
> And no, it's not that each of those filesystems does not use inode->i_ino at all.
> There's a bunch of library helpers in fs/*.c that happen to use the value filesystem
> has seen fit to store there.  Whether to use those helpers or not, what to store in
> that field, etc. is, again, entirely up to the filesystem in question.
> generic_fillattr() is one of those, that's all there is to it.

makes sense.

> That's precisely why I really do not like the idea of hooks poking in the internals
> of kernel data structures.  Especially since not even "it's not visible outside of
> a subsystem-internal header" appears to slow you down.

that's why there is a code review to get the patches in shape that
don't expose kernel internals by _accident_.

> The same goes for tracepoints, etc. - turning random details of implementation into
> a carved in stone ABI is actively harmful.

we're not talking about tracepoints here.

> PS: If anything, visibility to hooks should be opt-in.

not sure how do you expect 'opt-in' to be imlemented.
As far as exposing inode and dev I agree that was a wrong approach.
Going to switch to struct file_handle instead.
Doing statx for every file_open is probably too slow for practical use.

> Sure, we can start actively hiding
> the things, but that's a winless arms race  - even if we bloody went and encrypted the
> private stuff, you'd still be able to pull decryption key from where it would be accessed
> by legitimate users, etc.  Нахуй нам это надо?

why do this ?
the use cases are explained in commit log.

Back to internals exposure.
Do you see an issue in the following:
struct bpf_file_info {
        __u32 fs_magic; // file->f_inode->i_sb->s_magic
        __u32 mnt_id;   // real_mount(file->f_path.mnt)->mnt_id
        __u32 nlink;    // file->f_inode->i_nlink
        __u32 mode;     // file->f_inode->i_mode
        __u32 flags;    // file->f_flags
};
and separate helper that returns struct file_handle ?
and ctx rewriting moved to fs/bpf_file_filter.c ?

