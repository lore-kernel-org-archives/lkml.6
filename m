Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1435288-1519734587-2-1991212738804919824
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='no',
  MailFrom='org'
X-Spam-charsets: from='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519734587; b=T3MG8mNBEtBNXdqXjoizQtxkBr4YNG5LEoQiQHDZcdussbb
    WGl4+eawwnGo3NPvy+zveaNOE4Z5ZTvyt28VTJTkgmfEu7h3Su1S+hGoALNrVhq5
    Utgb3Or6jz1LFQvyYR9nyyevQz5C3B2wRmfajeREbjSvivmS9rAlNPyUjf4v0IEY
    9vfw1N/L4EmImtIZVueq93eJXTNhaxaW8qBey+XDphljNszaTI8ITCanazp8L8J3
    3/JvoXDzZkt7MK7oXtbS9riOnSizc4cY2+GZhZZcHj0q9EYfBCCc1Go2CWziMQiW
    QSIKHMELxNb0NAh3rWFJunw7NCJg2ZiQBSB2Rxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:references:date
    :in-reply-to:message-id:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519734587; bh=Q2s/0D41Mut3KSBr9ZwmtFBsl3IZR1Viyx1vgIshXNI=; b=q
    BbVCVhBlgurwK4eLWj2fv4WBZeFZxYtcuyh0Jpe7OdsfzrAhBMR+ox9TnccINwC9
    V4j04fWVCOMRo3+o2ph34aUCHSS0cLCi3A8XyofH0YS27jxtPUGYRVr8p7LLQt51
    qO5yIga9YUCafZUbZNK7aSQynrLSwgrzjitYiXIAa30GOor411NUrmaN2l3XdPrh
    WkF/acUOcH0IiO0u8pLWO8B8IkOcUl+W+bhVL+IPeajRaeU2BPGPRuWCwpxiVZ6D
    yuzC/5RuLd61/tpHHUmaw3wS0BSVVl5MWcKZsrsJxmfqej6zl9EyPBWjKSehl0a7
    Rsx4i4iqxOX3SFnR2Qqmg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=mork.no header.i=@mork.no header.b=bu2qzlYM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=b;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mork.no;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mork.no header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=mork.no header.i=@mork.no header.b=bu2qzlYM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=b;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mork.no;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mork.no header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752331AbeB0M32 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 07:29:28 -0500
Received: from canardo.mork.no ([148.122.252.1]:59059 "EHLO canardo.mork.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752107AbeB0M31 (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Tue, 27 Feb 2018 07:29:27 -0500
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: Bassem Boubaker <bassem.boubaker@actia.fr>
Cc: linux-kernel@vger.kernel.org, Oliver Neukum <oliver@neukum.org>,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] cdc_ether: flag the Cinterion PLS8 modem by gemalto as WWAN
Organization: m
References: <1519732192-29332-1-git-send-email-bassem.boubaker@actia.fr>
Date: Tue, 27 Feb 2018 13:29:15 +0100
In-Reply-To: <1519732192-29332-1-git-send-email-bassem.boubaker@actia.fr>
        (Bassem Boubaker's message of "Tue, 27 Feb 2018 12:49:52 +0100")
Message-ID: <878tbebopw.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Bassem Boubaker <bassem.boubaker@actia.fr> writes:

> +#define GEMALTO_VENDOR_ID	0x1e2d

This is defined as CINTERION_VENDOR_ID in drivers/usb/serial/option.c.

I have no idea which defintion is most correct, but I believe the macros
should be kept identical whatever you decide. Anything else is just
unnecessarily confusing.

IMHO the company name tracking macros have grown beyond useful a long
time ago. They just make it harder to grep for the IDs without adding
any useful information whatsoever. And because you have cases like this
where the same number end up having different names, they sometimes hide
information which a plain number would have revealed.



Bj=C3=B8rn
