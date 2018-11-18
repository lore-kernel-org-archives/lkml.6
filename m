Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D648AC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 14:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B1E120815
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 14:13:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B1E120815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbeKSAeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 19:34:01 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39529 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbeKSAeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 19:34:00 -0500
Received: by mail-wm1-f67.google.com with SMTP id u13-v6so2789841wmc.4;
        Sun, 18 Nov 2018 06:13:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kVfZvcbVe0NzSlVXecUWbo1eDsEON/pPF16oUUfktAs=;
        b=mtuKqtLQOFnfmwRgD5zXR1k9AE7aZ7q3c6lfpWu+AGWKtGZNnnpK0FrVigd3NZ72lO
         8sHgLC/eLl6d3coMkAjQGxkG1cL3ckFs9QJlp4ZwDJEbFc5ekYsijlXinwH2hXfRLLOy
         CkFOkfv6sFWmKCYnY7PJGUsyiagHqP/B6olVKd0/y4JpfmjMGhc+ZSCiSwKE5lXv03Kv
         Nv9+pw099QjM97gfdfc8fxWEYuRNDWGqp7vmtTxdpyARd7FpRaQbTyosGjBB6FLAdeI7
         xb0YMMTeOIMum57yGbPmjcGV19BM3TONzxgWih4k2uRAXHZQq+iqHLoIfpxXkIzqQ6ez
         9Qpg==
X-Gm-Message-State: AGRZ1gIfycsBEc7BQR8HkY/wtjkcpL4p5jGf/da1VIWjG1belYCJO5to
        Dl3uyWCG6z/bZxIRguK13Nw=
X-Google-Smtp-Source: AJdET5ewJZvUN1zSvA8P5sjo67BXlo+4dtRPzuQeFWBvQQKK2Udtw2GLF29adJUXubyPyd2qtsHEKA==
X-Received: by 2002:a1c:e88:: with SMTP id 130-v6mr1921977wmo.13.1542550413504;
        Sun, 18 Nov 2018 06:13:33 -0800 (PST)
Received: from kozik-lap ([178.38.103.27])
        by smtp.googlemail.com with ESMTPSA id l79-v6sm55266574wma.26.2018.11.18.06.13.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 18 Nov 2018 06:13:32 -0800 (PST)
Date:   Sun, 18 Nov 2018 15:13:30 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Markus Reichl <m.reichl@fivetechno.de>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] ARM: EXYNOS: remove secondary startup initialization
 from smp_prepare_cpus
Message-ID: <20181118141330.GA28873@kozik-lap>
References: <1542294698-17470-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20181115151211epcas2p4fdc719d354f2a732f70667ccbd8f1bae@epcas2p4.samsung.com>
 <1542294698-17470-2-git-send-email-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1542294698-17470-2-git-send-email-b.zolnierkie@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 04:11:30PM +0100, Bartlomiej Zolnierkiewicz wrote:
> From: Pankaj Dubey <pankaj.dubey@samsung.com>
> 
> We are taking care of setting secondary cpu boot address in
> exynos_boot_secondary just before sending ipi to secondary CPUs,
> so we can safely remove this setting from smp_prepare_cpus.
> 
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  arch/arm/mach-exynos/platsmp.c | 26 --------------------------

Thanks, applied.

Best regards,
Krzysztof

