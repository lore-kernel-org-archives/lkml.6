Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD23C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 11:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A17B92152D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 11:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="V9929M0M";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="V37/rfFp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A17B92152D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731371AbeHWOra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 10:47:30 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39234 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728762AbeHWOr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 10:47:29 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3BBCC60271; Thu, 23 Aug 2018 11:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535023095;
        bh=oAOXxVeDOwsgab2i/jmTjU2k+y6WxenBRQWDy+O3E14=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=V9929M0MDp1/wI4oFxeamV+lxABbCdl8T5/lNog9T6r9UmewpjIRP8fvVV/dEjG2G
         PfpVVq3oVN4y+z3DR0Q/n4aSm2a4SSpTzUKvGeSE8+oA9mU78uK7E5d6gGc35oAnN/
         20U+g7lBMolK6Tp1LLT9SsTT4Y5BFXljaTdcyhRc=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1E879601B4;
        Thu, 23 Aug 2018 11:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535023094;
        bh=oAOXxVeDOwsgab2i/jmTjU2k+y6WxenBRQWDy+O3E14=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=V37/rfFpQjumfwP4qPbkQz1UocMR2rFzz/ANrr6qAseDZBZfShNIES0yS/uXOSkq2
         Yhv8TZcF4w3q5PPwLiflFY2zI36JoUEgvlhJcQIQygvcb7giW+zyGiH1or2ZR0+Lq5
         2F1fVuAQrnSC3YtKkpo3i4ewXX44V4uBH40WYNoA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1E879601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Felix Fietkau <nbd@nbd.name>, ath9k-devel@qca.qualcomm.com,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ath9k: turn on btcoex_enable as default
References: <20180208052801.15670-1-kai.heng.feng@canonical.com>
        <56d650e6-d26f-087c-4e86-2e5d4e859414@nbd.name>
        <A5972CE9-8325-404A-A63D-ED29E44FB67B@canonical.com>
        <87k1vmeip8.fsf@kamboji.qca.qualcomm.com>
        <E500FA42-23F1-433F-9BFB-78A2FD1946AF@canonical.com>
        <7170e2d5-a59d-8260-fa8e-f02f583b773f@nbd.name>
        <6A0F65EF-A7C4-469F-8FAF-CBE314676237@canonical.com>
        <9AF82E83-2EBE-4076-BAFA-EEA44B1DB423@canonical.com>
Date:   Thu, 23 Aug 2018 14:18:10 +0300
In-Reply-To: <9AF82E83-2EBE-4076-BAFA-EEA44B1DB423@canonical.com> (Kai-Heng
        Feng's message of "Thu, 23 Aug 2018 09:33:56 +0800")
Message-ID: <87in41nxfx.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kai-Heng Feng <kai.heng.feng@canonical.com> writes:

> at 12:15, Kai Heng Feng <kai.heng.feng@canonical.com> wrote:
>
>>
>>
>>> On 10 Feb 2018, at 10:05 PM, Felix Fietkau <nbd@nbd.name> wrote:
>>>
>>> On 2018-02-10 14:56, Kai Heng Feng wrote:
>>>>> On 9 Feb 2018, at 3:16 PM, Kalle Valo <kvalo@codeaurora.org> wrote:
>>>>> Sure, but we have to make sure that we don't create regressions on
>>>>> existing systems. For example, did you test this with any system which
>>>>> don't support btcoex? (just asking, haven't tested this myself)
>>>>
>>>> No not really, but I will definitely test it.
>>>> The only module I have that uses ath9k is Dell=E2=80=99s DW1707.
>>>> How do I check if it support btcoex or not?
>>> I just reviewed the code again, and I am sure that we cannot merge this
>>> patch. Enabling the btcoex parameter makes the driver enable a whole
>>> bunch of code starting timers, listening to some GPIOs, etc.
>>>
>>> On non-btcoex systems, some of those GPIOs might be floating or even
>>> connected to different things, which could cause a lot of undefined
>>> behavior.
>>>
>>> This is simply too big a risk, so there absolutely needs to be a
>>> whitelist for systems that need this, otherwise it has to remain
>>> disabled by default.
>>
>> So what information can we use to whitelist btcoex chips?
>> Can we get btcoex support status at ath9k probing?
>
> Sorry for bringing this up again.
>
> Is DMI based match an acceptable approach for ath9k?

I don't know what Felix thinkgs, but to me using DMI sounds like a good
idea to try, assuming the matches are unique enough and there's no risk
of enabling bt coex on wrong platforms. Should the PCI bus number etc
checked as well in case the user adds more ath9k devices to the
platform?

But of course I need to see the patch to comment more.

--=20
Kalle Valo
