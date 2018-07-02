Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9006C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8264624A2C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nzsKIXGp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8264624A2C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752846AbeGBUSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 16:18:49 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:40775 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752560AbeGBUSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 16:18:47 -0400
Received: by mail-yw0-f194.google.com with SMTP id p129-v6so7107617ywg.7;
        Mon, 02 Jul 2018 13:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CJxV2yChqMBJ5ay5QNYWnaEbg06f3kyNq9N5ztvV+E0=;
        b=nzsKIXGpNtT0Z3vmaH5/YELsGK3uOGCYWJ6EnZwR5K2jBDhclnSLxGtolio4sjIlx6
         Sz5qUOTIIRcaGqFa715srhXzJbQCLJ0wbjg/a5XuXMKSOsfuZKCyG9AUIRILWvhDKYhs
         /njWBn2qEmrzXMys9Hc2s0Jr1rOjJZHG6VOU0L+uXdzCNm2KSFadQ++qWh1n7wpOHXq8
         qR7SAdHs1TblnXOUQPODFMzwPvkltq+Qf21AgPgMYlvhrBWt0VUwUGZ+YcE6OzUzncvX
         nD1rHzh6rIyAUW7cpKzD3oixQb4TrPwTxYfXtdelPKrgJYFP/EAZTBnU/NxYT8aqsoJ+
         dnaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=CJxV2yChqMBJ5ay5QNYWnaEbg06f3kyNq9N5ztvV+E0=;
        b=QnFFSpoHpLY6mHSjibxEi3nB/Na66pCFPu/1yLZWdXe3QJbd7bOi/XElkwLhWAG4WY
         aZhqDpwGgJIVVzdQ6BMuPcMlngAq6H7NDCfRIP4T/VTTg7Ujn0XaBxHNVHZ+CawIzMTt
         rKLHsYoR5fTp2y0Iksz4uZZx2+MtJV20bF2qbOd2Xe12BBLaQ5DqnTg62ET6ltKWl/UN
         cLwtHoxSMiQvH8kM1Cfbj/YyjFDDKOA9y7sG2t5fP1YwlHmyPwHCcG7fv4/06onKOHbL
         q7sEETYN4F3V7fVDSRVEj/QbRRgTVq4y2SHvI6c5mcweW0Bdqs2ebcpHJbi5Nhx0zsEX
         U1Hw==
X-Gm-Message-State: APt69E0llfsemxLVxVa01+Ya21xsim4nPl4cLwvPyTmj06ICItvs+Lan
        PLe9PtvsHwUfdrD9okm4XClzkfuK
X-Google-Smtp-Source: AAOMgpcFNZwAOM7CPPJCfU5J4HziH/vgNIKTZxn87i8ZKrS4foChGVrxWHk1D5CFvFNnG9tt2+zJSw==
X-Received: by 2002:a81:4990:: with SMTP id w138-v6mr6373586ywa.372.1530562726094;
        Mon, 02 Jul 2018 13:18:46 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2b6f])
        by smtp.gmail.com with ESMTPSA id q9-v6sm4554594ywl.76.2018.07.02.13.18.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 13:18:45 -0700 (PDT)
Date:   Mon, 2 Jul 2018 13:18:43 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] ata: Remove depends on HAS_DMA in case of platform
 dependency
Message-ID: <20180702201843.GJ533219@devbig577.frc2.facebook.com>
References: <20180622110307.31523-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622110307.31523-1-geert@linux-m68k.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 01:03:07PM +0200, Geert Uytterhoeven wrote:
> Remove dependencies on HAS_DMA where a Kconfig symbol depends on another
> symbol that implies HAS_DMA, and, optionally, on "|| COMPILE_TEST".
> In most cases this other symbol is an architecture or platform specific
> symbol, or PCI.
> 
> Generic symbols and drivers without platform dependencies keep their
> dependencies on HAS_DMA, to prevent compiling subsystems or drivers that
> cannot work anyway.
> 
> This simplifies the dependencies, and allows to improve compile-testing.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Acked-by: Robin Murphy <robin.murphy@arm.com>

Applied to libata/for-4.18-fixes.

Thanks.

-- 
tejun
