Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E4E9CC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BED9208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="E9CN6TEF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BED9208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934393AbeFLPxP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 11:53:15 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:42525 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754056AbeFLPxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 11:53:13 -0400
Received: by mail-pg0-f65.google.com with SMTP id c10-v6so6035969pgu.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 08:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bjW/o7ARld8kdSByEdj0pllnkFgp/Ar+JTQav1YVRYo=;
        b=E9CN6TEFuqRv4aLZCK57sdiOgoRNOIwP8VP2E9w6hY9g5GcbiGgTsX/AQQ/ZyURoMJ
         yGQTWsGtBHeLvjvSijJ1D/1ZBcVDlyfhUZ4u+vk2LjX6NQ5tuqwc+pv17rrej9LFj5Fh
         0diBlkh8m4rp/4Zci05oQhNT5p2Hb0C2oWDnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bjW/o7ARld8kdSByEdj0pllnkFgp/Ar+JTQav1YVRYo=;
        b=NES1yB1YoPxrqaDBj3KZXnGtdXBvbcpNUS75OFi7NA+fEqwHpGJFdqvsWRLSJjcfCo
         IdinR+lj1tNtvgpVkaqEnK6LWHLoEWxI/Pnox9xhPajmixmKPJZBb7O1uZkkLXtODWUJ
         +S56hMz4ObIpaTafCvTCg5QAUr1I4c9uyYLg7qu2W/EtvwYTwR/JPDWLwmVdZC/yEQFM
         dZb9qrslqboH1NX3TmKjkuQBZgyNMTUY8GQpDqNhknqmVyc68hrEBD3KsDMuOXC6R07m
         XeQr/pb4lo5QdvrsGW8QzUUApslugcJUNqofrpV/mLDnUABxjcFUGEhx3D8NB5SreTTB
         RXqg==
X-Gm-Message-State: APt69E2Enjd4OGqY2oaIKIT6I9fjKKtIZDbcdFB4J/mdNeAESiRRnS5q
        2fyAwdMZRyBdv6yRZydTd55kXw==
X-Google-Smtp-Source: ADUXVKLz0l0EvBacDU9iMaZyFCTInrG+xPmrMm/eIorI9mD84KHtAY6SUuaFy1voDUnKtzXmluEOxg==
X-Received: by 2002:a63:7553:: with SMTP id f19-v6mr831535pgn.314.1528818793259;
        Tue, 12 Jun 2018 08:53:13 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z3-v6sm705382pfn.36.2018.06.12.08.53.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 08:53:12 -0700 (PDT)
Date:   Tue, 12 Jun 2018 08:55:21 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Avaneesh Kumar Dwivedi <akdwived@codeaurora.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Govind Singh <govinds@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: qcom: scm: add a dummy qcom_scm_assign_mem()
Message-ID: <20180612155521.GY510@tuxbook-pro>
References: <20180612132314.29762-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612132314.29762-1-niklas.cassel@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 12 Jun 06:23 PDT 2018, Niklas Cassel wrote:

> Add a dummy qcom_scm_assign_mem() to enable building drivers when
> CONFIG_COMPILE_TEST=y && CONFIG_QCOM_SCM=n.
> 
> All other qcom_scm_* functions already have a dummy version.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  include/linux/qcom_scm.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
> index da63d84e1e91..06996ad4f2bc 100644
> --- a/include/linux/qcom_scm.h
> +++ b/include/linux/qcom_scm.h
> @@ -89,6 +89,10 @@ static inline int qcom_scm_pas_mem_setup(u32 peripheral, phys_addr_t addr,
>  static inline int
>  qcom_scm_pas_auth_and_reset(u32 peripheral) { return -ENODEV; }
>  static inline int qcom_scm_pas_shutdown(u32 peripheral) { return -ENODEV; }
> +static inline int qcom_scm_assign_mem(phys_addr_t mem_addr, size_t mem_sz,
> +				      unsigned int *src,
> +				      struct qcom_scm_vmperm *newvm,
> +				      int dest_cnt) { return -ENODEV; }
>  static inline void qcom_scm_cpu_power_down(u32 flags) {}
>  static inline u32 qcom_scm_get_version(void) { return 0; }
>  static inline u32
> -- 
> 2.17.1
> 
