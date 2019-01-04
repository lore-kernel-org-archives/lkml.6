Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F9BC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53F3A218D8
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546626890;
	bh=JUlTDHO9TTmsNqbCvZrFJ7Rp6XvR6+Y2zTU+IuCjvwE=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=yuotyxmY+TIeqrmO5G2XirAHXfAxYBb+cD/xCt2f9pzyYEYtXnHOlFfVdzpxwPjEr
	 xgmnBm/SOn6UYf6b72yu+ROImJ1UUPdYO/K4xObdJ3TC8zgCw4nV8IofYmYxa5m1eb
	 SMKoaz1gMVvB1h1oTNyZ0Qazs1bDSh7K3NgMH2jQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbfADSet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 13:34:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:53664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728797AbfADSeq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 13:34:46 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C8D1218EA;
        Fri,  4 Jan 2019 18:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546626886;
        bh=JUlTDHO9TTmsNqbCvZrFJ7Rp6XvR6+Y2zTU+IuCjvwE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Hw6YsQGvVYuYCX1kKuv/scECR/60oeDgHqZ66bV6wPRA30Mb9e0BJxBEnpStQcVLh
         3naU+1xFFF3JLijK+yJEeeFMflDn+sZa4X0DnK/e/yvdAh1emPietATAhzadgAOtgS
         JZLB8ee5Ve2R6QpuPtgC6zmNc0kg9y0ZRPioZJLk=
Subject: Re: [RFC PATCH 3/3] selftests/vm: add script helper for
 CONFIG_TEST_VMALLOC_MODULE
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Thomas Gleixner <tglx@linutronix.de>, shuah <shuah@kernel.org>
References: <20190103142108.20744-1-urezki@gmail.com>
 <20190103142108.20744-4-urezki@gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <d62089c4-8225-6363-1de5-ff2e8a3f684e@kernel.org>
Date:   Fri, 4 Jan 2019 11:34:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190103142108.20744-4-urezki@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/3/19 7:21 AM, Uladzislau Rezki (Sony) wrote:
> Add the test script for the kernel test driver to analyse vmalloc
> allocator for benchmarking and stressing purposes. It is just a kernel
> module loader. You can specify and pass different parameters in order
> to investigate allocations behaviour. See "usage" output for more
> details.
> 
> Also add basic vmalloc smoke test to the "run_vmtests" suite.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---

Thanks for adding skip handling. Here is my

Reviewed-by: Shuah Khan <shuah@kernel.org>

for Andrew to take this through mm tree.

thanks,
-- Shuah
