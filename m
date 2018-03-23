Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-69660-1521773300-2-5922729004117306109
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
    t=1521773299; b=fVtTRWzlsfTN6jlsq1F1Vhi0Mp+q9dxmkph7bgZWaNKtXC+
    h1RDsjqGNc8AIR703i3IrC8WT+ZNhd9sLbv3n4fvqKaKUtIhbrlEZT6TvdAG4PBx
    54WtMyyj5+edO3xr1uUadGUoFvf1djFbwjiIwp3aOxAc1KQgWfiLs8EIlBdz5yAf
    /w+T+rtGOcLbV6AKML19JERF88nLB2vpn/TPioZMxHRlDq04kMhszG9MudKOGFdE
    cEfo8fMsjJLi+d+W0XRB0/8otrzuKmQl4o2nIeCdLg9KqeJJLwweEkasVzK+uPZr
    bYAU8+55QTDYy+wIekRT9YakJaWQ6ZF37DCJ+ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1521773299; bh=xcbjubIbhjDtVnY95OPfgnbTgKtdknHU0pHnOc
    zLjBE=; b=tcq/orr6BHRq60Z+NG7uDaHa27xBbZZ6to/O0GuHVJRookfopZdAAm
    G3LjSwtYGoAC0DfM6AXbfTvjOFwRDXix5Br+EJJyV/kN18oDrWQOevDOG1eYMhif
    41EPL39pwb+irN4Uf2ao0SoBYWrN7UBoB+4MxWjaUCNreYapI5e1aPXOzVy6C++M
    Lzex2Pp8a7UdnEXky6U5MK5cCxg2Y5ke/SOY67MD75C/ewobvhB/UoWmtiW9kger
    mH+54eUaLHR8foMeJomVwBGFp7NVhnWQJXeTufKLmvKgGKITd18p/dlS5IYZA+Zp
    43cO7Bf9IPhG20p/qiTIZXCULIgMfg6Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751748AbeCWCsR (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Mar 2018 22:48:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:48994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751692AbeCWCsQ (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 22 Mar 2018 22:48:16 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A6F221841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mcgrof@kernel.org
X-Google-Smtp-Source: AG47ELuIHWvVCSYzDGpm8pzN0fYHfnXnZhHHDzICuIAYBn0rnUHWYRkhtYbQtlsPaQfyQTckmXmG8CsIYWKJ4LpTeok=
MIME-Version: 1.0
In-Reply-To: <CALCETrWFhTurv0gwxRcdLn4CD-1ySE=v4ZgvbsUYJqruZNMptQ@mail.gmail.com>
References: <CA+55aFwfcXzD+pzjN=vTcvscpK97pSztUZ2JK7pABs+rMtM7BQ@mail.gmail.com>
 <E459E6CC-F51B-4F2A-9D26-FFB7166E0A47@amacapital.net> <CA+55aFx7w1s7=5HzeczPkkksaU4oVsWQf+_c=aHS0O7i_9g+Kg@mail.gmail.com>
 <20180309.135724.452219538059491199.davem@davemloft.net> <CA+55aFyN8JDh76bm1VinBvrgMH5jNL6RbuFAkrH8vuYU1s9GDQ@mail.gmail.com>
 <CA+55aFx-kDp87_uv9TW5pYD2+nr8c65=ervvwcxhTBJVg7c_pQ@mail.gmail.com>
 <81b7599d-aab7-6cb6-7843-64510c8f6260@fb.com> <20180310140843.GP4449@wotan.suse.de>
 <20180310151652.GV4449@wotan.suse.de> <20180322205413.GA30543@wotan.suse.de> <CALCETrWFhTurv0gwxRcdLn4CD-1ySE=v4ZgvbsUYJqruZNMptQ@mail.gmail.com>
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Date: Thu, 22 Mar 2018 19:47:54 -0700
X-Gmail-Original-Message-ID: <CAB=NE6WafpqDGZhfUwrT_ng_fsR2_itNxv2AXGHzsMmqfj5Yyg@mail.gmail.com>
Message-ID: <CAB=NE6WafpqDGZhfUwrT_ng_fsR2_itNxv2AXGHzsMmqfj5Yyg@mail.gmail.com>
Subject: Re: [PATCH net-next] modules: allow modprobe load regular elf binaries
To: Andy Lutomirski <luto@kernel.org>
Cc: Alexei Starovoitov <ast@fb.com>, Jessica Yu <jeyu@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        David Miller <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Network Development <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>,
        Linux API <linux-api@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hannes Reinecke <hare@suse.com>, werner@suse.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 22, 2018 at 3:15 PM, Andy Lutomirski <luto@kernel.org> wrote:
>  All we need to do is to make sure that, if this is
> distributed as a module, that it's init routine doesn't wait for a
> long time, right?

Yeap.

 Luis
