Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F19C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9744D20856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:02:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9744D20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sony.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388711AbeGXQJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 12:09:50 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:13024 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726857AbeGXQJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 12:09:50 -0400
Subject: Re: [PATCH RESEND] kthread, tracing: Don't expose half-written comm
 when creating kthreads
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Yoshitaka Seto <yoshitaka.seto@sony.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        John Stultz <john.stultz@linaro.org>
References: <20180723134210.54013-1-snild@sony.com>
 <20180723095550.08203a24@gandalf.local.home>
 <9d762b4e-20a7-578f-90c8-10a044921d67@sony.com>
 <20180723113741.66df3b50@gandalf.local.home>
 <7749ed7d-50d5-4b95-fbd2-b056a1fff957@sony.com>
 <20180723124154.14ef0679@gandalf.local.home>
 <72573a9f-694e-fc4b-cfd1-d9cde504a480@sony.com>
 <20180724104815.05d2ac68@gandalf.local.home>
From:   Snild Dolkow <snild@sony.com>
Message-ID: <cbdab69a-28a4-08fd-a6c9-6db30958b12b@sony.com>
Date:   Tue, 24 Jul 2018 17:02:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180724104815.05d2ac68@gandalf.local.home>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/24/2018 04:48 PM, Steven Rostedt wrote:
> On Tue, 24 Jul 2018 10:17:37 +0200
> Snild Dolkow <snild@sony.com> wrote:
> 
>> 	creator                         other
>> 	vsnprintf:
>> 	  fill (not terminated)
>> 	  count the rest                read/use comm
> 
> I think it would be better to state what was reading the comm. Like
> 
> 					trace_sched_waking(p)
> 					  memcpy(comm, p->comm, TASK_COMM_LEN)
> 
> But the rest looks fine.
> 
> -- Steve

Works for me. Reworded v2 coming up soon.

//Snild
