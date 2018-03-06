Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1192132-1520366526-2-12338256617256803838
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520366525; b=dvIMPh8N858eovh1sAhVUB1XQp1YZGzmLTTHAWe6po6eJ1r
    vXjdCzfDzdL1jFy/6qad/kkMbQnmRx28b1nrWg3ZoOdQVpf6X/B/LvlDffb9ve9T
    CuL5rnmU5lkmw8S2W2DiRqQJNGeupm/rXHkSzClDL7FIjLAyMXldNvoh52gxCOrp
    trbM8NqzFJBcVctnIYvxSXP+D31vHev/TeI+oBKr42VSe9iN8v4M0kNyMwqq8yF1
    fQvg2dYiZjGdtwWITP2lEYQxXW4U3tyNGAxlf5laSKQLgkoiNKCHjmKVZYR5uOUf
    bM2ubsF87anmw+QF7OThJ35156T3DmvAlVdr+Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520366525; bh=9ND9IhQAXk+4+u7YK2YKSv8SxfN5ZB3+aUf7pp
    8hP2A=; b=H9lZfmzHknXD5jc+Gn3dmGA7744vNUTjrZZZJ2Oe8kfxesrKUU7epw
    WUNNlj1yLOWsSeqSi8bZpX7JYeWjsLGONNLlcTEOqdWCLk0XBQDLeE1s11Xmq+fE
    94O1NTHbiFQ8whVM4ciVL23OQ0L2NkFxFP+IkY3HcuuBhh+ZRC6I8gsKwLX5uLEq
    dBwm2WRlCMIjdEGas6pnhzovdRsAaBLmsNXG5kXtXmO0pBaQD26R5FXd24UoSqFX
    mA64JpavAkZTgT8ZYZRLK0EjIdHgSPX1fCavsb57Pq8r93CTYo6v4zBMOzxpkaXb
    nxTlB2XHI/u3Xu4uuxO9Zn2fp9QExp4Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753868AbeCFUBo (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Mar 2018 15:01:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:54694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750797AbeCFUBn (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 6 Mar 2018 15:01:43 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 083D22178B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AG47ELvYdrhWPCXa6m+O0pF29lzE1BB8s9sjv0+K+UJcMHuLC76+vUs7wYFC8VS9Loag3VHx0s0P+y3hBGDxeiNqd64=
MIME-Version: 1.0
In-Reply-To: <20180306013457.1955486-1-ast@kernel.org>
References: <20180306013457.1955486-1-ast@kernel.org>
From: Andy Lutomirski <luto@kernel.org>
Date: Tue, 6 Mar 2018 20:01:21 +0000
X-Gmail-Original-Message-ID: <CALCETrVO6dc6Fzf2VPjLF1Z+YHU=di_fh53+EhcRqt3V+wQDuA@mail.gmail.com>
Message-ID: <CALCETrVO6dc6Fzf2VPjLF1Z+YHU=di_fh53+EhcRqt3V+wQDuA@mail.gmail.com>
Subject: Re: [PATCH net-next] modules: allow modprobe load regular elf binaries
To: Alexei Starovoitov <ast@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@fb.com,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 6, 2018 at 1:34 AM, Alexei Starovoitov <ast@kernel.org> wrote:
> As the first step in development of bpfilter project [1] the request_module()
> code is extended to allow user mode helpers to be invoked. Idea is that
> user mode helpers are built as part of the kernel build and installed as
> traditional kernel modules with .ko file extension into distro specified
> location, such that from a distribution point of view, they are no different
> than regular kernel modules. Thus, allow request_module() logic to load such
> user mode helper (umh) modules via:
>
>   request_module("foo") ->
>     call_umh("modprobe foo") ->
>       sys_finit_module(FD of /lib/modules/.../foo.ko) ->
>         call_umh(struct file)
>

I assume I'm missing some context here, but why does this need to be
handled by the kernel rather than, say, a change to how modprobe
works?  I imagine that usermode tooling needs to change regardless
because the existing tools may get rather confused if a .ko "module"
is really a dynamically liked program.  I notice that you're using
ET_EXEC in your example, and that will probably avoid problems, but I
imagine that some distros would much rather use ET_DYN.
