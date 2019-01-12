Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A92C43444
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 17:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9412C2084C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 17:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rpABmmWs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfALRm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 12:42:26 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43136 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbfALRm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 12:42:26 -0500
Received: by mail-pg1-f196.google.com with SMTP id v28so7649780pgk.10;
        Sat, 12 Jan 2019 09:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1v3ydxuV3Mp4vHGQAofgwBy19gsnFvhe8le1LENyYJc=;
        b=rpABmmWs2RBlRPS6ABFD9bwh4tCbRYnzs3CWnADJWYS+uiybqttJZC/xrDazGPe0lX
         Wo8n0SjL7cF/Ryy7zmmOOscMUHKC0fVZmRJZKkF8lcUI74ZlvcFA8slsCJtjCPcEwcGI
         +ypJZwOs35BquUSaQmU3T/A/bR686ipDdLeyTdk5rzElhxWzJtnogNnQ1xjcIHpiuVup
         jUsEZUqKD6OgvQ6qVX5mhFPz2tcGsVguiVtAVb6uFdbPgYe62Cyc4b76h/ezNBf1s5RZ
         LCYwP530dLfn7dKDf2tGH1STE2OncdAwpNpjRxE7g16Q5zOF1CS0St4esKoglmcZKY6z
         fyGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1v3ydxuV3Mp4vHGQAofgwBy19gsnFvhe8le1LENyYJc=;
        b=GhFTCFWoD+DTGAn/iFfmGLrOPjYt8k+Mtd6t/ZwRWOkxoNzYmPc4Ejl9xbuKuj29uh
         xb4SE1tLpdjTtVZ9mEuumgIKHw0BgVcXbH5nqmlXHMMUWBh9xkz7WI3hrgBi7yCQ3qS2
         Zel2ru42A7/vhFvB8jOQLZyeO9zyO6jF/+UlxSFxCVC8ozHOZWtu+IlV8SJBKwGg4RYG
         PfM1zlCkLaVS4dr830FBh9LHjyg6ArsNC5msG18IamExfWP7zQuPFi0zPqO3eN0MVSZN
         /miPnCvPFAQjW09Z3LLNEfBXuYunA02EBRQp5F70huLlVoIDwEjD5Eq42f5m5y9kXY0f
         RO9w==
X-Gm-Message-State: AJcUukeKENPCJKnYfd9BuPGsyXjlNKzGpdJ8W8NJdAxvYtB6AsUp3jRv
        OktdUN/4ppwqdY44dD2bEF/iA3dv
X-Google-Smtp-Source: ALg8bN6L0HSbw0rkP086E7H/QHVSGChoNV695bywKjsRPwfeQJBu8xRWdNKLPpj3ZqJYbwTy+IxBLQ==
X-Received: by 2002:a63:7512:: with SMTP id q18mr16061149pgc.231.1547314944286;
        Sat, 12 Jan 2019 09:42:24 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 125sm135790890pfd.124.2019.01.12.09.42.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jan 2019 09:42:23 -0800 (PST)
Subject: Re: [PATCH 3.18 00/47] 3.18.132-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20190111130956.170952125@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <f762fe50-0a19-8649-acd0-e3c947e80c4e@roeck-us.net>
Date:   Sat, 12 Jan 2019 09:42:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190111130956.170952125@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/19 6:07 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.132 release.
> There are 47 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Jan 13 13:09:31 UTC 2019.
> Anything received after that time might be too late.
> 


Build results:
	total: 155 pass: 155 fail: 0
Qemu test results:
	total: 217 pass: 202 fail: 15
Failed tests:
	sparc32:SPARCClassic:nosmp:scsi:hd
	sparc32:SPARCbook:nosmp:scsi:cd
	sparc32:LX:nosmp:noapc:scsi:hd
	sparc32:SS-4:nosmp:initrd
	sparc32:SS-5:nosmp:scsi:hd
	sparc32:SS-10:nosmp:scsi:cd
	sparc32:SS-20:nosmp:scsi:hd
	sparc32:SS-600MP:nosmp:scsi:hd
	sparc32:Voyager:nosmp:noapc:scsi:hd
	sparc32:SS-4:smp:scsi:hd
	sparc32:SS-5:smp:scsi:cd
	sparc32:SS-10:smp:scsi:hd
	sparc32:SS-20:smp:scsi:hd
	sparc32:SS-600MP:smp:scsi:hd
	sparc32:Voyager:smp:noapc:scsi:hd

The failed sparc32 tests are really nothing new, but were discovered due
to more extensive testing. Observed behavior is a boot hang. sparc32 images
in v3.18.y (and v3.16.y) have probably been non-functional since commit
16c193364b4d ("sparc: Harden signal return frame checks."). The problem
was fixed upstream with commit 07b5ab3f71d3 ("sparc32: Fix inverted
invalid_frame_pointer checks on sigreturns"), and applying the same
commit to v3.18.y (and v3.16.y) fixes the problem.

Guenter
