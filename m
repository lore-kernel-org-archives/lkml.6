Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C62C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 15:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AEA021733
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 15:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IDeuB5Ib"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AEA021733
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732564AbeHNSF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 14:05:27 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39814 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732063AbeHNSF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 14:05:27 -0400
Received: by mail-pf1-f194.google.com with SMTP id j8-v6so9389153pff.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 08:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WcjsWNlcr8TRn0d1+jmwlAKFm8MGLJqKabVwN5Y30lw=;
        b=IDeuB5IbtSGqfIAj7KoAMBC822txbx1/1zVAjjTyfBvTw4S3g3bD1R+QT7ZTAAmWSk
         C1kbEYS46+3n1mVGpCkCPUk1kTVA7vCVySlBWK2T4kwP476KfflFSZppCA6igjF2+6Ed
         8ZeozQNp41jaR6pumsGGhA6yfDNA+HLWtKKq9LUkC2N6Z2YAJmGh5d9J5stEyjXRzmon
         MTqwkgqDt2E+t7r3eFwKEJekem3xL4O3x97lrKUE4oAlLPDse05h9NLyJZT6UEv4o7th
         uuuGvyb66QMDWSrLSUp76bG+ER0DhXOB63ox1tM+lk32bi5c215Wr9/G7FDIsoNE3ot1
         UmnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WcjsWNlcr8TRn0d1+jmwlAKFm8MGLJqKabVwN5Y30lw=;
        b=S/EFFHsPmpO6dL69t53b/eak4Pul1cueKNw1VWXVSjgpuYhqi+1vSZFybOngVHjvkW
         T2+lRRlJVOIj7DTmybczmH9n7jcfaAO4wDftuTPGrOkuZn5qmgmE9iPhg5hL1hyPZ4hx
         2+gO5HEdcib2IyUfk/VfUNmZs7t3YkT2tnlXXSGLceW1yCiN/KQy8x2Yz5wl6xD1r7sn
         66+DLHh5zJKPEO3BUcFzUKtxkHrLkBYjy31vZ8MDkvAsioEX0rM15LZZx7LsR1/Z8ocn
         zvc2RILL9+QRssrIx7ndwJtm6XH+IZcqUnQc/HdrU0KrmgmUeFjz4jiLZc7NmcHSPrme
         uMEQ==
X-Gm-Message-State: AOUpUlGLQ+fIilUXAV/lTu0/h1emTiNTriM2GVgT+LIrl4SKYrRffwLy
        BDWLqDx3OgG3MfBo8sGl/bCRe8Lg3hSZUw==
X-Google-Smtp-Source: AA+uWPz31vXNY1a1ktere+XwcTSdrOQWWASEGKk1x368AwwuPRhB0+4lL0JEeFnJNkcQryFVeerHxw==
X-Received: by 2002:a62:3703:: with SMTP id e3-v6mr23889495pfa.117.1534259871049;
        Tue, 14 Aug 2018 08:17:51 -0700 (PDT)
Received: from hackmann.mtv.corp.google.com ([2620:0:1000:1601:82f7:8f1:8c08:a97a])
        by smtp.gmail.com with ESMTPSA id 143-v6sm33437590pfy.156.2018.08.14.08.17.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 08:17:50 -0700 (PDT)
Subject: Re: [PATCH] arm64: mm: check for upper PAGE_SHIFT bits in pfn_valid()
To:     Will Deacon <will.deacon@arm.com>,
        Greg Hackmann <ghackmann@android.com>
Cc:     linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Steve Capper <steve.capper@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Stefan Agner <stefan@agner.ch>,
        CHANDAN VN <chandan.vn@samsung.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org
References: <20180813193013.236362-1-ghackmann@google.com>
 <20180814104041.GB28664@arm.com>
From:   Greg Hackmann <ghackmann@google.com>
Message-ID: <eb90a28e-893c-e02e-a9c2-1d988f08cf3a@google.com>
Date:   Tue, 14 Aug 2018 08:17:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180814104041.GB28664@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/14/2018 03:40 AM, Will Deacon wrote:
> Hi Greg,
> 
> On Mon, Aug 13, 2018 at 12:30:11PM -0700, Greg Hackmann wrote:
>> ARM64's pfn_valid() shifts away the upper PAGE_SHIFT bits of the input
>> before seeing if the PFN is valid.  This leads to false positives when
>> some of the upper bits are set, but the lower bits match a valid PFN.
>>
>> For example, the following userspace code looks up a bogus entry in
>> /proc/kpageflags:
>>
>>     int pagemap = open("/proc/self/pagemap", O_RDONLY);
>>     int pageflags = open("/proc/kpageflags", O_RDONLY);
>>     uint64_t pfn, val;
>>
>>     lseek64(pagemap, [...], SEEK_SET);
>>     read(pagemap, &pfn, sizeof(pfn));
>>     if (pfn & (1UL << 63)) {        /* valid PFN */
>>         pfn &= ((1UL << 55) - 1);   /* clear flag bits */
>>         pfn |= (1UL << 55);
>>         lseek64(pageflags, pfn * sizeof(uint64_t), SEEK_SET);
>>         read(pageflags, &val, sizeof(val));
>>     }
>>
>> On ARM64 this causes the userspace process to crash with SIGSEGV rather
>> than reading (1 << KPF_NOPAGE).  kpageflags_read() treats the offset as
>> valid, and stable_page_flags() will try to access an address between the
>> user and kernel address ranges.
>>
>> Signed-off-by: Greg Hackmann <ghackmann@google.com>
>> ---
>>  arch/arm64/mm/init.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> Thanks, this looks like a sensible fix to me. Do you think it warrants a
> CC stable?
> 
> Will

Yes, I think so.  Should I resend with a "Fixes" field?
