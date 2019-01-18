Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9E1C07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 19:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECD132086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 19:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729420AbfARTzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 14:55:00 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36606 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729284AbfARTzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 14:55:00 -0500
Received: by mail-qk1-f195.google.com with SMTP id o125so8748206qkf.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 11:54:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rmE3QGKcbLmBPMlTW4ytyaF4Tl6JtPSR/XV60Kyky34=;
        b=EHD+1JOTWyIwwxc5V+zOcRzaCzBlWGheFAALPwND020g8l2yPenmCD6sYSHc8yFNWn
         tN68V6dNxa36obGDuOEbMynRF1+7W/YPB/biVrfW9hXeAvMeVnebiA6/2VE8/xVN8juA
         SMOt6NrjYKusx5VCAlK0pGZaGhjar2VLJc1nRHDtYRnksjyZUiMa6OrW08p6brl3kbKR
         zjLZar5L3PMTTge5RWHmxNCz2ssiQP1eWk7WTF2wRKN4Aq2t4KC+s8oQu9bF/6HtJ/FX
         iWlV+q6eTwUKDZYFW9lJvLSs0F2YnINKcyCnbJUQqzTJGvwltnUjOmKlrUMSf+FZbpJg
         +11A==
X-Gm-Message-State: AJcUukfRKwa6wrBdUDblaEhjiOItppXfCpqvgy4h0G+ghDRka02Fxc8+
        iUecEkByKeouvllJj7eut4X27X5+8Js=
X-Google-Smtp-Source: ALg8bN7HE2iWVHEIhujbnDDGIp5sR0B6nYLN3sxLbnuEcXSmqY3ETfjF/Tspo2lFqwY7eYo2dBfxew==
X-Received: by 2002:ae9:dfc7:: with SMTP id t190mr15605239qkf.43.1547841298939;
        Fri, 18 Jan 2019 11:54:58 -0800 (PST)
Received: from ?IPv6:2601:602:9800:dae6::fb21? ([2601:602:9800:dae6::fb21])
        by smtp.gmail.com with ESMTPSA id j138sm26177330qke.65.2019.01.18.11.54.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 11:54:58 -0800 (PST)
Subject: Re: [PATCH 12/14] staging: android: ion: Declare helpers for carveout
 and chunk heaps
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Andrew F. Davis" <afd@ti.com>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOl?= =?UTF-8?Q?g?= <arve@android.com>,
        devel@driverdev.osuosl.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20190111180523.27862-1-afd@ti.com>
 <20190111180523.27862-13-afd@ti.com> <20190118095909.GB28982@kroah.com>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <bbb9c607-7347-20e7-7c05-b4c53e6abd55@redhat.com>
Date:   Fri, 18 Jan 2019 11:54:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190118095909.GB28982@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/19 1:59 AM, Greg Kroah-Hartman wrote:
> On Fri, Jan 11, 2019 at 12:05:21PM -0600, Andrew F. Davis wrote:
>> When enabled the helpers functions for creating carveout and chunk heaps
>> should have declarations in the ION header.
> 
> Why?  No one calls these from what I can tell.
> 
> Which makes me believe we should just delete the
> drivers/staging/android/ion/ion_carveout_heap.c and
> drivers/staging/android/ion/ion_chunk_heap.c files as there are no
> in-tree users?
> 
> Any objection to me doing that?
> 
> thanks,
> 
> greg k-h
> 

I'd rather not delete it quite yet. Part of this entire thread is a
discussion on how to let those heaps and associated function actually
be called in some way in tree. I expect them to either get called
in tree or be replaced.

Thanks,
Laura
