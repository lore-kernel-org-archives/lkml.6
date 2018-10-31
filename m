Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F52C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 17:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0154220657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 17:47:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0154220657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=electrozaur.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729949AbeKACq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 22:46:56 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53132 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729745AbeKACq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 22:46:56 -0400
Received: by mail-wm1-f65.google.com with SMTP id 189-v6so16010479wmw.2;
        Wed, 31 Oct 2018 10:47:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=BhDGAK0BcgCBiOTQRWaZcJpY9AuY8QHgMr5CyJ+vI50=;
        b=Xd4gK1Z4/+QcXmEZ7s1w6pGQEJ0mtj4392a3Cxt/KAfjteC6ynp+PgK780EvtBBFWH
         WgeI8tSixoohNN6u4ilERnrbqx1/wvZwbYPkwDi16va5BRYdOxt+eAhL+2R/LsQr4syD
         r1O1/r53LHm6gtPoX8MSrO6Homg0ErmrB3JZ61vPx54Woias4JJffoHz9lFwSC+EP1QD
         LkoT6I1KEmDg9W5DXZiHXLyBXEM8p5WFKZKMOet+NqyTDvQ5iHBayoH5wulrGMjRnzCi
         EUKAEIVSPqZKpeCAFSq30aSZxSKxX836Nv3bwsT1hrHiaidUa9XJFu0hWlLDeyNYp4sZ
         vleg==
X-Gm-Message-State: AGRZ1gIyodRGSnV1q0FbOts51GoKxKeyyN19yWoaHW7LMs/jnNrBpC16
        f+pp0AR9GRBOYtZvadesLy0usuJb
X-Google-Smtp-Source: AJdET5dFkdn7IWo/RD/Cey+7bFcjpmCsK0UKPUsk/pI9cGXwoIep3FEUYvEp/sOtJ9e0d1Wb5RWnQw==
X-Received: by 2002:a1c:e714:: with SMTP id e20-v6mr3004960wmh.83.1541008072985;
        Wed, 31 Oct 2018 10:47:52 -0700 (PDT)
Received: from [10.0.0.5] ([207.232.55.62])
        by smtp.gmail.com with ESMTPSA id t82-v6sm20041893wme.30.2018.10.31.10.47.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 10:47:52 -0700 (PDT)
Subject: Re: remove exofs and the T10 OSD code V2
To:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>, martin.petersen@oracle.com
References: <20181027082019.20838-1-hch@lst.de>
 <c9740eeb-6b96-35b6-a436-7537669da1a9@electrozaur.com>
 <1541006979.196084.138.camel@acm.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        osd-dev@open-osd.org, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Boaz Harrosh <ooo@electrozaur.com>
Message-ID: <6794b3a0-fe57-cd8b-3ad3-3a590121b12a@electrozaur.com>
Date:   Wed, 31 Oct 2018 19:47:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <1541006979.196084.138.camel@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/10/18 19:29, Bart Van Assche wrote:
> On Wed, 2018-10-31 at 18:34 +0200, Boaz Harrosh wrote:
>> On 27/10/18 11:20, Christoph Hellwig wrote:
>>> The only real user of the T10 OSD protocol, the pNFS object layout
>>> driver never went to the point of having shipping products, and we
>>> removed it 1.5 years ago.  Exofs is just a simple example without
>>> real life users.
>>>
>>> The code has been mostly unmaintained for years and is getting in the
>>> way of block / SCSI changes, so I think it's finally time to drop it.
>>>
>>> Quote from Boaz:
>>>
>>> "As I said then. It is used in Universities for studies and experiments.
>>> Every once in a while. I get an email with questions and reports.
>>>
>>> But yes feel free to remove the all thing!!
>>
>> I think I'm changing my mind about this.
>> [ ... ]
> 
> The osd driver was accepted in the upstream kernel in 2009. I have checked all
> commits in Linus' tree for the osd driver that went in since 2009. All changes
> made by other kernel developers than you are the result of tree-wide refactoring,
> compiler warning fixes, fixes for issues detected by static source code
> analyzers or spelling fixes. Hence my question: how big is the user base of the
> exofs and osd kernel drivers? 
> 

Not big at all. And none of them production setups. As I said mainly used
by academia.

Thanks
Boaz

> Thanks,
> Bart.

