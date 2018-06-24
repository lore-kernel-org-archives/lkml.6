Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F21C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 04:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31F9A24DB6
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 04:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7ckuYZS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31F9A24DB6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750817AbeFXEBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 00:01:42 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:40873 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750734AbeFXEBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 00:01:40 -0400
Received: by mail-ot0-f196.google.com with SMTP id w9-v6so11631965otj.7
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jun 2018 21:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UOk7B5ecqWw2bWgeOIZFvaRzhsjcFp2+wQeNi7zLGYw=;
        b=L7ckuYZSPYsuoMAR3MwoiBmnOZ4mG1nTtqqiEVFQKo9eqSR75dYaPDfp7GTdzGWtt5
         GaMSEWkX60bCWe6ymlB3PVnkoPQACKCFYsZGn7knX+8phuPomS3B/34lgQX9PL0tph2W
         NKgaPGuMeZWHa/yNa2O52HMzHt+sFisuyuOqtkcOS8sWlrjH8G2wphR2B+/dp1gm1tuo
         txBCKsyBHffRfvD5xPo8OfTp/R2HtYPM4IbTgLMGyG6eSJv8S/6AazxoWXQUKRCWq27B
         0VKxRP7GffOD5E5ulrN2B+03zZPejJkC20W0TsdeMPoqPvW+iMknGh4x4qdSQnfRT1Xf
         EJfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UOk7B5ecqWw2bWgeOIZFvaRzhsjcFp2+wQeNi7zLGYw=;
        b=TVM/hKVHXH2oer9hDnRjK/8vTW9z0jhfYElw6w6EOWMUoEcpt1Art62ocH3O3DuDTi
         hXZ288/2BBlTNfHl39DQYlLOLegJDz/qvUHd7ICRBaHuMU1ajgs3SC79p7b0YYRrePZz
         CpPQS9gT1BWhD+mqXymT/cWBbFdv44juYvk7ddfDdb8wuEWXIRsYM+a0YjH+gy2CNnl/
         XZiXSnQy3By27eBosMXgqURaENW/TRytw1FZ+2GQkFY0rgR+z0LgIhLTTfij2COOMczK
         rySdA75EZBAOxbNEZ4AeKig5fS4LJ07tbzkLxbXoId/cLIi8YX0fgat5u4BDu0H4/8eY
         eAmQ==
X-Gm-Message-State: APt69E1+hXoAtRQFJ7cGR/ycOPpKEtAXBM6XYcZ2eV+uQ8ZOOKTk1koi
        LV4V2YGBzzwdHnLxsm2pEBjlwA==
X-Google-Smtp-Source: ADUXVKL3PMplrpFB+QFIsQB5xL+bjTUbUNcMCH6btMGKmAVxTnyrL5v0vJnZ93bDxKWOB2GItlvGtw==
X-Received: by 2002:a9d:1529:: with SMTP id u38-v6mr4206910otf.367.1529812899682;
        Sat, 23 Jun 2018 21:01:39 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id q23-v6sm6927578otd.25.2018.06.23.21.01.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Jun 2018 21:01:38 -0700 (PDT)
Subject: Re: m68k boot failure in -next bisected to 'xarray: Replace
 exceptional entries'
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Josef Bacik <jbacik@fb.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <20180622184246.GA21226@roeck-us.net>
 <20180622210519.GA18630@bombadil.infradead.org>
 <20180622223335.GA12581@roeck-us.net>
 <20180624011703.GH18630@bombadil.infradead.org>
 <a62d8a6a-0376-2cbe-a34c-13e1242f06c6@roeck-us.net>
 <20180624032615.GA32667@bombadil.infradead.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <31d75d3d-2184-6053-5283-f9fe3b10bf82@roeck-us.net>
Date:   Sat, 23 Jun 2018 21:01:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180624032615.GA32667@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/23/2018 08:26 PM, Matthew Wilcox wrote:
> On Sat, Jun 23, 2018 at 07:52:35PM -0700, Guenter Roeck wrote:
>> On 06/23/2018 06:17 PM, Matthew Wilcox wrote:
>>> On Fri, Jun 22, 2018 at 03:33:35PM -0700, Guenter Roeck wrote:
>>>> It may be odd that fs/quota/netlink.c:quota_genl_family is not word
>>>> aligned, but on the other side I don't think there is a rule that
>>>> the function parameter to genl_register_family() - or the second
>>>> parameter of idr_alloc() - must be word aligned. Am I missing
>>>> something ? After all, it could be a pointer to the nth element
>>>> of a string, or the caller could on purpose allocate IDRs for
>>>> (ptr), (ptr + 1), and so on.
>>>
>>> This is probably going to cure the problem for you (apply on top
>>> of the existing radix tree / IDR changes).
>>>
>>> I realised when I was reviewing the patch that it's no good; if you
>>> call idr_replace() with a radix_tree_is_internal_node(), then you'll
>>> still get a crash.  I'm going to have to disable the optimisation of
>>> shrinking the tree all the way into the head for the IDR.  But this
>>> will probably get m68k working again.
>>>
>>
>> It doesn't crash anymore, but there is still a backtrace.
> 
> Oof.  Thank you!  Updated patch (still doesn't fix idr_replace, but does
> fix the idr_for_each() problem, at least according to the tests I added
> to the test-suite.
> 

Yes, that is much better:

Build reference: next-20180622-1-g023ad92e94da

Building mcf5208evb:m5208:m5208evb_defconfig:initrd ... running .... passed
Building q800:m68040:mac_defconfig:initrd ... running .... passed
Building q800:m68040:mac_defconfig:rootfs ... running .... passed

Guenter
