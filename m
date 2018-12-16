Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42646C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 15:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1062C2084A
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 15:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="RduXunlp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730664AbeLPPdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 10:33:05 -0500
Received: from mail-pf1-f175.google.com ([209.85.210.175]:34932 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730382AbeLPPdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 10:33:05 -0500
Received: by mail-pf1-f175.google.com with SMTP id z9so5123610pfi.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Dec 2018 07:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Nn+2UPoaHpW6vPiO+J2M5+exJQXYjytkfeO8UbZtH04=;
        b=RduXunlpnlMMprYyfFoqt1WJ+J9i8MKUzgfjbm1dcULck2f60744Qq01v9gbUjcvH3
         qs6aE1jtIjFrdPshWMwUIqkaDlnFImS7fp1BGatierhhxJ5JThJaqSZhjz5tilTj8kYj
         1gyPxZqB3Zm0YcgN/Q+Ap1Z7xhoEbdujSIUjO0YmPRpxfW7phtfqv+/PctTj4gerNiQG
         UCxdHXlV8V1TAKt4sOc9MH63eY4UCqkzHxx8XLgScLit0c/yIk4Ptu5+IJqxmXwy4YGb
         CMTsibxPg3xxtxLtD2twPkn11xqk2qMO8Dr85TA50aSquolB5+8X6H5BbV6apaIKcv+t
         xdsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Nn+2UPoaHpW6vPiO+J2M5+exJQXYjytkfeO8UbZtH04=;
        b=DLY6f8MFQPbks6fxO2d+AvZHl/TxBQwORY/BygvMAVcu1zTsHDpmtcz3KHCUSKA06o
         4lvwynnN+KLGBDX50s1BgOwXz0nNGta98vDzB/2DT3AKDj8VXww2lwT8JISERa9vu8Ul
         gQtWORvweQ1j1n78zJULRIXUu4ef6XPIWYeidWZumzwtkRmKkfeqerXryan088KexcQe
         xdrbOEdgFJ29VjbuHy+quAev2mZQgWQoVc6iAcCPWC1bfWxtvQSsZTfDjPVu8nEqEb4L
         h53muME1D4RWYEcpz8DQWMZ42kj+xxZZR1qdo15BwbCxcE3ZTCO98s7McPmyoHQauMMj
         AEpg==
X-Gm-Message-State: AA+aEWY6GWNwqg+WlBX+A3gwlZvTZMVdn9vYGOejMB3N3dcij9XanRTZ
        PH04kBTlS8uRtMLpa8x8G9znmFiNGX1Pbg==
X-Google-Smtp-Source: AFSGD/X3EH5noX60lmW4z2OeM8ZGOMg5a52qAiS6tZJ8RlJ/RWZglTts7sHXfTR/roV+R8VhpeD31g==
X-Received: by 2002:a65:49cd:: with SMTP id t13mr9376375pgs.376.1544974384276;
        Sun, 16 Dec 2018 07:33:04 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id v9sm15970335pfe.49.2018.12.16.07.33.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Dec 2018 07:33:03 -0800 (PST)
Subject: Re: linux-next: Signed-off-by missing for commit in the block tree
To:     Christoph Hellwig <hch@lst.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181216172649.5278d8e6@canb.auug.org.au>
 <20181216101816.GA31756@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b78c1177-7dfc-7eca-1b8b-2411cfc29d1e@kernel.dk>
Date:   Sun, 16 Dec 2018 08:33:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181216101816.GA31756@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/18 3:18 AM, Christoph Hellwig wrote:
> On Sun, Dec 16, 2018 at 05:26:49PM +1100, Stephen Rothwell wrote:
>> Hi Jens,
>>
>> Commit
>>
>>   6f7ceaa0559b ("block: remove the bioset_integrity_free export")
>>
>> is missing a Signed-off-by from its author.
> 
> Ooops.  Jens, in case you still feel ok ammending the tree:
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

I guess I can do that, would like to squash a commit too.

-- 
Jens Axboe

