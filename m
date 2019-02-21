Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF41C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F81D2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jnx8efQm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfBUWb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 17:31:59 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36662 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfBUWb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 17:31:58 -0500
Received: by mail-ed1-f66.google.com with SMTP id g9so206077eds.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 14:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qm0DGyJWXzeOwINDR0bxj4fWh6Bh46UTdYXrFCDW/Bk=;
        b=Jnx8efQmcNCTCC49xKba0Bp9Iqoe7l2y4MMOqf9qZTcH8faaEWK6UJM+TCHC6pQu3I
         D+P2d6PmTZ9sXL631sRs9tZzxjBll2NNMz2zXlEP/XJpIqI7kngFuemvnaMk7x37recN
         cZkPE6J7Q//0wQAEXmTB3DGMzPCNKFsXAgdRvrfgmLDuuHIAUnCzJQfBOCL1uCrIO353
         xj83l+6+q/ccU3N5inhmfd/3Jc5fSSFQo5+S3GcLmcO5EJnMzbEp13lARj6FOvFH0VEO
         mYK17ILlsCKGgTfo8fnYUbWSexFnUzHrJkumCwo7TcKlKKVFFhVY9dqt5jNdbAVZL2uf
         LnsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=qm0DGyJWXzeOwINDR0bxj4fWh6Bh46UTdYXrFCDW/Bk=;
        b=QItNKckN1q07CQJvHjTNVa2+2yRuB0rpELv6LK23FXdIeDVy8n0+J58B0LZfsMI404
         tnBeOx+MsWxbcSzQPWCKobfxgCCcRbm3HMFN7oQvBaXDLJZ7gyv/sGqaAD3LAeRv+myH
         yNWOmroLfqIUdQrLP/qUe/ntvF8RXuK7TMVfFQipQFsGTujgs5ja0SxI7NbRpEQQIOUl
         6BJMFGB3mhcqkq4TVtDL2q/rEOF5dw9D+jf0h4tdkw1a6B0SG/ATkw8pT1hy9SMP1P9X
         P7Vl00qev4rMjc9tG6JoLk/Yp4HEOXoO34HTJM/AvecUG9rGksdROg4EmMhO1jyYPwmu
         k2Uw==
X-Gm-Message-State: AHQUAuaM3+XonJKK/TLjmpd70uO8SIQiCM65DTTo10e2kA5SQJirieyW
        PAe6OmpGwa7OzSlkiwCNDCI=
X-Google-Smtp-Source: AHgI3IarnbpNRBwLXM5qCmXkL21SBqRcgBWuAPPhQX0ePE9NEQHKED9LwxuigLaAdAfFeHvJxZFeAg==
X-Received: by 2002:a50:cf41:: with SMTP id d1mr643556edk.242.1550788316063;
        Thu, 21 Feb 2019 14:31:56 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a52sm20035edc.74.2019.02.21.14.31.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 14:31:55 -0800 (PST)
Date:   Thu, 21 Feb 2019 22:31:54 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel test robot <rong.a.chen@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, lkp@01.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [LKP] [driver core] 570d020012: will-it-scale.per_thread_ops
 -12.2% regression
Message-ID: <20190221223154.pg7rlcfvzbqj7h5a@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20190218075442.GI29177@shao2-debian>
 <20190219005945.GA16734@richard>
 <20190219121904.GA24103@kroah.com>
 <20190221031049.GE28258@shao2-debian>
 <20190221071023.GA28637@kroah.com>
 <8736oh1uf5.fsf@yhuang-dev.intel.com>
 <20190221075313.GA4113@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221075313.GA4113@richard>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 03:53:13PM +0800, Wei Yang wrote:
>On Thu, Feb 21, 2019 at 03:18:22PM +0800, Huang, Ying wrote:
>>Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
>>
>>> On Thu, Feb 21, 2019 at 11:10:49AM +0800, kernel test robot wrote:
>>>> On Tue, Feb 19, 2019 at 01:19:04PM +0100, Greg Kroah-Hartman wrote:
>>>> > On Tue, Feb 19, 2019 at 08:59:45AM +0800, Wei Yang wrote:
>>>> > > On Mon, Feb 18, 2019 at 03:54:42PM +0800, kernel test robot wrote:
>>>> > > >Greeting,
>>>> > > >
>>>> > > >FYI, we noticed a -12.2% regression of will-it-scale.per_thread_ops due to commit:
>>>> > > >
>>>> > > >
>>>> > > >commit: 570d0200123fb4f809aa2f6226e93a458d664d70 ("driver core: move device->knode_class to device_private")
>>>> > > >https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>>>> > > >
>>>> > > 
>>>> > > This is interesting.
>>>> > > 
>>>> > > I didn't expect the move of this field will impact the performance.
>>>> > > 
>>>> > > The reason is struct device is a hotter memory than device->device_private?
>>>> > > 
>>>> > > >in testcase: will-it-scale
>>>> > > >on test machine: 288 threads Knights Mill with 80G memory
>>>> > > >with following parameters:
>>>> > > >
>>>> > > >	nr_task: 100%
>>>> > > >	mode: thread
>>>> > > >	test: unlink2
>>>> > > >	cpufreq_governor: performance
>>>> > > >
>>>> > > >test-description: Will It Scale takes a testcase and runs it from 1 through to n parallel copies to see if the testcase will scale. It builds both a process and threads based test in order to see any differences between the two.
>>>> > > >test-url: https://github.com/antonblanchard/will-it-scale
>>>> > > >
>>>> > > >In addition to that, the commit also has significant impact on the following tests:
>>>> > > >
>>>> > > >+------------------+---------------------------------------------------------------+
>>>> > > >| testcase: change | will-it-scale: will-it-scale.per_thread_ops -29.9% regression |
>>>> > > >| test machine     | 288 threads Knights Mill with 80G memory                      |
>>>> > > >| test parameters  | cpufreq_governor=performance                                  |
>>>> > > >|                  | mode=thread                                                   |
>>>> > > >|                  | nr_task=100%                                                  |
>>>> > > >|                  | test=signal1                                                  |
>>>> > 
>>>> > Ok, I'm going to blame your testing system, or something here, and not
>>>> > the above patch.
>>>> > 
>>>> > All this test does is call raise(3).  That does not touch the driver
>>>> > core at all.
>>>> > 
>>>> > > >+------------------+---------------------------------------------------------------+
>>>> > > >| testcase: change | will-it-scale: will-it-scale.per_thread_ops -16.5% regression |
>>>> > > >| test machine     | 288 threads Knights Mill with 80G memory                      |
>>>> > > >| test parameters  | cpufreq_governor=performance                                  |
>>>> > > >|                  | mode=thread                                                   |
>>>> > > >|                  | nr_task=100%                                                  |
>>>> > > >|                  | test=open1                                                    |
>>>> > > >+------------------+---------------------------------------------------------------+
>>>> > 
>>>> > Same here, open1 just calls open/close a lot.  No driver core
>>>> > interaction at all there either.
>>>> > 
>>>> > So are you _sure_ this is the offending patch?
>>>> 
>>>> Hi Greg,
>>>> 
>>>> We did an experiment, recovered the layout of struct device. and we
>>>> found the regression is gone. I guess the regession is not from the
>>>> patch but related to the struct layout.
>>>> 
>>>> 
>>>> tests: 1
>>>> testcase/path_params/tbox_group/run: will-it-scale/performance-thread-100%-unlink2/lkp-knm01
>>>> 
>>>> 570d0200123fb4f8  a36dc70b810afe9183de2ea18f  
>>>> ----------------  --------------------------  
>>>>          %stddev      change         %stddev
>>>>              \          |                \  
>>>>     237096              14%     270789        will-it-scale.workload
>>>>        823              14%        939        will-it-scale.per_thread_ops
>>>> 
>>>> 
>>>> tests: 1
>>>> testcase/path_params/tbox_group/run: will-it-scale/performance-thread-100%-signal1/lkp-knm01
>>>> 
>>>> 570d0200123fb4f8  a36dc70b810afe9183de2ea18f  
>>>> ----------------  --------------------------  
>>>>          %stddev      change         %stddev
>>>>              \          |                \  
>>>>      93.51   3%        48%     138.53   3%  will-it-scale.time.user_time
>>>>        186              40%        261        will-it-scale.per_thread_ops
>>>>      53909              40%      75507        will-it-scale.workload
>>>> 
>>>> 
>>>> tests: 1
>>>> testcase/path_params/tbox_group/run: will-it-scale/performance-thread-100%-open1/lkp-knm01
>>>> 
>>>> 570d0200123fb4f8  a36dc70b810afe9183de2ea18f  
>>>> ----------------  --------------------------  
>>>>          %stddev      change         %stddev
>>>>              \          |                \  
>>>>     447722              22%     546258  10%  will-it-scale.time.involuntary_context_switches
>>>>     226995              19%     269751        will-it-scale.workload
>>>>        787              19%        936        will-it-scale.per_thread_ops
>>>> 
>>>> 
>>>> 
>>>> commit a36dc70b810afe9183de2ea18faa4c0939c139ac
>>>> Author: 0day robot <lkp@intel.com>
>>>> Date:   Wed Feb 20 14:21:19 2019 +0800
>>>> 
>>>>     backfile klist_node in struct device for debugging
>>>>     
>>>>     Signed-off-by: 0day robot <lkp@intel.com>
>>>> 
>>>> diff --git a/include/linux/device.h b/include/linux/device.h
>>>> index d0e452fd0bff2..31666cb72b3ba 100644
>>>> --- a/include/linux/device.h
>>>> +++ b/include/linux/device.h
>>>> @@ -1035,6 +1035,7 @@ struct device {
>>>>  	spinlock_t		devres_lock;
>>>>  	struct list_head	devres_head;
>>>>  
>>>> +	struct klist_node       knode_class_test_by_rongc;
>>>>  	struct class		*class;
>>>>  	const struct attribute_group **groups;	/* optional groups */
>>>
>>> While this is fun to worry about alignment and structure size of 'struct
>>> device' I find it odd given that the syscalls and userspace load of
>>> those test programs have nothing to do with 'struct device' at all.
>>>
>>> So I can work on fixing up the alignment of struct device, as that's a
>>> nice thing to do for systems with 30k of these in memory, but that
>>> shouldn't affect a workload of a constant string of signal calls.
>>
>>Hi, Greg,
>>
>>I don't think this is an issues of struct device.  As you said, struct
>>device isn't access much during test.  Struct device may share slab page
>>with some other data structures (signal related, or fd related (as in
>>some other test cases)), so that the alignment of these data structures
>>are affected, so caused the performance regression.
>>
>
>I didn't get the point here neither.
>
>slab allocator ask memory from page allocator Page by Page and split the page
>into pre-defined size. For example, 128B, 512B... Just as shown in
>/proc/slabinfo. 
>
>Per my understanding, each struct device / device_private will sits in its own
>aligned space. struct device would sits in 1K slab and struct device_private
>would sits in 256B slab, both before and after this patch if I am correct.
>

As Greg mentioned, device is embedded in other structure. My analysis
here is not correct. The change in size of device, may affect the size
of struct who wraps device.

In case this struct is allocated by kmem_cache, this may affect the
number of objects allocated each time, or even the number of pages
allocated each time.

This means with this patch may affect the system in the following two
aspects:

    * the times for struct allocation
    * the order of page it asks from page allocator

One place we may take a look is the /proc/slabinfo. To see whether the
change in size of device affect kmem_cach objects.

Hmm... while as Greg mentioned, those cases will not involve struct
device allocation. So the above aspects may not take effect?

>Hmm... I am just curious about how this alignment is affected. Maybe I lost
>some point?
>
>>Best Regards,
>>Huang, Ying
>>
>>> thanks,
>>>
>>> greg k-h
>
>-- 
>Wei Yang
>Help you, Help me

-- 
Wei Yang
Help you, Help me
