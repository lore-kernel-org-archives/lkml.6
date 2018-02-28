Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3220176-1519790597-2-15760697471809051684
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519790597; b=EX3sNGrXh9ehIdUv326T36bSVv6CHGBgWciyv5Y1NIjmjZo
    bN46XTUQI76zaoD7GAnhc1ol7fPNJWtJN5TmXVhQR2kGIyCwvV1BeRQFKg6MaYiX
    p1utF6gK0ZQpSykE5XfYT6BWQ8oTKgfnpLKdOi6+BA3h2Rd1W+p9a4N6Fek08P7h
    IxmvD3Hh/+9PVozOHX42vVQZc9jdNCBGd44H9H/C+E68i0WHCgKG+LQW1ESR3/2D
    t22swWnr1mKl+fxoh7NiGiTaNfR8lCgQZ3jldI2gpMi98ndYmc1eRo0MZqL4iKiB
    8JqxUqehOsw0jNPP4gKORY/2ndbA+xtLstxvduw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:references:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519790597; bh=5lCIqGDXwswyBDCWna96ooOCz48mNJpMkR2WBpgqIZI=; b=X
    5fp32+nLM/3YgLpxjPSzAxaHdhpULQ6DewGmI/NkXrKl1d4SxnrxiyH+Cw+XzdsY
    cxx71o03ovo5Ysbalw03st3iHazHaen6sKSxuXy1kbHRVn1wveGSo0y0/0DP5rUS
    YwBhCaDcOMRJZHRdaZ2h8QB3uasj3VgiVIA5XvJaRExKCAA90zsIVZU19UYUudda
    7L1rmqSEXFt5RqRx51JtFzL9dXIKWS103l6dKxuheK1FApW12FSN2/PAWxNaBzKf
    Qk5dtgbzwdth7WDENFBJk4IVTpH8gnyTn1PtKoitm+VHpz33En+7cxhQdusFdgy9
    v4ShAS76KRalRL5gY86YQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=K4O6GQqt x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Heex2uWp;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=K4O6GQqt x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Heex2uWp;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752318AbeB1EDB (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 23:03:01 -0500
Received: from mail-pf0-f175.google.com ([209.85.192.175]:37526 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752016AbeB1EC7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Feb 2018 23:02:59 -0500
X-Google-Smtp-Source: AH8x224DIn5lxAJ+BdkEBNI5RpbUNbZ785YQbUDeWzvdV2SFXIhSyD+Rgs3e5uIhCSRpvyxBCCLZ2A==
Subject: Re: [PATCH 0/29] arm meltdown fix backporting review for lts 4.9
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
Message-ID: <1dfc010f-5ead-c57c-937d-e43eca6f6677@linaro.org>
Date: Wed, 28 Feb 2018 12:02:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 02/28/2018 11:56 AM, Alex Shi wrote:
> The patchset also on repository:
> 	git://git.linaro.org/kernel/linux-linaro-stable.git lts-4.9-spectrevv2 

Sorry, the correct branch address is here:

https://git.linaro.org/kernel/speculation-fixes-staging.git v4.9-meltdown

Thanks
Alex
