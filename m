Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2157884-1520520107-2-5470938961281729594
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='at',
  MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520520106; b=DHStAhpPKLP89bFZ4OAjICXb+1i5h/xhMoB8SirYeeIeM3d
    0GTeCpD6soukA3z1fc59/XHdCB06D5QFXTzokXZEsKQoF2+Oc/8EP/Tn+jPIqFEj
    3bg0aoIRj7jZXGhszdaQ+Ely67RK7MWG+Kd3g8/0aLuA8S/IvbLRNP4LIvEZXYQG
    UkTWpYIJN5t+Hh53PPRW8XIYZh6cd0ULy3Z5Ej1jGE7POY7GZQiCCaxnVUzZAXwB
    NaFbg3CvhjbdAnJxuL2apAD81YTgYOJZTCJIMW0jQ5J5Ajn8qzIGyqFRYt6eax0N
    JSA7CWk52LAcJGVC7wSsCb94gD2a3LUKMqj1L2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-transfer-encoding
    :content-type:sender:list-id; s=arctest; t=1520520106; bh=DWHeKS
    ASfwxiJYBWbdpcTJ2AHb1kpsbjEWXLdo4lay4=; b=mEdZa1Dwx7vExHXTlR9urt
    0zO7rfocXb6XrRhwI8oHCpGI+WSll0TkfS9525ZGRbFM7cf+nvVLkZL3oVO+XWBT
    c7pMt0/Zj48tlUKxx4CaoC44/DUsIBoBzfND33K3GTnX5KwB/D5SnesQyMtP6c3s
    eF60mx9KrdBFHWy2oOu32LbMG8tlo05LGwKIVBjHm9Jn23Xgo3S2MWZ5dhQum/FO
    N65MCJB2taJVcQKrupFi4v0Zr6udMVGHyXPMl2Iza3bQq96st5ozhASdAu/swoQy
    Xi0NTwQrzwkLIL7cSfzvakDmPxNKzYAkyhrXGSpn2Ak35WO6IkrooHUAEcmIvjcw
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=nod.at;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nod.at header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=nod.at;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nod.at header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752058AbeCHOln convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Thu, 8 Mar 2018 09:41:43 -0500
Received: from lilium.sigma-star.at ([109.75.188.150]:47740 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752009AbeCHOln (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Mar 2018 09:41:43 -0500
From: Richard Weinberger <richard@nod.at>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mtd@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        Mark Vasut <marek.vasut@gmail.com>,
        Boris BREZILLON <boris.brezillon@free-electrons.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Artem Bityutskiy <dedekind1@gmail.com>, tharvey@gateworks.com,
        stable <stable@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] ubi: Reject MLC NAND
Date: Thu, 08 Mar 2018 15:43:12 +0100
Message-ID: <3797589.z8fAhu5iDP@blindfold>
In-Reply-To: <CACRpkdYOqt4xTqGmbSwd_R84NRD8GA9TsHEk_hJ68hhxwbsL_Q@mail.gmail.com>
References: <20180303104554.5958-1-richard@nod.at> <CACRpkdYOqt4xTqGmbSwd_R84NRD8GA9TsHEk_hJ68hhxwbsL_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Linus,

Am Donnerstag, 8. März 2018, 14:42:16 CET schrieb Linus Walleij:
> On Sat, Mar 3, 2018 at 11:45 AM, Richard Weinberger <richard@nod.at> wrote:
> > While UBI and UBIFS seem to work at first sight with MLC NAND, you will
> > most likely lose all your data upon a power-cut or due to read/write
> > disturb.
> > 
> > In order to protect users from bad surprises, refuse to attach to MLC
> > NAND.
> > 
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Richard Weinberger <richard@nod.at>
> 
> I'm sorry to disturb in this interesting discussion about what
> "stable" really means as in "stable kernel".  Stable for who and
> in what sense, that seems to be the question.
> 
> But my main problem here is to understand who the consumers
> of the MLC NAND devices really are.
> 
> I hear some talk here about lab boards. But where is this
> really deployed, large-scale? And who are the people that
> will have their devices potentially not booting after this patch?
> 
> I am pretty sure these people are board support or
> customization consultants with work being done for some
> certain products, and not hobbyists and even less end
> consumers, right?

Correct.
I saw vendor specific kernels that have hardware and software hacks to make 
UBI on MLC NAND somehow work.
Somehow in terms of, the filesystem will die just a little later.

But these people do _not_ run a vanilla (stable) kernel.
We support mainline, nothing more, nothing less.

> What kind of devices are MLC NANDs being deployed in?
> Certainly not laptops, tablets and phones, they all use eMMC
> and even start to venture into UFS (unified flash storage).
> 
> What is using these flashes? Routers and switches? NAS boxes?
> Industrial control? Automotive?
> 
> Or are (God forbid, but would not surprise me) talking about a
> Linux instance running inside of eMMCs or UFS devices?

We need to clarify that even more. Upstream UBI and UBIFS cannot work with MLC 
NAND correctly. Any such product would die within days...
I have many MLC boards on my desk, by running a mainline kernel on them, I can 
kill every single one within a few minutes, either by plugging the power or 
triggering read-disturb.

As stated by David Woodhouse, it was a huge mistake by UBI to not reject MLC 
NAND from the very beginning.
The sole purpose of this patch is fixing that mistake and make it very clear.

Thanks,
//richard
