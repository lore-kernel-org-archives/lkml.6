Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87038C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 15:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41A8220663
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 15:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="KKfxsmKo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbfBXPPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 10:15:33 -0500
Received: from mail-pl1-f174.google.com ([209.85.214.174]:38767 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbfBXPPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 10:15:33 -0500
Received: by mail-pl1-f174.google.com with SMTP id g37so477877plb.5
        for <linux-kernel@vger.kernel.org>; Sun, 24 Feb 2019 07:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KjcZEKAtKvbeEfJDUWDF8ciIQZpuvBY8FQNPfjWkxbg=;
        b=KKfxsmKoDgquHF3vsUs/9gLMQnE+1Pizw8yCClatrIJv+zPWU9dxaVvXICqExmJ0vb
         kGMb7yWfCwBB2dpYXNth20Mn5oqA2WTwpwLJuiVtclpUZnQa8hfnVZ7llb4tqRAQE1Lr
         YG43WYst2uhgN9WG3YPuS95HOi5HqWc/X+lEqKB90iOQFu7pL1h30xWNPQT3K3dx4IzX
         qj2eXvmSptKm7xryBDwxPX0EwauYELoNldlqd4SCnEz5X0AMvS0sBtOrzrjCjY376rWH
         8DaVAslOusW9ItF6bsOudogE7RdhqMKFBXqE5LEXxklF2dNQoKRxyJqefMP7kqZ930XV
         mbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KjcZEKAtKvbeEfJDUWDF8ciIQZpuvBY8FQNPfjWkxbg=;
        b=Big6RB/r71qppEJw25SLGOxCc/IcfcHFVGNhZ6rDBrNFsBIGlvu6EjK2wwdfTdQLfn
         jOw2IHt/i0GyIfHKNv6ZFjKArVp9yrJpcchnhoeRN3sekAIpX4Ac0YM7La16zT1NxHiQ
         B5fp8RA6GaX4H/BgodRBKfaiyaoADr2YnL+9sGQJZRB8HzhGg8vgWivmRMkk+YQkde0j
         wj6LTkdjchCvjKarHsX3coyqatxfk9DimM4Fmf8OPhXP+40uCvkTt6IQsY5zgPClWUeB
         xXFNoqD5Onw/PgnhFbRrpJ+q+3vQSgknTY1OCWlzBgyR2kQ5wKrH+mIMvPPOezqX4SJK
         eDmw==
X-Gm-Message-State: AHQUAub01VIzUw22quSQWWF92nwy/LY8+zadUMwCA6DeHgebEzU9Zpfx
        GdOmQg5anEdRKRqM37TBb4yobI8hS7qpkw==
X-Google-Smtp-Source: AHgI3IZhcZTQYPNR3eIVFbN41lmu50agTY6tMKIoYk/GXNHsJKyQj0KoGpF7K0RPOXyzpSjIY8/q+Q==
X-Received: by 2002:a17:902:28e9:: with SMTP id f96mr14814920plb.169.1551021332087;
        Sun, 24 Feb 2019 07:15:32 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id f14sm7909517pgv.23.2019.02.24.07.15.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 07:15:31 -0800 (PST)
Subject: Re: [PATCH] badblocks: Prefer unsigned int over unsigned
To:     Bharath Vedartham <linux.bhar@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190224141952.GA3653@bharath12345-Inspiron-5559>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b96f9ac8-639c-adfa-e0a4-5ff537bc9db4@kernel.dk>
Date:   Sun, 24 Feb 2019 08:15:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190224141952.GA3653@bharath12345-Inspiron-5559>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/19 7:19 AM, Bharath Vedartham wrote:
> Replace unsigned with unsigned int to improve readability.

Frivolous change, would make a lot more sense to get checkpatch
to stop complaining about this.

-- 
Jens Axboe

