Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4AD0ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 23:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F68620871
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 23:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IlPddb0U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F68620871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731526AbeGNAAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 20:00:43 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52928 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729762AbeGNAAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 20:00:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BzhhUTWfymZlQdV1Ye90pVtOOYZ3lU/cYWkKSMbicck=; b=IlPddb0U+D+d4F5qWm/tjMAzBc
        QQtLpf3c+puVmxEf+iwBHNGTBdCzL/6ITnsL8zM0IGu2U1+DOBOf7l413GEPzzo39Q7YX7U6WXopt
        BQTjg9DAP16EcnE9nIvH3EciaeOSSQxuqtr4vcQ4+n5L+qOmSrwxV27D9N+YXw4RHpl00T2MLCkth
        9+j0dF0++QITSU1E/sMh/H7ZN2tSJPJCepGvFH0oSi7bBMgj5pfpiu/4+uxalNnEmp5X00qFEcKcf
        HqncYaP8QzK6kLstvR6ejspKJOwhtZpOB3/MNirHljjgbmaVVGsGvGtL2R4UPB8JFBfDMzKNZ0yQw
        ivTwOsfQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fe7iJ-0005YA-6m; Fri, 13 Jul 2018 23:43:03 +0000
Subject: Re: [PATCH] kernel.h: Add for_each_if()
To:     NeilBrown <neilb@suse.com>,
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
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <79133322-b04b-f005-f1f6-25c28c5058e4@infradead.org>
Date:   Fri, 13 Jul 2018 16:42:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <87bmbavhai.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/13/2018 04:37 PM, NeilBrown wrote:
> On Wed, Jul 11 2018, Andrew Morton wrote:
> 
>> On Wed, 11 Jul 2018 13:51:08 +0200 Daniel Vetter <daniel@ffwll.ch> wrote:
>>
>>> But I still have the situation that a bunch of maintainers acked this
>>> and Andrew Morton defacto nacked it, which I guess means I'll keep the
>>> macro in drm? The common way to go about this seems to be to just push
>>> the patch series with the ack in some pull request to Linus and ignore
>>> the people who raised questions, but not really my thing.
>>
>> Heh.
>>
>> But, am I wrong?  Code which uses regular kernel style doesn't have
>> these issues.  We shouldn't be enabling irregular style - we should be
>> making such sites more regular.  The fact that the compiler generates a
>> nice warning in some cases simply helps us with that.
> 
> I think you are wrong .... or at least, not completely correct.
> 
> I think it is perfectly acceptable in Linux to have code like:
> 
>   for (....)
>   	if (x)
>         	something();
>         else
>         	something_else();
> 
> Would you agree?  If not, then I'm the one who is wrong.  Otherwise....

coding-style.rst says:
Also, use braces when a loop contains more than a single simple statement:


> The problem is that for certain poorly written for_each_foo() macros,
> such as blkg_for_each_descendant_pre() (and several others identified in
> this patch series), writing
> 
>    blkg_for_each_descendant_pre(...)
>      	if (x)
>         	something();
>         else
>         	something_else();
> 
> will trigger a compiler warning.  This is inconsistent with the
> behaviour of a simple "for".
> So I do think that the macros should be fixed, and I don't think that
> sprinkling extra braces is an appropriate response.
> 
> I'm not personally convinced that writing
>    if_no_else(cond)
> is easier than just writing
>    if (!(cond)); else

agreed.

> in these macros, but I do think that the macros should be fixed and
> maybe this is the path-of-least-resistance to getting it done.

I'm not opposed to fixing some macros, but some of these macros are just
ease-of-less-typing shortcuts.  They don't improve readability at all;
they harm it.  (of course, that is just one opinion :)



-- 
~Randy
