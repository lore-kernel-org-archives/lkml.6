Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64118C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C51D7214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sYwdqMKL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C51D7214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbeISIXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 04:23:38 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37172 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbeISIXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 04:23:38 -0400
Received: by mail-pl1-f193.google.com with SMTP id f1-v6so1902033plt.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 19:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h4pmfop0kqiPTcVQInMHigI4uggqGn9/2m9ws7pBNWY=;
        b=sYwdqMKL0VIa9jH8eq9EMrSKBVfGiX1nZmpP3/L18mN2COlk26O93qge8g1lmeU/OR
         8GxQ+j7q7hPOsMey/SUd8IYCRGLokjfWwyydkSYKDJLPlZ0CMt7dW3P0u6YfYLQIzEIz
         BvIsQIkvUesRu7NAq8+p5upxF2TWoihvDM851OJFRGKOCybkJAfX6s2IYryxZwlLPfZB
         7Osjn7CNxnfhrhEvGVTzOR5dSfXfUYmOMSsT9zVD+PgOQitFXWGSAUOl6yca0V8CRInZ
         Vxlz1bt2AmGbRv4+3sbgQNm8UYRSVgIl914tjOzMFrPiRAxVJfGCGK1DuNB9hvvgWTdn
         HrFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h4pmfop0kqiPTcVQInMHigI4uggqGn9/2m9ws7pBNWY=;
        b=PdqAij/LAdB0Ds2Fl72cIt7excukKi8nhHM4wkOh9tsiOiv/JI713nyKqCYu6UhoX5
         kgIqJmxcyU8ijzl389OftM9jKAXS9xQ3aiBxayfC7o+WMufEkbrK9Dosfbzz9m+DAu4N
         Wsmw0etPEY86I8OPK1GquHOeYC2LIl7YJ1PFYULaN996t5h7qzq/HLQ8IR1YXkB9E84l
         7RH/mItjeXIX0zW6BqM9n5yA4AJ/J+Mw7N0/pyCOgUny0d0xa6nguNeTvkRZfPWYjzaY
         3fVv9LBz8diuSNdrna8xKf9i48jB8VGowIVE9glT+fwiXVl381CdaoiEeMX2YTS0uGMz
         Naig==
X-Gm-Message-State: APzg51COJ6qFtyyDz1pReDZ1tvUDnIWIKN4Fc4oR0nOF2CQABP1kqD9C
        44YfAvuQQGBZQzXq+b9zuqA=
X-Google-Smtp-Source: ANB0Vda/ZbGAKdMQI1kYEctKpLmNmst2Z/bdYRZVY6vknLuIAvpJ/CFJ54Mo/AzZeHOLKpLKiRLdrw==
X-Received: by 2002:a17:902:7586:: with SMTP id j6-v6mr32018331pll.295.1537325277915;
        Tue, 18 Sep 2018 19:47:57 -0700 (PDT)
Received: from localhost ([175.223.11.230])
        by smtp.gmail.com with ESMTPSA id y7-v6sm25110141pge.8.2018.09.18.19.47.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 19:47:56 -0700 (PDT)
Date:   Wed, 19 Sep 2018 11:47:54 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        He Zhe <zhe.he@windriver.com>, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] printk: Fix panic caused by passing log_buf_len
 to command line
Message-ID: <20180919024754.GA15128@jagdpanzerIV>
References: <1537291068-443145-1-git-send-email-zhe.he@windriver.com>
 <20180919015030.GA423@jagdpanzerIV>
 <6c354803-5341-7237-9ee3-7882252c7483@windriver.com>
 <20180919023932.GA14090@jagdpanzerIV>
 <20180918224312.6e9aef50@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918224312.6e9aef50@vmware.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/18/18 22:43), Steven Rostedt wrote:
> >  First  - switch to u64 size.
> >  Second - check for NULL str.
> > 
> I think I would switch it around. Check for NULL first, and then switch
> to u64. It was always an int, do we need to backport converting it to
> u64 to stable? The NULL check is a definite, the overflow of int
> shouldn't crash anything.

Agreed. This order makes much more sense. Do you mind, tho, to have
"unsigned int size" in the first patch along with NULL str check?
Just to silent the checkpatch.

	-ss
