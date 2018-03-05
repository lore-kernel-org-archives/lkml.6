Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1402221-1520247392-2-8287143514699696974
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org', XOriginatingCountry='ES'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520247391; b=r9oxDHDBVJ+Dub/hsf1sDJPKSaMWq35589QGW3GHoJia/cr
    X8lnMaDDvfJnTbEqiJpRV1Cweejp2YS/tku1ePUNP1pZCI6pbYukMCC9AeKUq+Gb
    valjjO09TWJK9/pOlVVLKn8ZH//4JgXr/6FeJgaH4iG0F5mS3Z1yktVkj/8wbKxV
    Htr6RKWHQ7ZrqFymwSYGzzRrigyF75AhyoV627S+qSqyZTsdXUC2dsVpyhxi4atC
    2AaBRo1tG3qX/HR3SHLJhkaoxxO/goSOtvX3+4Y1mMISBOSkYz1AqmarGdPuLMEj
    2H6ENSW6l96WnJt0FUu2bZY4uSnhy1Erf2tG1nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520247391; bh=Tl6Zytehb/HRXwxEBNbrbPvG2oZDNmAyuveZMA
    cYsqg=; b=vTrfhY9v4pDVdkGs9eohjaefruVHoLnbr3EWTdeIjhaZ5VgMdHfX8Y
    /JqYoJRjFFgEuMkvwI1tcCP2JCSoEhCq/2ZP1h3kuv6Fd7ODIx8nyalJKwULQYgL
    Jqs2K8TtVwxNt6AAEtXOST5vtYSDtiSSQyawj+fYMICQ0eE0eXHRVoXqpJnZHp08
    C1AmX26djYVoiBs1NcfZBTOwZgVjfVRW4c94TR/xQNLAvfrA2JLxFXD7SeDdzxvW
    xQv2ytbseCIA4FFZ5yDEUQY3Bdi9C3X2UjvhDKSsdUBJG4+iTXQGPFQVPuwDcSju
    DuLUIu7wWbSJbwhaEVim3w4NgVfRtrdw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=dowhile0-org.20150623.gappssmtp.com header.i=@dowhile0-org.20150623.gappssmtp.com header.b=ow6dJANJ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=dowhile0.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=nzqBmylC;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=dowhile0.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=dowhile0-org.20150623.gappssmtp.com header.i=@dowhile0-org.20150623.gappssmtp.com header.b=ow6dJANJ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=dowhile0.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=nzqBmylC;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=dowhile0.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933981AbeCEK40 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 05:56:26 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:38594 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933579AbeCEK4Z (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Mar 2018 05:56:25 -0500
X-Google-Smtp-Source: AG47ELtfIC6G8r10mVpo0tC7cpP2PEbvjjD30CI4Yqwjm7n75c2F9B0Va9zbPqK2C12XSgTZ/gmjPyXMnANf0QprR5Y=
MIME-Version: 1.0
X-Originating-IP: [90.77.100.34]
In-Reply-To: <20180305104203.GD8588@sirena.org.uk>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
 <20180303222716.26640-111-alexander.levin@microsoft.com> <20180305104203.GD8588@sirena.org.uk>
From: Javier Martinez Canillas <javier@dowhile0.org>
Date: Mon, 5 Mar 2018 11:56:23 +0100
Message-ID: <CABxcv=kyODkSPv-Z2a=y8uuF8ZEF8fr+6ONaQywSpKJ+kwA1OQ@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL for 4.9 111/219] ASoc: rt5645: Add OF device ID table
To: Mark Brown <broonie@kernel.org>
Cc: Sasha Levin <Alexander.Levin@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 5, 2018 at 11:42 AM, Mark Brown <broonie@kernel.org> wrote:
> On Sat, Mar 03, 2018 at 10:29:00PM +0000, Sasha Levin wrote:
>> From: Javier Martinez Canillas <javier@osg.samsung.com>
>>
>> [ Upstream commit 9ba2da5f5d18daaa365ab5426b05e16f1d114786 ]
>>
>> The driver doesn't have a struct of_device_id table but supported devices
>> are registered via Device Trees. This is working on the assumption that a
>> I2C device registered via OF will always match a legacy I2C device ID and
>> that the MODALIAS reported will always be of the form i2c:<device>.
>>
>> But this could change in the future so the correct approach is to have an
>> OF device ID table if the devices are registered via OF.
>
> As the commit message itself says this is not fixing anything, it's
> defence against future changes.

That's correct.

These were just preparatory patches for a change in the I2C subsystem
to properly report OF module aliases [0]. So these will only be
relevant once [0] is merged, but that patch will never be backported
to a stable kernel.

[0]: https://patchwork.kernel.org/patch/10089425/

Best regards,
Javier
