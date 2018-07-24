Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6750BC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CC2320883
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIFIq1vq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CC2320883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388483AbeGXSrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 14:47:07 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37431 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388415AbeGXSrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 14:47:07 -0400
Received: by mail-pg1-f194.google.com with SMTP id n7-v6so3393961pgq.4;
        Tue, 24 Jul 2018 10:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eGZWxv+LwE1ih3ikFvH9S15PdxEiEv0sw85tyEDFUCo=;
        b=GIFIq1vqCbvwoQA8ALuie06hKtXwxXrWpXizEDdUto4MLBLheQzAcn3ACUEIJNB2Nx
         dDuQPYz3ILrj2IgsfJA5LyJIHO/134/CRZZhqudYAklzgVkqdhmIl7+kBlGR+4MZ6knl
         un7yqOxx8Mkz1gdlmDpdSYt2vxb4QIgt/rTneCcE41RaniDYYIbk+LrBRSu/AasVNVnb
         aRRwSci0lUDC0PmXlQOZn9XjZmh1lBH9ICqOmZLfahmNE58SayCLy4N4YUBaj1C7r4cE
         V38g3MNVPvZRKQI5g+ze+pKFum9zXi8efZdg+PiiVWYvbTK+UmY++x0mAgq6t/ELKVZI
         KVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eGZWxv+LwE1ih3ikFvH9S15PdxEiEv0sw85tyEDFUCo=;
        b=XWzDFu6V5wsbi3ZOTFdNg1HWvwEzGxC61zGKUWLfVBCqAIZPsb8LcpNZC0I0GYAGSS
         Qj2lmsXwlsLur30JpeeLKf9+yd2L6jNy2HBGgXAvRRRwP0SJvZPnCiXo+IQn8J8gUxqg
         7LnH6RfY2ugTLrooUDbTCnUomIVlIpNWdWyz3+7bgD2HBgmwWuigi/jQA9GZxs0NtZYd
         WTtd/Rj9Ar7/3TeYk31L6kZ8IoeUGLQ5C2cU4TC+HZJ2rfYoVkL54ie7DDD/jAzV8xJV
         qkcYWMtfJO6c/EwFNV8fo7yKoqvICLj2IBGp+h3LG1UFuABHeChta5ZV+uFNFngST/yO
         HIrg==
X-Gm-Message-State: AOUpUlHfFI951FQ89cq+uzeXjjM+LBIEziQSi1YgyTlA2qnKu9ATJz/w
        D7fW9udMWsYqnPzerL7dOHE=
X-Google-Smtp-Source: AAOMgpcWQtjPazvChf0bb/jG5mY8e9B4mWgSrSulrQfc2Ng4EVo1VGQTJJRIov9YGHKggOeHfH3Hsw==
X-Received: by 2002:a62:23c2:: with SMTP id q63-v6mr18683548pfj.91.1532453973054;
        Tue, 24 Jul 2018 10:39:33 -0700 (PDT)
Received: from gmail.com ([2620:15c:17:3:dc28:5c82:b905:e8a8])
        by smtp.gmail.com with ESMTPSA id i3-v6sm11603714pgq.35.2018.07.24.10.39.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 10:39:32 -0700 (PDT)
Date:   Tue, 24 Jul 2018 10:39:30 -0700
From:   Eric Biggers <ebiggers3@gmail.com>
To:     Coly Li <colyli@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-block@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Noah Massey <noah.massey@gmail.com>
Subject: Re: [PATCH v4 3/3] lib/test_crc: Add test cases for crc calculation
Message-ID: <20180724173930.GA194165@gmail.com>
References: <20180718165545.1622-1-colyli@suse.de>
 <20180718165545.1622-4-colyli@suse.de>
 <20180724044420.GB1944@sol.localdomain>
 <2feeece1-6d92-aa08-c9b6-1b0c646eed29@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2feeece1-6d92-aa08-c9b6-1b0c646eed29@suse.de>
User-Agent: Mutt/1.10+35 (c786a508) (2018-06-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 12:28:15AM +0800, Coly Li wrote:
> On 2018/7/24 12:44 PM, Eric Biggers wrote:
> > On Thu, Jul 19, 2018 at 12:55:45AM +0800, Coly Li wrote:
> >> This patch adds a kernel module to test the consistency of multiple crc
> >> calculation in Linux kernel. It is enabled with CONFIG_TEST_CRC enabled.
> >>
> >> The test results are printed into kernel message, which look like,
> >>
> >> test_crc: crc64_be: FAILED (0x03d4d0d85685d9a1, expected 0x3d4d0d85685d9a1f)
> >>
> >> kernel 0day system has framework to check kernel message, then the above
> >> result can be handled by 0day system. If crc calculation inconsistency
> >> happens, it can be detected quite soon.
> >>
> >> lib/test_crc.c is a testing frame work for many crc consistency
> >> testings. For now, there is only one test caes for crc64_be().
> > 
> > Are you aware there's already a CRC-32 test module: CONFIG_CRC32_SELFTEST and
> > lib/crc32test.c?  Confusingly, your patch uses a different naming convention for
> > the new CRC-64 one, and puts the Kconfig option in a different place, and makes
> > it sound like it's a generic test for all CRC implementations rather than just
> > the CRC-64 one.  Please use the existing convention (i.e. add
> > CONFIG_CRC64_SELFTEST and lib/crc64test.c) unless you have a strong argument for
> > why it should be done differently.
> > 
> > (And I don't think it makes sense to combine all CRC tests into one module,
> > since you should be able to e.g. enable just CRC32 and CRC32_SELFTEST without
> > also pulling in a dependency on all the other CRC variants.)
> > 
> 
> Hi Eric,
> 
> The purpose of test_crc is to provide a unified crc calculation
> consistency testing for 0day. So far it is only crc64, and I will add
> more test cases later. I see there is crc-32 test module, which does
> more testing then consistency check, and no unified format for 0day
> system to detect. This is why people suggested me to add this test
> framework.
> 

Actually the code in crc32test is nearly the same as what you're adding for
CRC-64.  The CRC-32 test is longer because it's testing two different
polynomials "crc32" and "crc32c" as well as combining CRC's; neither of those is
relevant for CRC-64 yet, as you've implemented just one polynomial and there is
no function provided to combine CRC64's yet.  The CRC-32 test also tests
performance, but if you don't believe CRC performance should be tested, then you
should remove the performance test from the existing module rather than
implementing a brand new test module just to remove the performance test...

I still don't understand why you decided to do things differently for CRC-64,
when there were already CRC-32 tests that used a certain convention for the
Kconfig option, filename, etc.  It's inconsistent and confusing.  Again, please
use the existing convention unless you have a strong argument for why it should
be done differently.  (And if you do want to do things differently, the existing
test should be converted first.)

- Eric
