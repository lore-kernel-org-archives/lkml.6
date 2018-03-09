Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3342454-1520558738-2-15556014991270222110
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520558738; b=RgmlvhVY1ACfmY/z5wGtVRya/KG9liUMKimYoyIUCryRuoV
    3nG8Oht+x9HyXZ0/UfcQ08mofUsQE3GFM4sBF2xobzNdicoqwUo1BVZGM4gkXSjv
    aE/h1jGg0eqqqZLkUOE8YuFuc/KH2Fm5R/yjYPnyCIui4pzCXRHxpw4gXpFekhI2
    HOKtTRibtUmnCidF42lbQj8FQH4nZfwcGEDQqKZ3SLgXvJvE5yVJdaM5PQkHXwOk
    domBr12oFM3aEQomLVweZBljPimsCM2CCIVe0tp2AtRjwObJgccNuMUb1mxf/y7V
    ditZ08OPVTaxog1kXmjG7Ze1hvWgP4lG3lG3tjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520558738; bh=MQF+tSooyBcTNwR8IsR4nNj70/
    c+/3tNgMBYnm8zVQc=; b=GrJV3/QNlPMoQsiPo3YhwIaY7/hXzIM6csvQKHd5en
    g6Xi4XmI2cMmLD2bn8TCWZ/y9VR/TsHX+VDuuWr7719eqmai9bXeQ7AUJ7D2PaYx
    kLsAUzPUvfzn9rDFwFQY+uNANxgmWpRr/VfK5Xp3BJoLBCUvi1MWcPTuUmRHI5Sh
    3JYsKXcleTCs0vlMAzQGhJd49TVmUr/10yds3DZH0OKSS4TfIorAyHD4OvvmOJR+
    ICXQhBCGqBLqTRwYhrN2xNyCzK6P85SJ4cjOColxSBqEzO0oBJy6EAOgtlNVAI+E
    ga+QOvY/EyJC3XFUpWyTQSX5W7/UnAfxwNsFPhyyjNEg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=OU7yfsVR x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=SPYmfxfM;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=OU7yfsVR x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=SPYmfxfM;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751306AbeCIBZh (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 20:25:37 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:36936 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751212AbeCIBZg (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 8 Mar 2018 20:25:36 -0500
X-Google-Smtp-Source: AG47ELvrN3tvI9BsaVWgy/0EtbMQLwi920DHLeftLPz+x/xQ9k8o56vfWq4ZqW7Ffbv7a+WMXEQZ7A==
Date: Thu, 8 Mar 2018 17:25:32 -0800
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Alexei Starovoitov <ast@fb.com>, Kees Cook <keescook@chromium.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Djalal Harouni <tixxdz@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@fb.com,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH net-next] modules: allow modprobe load regular elf
 binaries
Message-ID: <20180309012530.rk2m5kmpab7eb5fe@ast-mbp>
References: <20180306013457.1955486-1-ast@kernel.org>
 <CAGXu5j+Q=S5sw9N5avyByxi2ekM6povT5Tajjhdb6D9g9ggKxQ@mail.gmail.com>
 <357c330f-0165-b7a4-7ecc-4cd797e61e15@fb.com>
 <CALCETrVUOToH5WnZMdpk+Vt=NK5OuE=ha62sj7cN5Hw5=qrgRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVUOToH5WnZMdpk+Vt=NK5OuE=ha62sj7cN5Hw5=qrgRw@mail.gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 09, 2018 at 01:04:39AM +0000, Andy Lutomirski wrote:
> On Fri, Mar 9, 2018 at 12:57 AM, Alexei Starovoitov <ast@fb.com> wrote:
> > On 3/8/18 4:24 PM, Kees Cook wrote:
> >>
> >> As Andy asked earlier, why not DYN too to catch PIE executables? Seems
> >> like forcing the userspace helper to be non-PIE would defeat some of
> >> the userspace defenses in use in most distros.
> >
> >
> > because we don't add features without concrete users.
> 
> I disagree here.  If you're going to add a magic trick that triggers
> an execve(), then I think you should either support *both* standard,
> widely-used types of ELF programs or you should give a compelling use
> case that works for ET_EXEC but not for ET_DYN.  Keep in mind that
> many distros have a very strong preference for ET_DYN.

misunderstanding here is that this bpfiler.ko is part of _kernel build_.
Kernel decides how it's build.
Nothing to do with distros.
Current Makefile is very dumb and it's built with HOSTCC:
https://git.kernel.org/pub/scm/linux/kernel/git/ast/bpf.git/tree/net/bpfilter/Makefile?h=ipt_bpf
but it will be standalone with CC before final to make sure crosscompiling works.

