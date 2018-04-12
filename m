Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-974663-1523538584-2-2823291866470184345
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523538583; b=jDKIJSVaFUfPF2Iw63Fjh2OMikKtkXBJ9rwJi/rMJ9YQhVtFEy
    +DlJfjcm3KqAs+ZUwggIJlUhPg2/dw79cmCDa2poMGd/t8gKRq2RJ3UflSGcllJ2
    YZct35FeXGw2kMpQm00J7FGLueLUUuFC3EfTj2mron4h0X2Z0N/6LhTX0zS62hD5
    ALW4Vm7YSivWDJASeO2doIrayVym6dn+ycn5jb/aTHPN+rqu6bZ+KWyOr0kV3mhe
    nzQ4RmpYzJlx/NnLyMFi+UOIGXlpgDgVn12Hkkr1gLJpTqyz2XeemIJWKXBBMj7v
    xB+f4sBOzv7UT2ZUvHP+x3CRN2uqTCyQecig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1523538583; bh=QdIW4AideTBAk62hG7Uv4ZFSdzt4xBPlLskdIx/wFB
    E=; b=WheXMYNQYR3VewCFcl6lnRlvPw/APA1/KAg2fxJMHpHHtr+cgalX3nwB5k
    okAFiyxAjIP2H235TbqXKR8FwSKgUdEuS847/rY6PeyLkxm1S80KHUYFVybTlKg3
    TpCmvVFzeirrGB+G6lhneNzYZ606Ynm9wB+8VXRkVR+fowy3ARlldJO9EPiK37us
    oxkVPcLhpgYr7eCYbh131cqCDeRWA3XIBEL8v/wW07wwLMbZaCxvuHnMssarXUla
    95CX6akeqJ8pbpu8Hrqt55M0HtdK8ugipkMyxUJYJNpAdvK+0Arsa1Jq34b14xMz
    aHhYud3AjDGa3Xf90b/9D7PcdKjQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=linuxtx.org header.i=@linuxtx.org header.b=Sinu/GI9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxtx.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qyN4hz6b;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxtx.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=linuxtx.org header.i=@linuxtx.org header.b=Sinu/GI9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxtx.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qyN4hz6b;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxtx.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDDKo+WQukG948zdGTFNirbS6DKN7LhPos4rSy4zaBTS6ibWeK2/FP/cBTh52h1El2k9uHUxfSLhPOlGS69Zrtr3NjvuS0isIh9jtmZXgGJVrlR9bMSk
    Ab/sD+soIq4g2TF09oBSpZOHuumAdj6V2K8SBl6ncq2+a0QGRkEEEXGUP9Rl7SlC/rSX63XhcZ1mLTya1Wp/cjWufm/alEE3YCK6sjtuGSj2DGDo1+k95zYS
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=Z4Rwk6OoAAAA:8 a=VwQbUJbxAAAA:8 a=WOTFN7GJjhNHXc8hSwsA:9
    a=MRTzlJ_LIG7lyrGj:21 a=7HoPVv9fiogwuxdG:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=HkZW87K1Qel5hWWM3VKY:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752901AbeDLNJO (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 09:09:14 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:54291 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751448AbeDLNJL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 12 Apr 2018 09:09:11 -0400
X-Google-Smtp-Source: AIpwx48McaTf+niOViKEdUghjVZoJuaq/3qsGGOQsKg2jHpoXEn3iXP4UWdXDUpaKeaYts9HI6cRtriPrSfpe8dEv6g=
MIME-Version: 1.0
In-Reply-To: <CA+55aFzvnf=4OeBy5vQQ6HQoCsgCkAJw1LhSBOTkDWm3ck1pZA@mail.gmail.com>
References: <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
 <152346388583.4030.15146667041427303547.stgit@warthog.procyon.org.uk>
 <CA+55aFzPo-dip8dgyo0U+g5qai9SAJU+D1c+AFJ0zV9_PBAB8Q@mail.gmail.com>
 <8z0aRQyD-6Krqntk8UD9WQjK5JSqEai2Pt5oeFU2EplgxoWiHlX5nlJXwCDHQ1WcS1oIprXimgz7UvwHCWDB9Z3dYFrEmZmtkEJSqaYMel8=@protonmail.ch>
 <CA+55aFzvnf=4OeBy5vQQ6HQoCsgCkAJw1LhSBOTkDWm3ck1pZA@mail.gmail.com>
From: Justin Forbes <jmforbes@linuxtx.org>
Date: Thu, 12 Apr 2018 08:09:10 -0500
Message-ID: <CAFxkdAr5c_bKEKqV2t-PKAo3iSvEkpqO1p+RPg9t-sW4yEUOnw@mail.gmail.com>
Subject: Re: [PATCH 01/24] Add the ability to lock down access to the running
 kernel image
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jordan Glover <Golden_Miller83@protonmail.ch>,
        David Howells <dhowells@redhat.com>,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 11, 2018, 5:38 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Apr 11, 2018 at 2:05 PM, Jordan Glover
> <Golden_Miller83@protonmail.ch> wrote:
> >>
> >> If that /dev/mem access prevention was just instead done as an even
> >> stricter mode of the existing CONFIG_STRICT_DEVMEM, it could just be
> >> enabled unconditionally.
> >
> > CONFIG_DEVMEM=n
>
> It's actually CONFIG_DEVMEM, CONFIG_DEVKMEM and CONFIG_DEVPORT, it's
> just not obvious from the patch.
>
> But the important part is this part:
>
> >> So I would seriously ask that the distros that have been using these
> >> patches look at which parts of lockdown they could make unconditional
> >> (because it doesn't break machines), and which ones need that escape
> >> clause.
>
> .. because I get the feeling that not a lot of people have actually
> been testing this, because "turn off secure boot" is such a universal
> thing when people boot Linux.
>
> So it's really the whole claim that distributions have been running
> for this for the last five years that I wonder about, and how often
> people end up being told: "just disable secure boot":.

Very rarely in my experience. And the one time that we sent a kernel
to updates-testing that was signed with the test key instead of the
real key, we had a surprisingly high number of reports from users that
it was broken before the update even got synched to mirrors.  So we
don't have actual numbers of users running active secure boot with
Fedora, but we do know it is more than we expected.  The majority of
people who do run into issues are those running out of tree modules,
who haven't imported any sort of key for local signing.  This isn't
like SELinux was at launch where it was so invasive that a large
number of users instinctively turned it off with every installation, I
would guess even people who turned it off in the past, don't even
think about it when they get a new machine and leave it on.

> But if people really don't need DEVMEM/DEVKMEM/DEVPORT, maybe we
> should just disable them in the default configs, and consider them
> legacy.
>
> I'm just surprised. I suspect a lot of people end up actually using
> devmem as a fallback for dmidecode etc. Maybe those people don't boot
> with EFI secure mode, but if so that just shows that this whole
> "hardening" is just security theater.
>
>               Linus
