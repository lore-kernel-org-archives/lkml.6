Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45764C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEBF8208E7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="v8dJq3Ek"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEBF8208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933838AbeGJOf1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 10:35:27 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:53340 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933449AbeGJOf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 10:35:26 -0400
Received: by mail-it0-f66.google.com with SMTP id a195-v6so30791747itd.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 07:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X4wlWV81eMBSja7/7AL7JR4EP7mPJmfr3ROrjcfqyns=;
        b=v8dJq3EkJqAchDF++KoOMg9Wz+J2UPFmqGyLbEQnLWauxOQOw2mEl0ueWlcxb3m+zV
         orVzNBIf0oYoCPcyuVzWfukN5V/JfRLDZZWPKLmlG9j1kmHXUPSECPd0Q3Hb4sxQZf4B
         kqf+tB0v7WgS5tlwSYRwQy9AgTnPuflS0wi7BdhVPWY0xc716ntGSaq4ImLKWPntA6pU
         avlazAtiVDmiu9x0lrTNesg0vpFjIAlMLeP9Zux5xVt6iGH0wECzx9U213dxsyeHBw55
         WIWBBaISjKOL3qcJbCi6ymOEgYRJX+9PNFa2BAB23LHwpIVQBW7vjiLm93po84psEmy9
         faOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X4wlWV81eMBSja7/7AL7JR4EP7mPJmfr3ROrjcfqyns=;
        b=Vxih5p2vmo/LDj6VWMjRgFvRNimgmA6wtKhnHTTV/L7HTdJzhe5mbAY0FC29Pe6vgK
         +qn1jkNL+MRJYRs8yMDJj8EQEhYgNXy9pG3ah5jncq8AEKozgdXnffWHWlpvS9hHCFcN
         pqV/BBXeVP+KGvfy5Ku8QdyOJmXYUOHFBwDEvdyd/+nnn7YIh5GAlHQ9FEBDiUS7iXUe
         +j+W3vaEcy6T2Pt96tVt1cPcIJTLZt5L3cxPw28Q7Lb27Hi2kIXfFpmb9C2/bF6bTte6
         K29gCSTczlM+QotujOBbtRXOkz+FJtDD0uuXyTChON3/BrrTogK5qxJJ79MGICQqPqd1
         8m+w==
X-Gm-Message-State: APt69E0PeQrjqF0WaqdtW+fOfmoBVOtevlc6PIZeHTMoUy7R4GWMP0fS
        fGUEVfRIJsen3RNz4nTkG1fR0BmJz7o=
X-Google-Smtp-Source: AAOMgpelXDBmy5ohCx2e6RSn9koMYXqKCAaTS22ujNNPJ2KmV1UnitK5hYi2C1rCa1Pc5EESY7f+Iw==
X-Received: by 2002:a24:d245:: with SMTP id z66-v6mr18994122itf.124.1531233325624;
        Tue, 10 Jul 2018 07:35:25 -0700 (PDT)
Received: from [192.168.1.167] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id q3-v6sm9419739itc.22.2018.07.10.07.35.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 07:35:24 -0700 (PDT)
Subject: Re: linux-next: build warning after merge of the scsi tree
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Omar Sandoval <osandov@fb.com>
References: <20180620132911.5f6ab464@canb.auug.org.au>
 <20180710173114.17ee69ad@canb.auug.org.au>
 <280ebbdf-fafb-1744-f517-815a30e682bb@kernel.dk>
 <1531232063.4963.8.camel@HansenPartnership.com>
 <3f0359a5-6733-f9d3-a616-d27ce430c904@kernel.dk>
 <1531232805.4963.11.camel@HansenPartnership.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <84241128-2d2e-4479-abe0-658fddc1af2d@kernel.dk>
Date:   Tue, 10 Jul 2018 08:35:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1531232805.4963.11.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/18 8:26 AM, James Bottomley wrote:
> On Tue, 2018-07-10 at 08:22 -0600, Jens Axboe wrote:
>> On 7/10/18 8:14 AM, James Bottomley wrote:
>>> On Tue, 2018-07-10 at 08:09 -0600, Jens Axboe wrote:
>>>> On 7/10/18 1:31 AM, Stephen Rothwell wrote:
>>>
>>> [...]
>>>>> I am still seeing these warnings ...
>>>>
>>>> Martin queued up the forward declaration patch for this one, not
>>>> sure
>>>> why it isn't showing up in the scsi tree yet.
>>>
>>> All the trees are fully up to date ... which commit is it?
>>
>> It's a patch from Arnd, I don't know what commit id it is. But
>> Martin replied a few days ago that it was applied. I don't have
>> the email handy, though.
> 
> You mean
> 
> Message-Id:	<20180706201920.2185565-1-arnd@arndb.de>
> Subject:	[PATCH] [v2] sbitmap, scsi/target: add seq_file forward declaration
> 
> ?
> 
> Martin didn't reply and it's not yet in his tree, although I'm sure it
> will be soon.

Yeah that's the one. I now had to look it up, looks like I mixed it up
with the host busy patch from Ming.

We should get it applied. Feel free to add my reviewed-by, if you want.

-- 
Jens Axboe

