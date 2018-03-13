Return-Path: <kernel-hardening-return-12496-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELt5gVHth4xqj9h+wYfhC3yJAumY1H086Lot92IyDMJQggLO/+F/40jr5Mid6GxQ7lZMion/
ARC-Seal: i=1; a=rsa-sha256; t=1520925825; cv=none;
        d=google.com; s=arc-20160816;
        b=gPx3JGmZjU4Zt8zdA8RIO/lb0kULqaTJJsUtaYwwkq13hlqFtxa4juX/zxMavWBXjx
         DWatYvWujbpR01awqRuyv+76xDPbsg4WMejAcnO4gDI8e3tw1sSGOXtt1mg0ma4Lg0k1
         hve9MuqXMcTJkCST9avOl6JLmIVFxcv7v37DK8M2s2RIHIsDzkuMc4Z8B9MjMEmERjCO
         8QAltLqycTx2QaB/Opv5BFES4N0Vviq3aLdDe1tuKN3qMlKZsQJP+OkdBSZDEab7IjHi
         ZwiKaqwoN5/mq/m/3iaUqrxsaWFHT1LQ1a1883PxEt3eipwdRXCPQT2S98WXKsxcGvG4
         r6+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=5LmFD6ETYVmTmjjoiNX6b19XalHs4Y7DmMY5G6mXyQE=;
        b=EpHfL/DX7Lalq17O/DyvlAvWwA7H8C85Z+jJBaFjPNwdvL9PqtghBsawIVw660R7/A
         5Epdy0idjB6PTTe0GryRewenpWD6zhiYlBj4hPrc3c4qUyXklz53aSOwB23Pm4k0QYZg
         9gHG6B7X6nHoPzdXyTyGHCxnYDTERSZgDhQzkDc85g9oRgviJgE/gUCR2fPdSiU3i3H4
         kPDk08/EAFU5CedD3ALJ49GSM7/TSGuSQeTibErIBRBCF7w7u9qt4kbPuomoDMrMOIFY
         qdJdCqXxZUf/5PtCMteKWoi20O8Gt/rtRcpKY4GDoqVEqcUMNKKX2htwMxQWp5r36Y9p
         8ewQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@rasmusvillemoes.dk header.s=google header.b=TwlgBBDq;
       spf=pass (google.com: domain of kernel-hardening-return-12496-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12496-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@rasmusvillemoes.dk header.s=google header.b=TwlgBBDq;
       spf=pass (google.com: domain of kernel-hardening-return-12496-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12496-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 1/4] gpio: Remove VLA from gpiolib
To: Laura Abbott <labbott@redhat.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Linus Walleij <linus.walleij@linaro.org>, Kees Cook <keescook@chromium.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-hardening@lists.openwall.com, Lukas Wunner <lukas@wunner.de>,
 Mathias Duckeck <m.duckeck@kunbus.de>, Nandor Han <nandor.han@ge.com>,
 Semi Malinen <semi.malinen@ge.com>, Patrice Chotard <patrice.chotard@st.com>
References: <20180310001021.6437-1-labbott@redhat.com>
 <20180310001021.6437-2-labbott@redhat.com>
 <a758ce3f-fed7-2ecf-94c5-ba133ea75bde@rasmusvillemoes.dk>
 <301ecaf7-62a4-14af-3a5b-7bd76a49c4f6@redhat.com>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <a55d544e-0b0c-1a5a-b474-d31eb338e8ee@rasmusvillemoes.dk>
Date: Tue, 13 Mar 2018 08:23:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <301ecaf7-62a4-14af-3a5b-7bd76a49c4f6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594507304079648871?=
X-GMAIL-MSGID: =?utf-8?q?1594806318776445261?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-03-13 00:40, Laura Abbott wrote:
> On 03/12/2018 08:00 AM, Rasmus Villemoes wrote:
>>
>> Hm, it seems you're now only clearing the first word of mask, not the
>> entire allocation. Why not just use kcalloc() instead of kmalloc_array
>> to have it automatically cleared?
> 
> Bleh, I didn't think through that carefully. I'll just switch
> to kcalloc, especially since it calls kmalloc_array.
> 
>> Other random thoughts: maybe two allocations for each loop iteration is
>> a bit much. Maybe do a first pass over the array and collect the maximal
>> chip->ngpio, do the memory allocation and freeing outside the loop (then
>> you'd of course need to preserve the memset() with appropriate length
>> computed). And maybe even just do one allocation, making bits point at
>> the second half.
>>
> 
> I was trying to make minimal changes and match the existing code.

Well, textually you may be making the minimal changes (though the error
handling adds some "boilerplate" kfree()s etc.), but semantically adding
two kmallocs in a loop could be a big deal. Dunno, maybe in practice all
the gpios (almost always) belong to the same chip, so there's only one
iteration through the loop anyway.

> Is this likely to be an actual hot path to optimize?

No idea, it was just a drive-by comment, so also...

>> Does the set function need to be updated to return an int to be able to
>> inform the caller that memory allocation failed?
> 
> That would involve changing the public API. I don't have a problem
> doing so if that's what you want.

... I don't "want" anything, that'll be for the gpio maintainers to decide.

Rasmus
