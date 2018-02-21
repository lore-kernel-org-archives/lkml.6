Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751694AbeBUXmr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 18:42:47 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:56129 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751346AbeBUXmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 18:42:45 -0500
Subject: Re: [PATCH 1/3] ARC: mcip: halt GFRC together with ARC cores
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        <linux-snps-arc@lists.infradead.org>
CC: Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        <linux-kernel@vger.kernel.org>
Newsgroups: gmane.linux.kernel.arc,gmane.linux.kernel
References: <20180221094027.12674-1-Eugeniy.Paltsev@synopsys.com>
 <a4a20519-e8b0-3522-0528-6de2595635ed@synopsys.com>
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Message-ID: <8c86b9f9-a4b7-1217-7cf3-1d8891292679@synopsys.com>
Date: Wed, 21 Feb 2018 15:42:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <a4a20519-e8b0-3522-0528-6de2595635ed@synopsys.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.10.161.84]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/21/2018 12:31 PM, Vineet Gupta wrote:
> Hi Eugeniy,
> 
>> Starting from ARC HS v3.0
> 
>  From the STAR fix, it seem this was fixed in HS 2.1c, so you should be able to 
> test it on HSDK, which was my next question: where and how did you test this and 
> verify that it works as we think it does. I tried the patch on HSDK and I still 
> see the rcu_preempt self-detected stall error splat when running hackbench and 
> pausing the target with Metaware debugger. Perhaps we need to write a small test 
> case to check what's going on. Also try that on AXS103 release which is definitely 
> HS 3.0 !

So I tried this on both.
  - HSDK   (HS 2.1c): Doesn't work
  - AXS103 (HS 3.0) : Works

Fortunately we can read (yet another BCR: GFRC_BUILD) and infer whether this is 
supported or not. So add that check in mcip_update_gfrc_halt_mask()

>> it's possible to tie GFRC to state of up-to 4
>> ARC cores with help of GFRC's CORE register where we set a mask for
>> cores which state we need to rely on.

On second thoughts, do we really have to do this per cpu. Just write 0xf once just 
as Alexey did in first iteration.

-Vineet
