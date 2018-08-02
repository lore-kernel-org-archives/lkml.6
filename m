Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A982C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 15:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0090F21501
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 15:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="wE3vc7xD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0090F21501
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387938AbeHBRvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 13:51:07 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:52855 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387649AbeHBRvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 13:51:06 -0400
Received: by mail-it0-f67.google.com with SMTP id d9-v6so4120870itf.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 08:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QJVFAUK2sfteIg6kbmoMjvdcqTQ40d+S51jY/MyhMWQ=;
        b=wE3vc7xDdxlQhYou2+VTmydkJy5dBsDg+Pcnws1VdqSQMGcMS+y5b+j9ZnOx7s8A60
         ctcJ1a50BzccegiCErWftjkjEHIXqUr/egZHZ7iTDpphfJjQZwyAfatmhQFZI4BDtn7F
         LQRo002mXv7vigfhckL4RMJezBVopO6+rNKYKiVkn1oPkCePNxfuV2kU8pk4DAF0jcaq
         sjtmeqxnduBquoEHoYKEX/ewGYFMAasKlAzVBAy3jjY62KjMPAP0vD261WYjcOihx0Uy
         iqhYJ55vqqtpYRXCunMDfjuFI9paORa/KxZVqKno+JyqY/ZkmoxXUw2kbTUlRxZqmJkE
         ux7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QJVFAUK2sfteIg6kbmoMjvdcqTQ40d+S51jY/MyhMWQ=;
        b=sPWpxJiM/+WNR/rrTgEyWrrmr+nQMpzO+TlJPITpecNSeyjtdb6niYTWfhSv2gjrlS
         uxTRPnmfw6JoQpSE8hKQ5K421gpb1lgJ/Elg53MaKDlpmSNTKeSuBVbDPyEBXdmmk7AV
         jWQT3EOnkVzEapjIR839Kye5q6ragMbLbE1NQaT83pZnFtbHhmN4u5uh/PfYrBr0912T
         jNvn4tMSm62wJqbAVG0ihGUgFzZgugi6wZekzn3aoG0PxzkWzy1Wl1Ugaj7C8AN3QI10
         X2VMdRjYtVFrGjfJaSKFwd/Z9k0yxncyxHR1kZrdMlLzI+a+NqRyOETejoWjcxpgBo43
         P5hw==
X-Gm-Message-State: AOUpUlEMuJvU4tA4eNhkFWvOm0tfBPGwz6uxekvXjUCzc2Ngt2+shstX
        vgnRdwgcjP5YVgwj1fgCffutORSz5LI=
X-Google-Smtp-Source: AAOMgpdTxa/7BzIbq2iyknlV61dxppMHvmm36B3QwfNx/9QeZhpRTmUGccimBvDkK28YAPWuVLW8Vw==
X-Received: by 2002:a24:6a8a:: with SMTP id l132-v6mr3177272itc.50.1533225559613;
        Thu, 02 Aug 2018 08:59:19 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.158.static.utbb.net. [107.191.0.158])
        by smtp.gmail.com with ESMTPSA id v23-v6sm603775iob.72.2018.08.02.08.59.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 08:59:18 -0700 (PDT)
Subject: Re: [PATCH] aoe: mark expected switch fall-through
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Ed L. Cashin" <ed.cashin@acm.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180801223020.GA11729@embeddedor.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <676f82a9-82d6-d219-f9d1-6e8847a7db73@kernel.dk>
Date:   Thu, 2 Aug 2018 09:59:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180801223020.GA11729@embeddedor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/18 4:30 PM, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.

Applied for 4.19, thanks.

-- 
Jens Axboe

