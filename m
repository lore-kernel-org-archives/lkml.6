Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA69C46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADA0F20881
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cP+wbgyV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADA0F20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731637AbeG2WwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 18:52:22 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35851 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbeG2WwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 18:52:22 -0400
Received: by mail-wm0-f68.google.com with SMTP id s14-v6so11500248wmc.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 14:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LYooROlXrMt2M40ipLGwTWGy7I4z+A65bm5U395ykKY=;
        b=cP+wbgyV3oB1/adEiTPN/XJFVbcFgBK8GT36usRKDwUPXIx0clxyEkPBT6o0YhQWpC
         n68yJWGI7X775EXrYQFCfOrAOyDETOl26ATPJqBovipWoLH6+mgVkXaphAEn8/C+tPah
         FOynXANVuqoRoPG5shZEagWlVu618/b8E15n2Yb5o8seqvQmZJ3PrYTUwYlWZwey9f8F
         ZjNtxA1KAqqtttssnaYDRooeVD2GlgizKNCUp3hyFJb8LG08sdkb+fwxi8TBpxzOwOAr
         ltyCtANUNVLb+SNFx3zP6osETDTlb5hOfbUoohm9NyE8QMKcPh0PjCt3aAO0iciox+db
         DQog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LYooROlXrMt2M40ipLGwTWGy7I4z+A65bm5U395ykKY=;
        b=dtjL/9KvkYv99AJLRXTYFx1QbbnGU/vX68/sVeiV6BMCewIKqmGMWvGdaaNSvgMp1A
         vEWL+0zbVXR6vLY8HG09Uul1wm7V6DywMoefzXb+gC9cyrIskQAp4EtcXsDXWnyVDoJ8
         5y9AJxYdjSCCbEJ2VzDNNhI4hzf4DmEYBz6vZgwj38tj2mDfyw03cqAP48YQpxqJTvUc
         Cp7XhQuWkdi8p+drKMfjLNJ5kgUXkkwv3qfCxjAIlpRxmCR6Vg6/fZ2l9ndi0Rmjgtpr
         nr78rjrhJVfPxTsXZT2M72zv0FhxrYx2KDQ5FH/ZCQDxyqe9EuljnwYfQG+ag4xbLpaK
         e4Eg==
X-Gm-Message-State: AOUpUlEZ280a4HSILwUm/Ft9FdTeutGWCZZxMFooZNWp+IIUwxKLSKFY
        CkNcNMCRXjGAUfebsG5yOEM=
X-Google-Smtp-Source: AAOMgpdLWfTfWqpRZoq2t4QjWqu03vNk/LIqSc8LpdBeNSCGzRcexcYUepcT0bigojJ8ISFc9sNcZA==
X-Received: by 2002:a1c:68f:: with SMTP id 137-v6mr13077017wmg.82.1532899228119;
        Sun, 29 Jul 2018 14:20:28 -0700 (PDT)
Received: from xux707-tw (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id y11-v6sm9210633wrr.84.2018.07.29.14.20.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Jul 2018 14:20:27 -0700 (PDT)
Date:   Sun, 29 Jul 2018 22:20:28 +0100
From:   John Whitmore <arigead@gmail.com>
To:     John Whitmore <johnfwhitmore@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v2 00/15] staging:rtl8192u: Coding style changes
Message-ID: <20180729212026.GC10968@xux707-tw>
References: <20180729210534.10617-1-johnfwhitmore@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180729210534.10617-1-johnfwhitmore@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 29, 2018 at 10:05:11PM +0100, John Whitmore wrote:
> Second attempt correcting my initial attempt where I left '_t'
> and '_e' trailing the structures defined. These have now been
> corrected.
> 
> John Whitmore (15):
>   staging:rtl8192u: Remove typedef of struct cmpk_txfb_t - Style
>   staging:rtl8192u: Remove unused CMPK_TX_SET_CONFIG_SIZE - Style
>   staging:rtl8192u: Removed unused CMPK_RX_DBG_MSG_SIZE - Style
>   staging:rtl8192u: Correct spelling in comments - style
>   staging:rtl8192u: Remove typedef of cmpk_intr_sta_t - Style
>   staging:rtl8192u: Remove typedef of cmpk_set_cfg_t - Style
>   staging:rtl8192u: Refactor use of enum dm_dig_sta_e - Style
>   staging:rtl8192u: Refactor enum dm_ratr_sta_e usage - Style
>   staging:rtl8192u: Remove enum dm_dig_op_e - Style
>   staging:rtl8192u: Refactor enum dm_dig_alg_e - Style
>   staging:rtl8192u: Remove unused enum dm_dig_dbg_e - Style
>   staging:rtl8192u: Refactor dm_dig_connect_e - Style
>   staging:rtl8192u: Refactor enum dm_dig_pd_th_e - Style
>   staging:rtl8192u: Refactor enum dm_dig_cs_ratio_e - Style
>   staging:rtl8192u: Refactor enum DM_CCK_Rx_Path_Method - Style
> 
>  drivers/staging/rtl8192u/r8192U.h        |  10 +-
>  drivers/staging/rtl8192u/r8192U_dm.c     |  91 -----------------
>  drivers/staging/rtl8192u/r8192U_dm.h     | 122 ++++++++---------------
>  drivers/staging/rtl8192u/r819xU_cmdpkt.c |  16 +--
>  drivers/staging/rtl8192u/r819xU_cmdpkt.h |  24 ++---
>  5 files changed, 70 insertions(+), 193 deletions(-)
> 
> -- 
> 2.18.0
> 

I made a mistake and sent patches when I had old patches still left
from a previous :( That meant a few patch xx/08 were sent.

I then resent the proper patch set xx/15 but in hindsight I should have
bumped the version to 3?

Scissors :(



