Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6897BC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 14:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16A0E21A29
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 14:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqItXBpg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16A0E21A29
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbeHFQSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 12:18:44 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41623 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbeHFQSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 12:18:44 -0400
Received: by mail-lj1-f196.google.com with SMTP id y17-v6so10704795ljy.8;
        Mon, 06 Aug 2018 07:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BHF0ICoT85ZiQgZbB2ZmcWZCE+64EOGTdGAtV4iGh3I=;
        b=ZqItXBpg4l0cLpxIiYvikFCoD73g4BaUJgJaV2xBBL2X4GLCzL2KCN3Nv4DJwnrw+V
         qKQLrfnYDoajnGHzhMthc3jzgjhokf6v5mRpJjkGFnhsEcimCwqCebV1axHFiuRov17L
         OFmC8/lz+SPKj0gKAM+7A/WZzvnfzr7U8OtTH7vbwj/2MTt1gAM6P29Dx/qcVQJXoLL6
         QFruWouk8IesYelmTLFq7fe2xzgxAdLyz/3K1J6zb986+bJa3MGwbu/0IADklu3C7M8p
         /IiDtTKOgVn9vUwAXlNH8k8k2ChIf0Y+NQFT6Rnlk7pzaRpGWMQ2XYYD+yNRCAF1eWq1
         IvkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=BHF0ICoT85ZiQgZbB2ZmcWZCE+64EOGTdGAtV4iGh3I=;
        b=kl6o3U4zU6RvXDGbecP3JHmssk88B3ALVQ+nCbSH4OxJA3iDQz2s3lesFKdJRXdnCv
         NZwA0zBRqm5tmgUEHn1l4LpxTT0ANS8AUNnuJ22dVzPG+qMlPJNFC+St5e4dY0HSfYxa
         1Q68nuJuLxyJOrxfLOBTyt6IKFVsp2HpYGt9E9CIQfqmmPQ3uCOMJgbib74XdlqSdTvf
         0u92y2GGJm9bxABhgZl5tM9qyRNC9PbK0TUXa/cRP4p81zKZw80cMUJbpnXq8uXZ1Ogs
         s8oa/9sp30pertN0TbQ1FG7QP7OpMOvIEgRQsPW84hWVFnY8bXXhGfP57J2Np05FLb7P
         +IQQ==
X-Gm-Message-State: AOUpUlHgMusNENu2U4UC33EVhRDg/8/Bjj1EmyNXCuvxsZSdFN027tLt
        cQgEnH8n2sdrDBA/RvogGn8=
X-Google-Smtp-Source: AAOMgpd7b4lHxpKU28grS4aqdlP4Z9/JdrtiOTYrBI9sNNAjgpaYjF3PAndsEdThKc46FzqYsY1KZw==
X-Received: by 2002:a2e:8e8c:: with SMTP id z12-v6mr12291849ljk.117.1533564565789;
        Mon, 06 Aug 2018 07:09:25 -0700 (PDT)
Received: from x1c.home (91-154-113-38.elisa-laajakaista.fi. [91.154.113.38])
        by smtp.gmail.com with ESMTPSA id k77-v6sm2236790lfi.46.2018.08.06.07.09.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 07:09:24 -0700 (PDT)
Date:   Mon, 6 Aug 2018 17:09:22 +0300
From:   Johan Hedberg <johan.hedberg@gmail.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     marcel@holtmann.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, davem@davemloft.net,
        linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: remove redundant variables 'adv_set' and 'cp'
Message-ID: <20180806140922.GA18195@x1c.home>
Mail-Followup-To: YueHaibing <yuehaibing@huawei.com>, marcel@holtmann.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        davem@davemloft.net, linux-bluetooth@vger.kernel.org
References: <20180806110851.8568-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806110851.8568-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi YueHaibing,

On Mon, Aug 06, 2018, YueHaibing wrote:
> Variables 'adv_set' and 'cp'  are being assigned but are never used hence
> they are redundant and can be removed.
> 
> Cleans up clang warnings:
> net/bluetooth/hci_event.c:1135:29: warning: variable 'adv_set' set but not used [-Wunused-but-set-variable]
> net/bluetooth/mgmt.c:3359:39: warning: variable 'cp' set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  net/bluetooth/hci_event.c | 3 ---
>  net/bluetooth/mgmt.c      | 3 ---
>  2 files changed, 6 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
