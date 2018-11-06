Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5AAC0044C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 03:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BB592084F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 03:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="pCQky5Wh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BB592084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbeKFMZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 07:25:38 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43029 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbeKFMZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 07:25:38 -0500
Received: by mail-pl1-f194.google.com with SMTP id g59-v6so5440572plb.10
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 19:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zTwVsdNrRsr8ENGhDIEOI+8DBGl6GR1NlQONLlwd+0M=;
        b=pCQky5WhwqkIoZiw95U7Q/GWy0t8SXF6Nt6o+wD8jN0uw92sEx7HvSlEdkAtTOP6oH
         ZHJ79cFrfpRNAYUCdOXoLkXkoO6WhkIr/2zC2v/9faUmX4NMtPhBZg0Q6kNglfeHXed0
         yfM+zyDftD1WX8w4f74qxSwLHcYOVr5bQE9zpFWg6XERyGk1Rgk+GwFNMShF+shdpO5L
         neMo++rqmqeQ2/4JIpdkmmjOBH4GBc1eBm8MHr2OWDZsd1CReIlxELqFwtOZrHx19PxX
         sd+ts5WgshZLzgNiNLR3s7H1uhZXq+c9yDrAcXJaMcjsi5dO8v+5wS4jHQ2vN5GwDIsA
         cVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zTwVsdNrRsr8ENGhDIEOI+8DBGl6GR1NlQONLlwd+0M=;
        b=uI6KlSdx2URdoHplYYnw/7kVMeLv5xyLTgOjeyLFMV/+Sev6u+rQTOtgpBsqgwpKJv
         z9oQ1b8orF7kAbM5XaygQntDnbDf2DRO3ZL8Mq2E5KyKVwDuUP5i3RlYuAq6i6bKi/Up
         3koGA30LBv2H7M6LRm1MoOBUFK/CKcxsJ9m882s3niHus5VuVYqWUEi6RvZ1O7aD/4h4
         u9PIL5B6upx6HwcrUzyh+a1TUcssHxNlFo06yYk5EQAUP3fYqfsjCYcziKrSyGji05Mp
         uc2RLj33Egkcw+PAzFkRKprBaJg1mUmn//RH+DoOr7gkm+R4ews/HvnExWfz03+PUrX0
         gR0w==
X-Gm-Message-State: AGRZ1gIERErUm9McFC8ag1ucqlwE6mm2D9UgQgpDdaVlNirH6Fr5t25J
        Edywx/OrS8UL2GgzKJA8g7jh2Q==
X-Google-Smtp-Source: AJdET5ebsXEVEevJhHJ1tt4zDLAa21CkBthfMBojlRqQ+NzHdgx0InNSJeeU4RboWS9vPsArAWeJVw==
X-Received: by 2002:a17:902:f209:: with SMTP id gn9mr23578267plb.6.1541473360856;
        Mon, 05 Nov 2018 19:02:40 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id v4-v6sm17193562pff.9.2018.11.05.19.02.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 19:02:39 -0800 (PST)
Subject: Re: [PATCH 0/4] irq: fix support for allocating sets of IRQs
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Long Li <longli@microsoft.com>
References: <20181102145951.31979-1-ming.lei@redhat.com>
 <955edd2f-ad2f-ae8b-b8c2-98a01918c112@kernel.dk>
 <alpine.DEB.2.21.1811041259350.3160@nanos.tec.linutronix.de>
 <5787f309-fa34-36df-83be-934a64989583@kernel.dk>
 <alpine.DEB.2.21.1811041938340.10744@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1811051220330.1566@nanos.tec.linutronix.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f4ed74a9-5083-2874-07a7-fdf0c45c494e@kernel.dk>
Date:   Mon, 5 Nov 2018 20:02:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1811051220330.1566@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/18 4:24 AM, Thomas Gleixner wrote:
> Jens,
> 
> On Sun, 4 Nov 2018, Thomas Gleixner wrote:
>> On Sun, 4 Nov 2018, Jens Axboe wrote:
>>> On 11/4/18 5:02 AM, Thomas Gleixner wrote:
>>>> So I assume, that I can pick up Mings series instead.
>>>
>>> Yes, let's do that.
>>>
>>>> There is another patch pending affecting the irq affinity spreading. Can
>>>> you folks please have a look at it?
>>>>
>>>> https://lkml.kernel.org/r/20181102180248.13583-1-longli@linuxonhyperv.com
>>>
>>> I'll give that a look and test. Thanks for the heads-up.
> 
> I picked the series from Ming and the patch from Long and merged it into
> tip/irq/core.
> 
> The result is available for you to pull from:
> 
>     git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/for-block
> 
> That branch is immutable now and I keep it around in case that there are
> incremental updates necessary before the merge window.

Great, thanks! I'll pull that in as a base.

-- 
Jens Axboe

