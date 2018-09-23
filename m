Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0073BECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 19:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 940BF20989
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 19:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekqix/Y6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 940BF20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbeIXBhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 21:37:36 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46515 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbeIXBhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 21:37:35 -0400
Received: by mail-wr1-f67.google.com with SMTP id z3-v6so5768635wrr.13;
        Sun, 23 Sep 2018 12:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q+qIr8FEZzSQIKoAMfXR58AHLQEc1gtii5XS/tmNpSE=;
        b=ekqix/Y6/AplntTmuHFz2L/P0d+k9l3Pg/e9Z2cfSS/8TTqFUucvyV2vPU0Oo093x/
         j/u1WuiCc1755XBiGUM3m7ewDy9TnUycdyqZeyaAD6dRni+zWqb7anLnxAUmiteD+FKV
         L6SpVH8vxb1dpgukVUW+eLLL+ZI4rILhzlcCpUbiqvHYFiznO+UtXe2cA0unAUBI0xR2
         x2Uol/hR81D3aRbjs6zJ+FCuaFrsEDOy1FkGR8fNMV0vb5QJi9gszMZusOuC/itB1Tgg
         hVnTB+Fdh/tyqP6eb65+U7lnUMNwa/CKn4F1CNU/OgkV0Ra+OTJdTXEL4vKrykpwhIpC
         oztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q+qIr8FEZzSQIKoAMfXR58AHLQEc1gtii5XS/tmNpSE=;
        b=YvDNT7cnqp2fYjlT1JLJaUOlzCHyGvx1b2Szu/GoLFJ+nTEju2G8kou0gwrWzbdvZP
         WLsCeUsL936HqYNd1X7IeAbTkXES0+f+HGq3C5C2ozDDcZ0DpfaNaRgC81InpPjfEK0D
         zQWqZW/T8S9jjGsDBsPyws4oOD/Tz/ndvp5bUPzDPajDh1JoPmnpOg0jEdLd30oueoDB
         7HmLebDFk1kbjuZWxHjBfB8amOGT8ng8/nvPJrQ+JgyHVH8oE4R1QIqEsqjNBXhXWvai
         NIX9hbDvRAtPXpocAP1G8IfOu4dwwcZ7Bgasdf5f1e2R6LlNGf18x6s7qI9QVsn6oZ51
         bL6Q==
X-Gm-Message-State: ABuFfog6uY2//YMp3bCXM9AnOiRKIWfDbDDRWn3YFXr2aYNDrPDEVER2
        ekPIOEAE3ZnGnNT95fjSsF6prKHTRxE=
X-Google-Smtp-Source: ACcGV61n9CkFTPgQGWeT9x8Y+vOW88QEn1ZU64ss3M6DYTvMxlc1olvjL+V8KgbnG6FqxcmY5CriAg==
X-Received: by 2002:adf:df0f:: with SMTP id y15-v6mr5401815wrl.26.1537731537108;
        Sun, 23 Sep 2018 12:38:57 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id b5-v6sm23043753wrs.62.2018.09.23.12.38.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Sep 2018 12:38:56 -0700 (PDT)
Date:   Sun, 23 Sep 2018 12:38:54 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     David Miller <davem@davemloft.net>
Cc:     santosh.shilimkar@oracle.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com
Subject: Re: [PATCH] RDS: IB: Use DEFINE_PER_CPU_SHARED_ALIGNED for
 rds_ib_stats
Message-ID: <20180923193854.GA27723@flashbox>
References: <20180921180451.18711-1-natechancellor@gmail.com>
 <20180923064445.GC12338@flashbox>
 <20180923.121927.436285462706036460.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180923.121927.436285462706036460.davem@davemloft.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 23, 2018 at 12:19:27PM -0700, David Miller wrote:
> From: Nathan Chancellor <natechancellor@gmail.com>
> Date: Sat, 22 Sep 2018 23:44:45 -0700
> 
> > I have sent a v2 because this should be DECLARE_PER_CPU_SHARED_ALIGNED,
> > not DEFINE (thanks to 0day for catching it).
> 
> Your first version was already applied to the networking GIT tree, so
> you will need to submit a relative fixup with a proper "Fixes: " tag.

Hi David,

My apologies, I didn't receive an email saying my patch was applied so I
didn't think to check your tree. I'll be better about this in the
future.

Thank you for fixing this up yourself and all your patience, sorry for
all the noise!

Nathan
