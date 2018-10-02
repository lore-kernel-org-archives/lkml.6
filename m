Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A3EC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 16:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC6B42089C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 16:59:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC6B42089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=electrozaur.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbeJBXnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 19:43:32 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44484 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbeJBXnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 19:43:32 -0400
Received: by mail-wr1-f66.google.com with SMTP id 63-v6so3038739wra.11;
        Tue, 02 Oct 2018 09:59:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=KInkuaBmL/vfDg0sGvxHoaX45Gr4AZ5I1Yff1MgQS9Q=;
        b=KXaeCPdT8NqbpVpJ3AiOt1u8QcnwoUFLlfawD75p5f/OWWEu13bgNBL/KUAtACo/5n
         gRWWceajISH09UtnR1uZwkxiGaa82dSXnDb+tuSqHr85iB5VdX3iL8vmZPAwBlHozIqq
         nrKc3xdxToe7UHJ6C1vR/+yopBhNWdTeuMtp9AFWrX22qMDucZdg8GbRwNMf/UkWXldZ
         0rDe4e+2Dix4O11BJnyqmYh+4o12GcuCpIlMKc7xOwfchHYeiCQVPRxYhfJUQyYuXTBS
         1bJ/t+y59YOG6ZFTuleXAok/ZQQ1w4CdDQKystqhFQjNjdjW++XFEhCgleNSW2G0wunC
         tGNw==
X-Gm-Message-State: ABuFfojd7Grd7DrRATmepxOVdBtefBAF5YCetXRtf+HrLqd+XBgSSpyN
        geL9kezM5q4a8qz03Rh3wmc=
X-Google-Smtp-Source: ACcGV61csmEDz0MYDYuayPuDw1fwzqQ1Zp6SLsspd+40CLbbfU0xw8y7p6hWQd20Gz9Naxa8UNUcsA==
X-Received: by 2002:a5d:618f:: with SMTP id j15-v6mr8836429wru.198.1538499550329;
        Tue, 02 Oct 2018 09:59:10 -0700 (PDT)
Received: from [10.0.0.5] ([207.232.55.62])
        by smtp.gmail.com with ESMTPSA id w4-v6sm15447423wra.83.2018.10.02.09.59.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 09:59:09 -0700 (PDT)
Subject: Re: [PATCH] libosd: Remove ignored __weak attribute
To:     Christoph Hellwig <hch@infradead.org>,
        Bart Van Assche <bvanassche@acm.org>
References: <20180930205448.26205-1-natechancellor@gmail.com>
 <10b12992-3570-4646-374b-82cbd7276839@acm.org>
 <20181002145613.GA11156@infradead.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
From:   Boaz Harrosh <ooo@electrozaur.com>
Message-ID: <f4ace065-fb9c-6901-d4d9-6b849e08d054@electrozaur.com>
Date:   Tue, 2 Oct 2018 19:59:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20181002145613.GA11156@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/10/18 17:56, Christoph Hellwig wrote:
> On Mon, Oct 01, 2018 at 06:16:32PM -0700, Bart Van Assche wrote:
>> Boaz, the most recent osd patch that is neither trivial nor treewide
>> refactoring is six years old (51976a8c85ce ("[SCSI] osd_uld: Add osdname &
>> systemid sysfs at scsi_osd class"). That suggests that nobody is using this
>> driver anymore. Can this driver be removed from the kernel tree?
> 
> Last time we tried to exofs and the osd code Boaz complained loudly,
> but as far as I can tell it really is not used and bitrotting, so we
> should finally go ahead and drop it.
> 

As I said then. It is used in Universities for studies and experiments.
Every once in a while. I get an email with questions and reports.

But yes feel free to remove the all thing!!

I guess I can put it up on github. In a public tree.

Just that I will need to forward port it myself, til now you guys
been doing this for me ;-)

Thanks, sorry for the hassle
Boaz

