Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCE2C07E85
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 472FA20863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="zbjqn2NX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 472FA20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730439AbeK3ERC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:17:02 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:37626 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728362AbeK3ERB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:17:01 -0500
Received: by mail-it1-f193.google.com with SMTP id b5so4805577iti.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 09:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=509fG5ohW0ABAHddsQVvEAUx3iqSoPz8t3CRL4oZu+0=;
        b=zbjqn2NXiUU5F/wbdNdZPpSgPc2cV36l0Axm+1tzGlshg07I+PK+iOMGRB2f06sZZK
         ZM/5uAsbnqSQbu3gdWRy3ZUMrFVHbDvsnXzsIDG3n2F6R5sqRGogOM9nL5laAxrdXKIN
         aj5ahnXNP/insuVrL4+IpNFeK5g65M0VxMXH0RQLGwK7Vslf1HKxRMo0H/k8T0cLkS9K
         Qq8JNKN0RatWksm0GoAV5ix0wWNlfSBXOj5t7oYMO4+t9Fx2as1GJ2kgROwwE7Qj/ab3
         qzjb15F53eT11PgcPnpLJi54UK5iX2vuUZXrmiXTAUGwSB3y3aiSII/0QQSjWNycutxQ
         HPbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=509fG5ohW0ABAHddsQVvEAUx3iqSoPz8t3CRL4oZu+0=;
        b=sPg7ds8DNWq5yOnt0VdrxliDq4dXbD3fTRJ+bXerRsrEXSwVqqf6UiOEwCgCl56cY5
         cD844TjkoRPxJRkSDN0YMlcZW+dkcJlw3I+EnEzcbSLhS4Q7FJX4ThOqFMSOQSs+baie
         7dKbTPZvDit4tHJtUupTMqzfE00mhCiItl+OtqhLMzXTPbBZkv0/D/c8YKvLsUc1hzOH
         LeDVoyUazg4f6GPeDR4sbE8BKcKf1sXlOftkrpy2NVg2mwLmcuHyst6Sk8ohLeki8bn8
         SNtQdrur/2sQNsRdxgfNZHfyx1Gj6U7JksXCssIa79qJvgW7fiVuQmYGacIX/tKUzesJ
         r8Ag==
X-Gm-Message-State: AA+aEWbTUY7GSowtfRpkxL3iwzef9k5HverQ7/kwfwGqJ8B7uNd14R9M
        bt20xGhYmFF6jFE+vPa3rcs9kg==
X-Google-Smtp-Source: AFSGD/WzBTigcgiAWbi4E4fkWzUKOACs1rlJFDtdpHkIRN0EDWaUUGSVbiDvYoAXJMrFZMC4vu+QJw==
X-Received: by 2002:a02:7e95:: with SMTP id g21mr1932112jae.114.1543511457266;
        Thu, 29 Nov 2018 09:10:57 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id k4sm899605ion.61.2018.11.29.09.10.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 09:10:56 -0800 (PST)
Subject: Re: [LKP] [block] 9d037ad707: BUG:unable_to_handle_kernel
To:     Christoph Hellwig <hch@lst.de>,
        kernel test robot <rong.a.chen@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@fb.com>,
        lkp@01.org
References: <20181129092031.GF21676@shao2-debian>
 <20181129170535.GA28147@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e22e64dd-1433-345c-4e43-50c9d1818d6f@kernel.dk>
Date:   Thu, 29 Nov 2018 10:10:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181129170535.GA28147@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/18 10:05 AM, Christoph Hellwig wrote:
> On Thu, Nov 29, 2018 at 05:20:31PM +0800, kernel test robot wrote:
>> FYI, we noticed the following commit (built with gcc-7):
>>
>> commit: 9d037ad707ed6069fbea4e38e6ee37e027b13f1d ("block: remove req->timeout_list")
>> https://git.kernel.org/cgit/linux/kernel/git/axboe/linux-block.git mq-perf
> 
> This looks very odd.  How could we introduce a new BUG with the removal
> of an unused structure member?

Someone else reported a t10 pi issue, I'm guessing it's a latent bug and
the struct size changing is causing it to trigger weirdly on this one.
That's the only explanation, as it can't possibly be this specific commit.


-- 
Jens Axboe

