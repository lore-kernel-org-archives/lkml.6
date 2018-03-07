Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-108815-1520460549-2-8665324967827770978
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520460548; b=TUOaig2DzqsH/wM8+8iVuSD4Vt+0R0BgNJZLmsIGulfWgWF
    19bsE16+pRhOCXQM3kv2cNcsyAJ9KSrUh9n2sBocT/GTs+e264zUmwto+p5bU1dv
    cgbsFNLXT0vFgBInruPmEqOqEMF/0/2ApMZsPfiwISF8jEiA+WLGPo4uQ2lpUO5O
    fVtY/u41cglUj0VUcSZKOnarIJad4mHgJo1a9wwYNsSlI/dAyg30HeZ1WJm3FX67
    ra4tW2W1ZV2MM8u6KLoXUYAFXfuwt+b0pCAiVl5xKhmDoDuw8U+AH/Kxkp+wbupW
    46Lg+h/OHA+nA2vK3aJyWnR4pvP4+6bJvAEDR2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520460548; bh=QIblE2sJebzLiaNBcnbDE/Dac3WSQc2x1Z/BgTAj+Ek=; b=b
    9KakoDvhId2TKIdnsQzq+oqXnvpLPBbyp8b1Z+kQ+Hhb47aC9jURZ1GzMp2Z3jLq
    xaf8/ZLluFLcRPfC4Atp2771gGs3cwglCzFw/vQFdR08hQ0VECanntZHPnfzz/9a
    a5apuLQ9MKpBPrkn58wfCb3IaBv/vUfSP1BfR31+vrhYs9lbm/nTELs1qyjT4o3Y
    5QfspcRgyr4OKE2LWe6yeoue5JulOtQDIhv8OBuzjb/d9ZCTj2ZNxx92NtmDlqbv
    W548vpL8QaphxAalI6sMbA02+RJ+xo/Vp8kIL7yynytZuxMfnqde8AKBMPN+4065
    Km32lLSl6nma8Tc51L8HQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=bT+SDRUf x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=cHN5gEJm;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=bT+SDRUf x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=cHN5gEJm;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754762AbeCGWJH (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 17:09:07 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34834 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754547AbeCGWJG (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 17:09:06 -0500
X-Google-Smtp-Source: AG47ELuEFtsGdoM4EB0GtVFfYRa2VBbtkOXzbfSa6/QcpM6ll7ayaGBZ20bXyrXCBeFnfEMMp7oOqH3uo3NUOmWjwqU=
MIME-Version: 1.0
In-Reply-To: <20180307214342.GA9852@amd>
References: <20180303104554.5958-1-richard@nod.at> <20180306231805.GA28183@amd>
 <6772577.AmT7QaWTNU@blindfold> <20180307214342.GA9852@amd>
From: Steve deRosier <derosier@gmail.com>
Date: Wed, 7 Mar 2018 14:08:24 -0800
X-Google-Sender-Auth: eEL9zHE3hDAofD3pO-_LE632GWo
Message-ID: <CALLGbRK4w9Yhznt6+aqr8jptQjsp7FmbjQMPtvhh2h354n2G0A@mail.gmail.com>
Subject: Re: [PATCH] ubi: Reject MLC NAND
To: Pavel Machek <pavel@ucw.cz>
Cc: Richard Weinberger <richard@nod.at>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        dedekind1@gmail.com, tharvey@gateworks.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        marek.vasut@gmail.com, linux-mtd@lists.infradead.org,
        cyrille.pitchen@wedev4u.fr, computersforpeace@gmail.com,
        dwmw2@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Pavel,

On Wed, Mar 7, 2018 at 1:43 PM, Pavel Machek <pavel@ucw.cz> wrote:
> On Wed 2018-03-07 09:01:16, Richard Weinberger wrote:
>> Pavel,
>>
>> Am Mittwoch, 7. M=C3=A4rz 2018, 00:18:05 CET schrieb Pavel Machek:
>> > On Sat 2018-03-03 11:45:54, Richard Weinberger wrote:
>> > > While UBI and UBIFS seem to work at first sight with MLC NAND, you w=
ill
>> > > most likely lose all your data upon a power-cut or due to read/write
>> > > disturb.
>> > > In order to protect users from bad surprises, refuse to attach to ML=
C
>> > > NAND.
>> > >
>> > > Cc: stable@vger.kernel.org
>> >
>> > That sounds like _really_ bad idea for stable. All it does is it
>> > removes support for hardware that somehow works.
>>
>> MLC is not supported and does not work. Full stop.
>> If someone manages to get it somehow work, either with hardware or softw=
are
>> hacks they are on their own.
>> Having it in stable is the only chance we have to get it into vendor
>> kernels.
>
> Can you show how it meets the stable kernel criteria? They are
> documented in tree. This should not be in stable.
>
> And I'd like to see changelog improved. Real reason MLC is not
> supported is upper/lower page parts on MLC. And real fix to work with
> bigger pages in UBI.
>

To clarify one thing: the reason for this is MLC has actually never
been supported, nor worked properly. The fact that it kinda worked was
incidental and the cause of major problems for people due to that not
being clear. This patch only makes it explicit and avoids people
mistakenly trying to use UBIFS on MLC flash and risking their data and
products. To me, that's what's important.

This is an important patch, even if all it does is keep people from
loosing data. It also changes the conversation from "I have a
corrupted UBIFS device, BTW it's on MLC..." to "What can we do to get
UBIFS to work on MLC".

I don't know what the stable criteria is with re: to this patch. But
what I do know is if it doesn't go back into the various stables,
there will be manufacturers who will continue to try to use UBIFS on
MLC in ignorance for the next several years until the current stable
kernels EOL, despite there being a known patch that would make it
immediately obvious they shouldn't.

Thanks,
- Steve
