Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1225332-1518821458-2-17339627717838097351
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518821458; b=uaJ/fnAuOy3nFsM8epTlQ9Sn9D6QWnLpJ/reRjo9eFErc/I
    7p8qRdIwBsQl2Wt5YbBLNWeCRzniHi6HACeKADsS5l4gS0bKOp49++BkK/maXL7v
    IfbPfMH8CRJa6eVCjZbuEFgNEJeIEvlOd2f8Y93Fyajy/DU8Ldzb9TULwY/n/7WM
    t/nk20GxHPmOX9Ndf1bC4zR4MvgrRIa8XmRl6g5ab13uBtds7ym8mL2TccaNTb9q
    JFY/zwqyTg9rhdrGy2PpXZgoIff0benVutPgD3rlZ3kyMYsaP25M7+Fa60CPHa7n
    8/Uchy8w+7QAi3D8vF7KZ7gIL1UODCnYlbqBFXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518821458; bh=42DxU1+33FZK85clJ2J0bRhOdqYFbRfJXfYMnJZ+cbg=; b=G
    u6P07IAYWe+h2JhbPguZGbP1PTvsBhALp4l3hYgROUTNq6EmBWbo8AZhKx6Mb/gU
    6W/58IGp8WZ1JoCOrxfdf17NTLdmgFe4NrUhqwDFw9kyz4vDsWg8uhkcsfzjQgXN
    Tcl9qjhlq3eWRJWkQrfDKc9shi92FoFBhYVGCpDUP6LKjzq2h9w3YgOol7Yvlcf8
    xmYo5qaH6X+aDk41x7JOnhgsYl2Dhrkmu5NRgbMFDW5ae5V/eOI8sJlPgNhOo5dk
    lUf8BZJ/xXwVewgNTU7zeC2eNiCTMRRHHp7T7gETwBwXUh9twkn6dpJnwb0+gfWU
    BmKsxjqRpKTMJnKU5jAkQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=goodmis.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=goodmis.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750994AbeBPWuR (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Feb 2018 17:50:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:56138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750940AbeBPWuO (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 16 Feb 2018 17:50:14 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EA14217B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Fri, 16 Feb 2018 17:50:11 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "Yann E . MORIN" <yann.morin.1998@free.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <mmarek@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        stable <stable@vger.kernel.org>
Subject: Re: [PATCH 1/3] Kconfig: disable PROFILE_ALL_BRANCHES for compile
 testing
Message-ID: <20180216175011.2f18dfd6@gandalf.local.home>
In-Reply-To: <CAK8P3a1U-FWXOAut9322BoK3H8drRvHh8E8CcsEq7HG2cv635Q@mail.gmail.com>
References: <20180216214117.1947175-1-arnd@arndb.de>
        <20180216214117.1947175-2-arnd@arndb.de>
        <20180216170346.497114b3@gandalf.local.home>
        <CAK8P3a1ZvA3dk8qRXaF_yjirYTYkvuCggh8x7QU_p+vMxpTPNA@mail.gmail.com>
        <CAK8P3a1U-FWXOAut9322BoK3H8drRvHh8E8CcsEq7HG2cv635Q@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 16 Feb 2018 23:40:22 +0100
Arnd Bergmann <arnd@arndb.de> wrote:

>      ((CAPI_MSG *) msg)->info.facility_req.structs[1] =
> LI_REQ_SILENT_UPDATE & 0xff;
>      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/isdn/hardware/eicon/message.c:11163:54: error: array subscript
> is above array bounds [-Werror=array-bounds]
>      ((CAPI_MSG *) msg)->info.facility_req.structs[2] =
> LI_REQ_SILENT_UPDATE >> 8;
>      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/isdn/hardware/eicon/message.c:11164:54: error: array subscript
> is above array bounds [-Werror=array-bounds]
>      ((CAPI_MSG *) msg)->info.facility_req.structs[3] = 0;
> 
> All those are nonsense AFAICT, and we see them only because the "if()" override
> ends up confusing gcc's value-range tracking in the same way it used to cause
> lots of -Wmaybe-uninitialized warnings (which we just disable these days
> with PROFILE_ALL_BRANCHES).

I'm fine with your patch then.

-- Steve
