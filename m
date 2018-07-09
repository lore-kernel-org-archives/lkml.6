Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0F3C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 06:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EE84208AF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 06:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EE84208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932411AbeGIGHm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 02:07:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:49724 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754544AbeGIGHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 02:07:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F14DDAD9D;
        Mon,  9 Jul 2018 06:07:37 +0000 (UTC)
Subject: Re: [PATCH] block/DAC960.c: fix defined but not used build warnings
To:     Randy Dunlap <rdunlap@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        axboe <axboe@kernel.dk>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <880681dd-f72f-6687-d2cc-59116acd5216@infradead.org>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <614c54d4-0d38-26e3-5dc1-6c66e2c67f7b@suse.de>
Date:   Mon, 9 Jul 2018 08:07:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <880681dd-f72f-6687-d2cc-59116acd5216@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/07/2018 05:49 AM, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix build warnings in DAC960.c when CONFIG_PROC_FS is not enabled
> by marking the unused functions as __maybe_unused.
> 
> ../drivers/block/DAC960.c:6429:12: warning: 'dac960_proc_show' defined but not used [-Wunused-function]
> ../drivers/block/DAC960.c:6449:12: warning: 'dac960_initial_status_proc_show' defined but not used [-Wunused-function]
> ../drivers/block/DAC960.c:6456:12: warning: 'dac960_current_status_proc_show' defined but not used [-Wunused-function]
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: linux-block@vger.kernel.org
> ---
>  drivers/block/DAC960.c |    9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 

Guess it's about time to resubmit my DAC960 rewrite.
Hope it get it done sometimes this week.

Cheers

Hannes

-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
