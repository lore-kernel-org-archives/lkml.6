Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DF7C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46B3820843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:35:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46B3820843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbeGYQr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 12:47:27 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:55233 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728360AbeGYQr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 12:47:27 -0400
Received: by mail-it0-f65.google.com with SMTP id s7-v6so9276263itb.4;
        Wed, 25 Jul 2018 08:35:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6zRMni635eTYxUCaHUp6RN9I3JEEpv3ygAV2pMBQ7nw=;
        b=b++fAe2DE855h1JHnycF4qLiSR5NfJpWm1g50iUqI0zTI+lfvr3KocQi+pxeiffNLO
         ckWjhCRhezqWUKctt91tFAJu5bNF1PFTncJDw3ASbhc9pRWF3mzqfV83rmH4VWnq0EvW
         2+F81oSGwgrLNPaYYx9TgNc71myq71OsGhY0mUhr9YTTrUsXWtfgDfwBatYFzk7I/mU8
         N+/qt4vcq7QIJdGumtkGPln/URvpqQUejheddy1LDEqBvxL2scxspb4qtaqeLBrbwKlb
         6usZA16BLrvIZFaJxleTxBuxfkQyfy8adjmzqwvesTVbJhlAKkx+JL/nWdm8ZMKDlIWT
         d6oA==
X-Gm-Message-State: AOUpUlEU6QdON306AwjvhB74MoVwH27VF/UEBKFmRa/uurXU50gKf8Tp
        kGuNCMb83YxC2qa3O/0WGA==
X-Google-Smtp-Source: AAOMgpcTtybWovR2zfTF9pwa1Jnq7KTeJ6kQctXmvyeZT3Kous3/vyMo1xYyuh4zY8Xy2buEutNTaQ==
X-Received: by 2002:a02:18d0:: with SMTP id 77-v6mr20505318jar.25.1532532915482;
        Wed, 25 Jul 2018 08:35:15 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id e21-v6sm4537967iob.20.2018.07.25.08.35.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 08:35:15 -0700 (PDT)
Date:   Wed, 25 Jul 2018 09:35:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 2/2] Add support for CPCAP regulators on Motorola Xoom
 devices.
Message-ID: <20180725153514.GA21550@rob-hp-laptop>
References: <20180724132541.17039-1-pgwipeout@gmail.com>
 <20180724132541.17039-3-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724132541.17039-3-pgwipeout@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 09:25:41AM -0400, Peter Geis wrote:
> Added support for the CPCAP power management regulator functions on
> Tegra based Motorola Xoom devices.
> Added sw2_sw4 value tables, which provide power to the Tegra core and
> aux devices.
> Added the Xoom init tables and device tree compatibility match.
> 
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> ---
>  .../bindings/regulator/cpcap-regulator.txt    |  1 +

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/regulator/cpcap-regulator.c           | 80 +++++++++++++++++++
>  2 files changed, 81 insertions(+)
