Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68C5C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8D4721479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="GmAlQajt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8D4721479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbeJIVnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 17:43:02 -0400
Received: from mail-it1-f170.google.com ([209.85.166.170]:54391 "EHLO
        mail-it1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbeJIVnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 17:43:01 -0400
Received: by mail-it1-f170.google.com with SMTP id l191-v6so2869644ita.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 07:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WplHCN/XHSu+pq7iffC8NqqRB/g76gqlZ37Ldd15fzM=;
        b=GmAlQajtUOk6Jo3swHTmVnw5aLI3kfWy/mBUH0Foq99zNEfuTGtnqZU44LOjFcVD4Z
         9jaVBhzGdTdMxupLesoEdJJBhu+bN4IdnwWVjNADe6cIp+klCYfdwbas3cg14/zfYOI4
         9P/Eb62DRyjsMc8Oo3MuQJaD95w4LxRitGGuCvFtrsEcpHftQcRIfhrRyYDbq+Je/GAG
         nhgxG0wgd1pvHbKrz2eAWSmqe4/c3+5xD+j0zD9EGvvudG3qSQZz/v0S/22E7plX/Y3h
         k2BU57nZEFiJ6MM5kYcQyN40jLrF09ubClPxvTM1Jwg2opp4CtJPkvTLz3AhXip0Xotj
         kkeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WplHCN/XHSu+pq7iffC8NqqRB/g76gqlZ37Ldd15fzM=;
        b=WGDArmAFqS6f5Akux5nMErTCpspZ6IIsisC90taY3JfbL0rbRgjJcE7DQqf2KI7mpa
         mYg9x6xmce42Yr3yhO4siUVy8isr6DVVF7iCl3T1AoMff6IVykXuUaFYB7ZWomHq46p/
         qvlB/VdXO+QuVVbLSGU/dLuwtZjyrJnWkJpysZMRXUoN59UdZy1DXxrdVSXrmJhSaYr1
         ZbqdCG22r8vW2DWxfIHnS7ERodxl0VxFlE99qWrforGzEBKHHzdaoqaov7w9zyhxGO0y
         Sl8mPwqQdwfEg/7dIEqYMAztvSpiwC1UgWuodbhfauqQJyN+Nh4XOy8onfawVJxlsY8Q
         RwvA==
X-Gm-Message-State: ABuFfojtec2fInbSDTMx61lX6b2feB2mMAbemm+bamQ5vz5861zRwk84
        xqZGuUAyJMIxtYgRQpPsPoOlg4xFGfA=
X-Google-Smtp-Source: ACcGV607OQ/YwGGKirfEZJ8d5a73w9Cu5HpANLKOZtHUJ5qJyn6Gyb/MliIzMX6r6Y3D2Z8btJadNw==
X-Received: by 2002:a24:648d:: with SMTP id t135-v6mr1915514itc.155.1539095149067;
        Tue, 09 Oct 2018 07:25:49 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id h8-v6sm7377105ioa.52.2018.10.09.07.25.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 07:25:47 -0700 (PDT)
Subject: Re: [GIT PULL 00/45] lightnvm updates for 4.20.
To:     =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181009111215.7653-1-mb@lightnvm.io>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d16b0748-5771-6743-4ddf-0d974309a3b2@kernel.dk>
Date:   Tue, 9 Oct 2018 08:25:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181009111215.7653-1-mb@lightnvm.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/18 5:11 AM, Matias Bjørling wrote:
> Hi Jens,
> 
> Please pick up the following patches for 4.20.
> 
> The changes include:
> 
>  - pblk trace support from Hans.
>  - SPDX license header update from Javier.
>  - Tons of refactoring patches from Javier, and me to cleanly abstract
>    the 1.2 and 2.0 specs behind a common core interface.
>  - Enable pblk to use a common interface to retrieve chunk metadata.
>    From me.
>  - Bug fixes from Hans, Javier, Jia-ju, Wei, Zhoujie, and me.

Applied, thanks Matias.

-- 
Jens Axboe

