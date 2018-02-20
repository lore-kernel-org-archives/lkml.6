Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1667321-1519096655-2-13981471661534969898
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519096654; b=k8MS3b1gAvSjHQX4cc7KFUGuTG6d3ct3tWRAFyjvIIsfPlT
    Zz45NrCrJzLuBpINNqwqW25OvQkMOaOQ5WTuBzmpKbek9mk7pES+baqLjWjQp/ta
    EKKAOipHj2EwkrM8B9EOnhIhAnaSkRMYLM4FoqSBVPLrsmpy50IfOipKdapOc+zD
    yymUQ/au1kTTNZ2MhcY+YrXuwURRGQhyPukqPGoEO+looHIHlyIjlXPst+XC05tf
    0hzrAZ2s2DSgGQXRm7qt8NfeQuquf0+nQfMNTaxERj+d34qGu6ULULn9+7LnTl/7
    xqlHe+rOO/VctueGKUEDdZA6bcCzz6XOafr8gaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1519096654; bh=bANToy53uIKE+4h4U2JunBnnS5b1EaXEDnajMF
    jpHnw=; b=wlK6g143j+IKxth1Rip9CaJy+IYSoNXDfmLw/sMAuv3goMFIbBXPkj
    LKDxDeXLxAtrZSdhKieFWlX+LQash9WQ1nekMw4Nh4P8x0LDJ32PxyOMUDGz0jX2
    xLwd4+wXHMFmXfu+dssuDd+KYVEaw473+VdYRVKHIr4WSSkvxLsdRKRb8S7fgT11
    F/6da7hx1RgOejucdhggq3XP83KF8JqxinVTMXWca5+g+UziubcWqyjkGtHj1Vee
    IcCi37pOk3d6HXp8+L40HkIjFp3+RCzjFuSEIzpaoccBPc/E1NGQzSj63FhjgpOl
    LV1vu1RlWaOCqtpcKjU4PCHFtsjanlvg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=csie.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=p+LtY3wK;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=csie.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=csie.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=p+LtY3wK;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=csie.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932487AbeBTDRb (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Feb 2018 22:17:31 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37624 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932352AbeBTDRa (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Feb 2018 22:17:30 -0500
X-Google-Smtp-Source: AH8x22421Kp3Suyslq7xCEsec3swsqVerx8XZdmcgdXOb/I2N7Cm/1vd72Gd4pRDyJzVWjICwAD7gg==
MIME-Version: 1.0
In-Reply-To: <694c5137-0020-bb62-68c7-f9729c101462@gmail.com>
References: <20180217130504.8668-1-wens@csie.org> <694c5137-0020-bb62-68c7-f9729c101462@gmail.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 20 Feb 2018 11:17:06 +0800
X-Gmail-Original-Message-ID: <CAGb2v64F9oHCv=uOGmeLc4_Qnz4BZO29ct8mCbJsRgdTJMDk3w@mail.gmail.com>
Message-ID: <CAGb2v64F9oHCv=uOGmeLc4_Qnz4BZO29ct8mCbJsRgdTJMDk3w@mail.gmail.com>
Subject: Re: [PATCH] clk: sunxi-ng: a31: Fix CLK_OUT_* clock ops
To: Philipp Rossak <embed3d@gmail.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Feb 17, 2018 at 9:54 PM, Philipp Rossak <embed3d@gmail.com> wrote:
>
>
> On 17.02.2018 14:05, Chen-Yu Tsai wrote:
>>
>> When support for the A31/A31s CCU was first added, the clock ops for
>> the CLK_OUT_* clocks was set to the wrong type. The clocks are MP-type,
>> but the ops was set for div (M) clocks. This went unnoticed until now.
>> This was because while they are different clocks, their data structures
>> aligned in a way that ccu_div_ops would access the second ccu_div_internal
>> and ccu_mux_internal structures, which were valid, if not incorrect.
>>
>> Furthermore, the use of these CLK_OUT_* was for feeding a precise 32.768
>> kHz clock signal to the WiFi chip. This was achievable by using the parent
>> with the same clock rate and no divider. So the incorrect divider setting
>> did not affect this usage.
>>
>> Commit 946797aa3f08 ("clk: sunxi-ng: Support fixed post-dividers on MP
>> style clocks") added a new field to the ccu_mp structure, which broke
>> the aforementioned alignment. Now the system crashes as div_ops tries
>> to look up a nonexistent table.
>>
>> Reported-by: Philipp Rossak <embed3d@gmail.com>
>> Fixes: c6e6c96d8fa6 ("clk: sunxi-ng: Add A31/A31s clocks")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>
> Tested-by: Philipp Rossak <embed3d@gmail.com>
>>
>> ---
>>
>> Philipp, can you give this a test and report if this fixes thing?
>> I don't have any A31/A31s boards online to test this.
>>
> Thanks!
> That fixes that bug!

Thanks.

It looks like this has been applied by Maxime.
