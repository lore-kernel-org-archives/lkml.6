Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FBFC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 15:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10EAF208FE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 15:40:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10EAF208FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbeHWTKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 15:10:42 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48484 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727881AbeHWTKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 15:10:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85F327A9;
        Thu, 23 Aug 2018 08:40:30 -0700 (PDT)
Received: from e107564-lin.cambridge.arm.com (e107564-lin.cambridge.arm.com [10.2.131.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 755863F2EA;
        Thu, 23 Aug 2018 08:40:28 -0700 (PDT)
Date:   Thu, 23 Aug 2018 16:40:22 +0100
From:   Brian Starkey <brian.starkey@arm.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Eric Engestrom <eric.engestrom@intel.com>,
        Alexandru-Cosmin Gheorghe <alexandru-cosmin.gheorghe@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Dave Airlie <airlied@linux.ie>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sean Paul <seanpaul@chromium.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Ayan Kumar Halder <ayan.halder@arm.com>
Subject: Re: [PATCH] drm/fourcc: Add DOC: overview comment
Message-ID: <20180823154022.GA6535@e107564-lin.cambridge.arm.com>
References: <20180821161611.10424-1-brian.starkey@arm.com>
 <20180821162639.GA21697@bombadil.infradead.org>
 <20180821164416.GA11553@e107564-lin.cambridge.arm.com>
 <20180822145924.GA13763@intel.com>
 <CAKMK7uHxPDfxJaA+1esSW8L2HAjMD6xgF0cMH-nkTjA=6S5+CA@mail.gmail.com>
 <20180822155732.GA39066@e107564-lin.cambridge.arm.com>
 <20180823143445.GA26109@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180823143445.GA26109@bombadil.infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

On Thu, Aug 23, 2018 at 07:34:45AM -0700, Matthew Wilcox wrote:
>On Wed, Aug 22, 2018 at 04:57:33PM +0100, Brian Starkey wrote:
>> On Wed, Aug 22, 2018 at 05:11:55PM +0200, Daniel Vetter wrote:
>> > On Wed, Aug 22, 2018 at 4:59 PM, Eric Engestrom
>> > <eric.engestrom@intel.com> wrote:
>> > > On Tuesday, 2018-08-21 17:44:17 +0100, Brian Starkey wrote:
>> > > > On Tue, Aug 21, 2018 at 09:26:39AM -0700, Matthew Wilcox wrote:
>> > > > > Can you turn them into enums?  This seems to work ok:
>>
>> I'm not sure that swapping out explicit 32-bit unsigned integers for
>> enums (unspecified width, signed integers) is necessarily a good idea,
>> it seems like Bad Things could happen.
>>
>> The C spec says:
>>
>>   "the value of an enumeration constant shall be an integer constant
>>   expression that has a value representable as an int"
>>
>> Which likely gives us 4 bytes to play with on all machines
>> that run Linux, but if drm_fourcc.h is ever going to be some kind of
>> standard reference, making it non-portable seems like a fail.
>>
>> And even if you do have 4 bytes in an enum, signed integers act
>> differently from unsigned ones, and compilers do love to invoke the UB
>> clause...
>
>I think you're exaggerating how much latitude C compilers have here.
>Further down in 6.7.2.2, it says:
>
>  Each enumerated type shall be compatible with char, a signed
>  integer type, or an unsigned integer type.  The choice of type is
>  implementation-defined, but shall be capable of representing the values
>  of all the members of the enumeration.
>
>So if we include an integer which isn't representable in a plain int,
>then the compiler _must_ choose a larger type.

I don't think so... the sentence I pasted says that including a value
which isn't representable in a plain int would be illegal, and so the
compiler doesn't _have_ to do anything (nasal demons, right?).

>It could choose a
>signed-64-bit type rather than an unsigned-32-bit type, but I can't
>imagine any compiler being quite so insane.

The paragraph about the implementation choosing a representation is
separate from the valid range of values - the compiler can pick
whatever storage it likes (smaller or even larger than an int), so
long as that storage can fit all the defined values. However,
providing a value in an enum definition which is not representable as
an int would still be invalid (irrespective of how large the storage
is) - it's a separate restriction.

Anyhow, I'm not dying to replace all the current definitions with
enums, so if someone else wants to pick that up, be my guest.

Cheers,
-Brian
