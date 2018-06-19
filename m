Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,SUBJ_ALL_CAPS,
	T_DKIMWL_WL_MED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6DAC5AE5A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DECA020661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="14EYuX1n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DECA020661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030470AbeFSTeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 15:34:05 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:41165 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966676AbeFSTeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 15:34:03 -0400
Received: by mail-io0-f170.google.com with SMTP id t5-v6so1281189ioa.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 12:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=m6LcF2X6OELxUawXN6hDcKumBxuyR2EuzAw8eBlnbk8=;
        b=14EYuX1nSVnrWLytpJnFC0eBObA47oSmkPfq33j6b1QMO9ey9CY1ZKyw+nYDbb/fV9
         /RlCmOZPYqLxtyDWgZFf/w2rDDRFVLtaRkJhOV7xJKOBdcTvnQJxK9pOkbh97DtuAABy
         xzec7RzBAWu/2D41w25sBiVNCEf5m2m8PGVCjePoqwnESFwZUXtcOt+vlINROppr7iEg
         9yKESImTuXV3WrnM2hBsCzZ7WFacGgSyBZTLydRN9jTGUnWbQrhwcznrbu0Vj99BsiHv
         mFlOg3irXRIMnSs/SOr32XjDfqRWpFYVR7w0tSv7CgPN15l9KSR6jIx7pppXWY7hEEiz
         ketg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m6LcF2X6OELxUawXN6hDcKumBxuyR2EuzAw8eBlnbk8=;
        b=aSNN3LpRZU2B2bv0CNcKj7b/sXVBdDI7yL+dWBXznJqW0oX20qa+1Nb+Y4zLlm/HbG
         UQCxlIRjmLQLkKff5swNlCMt9+CD6vyRCdnNGOHiDgQs45fnRdRVQutqpumqLFvsYsZf
         si2rcNDD6OiaAPjJWTVXDjhtULCjyhKhPHgESBPmlqo8z0NTMYEZQpC5Qs9AuRULG/x2
         p/v1rLV6NQgfuy6YeKUENgKN6b5o7uZFy+fbTHKLtmvz+OS87iocwHTjjhI0PwmVQEBs
         cLGgc646I9K/yD96b5ZUJC/F53gimciKjClr+P3EbWNCoWKU5bzvmIiPee/fPpGsK9rp
         feAw==
X-Gm-Message-State: APt69E2aT4almKsrU5OiHBxoT7zCVyn+vEfujgsTzhovdWgvwCgXBcFV
        J3aeNFK1GRImVu1341s0rOmbjRrBGUM=
X-Google-Smtp-Source: ADUXVKJV7NuKqgmEJ0l7L95EJ2V0ErLkHUY5Ya7Iqad7Si0JJG3sY34201sud13KtW4glVAnHmJ89A==
X-Received: by 2002:a6b:a282:: with SMTP id l124-v6mr14655819ioe.256.1529436842420;
        Tue, 19 Jun 2018 12:34:02 -0700 (PDT)
Received: from [192.168.1.167] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id i189-v6sm334086itf.22.2018.06.19.12.34.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 12:34:01 -0700 (PDT)
Subject: Re: REMOVE CODING STYLE WARNING
To:     Kitone Elvis Peter <elviskitone@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180619142738.GA12449@kitone-HP-ProBook-4530s>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0b851687-0663-69b0-6c37-305cabc0b543@kernel.dk>
Date:   Tue, 19 Jun 2018 13:34:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180619142738.GA12449@kitone-HP-ProBook-4530s>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/18 8:27 AM, Kitone Elvis Peter wrote:
> Added a license identifier for this file to remove the malformed
> license warning. This will specify which license the file is
> using.

This is the third (and last) time I'll explain this. Go read

Documentation/process/submitting-patches.rst

and format your patches properly.

-- 
Jens Axboe

