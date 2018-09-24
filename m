Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318BAC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 703BF20C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SfZQZk+d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 703BF20C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbeIYBrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 21:47:48 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49920 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbeIYBrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 21:47:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=d7nfAlpTa4kiJ3fuJnaQl867ETtheD7fC+ZCwuhC25A=; b=SfZQZk+dnp/ahrpTAr1ZebvhPF
        eLAUMgjSVxoS31zRiw+/vdkVDP/hpwpvQmIV2YjtK3NULjLCCqJXc77uwa3NC4JRi5yXTXo/CEs2h
        1SIr9wLAt2YeJnI9FYgaVn2QxkndZlIeuQTLBZvaZeI9cCdLCfo2CoeFPzI+7PSoZgdpJt7GpJYSd
        mCDuacFXOHuGvdEnc7UBiXLjBxQdzx8k3afCIMm5Lvht4mFbZh6MWi0QI+kgZ1ZpArx5MEYHxa3Y1
        1r/1WaWQ9QH4G86Vh/4SfQ+Qtg84ZITTfJaTkBgkojKL0C0vTLReXCioJgdAuDFClAcx5xxiDLwjP
        SrtQUkWw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g4Wlf-0005eC-FG; Mon, 24 Sep 2018 19:43:59 +0000
Subject: Re: libata-core WARNING during boot
To:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <b9b55c84-a90c-e7ac-add7-fdf1b7e13dc6@infradead.org>
 <0d5420a4-dd7c-1810-2fbd-0840372a5ba3@kernel.dk>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <27c207df-f7ff-4f01-a713-9d92ab7b3631@infradead.org>
Date:   Mon, 24 Sep 2018 12:43:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <0d5420a4-dd7c-1810-2fbd-0840372a5ba3@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/18 12:19 PM, Jens Axboe wrote:
> On 9/23/18 9:34 PM, Randy Dunlap wrote:
>> Hi,
>>
>> I'm having (repeatable) problems booting 4.18 and 4.18.9 (latest stable):
>>
>> WARNING: CPU: 1 PID: 1 at ../drivers/ata/libata-core.c:6677 ata_host_detach+0x6e/0x150
>>
>>
>> It never completes the boot.  Could that be due to this eh warning?
> 
> Is this a new issue? Not quite clear based on your report.
> 

That's because I don't know.  I've been struggling with this for a few weeks
now but I don't know how far back it goes.  I'll keep digging.

thanks,
-- 
~Randy
