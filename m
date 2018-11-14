Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A12BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07E3320896
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Onxve9zW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07E3320896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387490AbeKOBsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:48:14 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44243 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733180AbeKOBsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 20:48:13 -0500
Received: by mail-pf1-f193.google.com with SMTP id b81-v6so7605470pfe.11;
        Wed, 14 Nov 2018 07:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=diu/s4mGfVSUOrc95XAulquzf8puY/iu7EADd2higB8=;
        b=Onxve9zWXsEZaw8VEKOGT9XGQMy24WE6zZmNAICMS5YxuJGOEDyXdPlyFo6HHBye0x
         dbR8w3WOB5FLQH3s5FanPiQkoY5k7JWYFW6AMvjqGjYnh7pop/J40kuhYhh+BCkvc10e
         juT7449lTsAtBSXxYEgUXncdU3IhzLA1AVWbmgT/K40I2SBL9Vy0l5UMk6aBxGBLU1so
         0hTTv4r48feevddw9L9TncmgbpRsDiuwpbdESaStMLyCGw6wdrXLydh+Tr/2n/fNt5Kd
         pX1MqcqXWTYCiCG21oU6ZM4XzwxdUOFq8XJHITCToGjDH/Dud+sbP4YPKbDjeg3w9AiY
         /4SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=diu/s4mGfVSUOrc95XAulquzf8puY/iu7EADd2higB8=;
        b=scHDvBbbm5k+ltR/XLfsQW4KkdmQeIa3UE/SOa1cBSDxZCSDWuMLiO1EXyg7bOP9V8
         Q6A70dgoEpwvY+A+snabiyhHOowlh6sDy2DxyAf6NosBLqecDMkmzMsVzBNbk1QD1LSc
         3GOcprp2yanDz9/E8E0X3a0EhvGiE89t1C6CJt43LGEydZ/nuDTFzLdnFd64zxkTCOxb
         FGaWqY2Gm/X6YBju9Ty3ZtJae+K9GTnTl5S8dKW1m+px72C2+2ZX81JE7NK/YuCLvrNc
         IdvZs2GgIG8AHFCtSL4NuARXJG0ITOr7xa0SHP3EqCNOX7GRF6ZR4jPtGNq3pSTzHo8D
         Wdiw==
X-Gm-Message-State: AGRZ1gLH39QGjBwws4NgBTkEqMvhgpbH+Hvz8UTdiaTwoISQXY0cljAn
        ksRmwqpY5hV3te7bfcV08HO+rVe9
X-Google-Smtp-Source: AJdET5eIYJVpRhkoysNhnhzqpKVzZZFrXx9CxARCj+R71xkuje8IF6RLTkLWlNtDGGCAAnfDqH3ZBg==
X-Received: by 2002:a62:8a0d:: with SMTP id y13-v6mr2504357pfd.142.1542210267769;
        Wed, 14 Nov 2018 07:44:27 -0800 (PST)
Received: from [192.168.44.50] ([64.114.255.114])
        by smtp.gmail.com with ESMTPSA id u13-v6sm21575264pgp.18.2018.11.14.07.44.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 07:44:26 -0800 (PST)
Subject: Re: [PATCH net-next] tcp: clean up STATE_TRACE
To:     Yafang Shao <laoar.shao@gmail.com>, davem@davemloft.net,
        edumazet@google.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1542205577-21925-1-git-send-email-laoar.shao@gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <74f5b61e-eb66-4c34-dfb7-1f746761939a@gmail.com>
Date:   Wed, 14 Nov 2018 07:44:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1542205577-21925-1-git-send-email-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/14/2018 06:26 AM, Yafang Shao wrote:
> Currently we can use bpf or tcp tracepoint to conveniently trace the tcp
> state transition at the run time.
> So we don't need to do this stuff at the compile time anymore.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  include/net/tcp.h | 12 ------------
>  net/ipv4/tcp.c    |  4 ----
>  2 files changed, 16 deletions(-)

Yes, sure.

Signed-off-by: Eric Dumazet <edumazet@google.com>

