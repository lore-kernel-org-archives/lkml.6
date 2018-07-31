Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A51C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78137208AC
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="mfCJ2nTD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78137208AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=networkplumber.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732198AbeGaWJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 18:09:08 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43650 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbeGaWJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 18:09:08 -0400
Received: by mail-pg1-f194.google.com with SMTP id d17-v6so5195458pgv.10
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 13:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jvFeZXrk3oKikBKgA6HGG1zqb2rUCE9zVZ5+CocYrd0=;
        b=mfCJ2nTDWD9WuQ/sE+y4Et5i27NIiPtxDTgTCW/9PU/HnGmyfWtukUYhTepiyRkqQE
         fH0piCszw3Jf2AkcstdjhKbfo3v7Lfm0mtx4Gje+WGWGD5/Wj+64ie9MohCmn9eKsInJ
         SwJykvQezW6y0etkq9z1Pi1Q/GmuaRyYOy1y6hMAAzHBrWo2+EpjkMy191/1uZXH0l6O
         SmchUY9b22aSLFgAReT7WEYRVlPg4M50AaW7dbFvWnPNIgEXQUDpt14SNNJ0xAMQCVFA
         CEuYyvlo5+5b5A88RLNCAzz6sfgnYAdwCDA8Tb2wlqhgtu/EjSmr8GST7rVhXJABYPLv
         RTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jvFeZXrk3oKikBKgA6HGG1zqb2rUCE9zVZ5+CocYrd0=;
        b=jDnDEiLqgOs9TvUUvIYxvVE+JY09MCLTC0Z2zfTrnqmlIpEp761vOi1uZt1/BLVvqr
         ldOYtLrvb+j6SLieR20hz6YZ4YcPQSO/vLuOH7wKDxxXKLveW0fSYY8mFmODedxrgFGU
         nXbeoRW9624QwEvDBe0g3jKcrLEO5yUmUnJbTL8wLB3rSHCV+SxIAiG5mD2ohwCDi/zM
         i2BB9Hg4QA3YMbHHz+ydJcihqmXDwehf8HiSIeJNhOnpRrueFfa0x37we54+eV5B2Fqv
         7bE8x3qE/JebyaF8Gkvv35ZuLSy8Vp8lVlgYqB2nwh/RAaOO5wdvRA7+atTka3jK8WWi
         Utdw==
X-Gm-Message-State: AOUpUlFqXQHNuZJtjEpCdZFbtr+ROIFMBEWNjzCbX62/juMlx9WL9bPJ
        M7l1bTDqWXW/D+IXaju9Isv5NQ==
X-Google-Smtp-Source: AAOMgpd37JN4izayhUj/mpZ9DhidIOshpzo8JrMoKhLLcVQPmmPdRq56ZrvP+qhtxqUujc3gRmeBZA==
X-Received: by 2002:a65:4849:: with SMTP id i9-v6mr21802128pgs.350.1533068824818;
        Tue, 31 Jul 2018 13:27:04 -0700 (PDT)
Received: from xeon-e3 (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id u83-v6sm2025493pfj.37.2018.07.31.13.27.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 13:27:04 -0700 (PDT)
Date:   Tue, 31 Jul 2018 13:27:01 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        davem@davemloft.net, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 3/3] net: WireGuard secure network tunnel
Message-ID: <20180731132701.522b55e2@xeon-e3>
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

> +#define push(stack, p, len) ({ \
> +	if (rcu_access_pointer(p)) { \
> +		BUG_ON(len >= 128); \
> +		stack[len++] = rcu_dereference_protected(p, lockdep_is_held(lock)); \
> +	} \
> +	true; \
> +})
> +static void free_root_node(struct allowedips_node __rcu *top, struct mutex *lock)
> +{
> +	struct allowedips_node *stack[128], *node;
> +	unsigned int len;
> +
> +	for (len = 0, push(stack, top, len); len > 0 && (node = stack[--len]) && push(stack, node->bit[0], len) && push(stack, node->bit[1], len);)
> +		call_rcu_bh(&node->rcu, node_free_rcu);
> +}

This looks like you are doing traversal to free a tree.  The stack is there so that you do the rcu callbacks
in the proper order. Won't this create an lot of RCU work at once?
