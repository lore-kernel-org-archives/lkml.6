Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F43ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0664420881
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:16:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0664420881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gblabs.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388614AbeGWQSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 12:18:23 -0400
Received: from 61.239-255-62.static.virginmediabusiness.co.uk ([62.255.239.61]:57236
        "EHLO office.gblabs.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388310AbeGWQSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 12:18:23 -0400
X-Footer: Z2JsYWJzLmNvLnVr
Received: from [172.16.36.160] ([82.71.45.69])
        (authenticated user a.richman@gblabs.co.uk)
        by office.gblabs.co.uk (Kerio Connect 9.2.5 patch 3) with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Mon, 23 Jul 2018 16:16:33 +0100
Subject: Re: Very slow SYS_io_destroy()
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <27245a6a-a827-2662-215c-05ccdff65768@gblabs.co.uk>
 <x49fu0a3rz1.fsf@segfault.boston.devel.redhat.com>
From:   Alex Richman <alex.r@gblabs.co.uk>
Message-ID: <4c5819ce-72cb-2ee3-06b9-8c3d0a11a0aa@gblabs.co.uk>
Date:   Mon, 23 Jul 2018 16:16:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <x49fu0a3rz1.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the response.  I'm running 4.4.123-1 from Gentoo.  It also 
happens on 4.4.87-r1.

Cheers,
- Alex.

On 23/07/18 16:13, Jeff Moyer wrote:
> Alex Richman <alex.r@gblabs.co.uk> writes:
>
>> Hi,
>>
>> I'm seeing some weirdness with AIO, specifically SYS_io_destroy() is
>> taking upwards of ~100000 microseconds (~100 miliseconds) per call.
>> How long is that call expected to take?  I can see from the source
> Well, it waits for an RCU grace period.  I would not expect that to take
> 100ms, though.  What kernel version is this?
>
> -Jeff

-- 
Alex Richman
alex.r@gblabs.co.uk
Engineering
Tel:+44 (0)118 455 5000
www.gblabs.com


