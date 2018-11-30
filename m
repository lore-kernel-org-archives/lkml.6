Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFC3C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 21:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFFF12146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 21:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="SaHXTj1I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFFF12146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbeLAIlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 03:41:40 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41869 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbeLAIlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 03:41:40 -0500
Received: by mail-pf1-f195.google.com with SMTP id b7so3405361pfi.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 13:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=AKsFmGpj1KyxqLr6b6lsXZ1B648c8yRaCdP0piMnjhg=;
        b=SaHXTj1IhGyou5dVsMdZnCRagJFOi3Qvk9pwAjljCW9S5rm/jJHQxzU+9U1/HN5OLm
         Alf0E/oqS2eXLTscAthY0jaHiB3wC9fpU7EeZT6lGuKS2QZ0E4+5zphVRJLPi9i1IZm+
         zaAM11B412IgVXzk31hJD03LDsAp1oHoxeip4xdTLqDXp+E2N/Odg8M0+VC5xBYRYB8x
         WPG/fXEKGBoccHrabqJLB/6iOh2oAS9xEgiSCHCsxqGSWgK1VhJSb1xsvb7jEZEbG6Xk
         fhma0FhpkuO7jlOjUD+z2+u7KrwSpH1qcaDbp6jH7/7EaVCNIJalt1F5tHSKg6HSG6wx
         usQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=AKsFmGpj1KyxqLr6b6lsXZ1B648c8yRaCdP0piMnjhg=;
        b=rxrI6V79yOAWaaHBHDpi7oa+zjQ/ezGk86f55GtQkb47cQMt/pyLxAWbehK4UIlnLc
         wWPlZeeQIADztsoovW1Gpq08Ouv7vqJSs7WonJqJNG81fXHLqtcI7lgpAjC4y5jwTpls
         eQjBXTs8QHNQ8nza8+5Fqa35cFAtAPhABijqy4WNC3r+ia/WH3ZS0TioPUTU3yOJq7wK
         nsS+bIvQMQWSEQA/f5LqZmvFvhSZmXgCaEBBTl1245m7vBqZytL9W6nKbufa57RgQSj+
         SB55TDr/bDksOPLfJNsGhXQs6qDOZSrts11aAOAtRwlqJj0MkFusd2G8A+xwmitel1hK
         DxXg==
X-Gm-Message-State: AA+aEWa5k+ecTJXbmbtB8iuDSjZTjq9xx00cN4h97fz3pYhIQKDOOBmK
        8Zg/T5oIHt7ZSpDzV9rE0SK11Q==
X-Google-Smtp-Source: AFSGD/UGxr7WKP66DIVO6qcdEDPmrtfCMCcZvDoXEBBf/OlbarROJah2Q97SNLDVtWinIG5KultDgw==
X-Received: by 2002:a63:1444:: with SMTP id 4mr6220462pgu.430.1543613461224;
        Fri, 30 Nov 2018 13:31:01 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id g28sm13685618pfd.100.2018.11.30.13.31.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 13:31:00 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Alexey Brodkin <alexey.brodkin@synopsys.com>,
        linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] ARC: change defconfig defaults to ARCv2
In-Reply-To: <20181130125156.34460-1-abrodkin@synopsys.com>
References: <20181130125156.34460-1-abrodkin@synopsys.com>
Date:   Fri, 30 Nov 2018 13:30:59 -0800
Message-ID: <7hva4e45ik.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Brodkin <alexey.brodkin@synopsys.com> writes:

> From: Kevin Hilman <khilman@baylibre.com>
>
> Change the default defconfig (used with 'make defconfig') to the ARCv2
> nsim_hs_defconfig, and also switch the default Kconfig ISA selection to
> ARCv2.
>
> This allows several default defconfigs (e.g. make defconfig, make
> allnoconfig, make tinyconfig) to all work with ARCv2 by default.
>
> Note since we change default architecture from ARCompact to ARCv2
> it's required to explicitly mention architecture type in ARCompact
> defconfigs otherwise ARCv2 will be implied and binaries will be
> generated for ARCv2.
>
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
> Cc: <stable@vger.kernel.org> # 4.4.x

Tested-by: Kevin Hilman <khilman@baylibre.com>

Nice, thanks for cleaning this up.  I tested it again for the kernelCI
use cases, and it's still working.

Thanks,

Kevin
