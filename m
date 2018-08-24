Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44907C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 06:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDD042147A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 06:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/vOd/Ge"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDD042147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbeHXJdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 05:33:08 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39065 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbeHXJdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 05:33:08 -0400
Received: by mail-wr1-f68.google.com with SMTP id o37-v6so6443547wrf.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 23:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TT4E1yBoJe/aCJWF0rYG9kVpseGaW6k9ENZXA1j3B74=;
        b=i/vOd/GeBu0FQT1NX9DrFWLRHzUAEMTo2j1ypN393HOVKTsRGE4dxWqee1k6ByD1o2
         tx83rrVfvd1doG836UwI5kpwlNfpKlRvEnLIU3NuUr+eiwKB1Cj9sUJ76ml68dl0FN3Z
         mg3EQQN8XzuxyVkDaKXWXebHyZgXByMiop4FQIsIoSlF9U9zJo68/r5RlPjcd+m+f3NW
         UztCmITDacHvI1U3G7me2pnAFKymxUwe7lbKq4DXsLm3GPARMSIpaGphMmt4un2x0+Jd
         RoilxyP0hhnzynutmWASoOOqV04cr9+1zn61OD8iDI/aKVLsXZ6FjVWBUghoM14NbT6g
         xwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TT4E1yBoJe/aCJWF0rYG9kVpseGaW6k9ENZXA1j3B74=;
        b=WrzSFpcpFIm+Zee8oCQRHcqM4mcoTwpUt9v8QsCeVeF9rTakr8On4jGRSaqvvn7aD8
         E04vndmcRaLlWnSdDlVQXgaC/ZnQ+vNCYqCc6FG85pXBOy4yLDDwmwD3jOJykDfpt3Qs
         gR615qe3Wojr+mgTz0o+qDMQL3cB4+HeVQkwIWVWWDNJ+kPwdM8rHzjTA8ZaCg0QhUcx
         qlZYoh71Ze6kNOHxxJLUmnRy9J4ZpRDwiFqMSh6jVA2vxkJHEzfi/gE6/w/hA+An4/xG
         n0usH+gg7dAZ9pobndzcBXjCX/YOZFk2/rBb2ewwFCzNU0eDwpvsViG1lTolQqce0JYk
         DLHA==
X-Gm-Message-State: APzg51Cn/HJmza2aOfuMOLdO4wao3eIQxtKNNgiXdEVbprbWHpdYv1gq
        O+uAxjYxFqJE1nAjHJafWPs=
X-Google-Smtp-Source: ANB0VdZ12jr83m03q1GzoQ7i/yqukWthGf/I0FXJBG17MPsigcNzovr1OfODpud2991UnkSTCrwC3g==
X-Received: by 2002:adf:ffc7:: with SMTP id x7-v6mr179069wrs.137.1535090401527;
        Thu, 23 Aug 2018 23:00:01 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:d600:71c4:a2f:ce95:ec39? (p200300EA8BD4D60071C40A2FCE95EC39.dip0.t-ipconnect.de. [2003:ea:8bd4:d600:71c4:a2f:ce95:ec39])
        by smtp.googlemail.com with ESMTPSA id b2-v6sm536318wmh.3.2018.08.23.23.00.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 23:00:00 -0700 (PDT)
Subject: Re: Fix 80d20d35af1e ("nohz: Fix local_timer_softirq_pending()") may
 have revealed another problem
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
References: <8b93f213-fe67-f132-f3f5-5b17995ec63d@gmail.com>
 <20180824041245.GA2730@lerouge>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <67ce38dc-1f00-55c6-f9ae-2dec00172cf6@gmail.com>
Date:   Fri, 24 Aug 2018 07:59:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180824041245.GA2730@lerouge>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.08.2018 06:12, Frederic Weisbecker wrote:
> On Thu, Aug 16, 2018 at 08:13:03AM +0200, Heiner Kallweit wrote:
>> Recently I started to get warning "NOHZ: local_softirq_pending 202" and
>> I think it's related to mentioned commit (didn't bisect it yet).
>> See log from suspending.
>>
>> I have no reason to think the fix is wrong, it may just have revealed
>> another issue which existed before and was hidden by the bug.
>>
>> Rgds, Heiner
>>
>> [   75.073353] random: crng init done
>> [   75.073402] random: 7 urandom warning(s) missed due to ratelimiting
>> [   78.619564] PM: suspend entry (deep)
>> [   78.619675] PM: Syncing filesystems ... done.
>> [   78.653684] Freezing user space processes ... (elapsed 0.002 seconds) done.
>> [   78.656094] OOM killer disabled.
>> [   78.656113] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
>> [   78.658177] Suspending console(s) (use no_console_suspend to debug)
>> [   78.663066] nuvoton-cir 00:07: disabled
>> [   78.671817] sd 0:0:0:0: [sda] Synchronizing SCSI cache
>> [   78.672210] sd 0:0:0:0: [sda] Stopping disk
>> [   78.786651] ACPI: Preparing to enter system sleep state S3
>> [   78.789613] PM: Saving platform NVS memory
>> [   78.789759] Disabling non-boot CPUs ...
>> [   78.805154] NOHZ: local_softirq_pending 202
>> [   78.805182] NOHZ: local_softirq_pending 202
>> [   78.807102] smpboot: CPU 1 is now offline
> 
> I've tried to reproduce with suspend on disk but got unsuccessful.
> 
> A small question as I see someone is having a similar issue with a stable
> release only. On which kernel did you trigger that: upstream or stable?
> 
> I'll continue investigating.
> 
> Thanks.
> 
Affected is recent linux-next, after the commit mentioned in the subject.
I can work around the warning (not sure whether it's a proper fix),
see here:
https://lkml.org/lkml/2018/8/18/272

Rgds, Heiner
