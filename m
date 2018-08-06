Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570E8C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 22:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F34421A56
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 22:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="d92Cc2ry"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F34421A56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387548AbeHGBGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 21:06:03 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:46756 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387501AbeHGBGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 21:06:02 -0400
Received: by mail-pl0-f66.google.com with SMTP id t17-v6so6225895ply.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 15:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QLRsVfIVCD+nAhM79cv2Z4F+YdybVTYt1VAgcmSaM50=;
        b=d92Cc2ryptn1qBZ6ZzAqZGDttUiPSYmjnjgJ7gIbgkJcQL+SdggEtxL+/hLC26+5GQ
         1CBk3lVBDc4/ffGyk+b/lF/E9zATRLz8toDQ/xKXjXyHca8ZsruHDXIXxlvnmy7WlKK3
         gNTbuPktAVCI5uan4lrtn1Y3uYqfiAhc4CepU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QLRsVfIVCD+nAhM79cv2Z4F+YdybVTYt1VAgcmSaM50=;
        b=DKqHzCvDk8iJIodpqrFWomleBgO9r5tHypBI7GVXDnsHIwyKPjcY9TFY4LETYW2SUs
         5APmmubw5/8oueQ8M+eP76Ti+CYrAeTw60KSE04FFhhNGLmntszYh8eJtzxbf0nk2oSF
         P9EvsPODm7BtpI6dotyzCQ5HtA1PyREaLBryAVzdBzpChYiv/jtWiCjJPGt4xCANAYFA
         oQxvAJ75pyK5Ls6wwxgJhVy7AWNfRg7RcwBcrG0HoeuVmujlAMEwESVAnVdRBPqPACpD
         VKSU21MbZwvyXhTJUUyvqDCqUKtVvWPaiSFyBSkdu5BN7FsSL4iNFMNdCKkiY9gvu8jy
         QBbg==
X-Gm-Message-State: AOUpUlGIe8u3MqB4uI/hAGxOiLHeAJRT/POBOR/kVFJcoq/E2fOCC48N
        bUM/cCnvMTAg/21oqHRS1MnYwiWfjtU=
X-Google-Smtp-Source: AAOMgpeGgmBq6E9tOicko9rTlFWkg26UHnIgviC7nQtgXJ0zOlrNGCaSmOg+NDk37WVzZhia12tWEg==
X-Received: by 2002:a17:902:47c2:: with SMTP id d2-v6mr9220795plh.139.1533596085648;
        Mon, 06 Aug 2018 15:54:45 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id f186-v6sm14828907pgc.4.2018.08.06.15.54.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 15:54:44 -0700 (PDT)
Date:   Mon, 6 Aug 2018 15:52:52 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     David Dai <daidavid1@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        georgi.djakov@linaro.org, vincent.guittot@linaro.org,
        amit.kucheria@linaro.org, ilina@codeaurora.org,
        seansw@qti.qualcomm.com, grahamr@qti.qualcomm.com
Subject: Re: [RFC PATCH v2 1/2] interconnect: qcom: Add sdm845 interconnect
 provider driver
Message-ID: <20180806225252.GQ30024@minitux>
References: <1531967820-27483-1-git-send-email-daidavid1@codeaurora.org>
 <1531967820-27483-2-git-send-email-daidavid1@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531967820-27483-2-git-send-email-daidavid1@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 18 Jul 19:36 PDT 2018, David Dai wrote:
> diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
[..]
> +DEFINE_QNODE(ipa_core_master, MASTER_IPA_CORE, 1, 8, 1, SLAVE_IPA_CORE);
[..]
> +DEFINE_QNODE(ipa_core_slave, SLAVE_IPA_CORE, 1, 8, 0);

As discussed before; while the two sides of IPA_CORE are controlled
through the "bus mechanism", they do represent the clock of the IPA
block.

I think it would make sense to make this interconnect provider also
register a clock provider and expose this as a clock, for the IPA driver
to consume.

Regards,
Bjorn
