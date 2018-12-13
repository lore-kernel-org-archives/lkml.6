Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BA8C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E00362086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0d8wMK6W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E00362086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728747AbeLMTsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 14:48:17 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:36822 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728115AbeLMTsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 14:48:16 -0500
Received: by mail-it1-f193.google.com with SMTP id c9so5763893itj.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 11:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vO0PVlC/h/TD8mOKDcNOZghona65qVLNu9TgC87CmsI=;
        b=0d8wMK6WrqJrVzfELihclsJcuETB5BnN3+Arx/NlwWZIkj/puRhien7VXSOJzfYbZk
         7765Fzp6yB+Pcn2BhLUD4zsM397yly3SvQFucCDiwr30DMMJEtdbWQ7Xq9J5YLhyNKq5
         BcW1CX4L7b2SZdQ9OWMjBeOn7x+H0VCgI5uAIl8++xgHeqsSLgwvMqdPblGq1s+I6YLc
         Y5uqbp6wzckfuuypl4tdT0jU71CFgFMGzfzdHXdehhODUwGOh+0yD1YFRzanLF03kmJP
         72XnekOd/HSkK+LrkmfKsgbkzWbpuqOnRoMAH+tgC4slWNZbCYI+0sVUhPrnkfk166F4
         LYQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vO0PVlC/h/TD8mOKDcNOZghona65qVLNu9TgC87CmsI=;
        b=I+ByIRkXn70/fDMFb+0zppvN1YM7nmWtfskqROe/h/PtoeEIBzzFEaegx1aBAoH33u
         kIq6JpstXhm9U0xLphx4ce5FrmrLE7g2+j0/lsZ5lz0Qz5rp8aE/vITzjQ7HD4GHma82
         0wbB1zJKWKprsF9CY03xC3bTOzmIfJmiQENiP68r5jEMBgKbc1lClhU/YR/9FgfXdvRN
         8CfsMtF+5Z9chfCGo2h6t9wkpO/NyU44UPS1iAFYEpanAmL2MbfQdeH9lhAVWi2JKfBZ
         9R+ozjPlF+hEQfbjzx7LKIpFJlda1XO/G+FNnuoXLAiwQZXS3OmkhXgD9prrsAGMaR/R
         P8dQ==
X-Gm-Message-State: AA+aEWYOTOm4a8iFCYkUkzxywzmOdf87GBJySfBAF3TeGD/YvBeFpvSY
        VyrBFuZBFtkIzW8cRpaBtg5/nvOJz35kbw==
X-Google-Smtp-Source: AFSGD/U5p5jTQUXU7vmYEwI1LNCAfuI+iIlWTm1xkH0MiSQ+wr6PD6zrHbC6t1t1KYE1hN9tjkLYSA==
X-Received: by 2002:a24:4110:: with SMTP id x16mr721767ita.30.1544730493524;
        Thu, 13 Dec 2018 11:48:13 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id u5sm1571542itb.33.2018.12.13.11.48.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 11:48:12 -0800 (PST)
Subject: Re: [PATCH v2] block: fix iolat timestamp and restore accounting
 semantics
To:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181211230114.65967-1-dennis@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <59500829-10f5-fa83-b2db-fcfa4a1cd11d@kernel.dk>
Date:   Thu, 13 Dec 2018 12:48:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181211230114.65967-1-dennis@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/18 4:01 PM, Dennis Zhou wrote:
> The blk-iolatency controller measures the time from rq_qos_throttle() to
> rq_qos_done_bio() and attributes this time to the first bio that needs
> to create the request. This means if a bio is plug-mergeable or
> bio-mergeable, it gets to bypass the blk-iolatency controller.
> 
> The recent series, to tag all bios w/ blkgs in [1] changed the timing
> incorrectly as well. First, the iolatency controller was tagging bios
> and using that information if it should process it in rq_qos_done_bio().
> However, now that all bios are tagged, this caused the atomic_t for the
> struct rq_wait inflight count to underflow resulting in a stall. Second,
> now the timing was using the duration a bio from generic_make_request()
> rather than the timing mentioned above.
> 
> This patch fixes these issues by reusing the BLK_QUEUE_ENTERED flag to
> determine if a bio has entered the request layer and is responsible for
> starting a request. Stacked drivers don't recurse through
> blk_mq_make_request(), so the overhead of using time between
> generic_make_request() and the blk_mq_get_request() should be minimal.
> blk-iolatency now checks if this flag is set to determine if it should
> process the bio in rq_qos_done_bio().

I'm having a hard time convincing myself that this is correct... Maybe
we should just add a new flag for this specific use case? Or feel free
to convince me otherwise.

-- 
Jens Axboe

