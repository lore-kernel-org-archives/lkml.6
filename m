Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13936C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 18:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C459826001
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 18:03:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C459826001
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964879AbeFYSDY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 14:03:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49909 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964834AbeFYSDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 14:03:23 -0400
Received: from hanvin-mobl2.amr.corp.intel.com (fmdmzpr03-ext.fm.intel.com [192.55.54.38])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id w5PI0kqt1280295
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 25 Jun 2018 11:00:47 -0700
Subject: Re: [PATCH v4 7/7] x86/vdso: Move out the CPU number store
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>
Cc:     "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <1529536506-26237-1-git-send-email-chang.seok.bae@intel.com>
 <1529536506-26237-8-git-send-email-chang.seok.bae@intel.com>
 <alpine.DEB.2.21.1806221714260.2402@nanos.tec.linutronix.de>
 <80C1F514-1B4D-4CDC-BD46-6C3AA9601446@amacapital.net>
 <alpine.DEB.2.21.1806221817280.2402@nanos.tec.linutronix.de>
 <C9BB696F3A938947B10DCAD29FAB8FFA66BDB78B@CRSMSX101.amr.corp.intel.com>
 <CALCETrU5yUFiY09yqzbZV3gYyMyqGPBPs2n31PRNkhyYZsNrgA@mail.gmail.com>
 <alpine.DEB.2.21.1806251739450.1821@nanos.tec.linutronix.de>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <e006b351-a2d7-e269-4e1f-d5ffa67d25d6@zytor.com>
Date:   Mon, 25 Jun 2018 11:00:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1806251739450.1821@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/25/18 08:40, Thomas Gleixner wrote:
> On Fri, 22 Jun 2018, Andy Lutomirski wrote:
> 
>> On Fri, Jun 22, 2018 at 11:02 AM Bae, Chang Seok
>> <chang.seok.bae@intel.com> wrote:
>>>
>>>> Still setup_cpu_number() sucks.
>>>
>>> How about setup_cpu_and_node_number()?
>>
>> setup_fast_cpu_node_nr()?  setup_cpunr_regs()?  I don't have any
>> brilliant ideas.  Thomas?
> 
> It's really hard to find a good one. setup_cpu_node_cache() might work, but
> it's not brilliant either.
> 

Since this applies to the getcpu(2) system call (in addition to the
kernel usage), perhaps setup_getcpu()?

	-hpa

