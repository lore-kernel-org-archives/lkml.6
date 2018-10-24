Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFA3ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 16:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DCD220833
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 16:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEehiHwI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DCD220833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbeJYBF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 21:05:57 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42929 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbeJYBF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 21:05:57 -0400
Received: by mail-lj1-f193.google.com with SMTP id z9-v6so558800ljk.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 09:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CBH6pxQUT3aBGzjy1pRlWiZdbQKJpXP8e2xUJi7BgwM=;
        b=SEehiHwImgQzipfu0zVeQ1EMIMLIpHLuvzfL1CMpHoWB1tyxCWzhpTA79gaYFmYZq5
         Bmu388TuD0Lpktm3ogF7cxwFZVsDu03gX8d+hbRB5vQasPkH1SJGJtA74jkUVAF6w54g
         rKqiJxSObfaKlBusAUojJcvy9uGPCdaZTGQQ8jVL5FovyUEw59QSFldBp1l67q8S6tnh
         oa4QSUokgEt0zyxEgQw7nRfWFg1GGIkeyINZTyrFGiGItiqzCIgmisqZhGRdk60M/wYc
         GIPHkh0f7+vvz+oV+2BLWTy816lDpykS7NiD1ZSra6McivrfF3om5Lo1nHFvgl8cvS1m
         N2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CBH6pxQUT3aBGzjy1pRlWiZdbQKJpXP8e2xUJi7BgwM=;
        b=cO9N8pEYDK7GBX9NIdoY9I+gByo3jg8F2rYOlgKloPagYaiXWbzNjdsJdX2aQaDiiG
         kpJ0tSL1iIUppTd5Qq+JOtaZpV6vm6BnGagR84A4vE/ELU7pesj2ziSf5gUlbG1q9fJR
         TcdKs6Z/rHPRUJ0XGzwBE+dJrAy4G3JqZZ8l2okxlW49Q2VyZ7PQLIFgB3F7d8eSHamc
         i+d52Hxg7kSdquYxUNssyT2a2eaWuLVVHNhW9jgKt2T2VbMwGNqTgyMm4tiVy+Kj+OXf
         p6q6ssMBjYDFGTcyT8DOt2M+MD+/W+ZGdu9UoITCtg+3XdvoUeQ7tiwrxQxZ7/ZxY6nC
         OQXA==
X-Gm-Message-State: AGRZ1gLcl8hflxCWVg8Hp2w4vxx4+2ktlxKYvBtydumQo1/YGCmSEj1T
        hSsmM14GLoQHenKAbvdaK7E=
X-Google-Smtp-Source: AJdET5eSPAyU2T+CZto70qnVp48mbVQzKR323F5oOEv22Zj21Nds6Gkz3Z+3m8vIVEgS/hPYAbpJVA==
X-Received: by 2002:a2e:9c59:: with SMTP id t25-v6mr2452180ljj.107.1540399028644;
        Wed, 24 Oct 2018 09:37:08 -0700 (PDT)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id d17-v6sm799467lfg.97.2018.10.24.09.37.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 09:37:07 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 24 Oct 2018 18:36:58 +0200
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Shuah Khan <shuah@kernel.org>, Michal Hocko <mhocko@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Subject: Re: [RFC PATCH 0/2] improve vmalloc allocation
Message-ID: <20181024163658.ojar7gvstaycn2wz@pc636>
References: <20181019173538.590-1-urezki@gmail.com>
 <20181022125142.GD18839@dhcp22.suse.cz>
 <20181022165253.uphv3xzqivh44o3d@pc636>
 <20181023072306.GN18839@dhcp22.suse.cz>
 <dd0c3528-9c01-12bc-3400-ca88060cb7cf@kernel.org>
 <20181023152640.GD20085@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023152640.GD20085@bombadil.infradead.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 08:26:40AM -0700, Matthew Wilcox wrote:
> On Tue, Oct 23, 2018 at 09:02:56AM -0600, Shuah Khan wrote:
> > Hi Michal,
> > 
> > On 10/23/2018 01:23 AM, Michal Hocko wrote:
> > > Hi Shuah,
> > > 
> > > On Mon 22-10-18 18:52:53, Uladzislau Rezki wrote:
> > >> On Mon, Oct 22, 2018 at 02:51:42PM +0200, Michal Hocko wrote:
> > >>> Hi,
> > >>> I haven't read through the implementation yet but I have say that I
> > >>> really love this cover letter. It is clear on intetion, it covers design
> > >>> from high level enough to start discussion and provides a very nice
> > >>> testing coverage. Nice work!
> > >>>
> > >>> I also think that we need a better performing vmalloc implementation
> > >>> long term because of the increasing number of kvmalloc users.
> > >>>
> > >>> I just have two mostly workflow specific comments.
> > >>>
> > >>>> A test-suite patch you can find here, it is based on 4.18 kernel.
> > >>>> ftp://vps418301.ovh.net/incoming/0001-mm-vmalloc-stress-test-suite-v4.18.patch
> > >>>
> > >>> Can you fit this stress test into the standard self test machinery?
> > >>>
> > >> If you mean "tools/testing/selftests", then i can fit that as a kernel module.
> > >> But not all the tests i can trigger from kernel module, because 3 of 8 tests
> > >> use __vmalloc_node_range() function that is not marked as EXPORT_SYMBOL.
> > > 
> > > Is there any way to conditionally export these internal symbols just for
> > > kselftests? Or is there any other standard way how to test internal
> > > functionality that is not exported to modules?
> > > 
> > 
> > The way it can be handled is by adding a test module under lib. test_kmod,
> > test_sysctl, test_user_copy etc.
> 
> The problem is that said module can only invoke functions which are
> exported using EXPORT_SYMBOL.  And there's a cost to exporting them,
> which I don't think we're willing to pay, purely to get test coverage.
> 
> Based on my own experience with the IDA & XArray test suites, I would
> like to propose a solution which does not require exporting all of
> these symbols:
> 
> Create a new kernel module in mm/test_vmalloc.c
> 
> Towards the top of that file,
> 
> #include <linux/export.h>
> #undef EXPORT_SYMBOL
> #define EXPORT_SYMBOL(x)	/* */
> #include "vmalloc.c"
> 
> Now you can invoke even static functions from your test harness.
I see your point. But i also think that it would not be so easy to go.

<snip>
#undef CONFIG_HAVE_ARCH_HUGE_VMAP
#undef CONFIG_PROC_FS

#include "../hikey_linux.git/mm/vmalloc.c"
#include <linux/random.h>
<snip>

<snip>
  LD [M]  /mnt/coding/vmalloc_performance_test/vmalloc_test.o
  Building modules, stage 2.
  MODPOST 1 modules
WARNING: "__pud_alloc" [/mnt/coding/vmalloc_performance_test/vmalloc_test.ko] undefined!
WARNING: "__sync_icache_dcache" [/mnt/coding/vmalloc_performance_test/vmalloc_test.ko] undefined!
WARNING: "warn_alloc" [/mnt/coding/vmalloc_performance_test/vmalloc_test.ko] undefined!
WARNING: "pmd_clear_bad" [/mnt/coding/vmalloc_performance_test/vmalloc_test.ko] undefined!
WARNING: "pgd_clear_bad" [/mnt/coding/vmalloc_performance_test/vmalloc_test.ko] undefined!
WARNING: "swapper_pg_dir" [/mnt/coding/vmalloc_performance_test/vmalloc_test.ko] undefined!
WARNING: "__pmd_alloc" [/mnt/coding/vmalloc_performance_test/vmalloc_test.ko] undefined!
WARNING: "pud_clear_bad" [/mnt/coding/vmalloc_performance_test/vmalloc_test.ko] undefined!
WARNING: "__pte_alloc_kernel" [/mnt/coding/vmalloc_performance_test/vmalloc_test.ko] undefined!
 LD [M]  /mnt/coding/vmalloc_performance_test/vmalloc_test.ko
<snip>

i.e. i will need either link with objects where those functions are or
wrap them up somehow. 

Thanks!

--
Vlad Rezki
