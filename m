Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEA9C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 10:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED3C220839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 10:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="irz+aeFS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED3C220839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbeIKPVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 11:21:05 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179]:34016 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbeIKPVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 11:21:05 -0400
Received: by mail-pl1-f179.google.com with SMTP id f6-v6so11142301plo.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 03:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=EcVEZAd6SQJ+7kozSlrC/pCYC0vKrTJoaq2bACPsyrU=;
        b=irz+aeFSeS/11MkjefwJihennwDP9h8MqcIh2MllaBInb40gTkcu33Z9gwcT8L+gkC
         cqVS1qp5TEj388q+nSgCZgWFJobXOFnjaINXO83onqLnphSyQHs/9n3YFgFKsumtcHVJ
         ClEh0DlXS/W5huiK+4ij/jURDNb1uB2TqChggRkMCLK0XPFfR07cYZO9rmW+aPq3+itY
         RqsciJ+QSsavJAUHAYebBxjZrDDfE8b+F47ffipf9XcPCuTippo1HqspXDaybEGoGZL2
         w/fBfnL9DA52qxCuPUTeuLLzWV4DelYd9aNhGv+3lAAKbOMcBGRPsnXd06OMTc057kvy
         kh2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=EcVEZAd6SQJ+7kozSlrC/pCYC0vKrTJoaq2bACPsyrU=;
        b=IzCRKWittfiu+Sam7+vLh6r4BfbfQ58na2cHCboRGaeqAehWJiZMX2d33tT5qAEasY
         Kd5QACri9EuyzTU/1Y2hXGwespf5TiJoqWUZF3GMqvD/3ER1vRHLMoYXkInhMnqsYC5Q
         MGuYW5WDXNhkV6bIt5s2DXQrX829zbSDqsVGl6J43C4DTvW1ROtyQPsUWj9kW6/Z8PZK
         4DzniAcsujgqyg+AxzsQPF6qSxGcHndiRu7+Q/V9f6Ow5LoY4/p9uGAzm5+xJwWmFjmY
         EwNKMX4A0G1ZAM4Upj6WNEaRydXGHpAPPb/X36lKC32eQMAF64vvpGV6FJY+XvHuQROQ
         q/xQ==
X-Gm-Message-State: APzg51BnMsxram8M0Ht1JFP/cQ4Rj8oHDC39aaVF7BqhGkfZHLUT/A+D
        9esFmpR5E46pfHgIL1Skq6D2mA==
X-Google-Smtp-Source: ANB0Vda8eShAeDRIVfrpnvb5hui1HDcFmmTTl+kDZMQpTAqk2SqyoYHTFOeXgKs8BBQFLzyg10fpAQ==
X-Received: by 2002:a17:902:a5c5:: with SMTP id t5-v6mr26142773plq.6.1536661345414;
        Tue, 11 Sep 2018 03:22:25 -0700 (PDT)
Received: from cakuba (89-66-82-92.dynamic.chello.pl. [89.66.82.92])
        by smtp.gmail.com with ESMTPSA id 9-v6sm30975734pfc.20.2018.09.11.03.22.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 03:22:25 -0700 (PDT)
Date:   Tue, 11 Sep 2018 12:22:18 +0200
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Networking Development Mailing List 
        <netdev@vger.kernel.org>
Subject: Re: libbpf build broken on musl libc (Alpine Linux)
Message-ID: <20180911122218.0d2eb3f9@cakuba>
In-Reply-To: <20180910172903.GB15516@kernel.org>
References: <20180910172903.GB15516@kernel.org>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Sep 2018 14:29:03 -0300, Arnaldo Carvalho de Melo wrote:
> After lunch I'll work on a patch to fix this, 

Hi Arnaldo!

Any luck?
