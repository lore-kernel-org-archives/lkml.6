Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5724C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 15:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 886702150F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 15:57:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 886702150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbeHVTXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 15:23:08 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34982 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729153AbeHVTXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 15:23:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9E5680D;
        Wed, 22 Aug 2018 08:57:40 -0700 (PDT)
Received: from e107564-lin.cambridge.arm.com (e107564-lin.cambridge.arm.com [10.2.131.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B82EA3F2EA;
        Wed, 22 Aug 2018 08:57:38 -0700 (PDT)
Date:   Wed, 22 Aug 2018 16:57:33 +0100
From:   Brian Starkey <brian.starkey@arm.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Eric Engestrom <eric.engestrom@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
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
Message-ID: <20180822155732.GA39066@e107564-lin.cambridge.arm.com>
References: <20180821161611.10424-1-brian.starkey@arm.com>
 <20180821162639.GA21697@bombadil.infradead.org>
 <20180821164416.GA11553@e107564-lin.cambridge.arm.com>
 <20180822145924.GA13763@intel.com>
 <CAKMK7uHxPDfxJaA+1esSW8L2HAjMD6xgF0cMH-nkTjA=6S5+CA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAKMK7uHxPDfxJaA+1esSW8L2HAjMD6xgF0cMH-nkTjA=6S5+CA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 22, 2018 at 05:11:55PM +0200, Daniel Vetter wrote:
>On Wed, Aug 22, 2018 at 4:59 PM, Eric Engestrom
><eric.engestrom@intel.com> wrote:
>> On Tuesday, 2018-08-21 17:44:17 +0100, Brian Starkey wrote:
>>> Hi Matthew,
>>>
>>> On Tue, Aug 21, 2018 at 09:26:39AM -0700, Matthew Wilcox wrote:
>>> > On Tue, Aug 21, 2018 at 05:16:11PM +0100, Brian Starkey wrote:
>>> > > There's a number of things which haven't previously been documented
>>> > > around the usage of format modifiers. Capture the current
>>> > > understanding in an overview comment and add it to the rst
>>> > > documentation.
>>> > >
>>> > > Ideally, the generated documentation would also include documentation
>>> > > of all of the #defines, but the kernel-doc system doesn't currently
>>> > > support kernel-doc comments on #define constants.
>>> >
>>> > Can you turn them into enums?  This seems to work ok:
>>> >
>>> > -/* color index */
>>> > -#define DRM_FORMAT_C8          fourcc_code('C', '8', ' ', ' ') /* [7:0] C */
>>> > -
>>> > -/* 8 bpp Red */
>>> > -#define DRM_FORMAT_R8          fourcc_code('R', '8', ' ', ' ') /* [7:0] R */
>>> > +enum {
>>> > +       /* color index */
>>> > +       DRM_FORMAT_C8   = fourcc_code('C', '8', ' ', ' '), /* [7:0] C */
>>> > +       /* 8 bpp Red */
>>> > +       DRM_FORMAT_R8   = fourcc_code('R', '8', ' ', ' '), /* [7:0] R */
>>> > +};
>>> >
>>> > but I appreciate this is user API and maybe there's some code out there
>>> > that does #ifndef DRM_FORMAT_C8 ...
>>>
>>> Thanks for the suggestion, Daniel did mention the same. However,
>>> unfortunately I don't think we can safely change the UAPI header in
>>> this manner.
>>
>> You could get the best of both worlds by doing both:
>>
>>   enum {
>>     foo = fourcc(...),
>>     bar = fourcc(...),
>>   }
>>   #define foo foo
>>   #define bar bar
>>
>> It would mean a bit more code though, but that way these would now be
>> enums (with all the advantages of enums vs plain literals) and still
>> pass #ifdef checks :)
>>
>> (BTW, on the "maybe there's some code that does #ifdef": I can tell you
>> there is indeed, having written this myself for an out-of-tree driver
>> for customer-modified kernels that may contain additional formats)
>
>Looks reasonable. I'd even put the #define right within each enum line
>(as a reminder so people don't forget to add them. Would happily ack a
>patch to mass-convert, if that ups the odds of good kerneldoc for all
>this.
>
>enum also should support the inline style of kerneldoc (otherwise I
>guess we'd need to fix that first, or it just makes no sense at all).
>-Daniel

I'm not sure that swapping out explicit 32-bit unsigned integers for
enums (unspecified width, signed integers) is necessarily a good idea,
it seems like Bad Things could happen.

The C spec says:

   "the value of an enumeration constant shall be an integer constant
   expression that has a value representable as an int"

Which likely gives us 4 bytes to play with on all machines
that run Linux, but if drm_fourcc.h is ever going to be some kind of
standard reference, making it non-portable seems like a fail.

And even if you do have 4 bytes in an enum, signed integers act
differently from unsigned ones, and compilers do love to invoke the UB
clause...

Cheers,
-Brian

>-- 
>Daniel Vetter
>Software Engineer, Intel Corporation
>+41 (0) 79 365 57 48 - http://blog.ffwll.ch
