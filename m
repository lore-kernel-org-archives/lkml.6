Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326F6C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 22:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB59927A1E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 22:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBLmiZJB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB59927A1E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966987AbeF1WWa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 18:22:30 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:38410 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966903AbeF1WW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 18:22:28 -0400
Received: by mail-pl0-f68.google.com with SMTP id d10-v6so3427138plo.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 15:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZS9lrgCKcH5cn/fUKhkwzimnM7jOIILFchM59oHHobQ=;
        b=IBLmiZJBvFZFSgT2JEHmYxbMB6E2bZPwuzHdTgQRSCdo1OX7fVc561+0cda2cmXzPM
         rPne2GO+Rl4L+qDtbkZ4E/PffLhQ1FJ4TJT7N/zoN0Jd4DfP45wjSARYCn+eep7LVmCH
         j/vkpSo1H0Dp62hMPO5EHHzz9+34G9w5I09eZfZZ69hWoQl+X/Q+0oCLaX0TMNx4k5r2
         7xvTvc7hNRth+O6QWgEntx9qay7WQRzvPAVIAoPvigsdoPjVBAa4NjJCiuHuKtIQP1CF
         YmRd8VDHzszNPsFrDp0+EcwUkK5fwO3c1m//NzbEB0cnQeb1o1s5chIx3o0NgyqAtzib
         9zHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZS9lrgCKcH5cn/fUKhkwzimnM7jOIILFchM59oHHobQ=;
        b=ou3ygRFO9OLolI7m3eQM87979C81E8eCSEE7FWcYi/byzD0AXW7fKhnstQ3yjRswcy
         g4XRLf/voD0QjONBZMuIzr+DDhhuohQt1FXe9AvHBEuC8yRm3kpc3iiL409bFsgrqk7y
         9LV0Ge+aC6EUpu/iaSHMGobbbmrshkq9+Q1j89N5CobhXRzm2YXfJvVmO+i87TO4DykI
         AXdXis9GMQTuatBdwmXlHHSoEpMEKBw5NSHwUT/ML+uYo0eDAqD+vgQkSRoFGxi945lU
         ige342fSa9aVCDyXLcmjrCUTq13FY3oeCglWNZzfMLAiiBsY1LWEy3Pd18ODJhrNVilX
         xMsw==
X-Gm-Message-State: APt69E2GTdpH/qb/CY9G3T3P3OIQBOr1LJ29eDQ4tB8p/yiOxGcLaBUj
        I+oTTQo4r17nQsyGJTbqa6g=
X-Google-Smtp-Source: AAOMgpfPPGc8UIrU21DpKMWOH3v3xdKdQhcz7QZtZgwEw/qb8Oc2L+qCj+ysg9qIyqb+ONHi+vfpeA==
X-Received: by 2002:a17:902:530a:: with SMTP id b10-v6mr7902201pli.316.1530224548300;
        Thu, 28 Jun 2018 15:22:28 -0700 (PDT)
Received: from [192.168.11.4] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id e17-v6sm13687687pfd.15.2018.06.28.15.22.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 15:22:27 -0700 (PDT)
Subject: Re: [PATCH 0/2] tools/memory-model: remove ACCESS_ONCE()
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, boqun.feng@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        npiggin@gmail.com, peterz@infradead.org, stern@rowland.harvard.edu,
        will.deacon@arm.com
References: <20180628123347.52963-1-mark.rutland@arm.com>
 <20180628123845.GA14456@andrea> <20180628152140.GK3593@linux.vnet.ibm.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <1b382e0f-bfa8-8465-ba88-3a1431beefde@gmail.com>
Date:   Fri, 29 Jun 2018 07:22:22 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180628152140.GK3593@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/06/28 08:21:40 -0700, Paul E. McKenney wrote:
[...]
> 
> While I am at it, here is the current scorecard:
> 
> e9ff68680cd4 tools/memory-model: Add litmus test for full multicopy atomicity
> c21fcc6594f1 tools/memory-model: Fix ISA2+pooncelock+pooncelock+pombonce name
> aa838e0b70e1 MAINTAINERS: Add Daniel Lustig as an LKMM reviewer
> 3cb0d7701c4c locking/memory-barriers.txt/kokr: Update Korean translation to fix broken DMA vs. MMIO ordering example
> 0bde941f3629 tools/memory-model: Remove ACCESS_ONCE() from recipes
> 80b7b05c3aa0 tools/memory-model: Remove ACCESS_ONCE() from model
> 
> 	The above patches are ready for the upcoming merge window because
> 	each has at least one Acked-by or Reviewed-by.
> 
> 6098ce88bc4d tools/memory-model: Make scripts executable

In this commit, "Usage:" in the header of scripts/checklitmus.sh should
also be updated.

When it is fixed,

Acked-by: Akira Yokosawa <akiyks@gmail.com>

      Thanks, Akira

> 5bb22d0126f9 tools/memory-model: Rename litmus tests to comply to norm7
> 1bc179880fba docs: atomic_ops: Describe atomic_set as a write operation
> 
> 	The above patches need at least one additional Acked-by
> 	or Reviewed-by.  If any of you gets a chance, please do
> 	look them over.
> 
> 51b0a8985c5a EXP tools/memory-model: Add litmus-test naming scheme
> 
> 	This patch needs me to get Will Deacon's feedback applied.  :-/
> 
> 06e99a0d9662 EXP tools/memory-model: Add .cfg and .cat files for s390
> 
> 	This is a placeholder, and probably won't ever go upstream
> 	into the Linux kernel.  (Maybe someday into herd where the
> 	other architecture-specific .cat files live.)
> 
> 							Thanx, Paul
> 
>> Cheers,
>>   Andrea
>>
>>
>>>
>>>  tools/memory-model/Documentation/recipes.txt | 4 ++--
>>>  tools/memory-model/linux-kernel.bell         | 2 +-
>>>  2 files changed, 3 insertions(+), 3 deletions(-)
>>>
>>> -- 
>>> 2.11.0
>>>
>>
> 

