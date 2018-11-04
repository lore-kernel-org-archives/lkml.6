Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1691DC32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 17:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A46C72085A
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 17:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="wkR12sJW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A46C72085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731193AbeKECkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 21:40:39 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44559 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731134AbeKECki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 21:40:38 -0500
Received: by mail-pl1-f195.google.com with SMTP id s5-v6so3260621plq.11
        for <linux-kernel@vger.kernel.org>; Sun, 04 Nov 2018 09:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=86FSNt5Rysvpf94sFgcBNoY1n4p23r/wZG8TUDw3cXU=;
        b=wkR12sJWfRgVRdti7Ie+lg9w32RWbhEIC4UGqKaDHKUCOMaaAb8jmmHPTvXJOOSful
         1E0rmgpKNQVoRMbYjqWCbXGfGpgaWp09JjQVwC86KpmoWaOKiTenrf0w6Vt5IkLCpLv9
         EWl68XtflIg01Ljq4QpgWECphXGwzvp+fqXgvGAZ0DZMgFUtuaqdH0Q3O6erilSiaP9D
         WxH/PXm2p5KzCiea+Z4hKbmix+qp3POHlGJhUfroghXD5BqDQymwTb+5QXlNXDWTRhMw
         ZAzW+nTeuP8Z6X1PLZlfWadYSsmyDQwv7VfCJH8dvDAykI9DEKnBf7pFmauGrkwhjeDq
         1vdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=86FSNt5Rysvpf94sFgcBNoY1n4p23r/wZG8TUDw3cXU=;
        b=cOdvveCe2iBZwFW59cwDFVWhYq/xTx+iKap6faka5tP7RDNL362w2Koy91ASGc6WU5
         Whuy4iVoK3bHA9MhpatJT6pk1xktJ/1M9IddOTAum3PoxSkzn27rcTOPe58K1f196Uug
         Gob/V8UpHoHAv3yQDbdgwc6ZLCiBH3SC2NwCpxXQJ9CObKRdErnpqF+hycWtPCaehfdR
         2B3Rhzkelh+vGXWsDlizK9LS2sSnVluNVfeQE3zRuM8mqNZcF63S1dVXdJR1QhfcI146
         e1Rcrint6cuOQugtWj41etRF0V2wK1Eo6JRJlnz8GhNxejSd8XKZLiSfC+EakKrjPp1G
         FJyA==
X-Gm-Message-State: AGRZ1gIIPKqP/JFv7EoH6DeWRjmT0RC2P0EaayTLRZa3dBp+KtCcHePE
        n+tG4Bh5+mvpSSEfTGdfKqTZ4Q==
X-Google-Smtp-Source: AJdET5dfnFVVx2d62g0rncwl6z9OAdSRrs9fQzIRZusp7M1txSXzi44aSyL7lEtplcam+YZ0Lk9/IQ==
X-Received: by 2002:a17:902:2849:: with SMTP id e67-v6mr19202774plb.269.1541352296415;
        Sun, 04 Nov 2018 09:24:56 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id n87-v6sm51722263pfb.62.2018.11.04.09.24.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Nov 2018 09:24:55 -0800 (PST)
Subject: Re: [PATCH 0/4] irq: fix support for allocating sets of IRQs
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Long Li <longli@linuxonhyperv.com>
References: <20181102145951.31979-1-ming.lei@redhat.com>
 <955edd2f-ad2f-ae8b-b8c2-98a01918c112@kernel.dk>
 <alpine.DEB.2.21.1811041259350.3160@nanos.tec.linutronix.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5787f309-fa34-36df-83be-934a64989583@kernel.dk>
Date:   Sun, 4 Nov 2018 10:24:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1811041259350.3160@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/18 5:02 AM, Thomas Gleixner wrote:
> Jens,
> 
> On Sat, 3 Nov 2018, Jens Axboe wrote:
> 
>> On 11/2/18 8:59 AM, Ming Lei wrote:
>>> Hi Jens,
>>>
>>> As I mentioned, there are at least two issues in the patch of '
>>> irq: add support for allocating (and affinitizing) sets of IRQs':
>>>
>>> 1) it is wrong to pass 'mask + usedvec' to irq_build_affinity_masks()
>>>
>>> 2) we should spread all possible CPUs in 2-stage way on each set of IRQs
>>>
>>> The fix isn't trivial, and I introduce two extra patches as preparation,
>>> then the implementation can be more clean.
>>>
>>> The patchset is against mq-maps branch of block tree, feel free to
>>> integrate into the whole patchset of multiple queue maps.
>>
>> Thanks Ming, I ran this through my testing, and I end up with the
>> same maps and affinities for all the cases I cared about. I'm going
>> to drop my initial version, and add the three.
> 
> So I assume, that I can pick up Mings series instead.

Yes, let's do that.

> There is another patch pending affecting the irq affinity spreading. Can
> you folks please have a look at it?
> 
> https://lkml.kernel.org/r/20181102180248.13583-1-longli@linuxonhyperv.com

I'll give that a look and test. Thanks for the heads-up.

-- 
Jens Axboe

