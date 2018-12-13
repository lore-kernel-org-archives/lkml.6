Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3410C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E63F2080F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="RNlpNHwj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E63F2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbeLMGvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 01:51:31 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38402 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbeLMGva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 01:51:30 -0500
Received: by mail-lj1-f194.google.com with SMTP id c19-v6so791257lja.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 22:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Pd6tHbQst91EQZ2Y5QS5QhJdiC/L7CkDcFsCNyMkDgE=;
        b=RNlpNHwjZVW3XHSQJ2CVcrPmulZZwYm0XPx44b0dp57jf4W6SORMuoL59N8Jd1Eupa
         dy/DrJJ3YVCeImAq/Ub97pMTTEH5zzTaqK8yL0vVJaFdXyT64hMVDiSt8PfvUrcoOF6A
         IN4WVKQbEpT1UPeiGrJ1zP3CH8T2fUIpOKPUm5OXHFIrARii3dZ7DUo1tOASyJup0fVZ
         M09/FljPHvtKvvIpteUajHGfhJqSGP+KmZ/hYoBqaoOJ2isI62fU9vkE2InaxbPWy1Oj
         g4x5stBSZhVISqG6lq3n1kMcNz8WUOUrFzqgIkVpOsBCaGzI5kOJ8h8HECdDhuYhWt21
         yrOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Pd6tHbQst91EQZ2Y5QS5QhJdiC/L7CkDcFsCNyMkDgE=;
        b=bT91z2URXOcKmv47CEaIB937oPkvj+3LC33PfY6ZD4NsPOJWv7xqaRysrFhweFuqil
         E8Zl2KXcUj+oGpeKj/QM/YWTaJRtf3qnyRNWJG7JWubw70jjCRmmvnB5JLXMQ3Rb5BNk
         FPfbkPOwKv0f2rgdWemwuZQAgI6w28LyklG0FviDPjUs0q3MmdEBqBazWFrAW/DWNO4N
         h+RlNEmztk6Eaf9qL+/p9LjCgY10vkRxwXgF2f2dv/97lZmv9LCbKzYSoadrpMWkno3M
         lUXyPYVYcRQEEdNi3662ZfaRAmj2tk1AeO/TUIv+yoYJ8m0E9jSCLeQU/z9ic/2c4LO6
         h1Hw==
X-Gm-Message-State: AA+aEWaDpXaX00250JuZ67yc3CB1bosGe66M8ZeRD5sFa4etjS5UxRli
        MPTI/oYiX6eDXgkO0CQt7AaHag==
X-Google-Smtp-Source: AFSGD/WJ5j3QRWj9SpWrk58QqfhxK43zcDi9DDIhR8Xj7GFcBzqwQrPgR3+dE7RkwBkked34mdxbCw==
X-Received: by 2002:a2e:b1ca:: with SMTP id e10-v6mr15390969lja.16.1544683887500;
        Wed, 12 Dec 2018 22:51:27 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id r26-v6sm156142lji.25.2018.12.12.22.51.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 22:51:25 -0800 (PST)
Date:   Wed, 12 Dec 2018 18:09:23 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/9] arm64: defconfig: Regenerate for v4.20
Message-ID: <20181213020923.zf7juagqy7ukvylp@localhost>
References: <49a5d199-4eeb-a7c2-b539-13356162547f@free.fr>
 <359ddf7d-be3f-a957-0b21-9fdc86120855@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <359ddf7d-be3f-a957-0b21-9fdc86120855@free.fr>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 01:56:44AM +0100, Marc Gonzalez wrote:
> Run the platform defconfig through kbuild, and handle the trivial case
> where options merely move around.
> 
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>

Applied, which in reality meant that I had to redo what you did and commit
that, but that's fine. :)


-Olof

