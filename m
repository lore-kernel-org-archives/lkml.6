Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-778319-1524664704-2-17660680223133180326
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524664704; b=BxvVDnk7/fjNpnLQJnz9PxHMFgDFw5rbh7KCBI/Xf2VyQhKpi6
    WpC7RcHqNiwDDmbECN/bOpV4XI4VR9rejIGM3zv1eCGc8Tj3UKRZ4tZqit+bfeei
    j9G6+EVSyV4F5iePtechNDPJcZkU12KQ24ZFYOUgup5kTHYvzwKJsiNh2Kk3OL9P
    cF5SuFqD2D7SfDVfQIO4a24KXSPolmkNrsmTzFHXKtsSx+yRclVtGTeUFulvO9y5
    Bpw8r+SgeGQ+PZ5kZerIrXQf9jxaZj7VrcKU5erhu/nP1FOzDdIxLaefcrmwDP7p
    BLhlNedA1oZLvsFNvQpu4ovz5ufs3rCUdNRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:references:date
    :in-reply-to:message-id:mime-version:content-type:sender
    :list-id; s=fm2; t=1524664704; bh=6BzhNZ1GqBxTFyUVghPsltjbSkt3/H
    4OYDN0hd55w4E=; b=XD9MtwSftz79UGei40AnQPBP7ZGKwpKg/pw9bdHVxtaABE
    omm91CLbVRHlYAbXw7jkzyy7OXDWXMoKvxKVa866iB1ShUBdKWaq/LeHJeX7Jy/z
    AKEmntuaQ+rA2dz22a8q8bCkJsToR8M6MeoGlcw2WHo9UuyWeRiThbYnXdrR3Zb3
    h2Rs5BaK7d27OB+6XYHkGniTPCTafcWyDUIylvRsNy96o1wjR6BJ9/fszPwaLIhn
    lCEjbDB0PpOy4mhOSg2TdzgN1wa1pk8h1uLL4y7Nb6oLwfitOGqm2jzPUZ3Umvj/
    rPOTVsoO9VKlaOqILP+wVvYVvd9PdiZiqpGKV1zg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=V8CkuSXA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=brDR2amP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=V8CkuSXA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=brDR2amP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHs5XO7Xeqr6F0g3qzOqge+ZG0Ut3cZVsb/Tv5h7rUKWMq/9C325Jy20fvnTiO396X0y6T9fL5OiB35XE5cSC7DV2XIwYSVNFBfdFJzhygUH/tMfT+eA
    pEH6seIHMnFjz0L/Xzky5vmDTaM/po5idWxSNsNDcz/ZgFCF8zwstMPwRUWP92Pl6aeV3ud617fOUxz0KudJy8jpcUIKGZH/silcxSINqldMoH02kLDTZzRN
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=pGLkceISAAAA:8
    a=sozttTNsAAAA:8 a=VwQbUJbxAAAA:8 a=rpx0JUOn-2ZwZpnQpAcA:9
    a=aeg5Gbbo78KNqacMgKqU:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753405AbeDYN6W (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 09:58:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40560 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753327AbeDYN6V (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 09:58:21 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-2.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,T_DKIM_INVALID autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3662360500
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From: Kalle Valo <kvalo@codeaurora.org>
To: Eyal Reizer <eyalreizer@gmail.com>
Cc: linux-wireless@vger.kernel.org, robh@kernel.org, sre@kernel.org,
        tony@atomide.com, linux-kernel@vger.kernel.org,
        Eyal Reizer <eyalr@ti.com>, stable@vger.kernel.org
Subject: Re: [PATCH] wlcore: sdio: allow pm to handle sdio power
References: <1524663710-31927-1-git-send-email-eyalr@ti.com>
Date: Wed, 25 Apr 2018 16:58:15 +0300
In-Reply-To: <1524663710-31927-1-git-send-email-eyalr@ti.com> (Eyal Reizer's
        message of "Wed, 25 Apr 2018 16:41:50 +0300")
Message-ID: <8736zj9ymg.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Eyal Reizer <eyalreizer@gmail.com> writes:

> pm_runtime handles sdio power on and power off transitions.
> An old workaround for trying to control the power explicitly from the
> driver was in fact causing failures on suspend/resume as the mmc layer
> already power the module on resume.
>
> In case of resume pm_runtime_get sync returns a positive device's usage
> count causing the driver to try an re-initialize an already initialized
> device. This was causing sdio bus failure on resume.
>
> Remove this manual power on/off sequence as it is in-fact not needed.
>
> Signed-off-by: Eyal Reizer <eyalr@ti.com>
> Cc: stable@vger.kernel.org

I'll remove "net: wireless: ti:" from the title. The idea is not to put
the whole directory structure there, just the driver name.

-- 
Kalle Valo
