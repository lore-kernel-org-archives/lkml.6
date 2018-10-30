Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3ACFC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 21:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C5620664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 21:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMZOk7UY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40C5620664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbeJaGvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 02:51:03 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35560 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725743AbeJaGvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 02:51:02 -0400
Received: by mail-lf1-f66.google.com with SMTP id d7-v6so10118277lfi.2;
        Tue, 30 Oct 2018 14:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sB1PU5Z96Q9I4jKKu4z3PUkeLmdLtuGz5xQW423nXzA=;
        b=bMZOk7UYCN9+LHGeXp9Wm7t+q5kaiSJ9JHKuYoehE4bEGKkMeiP5hYbxjznDIeK5j1
         C51vyjeBsEkxI8yCBfFq1Lwk00mSLhfPDKM0kBEj3VZegdA7L8PPLqp0UOZxSkj1BlnP
         onFRMexdgleMxnWWFtdG1CJ3Mv9rVbhboPiKBXCX+1+4cVqlom1XKU16UsLVbNTVOXT0
         i6GwAmJHDBYTRXld69VmUugUAgLmQW1iG+l5NzaHUaQWIz/Zgadti1PkbfGsFl+ND39E
         v+fyIVaGtVLuqaa0Q5upef7crZwN2L+dzhlwozoXigcIcbIqtU4gmTNxKTzdG8V3pAOz
         yVHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sB1PU5Z96Q9I4jKKu4z3PUkeLmdLtuGz5xQW423nXzA=;
        b=PC0fwKhyvPkrYYoEJNod/8yof/8mI/mBIJvCJ7Blb/Nnqasq50DHMu+TQS6oGv1EE/
         8z4teXtkhyOa17rWhM529mdaFACoJ0s2uEW5qsPliiVl6dngpQ4qovZ7NkbMHAi1ZRVm
         /ksmKv1Qiqty1g8jRHCfse0wZS6g/IqVd6j3xRcvKKrRNVUKV+Na7Ghum4vn9MV8XBU3
         QxXSi55QpWg7cuSmRR70jBcYXLmbfPY34Uw7A8YQ+92wS9y4+E0exvHNXsFrGsfIISN0
         HlW9/P35vWMAizBx1+tGnBWyuoYfxvMSbuKpDnPdMxnnNbFcI1lx96NuxoS0IYa9kG9p
         ykgQ==
X-Gm-Message-State: AGRZ1gJSkXvPncE/UFY9RWLlM09fY8nhhOc1ZWGDSxHjhOXGWDlPfwgp
        /jwGw2fx6j6Ri6o/vBc/0gM=
X-Google-Smtp-Source: AJdET5eZl5Gs7Dk738yvN1ykyAbdzzg/vey7h/m2jkDeAxT1Ws1rqeGCKPuMWFkCmy/wpNjEpkWRIQ==
X-Received: by 2002:a19:6f0a:: with SMTP id k10mr236020lfc.119.1540936548844;
        Tue, 30 Oct 2018 14:55:48 -0700 (PDT)
Received: from [192.168.10.160] (91-159-62-242.elisa-laajakaista.fi. [91.159.62.242])
        by smtp.gmail.com with ESMTPSA id d24-v6sm3797656lfj.64.2018.10.30.14.55.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 14:55:48 -0700 (PDT)
Subject: Re: [PATCH 10/17] prmem: documentation
To:     Matthew Wilcox <willy@infradead.org>,
        Andy Lutomirski <luto@amacapital.net>
Cc:     nadav.amit@gmail.com, Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Igor Stoppa <igor.stoppa@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20181023213504.28905-11-igor.stoppa@huawei.com>
 <20181026092609.GB3159@worktop.c.hoisthospitality.com>
 <CAGXu5jKCs01jvtvpEFS7R8qCR-5iRqK11kJxLJY99NicGWc4aQ@mail.gmail.com>
 <20181028183126.GB744@hirez.programming.kicks-ass.net>
 <40cd77ce-f234-3213-f3cb-0c3137c5e201@gmail.com>
 <20181030152641.GE8177@hirez.programming.kicks-ass.net>
 <CAGXu5jJftJ+Hq+jrZGHX5CTDLWOog7kGsd_Ne=yMvrRs__skSg@mail.gmail.com>
 <0A7AFB50-9ADE-4E12-B541-EC7839223B65@amacapital.net>
 <20181030175814.GB10491@bombadil.infradead.org>
 <28C8CD2A-BDC0-49A5-854E-1E18968528B8@amacapital.net>
 <20181030212551.GD10491@bombadil.infradead.org>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <a62a1fed-252b-f4c8-8abb-0e4468f50fe8@gmail.com>
Date:   Tue, 30 Oct 2018 23:55:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181030212551.GD10491@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/10/2018 23:25, Matthew Wilcox wrote:
> On Tue, Oct 30, 2018 at 11:51:17AM -0700, Andy Lutomirski wrote:
>> Finally, one issue: rare_alloc() is going to utterly suck
>> performance-wise due to the global IPI when the region gets zapped out
>> of the direct map or otherwise made RO.  This is the same issue that
>> makes all existing XPO efforts so painful. We need to either optimize
>> the crap out of it somehow or we need to make sure it’s not called
>> except during rare events like device enumeration.
> 
> Batching operations is kind of the whole point of the VM ;-)  Either
> this rare memory gets used a lot, in which case we'll want to create slab
> caches for it, make it a MM zone and the whole nine yeards, or it's not
> used very much in which case it doesn't matter that performance sucks.
> 
> For now, I'd suggest allocating 2MB chunks as needed, and having a
> shrinker to hand back any unused pieces.

One of the prime candidates for this sort of protection is IMA.
In the IMA case, there are ever-growing lists which are populated when 
accessing files.
It's something that ends up on the critical path of any usual 
performance critical use case, when accessing files for the first time, 
like at boot/application startup.

Also the SELinux AVC is based on lists. It uses an object cache, but it 
is still something that grows and is on the critical path of evaluating 
the callbacks from the LSM hooks. A lot of them.

These are the main two reasons, so far, for me advocating an 
optimization of the write-rare version of the (h)list.

--
igor
