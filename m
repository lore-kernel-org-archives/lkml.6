Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 69FE4C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AD57208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:07:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AD57208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=icdsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966013AbeFOQHc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 12:07:32 -0400
Received: from us.icdsoft.com ([192.252.146.184]:43668 "EHLO us.icdsoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965947AbeFOQHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 12:07:30 -0400
Received: (qmail 5552 invoked by uid 1001); 15 Jun 2018 16:07:30 -0000
Received: from unknown (HELO ?94.155.37.249?) (famzah@94.155.37.249)
  by 192.252.159.165 with ESMTPA; 15 Jun 2018 16:07:30 -0000
Subject: Re: Cgroups "pids" controller does not update "pids.current" count
 immediately
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <77af3805-e912-2664-f347-e30c0919d0c4@icdsoft.com>
 <20180614150650.GU1351649@devbig577.frc2.facebook.com>
 <7860105c-553a-534b-57fc-222d931cb972@icdsoft.com>
 <20180615154140.GV1351649@devbig577.frc2.facebook.com>
From:   Ivan Zahariev <famzah@icdsoft.com>
Message-ID: <1d635d1d-6152-ecfc-d235-147ff1fe7c95@icdsoft.com>
Date:   Fri, 15 Jun 2018 19:07:27 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180615154140.GV1351649@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-bg
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for the quick and insightful reply. I have one suggestion below:

On 15.6.2018 г. 18:41 ч., Tejun Heo wrote:
> On Fri, Jun 15, 2018 at 05:26:04PM +0300, Ivan Zahariev wrote:
>> The standard RLIMIT_NPROC does not suffer from such accounting
>> discrepancies at any time.
> They seem equivalent but serve a bit different purposes.  RLIMIT_NPROC
> is primarily about limiting what the user can do and doesn't guarantee
> that that actually matches resource (pid here) consumption.
>
>> Is it really technically not possible to make "pids.current" do
>> accounting properly like RLIMIT_NPROC does? We were hoping to
>> replace RLIMIT_NPROC with the "pids" controller.
> It is of course possible but at a cost.  The cost (getting rid of lazy
> release optimizations) is just not justifiable for most cases.

I understand all concerns and design decisions. However, having 
RLIMIT_NPROC support combined with "cgroups" hierarchy would be very handy.

Does it make sense that you introduce "nproc.current" and "nproc.max" 
metrics which work in the same atomic, real-time way like RLIMIT_NPROC? 
Or make this in a new "nproc" controller?

--
Ivan
--
