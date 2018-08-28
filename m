Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3EFC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C4682084A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ooo08PjF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C4682084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbeH1TlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 15:41:15 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:37214 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbeH1TlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 15:41:15 -0400
Received: by mail-io0-f195.google.com with SMTP id v14-v6so1864482iob.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 08:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hZXJJoMUomqqyQBrHFq552yHGanjV3qgKSv736VHe5w=;
        b=ooo08PjFoPFUXOiyJ3k4rhVyMPH27YsP5XA24BsFHoJgqJbjaGRbD5jCbjYAPUEgMW
         XxonQP+lnQTMWsg2BbZhHobfIPvkNKjUB5PH19JDcD8yTtXlmaNklPH0wjohwvQf6Jwz
         KwRZtSfRzK2teYWKidR1qlCkx6Fm4zOJjXFjwcK39mHlupDEmSBq1YKcUu60/Yd4JnkJ
         N5FpEPh7Ka/fsgpLiXmgTOAullQPTwpRjYV+gIY8qVKoAwU6Neqf5N041fwxGdgL26UW
         pR6HBTUyZD/SD3qXvRMmDbM9GHMIUV5256+ymMUOeL0M2HCmCk14ws3MLLLIQrX8dcPx
         PAOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hZXJJoMUomqqyQBrHFq552yHGanjV3qgKSv736VHe5w=;
        b=NWgvvlFj9EBI0tcqewbQdyFePJ1qO/uUpuw2PC5bw4H0yih2SQ3lmzLMTYRzOS+QoP
         pfnJArB2Bo2OtOl/L4iG/eUG566w4GH+bqzrSBBkEqF9ZIhL5v0iC5wCpJxeqf4Lhrys
         fOnzMPn0S1YI1ATprHA5eb6Bk+FCle8ssoO5RR/+WJPhnTtu+s7YeLfmhRTKQhQuq/Sh
         USGxYw4sKAl6SvsGBRgMj8WIBxio+eyWKDdpuYZ1hlLtDNolpQI9H+TV+uzMKd3NaHv/
         P+OO40tXR48E8218V1+74UuLfozHxvbimHcrhj3MJsv8ElA0Ek+nG8vbU0C2nCvvlGOy
         2wTQ==
X-Gm-Message-State: APzg51ApfN8FxVxO5zfgL2xhF2y4Iiy5UJsNBrAP8gBFufDtIa+v3XzB
        YJ275nH+ArPaWMR4TuoRY4Bp5A==
X-Google-Smtp-Source: ANB0Vdb+sk654IYbEhVAkNLo7FIpDPOO/0U7hApw/gqzYtcDlTF3/P8zqh0sy6h+srfJOH7crmM4wQ==
X-Received: by 2002:a6b:1f4d:: with SMTP id f74-v6mr1921137iof.206.1535471338824;
        Tue, 28 Aug 2018 08:48:58 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id b10-v6sm588779iok.40.2018.08.28.08.48.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 08:48:57 -0700 (PDT)
Subject: Re: [PATCH] Revert "blk-mq: issue directly if hw queue isn't busy in
 case of 'none'"
To:     Ian W MORRISON <ianwmorrison@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kashyap.desai@broadcom.com, loberman@redhat.com, osandov@fb.com,
        hch@lst.de, bart.vanassche@wdc.com, hare@suse.de,
        ming.lei@redhat.com
References: <20180828154727.3589-1-ianwmorrison@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <211633e2-a812-d489-e11c-c3f271c465fc@kernel.dk>
Date:   Tue, 28 Aug 2018 09:48:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180828154727.3589-1-ianwmorrison@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/18 9:47 AM, Ian W MORRISON wrote:
> Kernel oops when booting on Bay and Cherry Trail devices
> such as Intel Compute Stick. Bisected as:
> 
> commit 6ce3dd6eec11 ("blk-mq: issue directly if hw queue isn't busy in case of 'none'")
> 
> This patch reverts the above commit.

Did I miss the posting of that oops? Just curious where this is
going wrong. Not adverse to reverting, but I'd like to try to
understand the issue first.

-- 
Jens Axboe

