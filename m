Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4AECC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8599420844
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730037AbfBEXIG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 18:08:06 -0500
Received: from terminus.zytor.com ([198.137.202.136]:49039 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726927AbfBEXIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 18:08:06 -0500
Received: from [IPv6:2601:646:8680:2bb1:34bd:8de1:bd14:4ee9] ([IPv6:2601:646:8680:2bb1:34bd:8de1:bd14:4ee9])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x15N7o5q1039341
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Tue, 5 Feb 2019 15:07:51 -0800
Date:   Tue, 05 Feb 2019 15:07:42 -0800
User-Agent: K-9 Mail for Android
In-Reply-To: <f41a5d14-b642-0969-3c7a-cc12b820d208@infradead.org>
References: <20190201205319.15995-1-chang.seok.bae@intel.com> <20190201205319.15995-2-chang.seok.bae@intel.com> <CALCETrXi=PEOXCQYkCO9BLL+oaoJonRohWoxvUqxZdiWURc3=Q@mail.gmail.com> <20190205132146.2e61b3df9e7be49e22b7d903@linux-foundation.org> <f41a5d14-b642-0969-3c7a-cc12b820d208@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v5 01/13] taint: Introduce a new taint flag (insecure)
To:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>
CC:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
From:   hpa@zytor.com
Message-ID: <3B92973A-A2D2-4FCB-A2A2-030057229D4B@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On February 5, 2019 2:46:11 PM PST, Randy Dunlap <rdunlap@infradead.org> wrote:
>On 2/5/19 1:21 PM, Andrew Morton wrote:
>> On Fri, 1 Feb 2019 18:42:29 -0800 Andy Lutomirski <luto@kernel.org>
>wrote:
>> 
>>> On Fri, Feb 1, 2019 at 12:54 PM Chang S. Bae
><chang.seok.bae@intel.com> wrote:
>>>>
>>>> For testing (or root-only) purposes, the new flag will serve to tag
>the
>>>> kernel taint accurately.
>>>>
>>>> When adding a new feature support, patches need to be incrementally
>>>> applied and tested with temporal parameters. Currently, there is no
>flag
>>>> for this usage.
>>>
>>> I think this should be reviewed by someone like akpm.  akpm, for
>>> background, this is part of an x86 patch series.  If only part of
>the
>>> series is applied, the kernel will be blatantly insecure (but still
>>> functional and useful for testing and bisection), and this taint
>flag
>>> will be set if this kernel is booted.  With the whole series
>applied,
>>> there are no users of the taint flag in the kernel.
>>>
>>> Do you think this is a good idea?
>> 
>> What does "temporal parameters" mean?  A complete description of this
>> testing process would help.
>> 
>> I sounds a bit strange.  You mean it assumes that people will
>partially
>> apply the series to test its functionality?  That would be
>inconvenient.
>
>Ack.  I don't think we need to (or should) worry about that kind of
>muckup.
>
>> - Can the new and now-unused taint flag be removed again at
>>   end-of-series?
>> 
>> - It would be a lot more convenient if we had some means of testing
>>   after the whole series is applied, on a permanent basis - some
>>   debugfs flag, perhaps?
>> 

I would like to see this taint flag, though, because sometimes it is useful to write test modules (e.g. when I was testing SMAP) which are dangerous even if out of tree.

In case of an escape or pilot error gets it into the wrong kernel, it is a very good thing to have the kernel flagged.
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
