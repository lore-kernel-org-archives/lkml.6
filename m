Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7919ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AC7420852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:23:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AC7420852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sony.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388394AbeGWPYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 11:24:41 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:19994 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388104AbeGWPYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 11:24:41 -0400
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
From:   Snild Dolkow <snild@sony.com>
Message-ID: <9d762b4e-20a7-578f-90c8-10a044921d67@sony.com>
Date:   Mon, 23 Jul 2018 16:23:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180723095550.08203a24@gandalf.local.home>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/23/2018 03:55 PM, Steven Rostedt wrote:

> Can you add a comment here stating something to the affect of:
> 		/* task is now visible to other tasks */
>
> -- Steve
Sure, but isn't that a bit misleading? It will have been visible since
some unknown point in time between waking up kthreadd and the return of
wait_for_completion(); we're not the ones making it visible.

//Snild
