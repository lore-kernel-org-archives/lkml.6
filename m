Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161D6C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA5DB205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="CVDX3c+d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA5DB205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=networkplumber.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731994AbeGaWEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 18:04:14 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36044 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731306AbeGaWEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 18:04:14 -0400
Received: by mail-pl0-f68.google.com with SMTP id e11-v6so7657540plb.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 13:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r+ldeb3J8Oi7/Tf6SIpCba1z9O5zFLm6ebOP5hgn88Y=;
        b=CVDX3c+dUH1eiKTWBMb4VQfqnnFJuVlJlEwFkXF4sJALS12XOEVN/FkftvnvfdOc9E
         SKD5FZ+6B2AhJQ0jiNxO7P1FI48txzpDN55C5kRsfihz41uhs53DlPRqCcoY3FAgRBC+
         S/GKH00Oe2FBjkLk+G36QNLWUESNFPQz41YG3Ar8reWjTQRUUS37oICRJTYAS8BeN7eq
         Diegq8FgDboRmkp0a8q5hAvTDbZ1tFJARhFomJaPBHqI0yTTjfX7uTvJSNgj1Mf2QcIG
         hhQQVnAhC+FKITssL3sj56wn5FLI40wdTMEe0LLYr0df5w94hMwoWzxQbLHvazKhLs5t
         N4rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r+ldeb3J8Oi7/Tf6SIpCba1z9O5zFLm6ebOP5hgn88Y=;
        b=uNVCvX/c2+2vrN9QPP1eWrUQMDlBpum/a3tFEasdcK2nnJrNsnMXNimTAFdW5H+2AN
         BazGPD+sVlWHS+38DyW65YdVZK04RFc0BymlBDjgvlwNo7UO5WjZxM5XWjhhVWth3kBl
         6QpL+6gsZL7eTSx11a97OMJvabRTO2wLIJT0anJ+nDbM90DKkJ/UOPLChLC9VDfW29MS
         MOo7ORq5d4ctiFHBo5ia6rJHFYB+kDKRp+TsVSlATdvYPL+NZLVInE1es2hWt5aeqJTu
         3ScXnTpWbSMj3ZOEyt/H7ANKRrAqdAfvMXw6YPpy0vgBxGX9kcv/TwpwU/yaDBFT7aBe
         Yojg==
X-Gm-Message-State: AOUpUlGx5RV3rS+a3U1zuu45+X4ShrPvI73hfhpfdADAB7ldGjRAMw06
        FI22b/GNJv34twB3C+IcDu0wHqzgC4k=
X-Google-Smtp-Source: AAOMgpd3nmq7EqwN0gS394Ji6nBEkMhTrZG3HslmwmC3ZzE9SYpycFC9fmYxvn5F5pswzrwrbIzJyw==
X-Received: by 2002:a17:902:290a:: with SMTP id g10-v6mr12376895plb.110.1533068527417;
        Tue, 31 Jul 2018 13:22:07 -0700 (PDT)
Received: from xeon-e3 (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id s195-v6sm28628555pgs.76.2018.07.31.13.22.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 13:22:07 -0700 (PDT)
Date:   Tue, 31 Jul 2018 13:22:04 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        davem@davemloft.net, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 3/3] net: WireGuard secure network tunnel
Message-ID: <20180731132204.2bc30d15@xeon-e3>
In-Reply-To: <20180731191102.2434-4-Jason@zx2c4.com>
References: <20180731191102.2434-1-Jason@zx2c4.com>
        <20180731191102.2434-4-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Jul 2018 21:11:02 +0200
"Jason A. Donenfeld" <Jason@zx2c4.com> wrote:

> +static int walk_by_peer(struct allowedips_node __rcu *top, u8 bits, struct allowedips_cursor *cursor, struct wireguard_peer *peer, int (*func)(void *ctx, const u8 *ip, u8 cidr, int family), void *ctx, struct mutex *lock)
> +{

Please break lines at something reasonable like 100 characters.
