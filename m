Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC25C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BC8F2070D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="NShKpzrN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732372AbfACQo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 11:44:59 -0500
Received: from mail-it1-f177.google.com ([209.85.166.177]:53595 "EHLO
        mail-it1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731280AbfACQo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 11:44:57 -0500
Received: by mail-it1-f177.google.com with SMTP id g85so46031713ita.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 08:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=QCaOzSC26IxHVRPOOmvE8nQmVr09QUJSi7iOSihTUFw=;
        b=NShKpzrNABTm2XVUbGF/tpofB9klWZ6DweHMfVY9QCUo1YPULL43z5dVEwi8U3cEzQ
         2YE2b5TKZ9gX1FFBcwA8uBkLFDgsffbaeuMgsu2FUU2iz2liy6/1nGLZWkkb5mdA8ySI
         +TRwfbk7VqRLL7mUWN1SwBV3fSfySb5KdtjSVUxZT59i0NLeNU+fab/9tMdg+MDA1YxG
         jkjQL/SKW+kXaSqyYgj7YdAFL06Iexg0anNHWtDtpLK9I7N2r4Dfli5IVBMUOq+XyPUx
         /OUzZ4rbAdu8ElUTdCPfbPGnCD83ykSuEHK12dWlvrIVDtzYqEHBGqu1mW3oxfsoYm1R
         B78Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QCaOzSC26IxHVRPOOmvE8nQmVr09QUJSi7iOSihTUFw=;
        b=RZG/0dnU8Uan1sPfcyuvnTADMw+plpCRH9zSaduOEdK4zTdj4Otfg34O/Zu48v01S5
         qDBsOFHBBdKU8oNBXmDbGZrMULVGMThgTfnp1SAYQ7e5/WtAweYt4eaen5cv8K/5O5yw
         wvpBlvxQINSdgbcVNZmiOEhvdgTYNVRbmcIL01aNzIUvOzooKGWDntc72drqsSn85Xq+
         v2fGlkWc35sqTm8PIyxCe5jw5GuHRproMxDYe8ECDmnHRNqiZPUO6RaCy0vO2OHdjrn6
         AnrmTQqxfOqmsX0MDtZGFG4xKA3p67TPLdSwAlZ0d8oKNWcu1WnWICPVJGkSXFklzdev
         wy9A==
X-Gm-Message-State: AA+aEWaWbIOiCIZYVfCeTNKgbB6IG8R6pOodcbbRZoACvyzb8PFv/npJ
        TUzlPOLEQ/zPIp7UoVTew5qKNU+GoDtDjQ==
X-Google-Smtp-Source: AFSGD/XGbIbrE1AwqZL/StD7fr2lS9IHCMlpW7aT/hRJAt80KdaPOMiHMnyElxGtFmAfbtN+w30elA==
X-Received: by 2002:a02:5618:: with SMTP id o24mr33782959jab.111.1546533895445;
        Thu, 03 Jan 2019 08:44:55 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id d3sm24037955itc.40.2019.01.03.08.44.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jan 2019 08:44:54 -0800 (PST)
Subject: Re: Shaohua Li
To:     Guoqing Jiang <gqjiang@suse.com>, linux-raid@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <398a74fa-6566-8d0d-6434-e68ff3763656@kernel.dk>
 <af940531-2535-2777-8c09-e9d1e6c16e82@suse.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <86273f7b-f036-cb31-1da1-e3d65e593ee6@kernel.dk>
Date:   Thu, 3 Jan 2019 09:44:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <af940531-2535-2777-8c09-e9d1e6c16e82@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/2/19 7:38 PM, Guoqing Jiang wrote:
>> As you know, Shaohua acted as the maintainer for md. He remained
>> dedicated to that through the difficult times. With his passing, we
>> obviously have a void that needs to be filled.
> 
> It is better if there is a small team to maintain md in future since nobody
> have broad/deep knowledge as Neil or Shaohua, also people in the team
> can cover/backup each other, see [1].

Certainly, whatever the community deems the best solution.

>> For now, I'll act as interim maintainer for md until we can find a good
>> permanent solution. I'll queue up reviewed patches in a separate branch,
>> in the block tree, and help review fixes. I'm subscribed to linux-raid,
>> but please do CC me as well.
> 
> Thanks, I think there are some patches in shli/md/for-next which supposed
> to be merge to 4.21, could you please help to merge them to your branch?
> And I suppose you will send a patch to CREDITS for Shaohua.

I have picked them up and will send them in for this merge window.

-- 
Jens Axboe

