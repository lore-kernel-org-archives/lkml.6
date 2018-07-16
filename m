Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9A1ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAF3E208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="15aYdh5o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAF3E208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbeGPQKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 12:10:12 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54660 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbeGPQKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 12:10:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=i20PPhjABEcbSolqLK+z5XpFdJqDmy9SLONwofQBxlY=; b=15aYdh5opmVbVJGsHXX+9lmywt
        BYckHVqzuW7974NH8tUaaX3sya3WckPn9qFblY53czZOU4YbLj8AdzQa/69/iwZo5B9Qx+aq79iJm
        WieHjFHTaZ/In+Er9T5lJZN5eypLB3lNG00A0kTFrHu9Uc7JdzVxwniovCeVMmFvp4G3BSnrfmBGV
        ivNUNhEUU3joV2ZK6L3O7FwbQ6JIyEnNroSviTSRyCAJ56+g02SpGMjDQ8CQhjg0+cYJdi9/bSdny
        kUkQApjVYTACbOkWG0MYb9CZa1l4JGmDR6X9xRQfb1fORIvUYnbEmJGingwL14O145Pk1XAjPPVxF
        fE65qqGw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ff5cn-00034P-RX; Mon, 16 Jul 2018 15:41:22 +0000
Subject: Re: [PATCH] kernel.h: Add for_each_if()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        NeilBrown <neilb@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wei Wang <wvw@google.com>, Stefan Agner <stefan@agner.ch>,
        Andrei Vagin <avagin@openvz.org>,
        Yisheng Xie <ysxie@foxmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Vetter <daniel.vetter@intel.com>
References: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
 <20180709162509.29343-1-daniel.vetter@ffwll.ch>
 <20180709163001.8fb8148223a57bc46a13fbda@linux-foundation.org>
 <20180710075328.GG3008@phenom.ffwll.local>
 <871scbwfd4.fsf@notabene.neil.brown.name>
 <CAKMK7uFEYyD2ChWnO_0PS_rkK180dDoQ1g4J0UWRfchnYQxOTA@mail.gmail.com>
 <20180711160547.59f086a587c7f3c8d3c40f0f@linux-foundation.org>
 <87bmbavhai.fsf@notabene.neil.brown.name>
 <79133322-b04b-f005-f1f6-25c28c5058e4@infradead.org>
 <f361dcc9c25e46819100ba1634f56db1c867f1b8.camel@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <bb9df9a3-9bce-2ccc-b984-156f11e1c7cf@infradead.org>
Date:   Mon, 16 Jul 2018 08:41:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <f361dcc9c25e46819100ba1634f56db1c867f1b8.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/16/2018 01:11 AM, Andy Shevchenko wrote:
> On Fri, 2018-07-13 at 16:42 -0700, Randy Dunlap wrote:
>> On 07/13/2018 04:37 PM, NeilBrown wrote:
> 
>>
>> coding-style.rst says:
>> Also, use braces when a loop contains more than a single simple
>> statement:
> 
> Independently on a) would we use some macro for condition, or b) fix
> macros against this kind of nested conditions, there is another
> weirdness we would like to avoid, i.e.
> 
> for_each_foo() {
>  ...
> } else {
>  ...
> }
> 
> It is written according to coding style, but too much weird.

Yeah, that's odd.  Looks like else matches the for loop. (!)

> So, summarize this discussion I think we would
> - keep for_each_if() in DRM subsystem alone
> - fix macros which are using positive condition 'if (cond)' by replacing
> with 'if (!cond) {} else' form for sake of robustness.
> 
> Do you agree on that?

Sure, both of those sound good to me.

thanks,
-- 
~Randy
