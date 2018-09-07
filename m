Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532A9C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E532075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="apPGmYDC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01E532075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbeIGWYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 18:24:15 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38647 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbeIGWYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 18:24:15 -0400
Received: by mail-pg1-f194.google.com with SMTP id t84-v6so5490789pgb.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 10:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=SDBqecwFp3ibGx/Oq42nQJf2flCk+viNp8p/Is/DPJ0=;
        b=apPGmYDCrix9ckHqHpxMDpLy2+qN2UXv4BdLNMzp2wNwa49y3XejU3d9kokgwr72jm
         1LhXaktxWhPhoJRRd7epzUndHIvIQ3wqhxY7ZtdGX7IHxi3XN6oCBfhUtZvoExZ9HqEm
         VkmBOVFy4Rz77NwAPTCraJlkS40v980i6tNzGcQrX0bsN5Ky9kWbaC7kFJgHT9Rb/GEI
         9KwsUeeUp6arIm1aDHWZTVL2RIsQLaXV/ZypujvEnhxlaUt+6gXqNhe0GzS09+4h0BaS
         s8gOQRTnC2C0LPgkobwOnHhELoJmfpyzGgt3XaFNHcYOsIMvjocM28tqaMNnp6Ie05J8
         xzzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=SDBqecwFp3ibGx/Oq42nQJf2flCk+viNp8p/Is/DPJ0=;
        b=oMmN/4iTsgzdlM7d0enNjAImGXxqp4syEgg06fwO5RmjW2fRG13XGlVeTpvK7+jc2e
         MxBquE1+MkHNRs32pm9nXV1fSpiWtQvCGkTKk6iBC4kc3Yj3x4NcQXmT1vFe0KV5y9ig
         cUAXdscqhrhxi+ZspSnqAc9kkyb5mp+8ZjzhZVXGQD0D5ywsNbLT6Sa9t/1xl2SIH9Zv
         SbwfQe2nNkMqj4S7iFMsU5YKd6JSo6sEQSsS+M68UnNaS4y8G8LmuX3S6NIcy+lLtwye
         z8vg2mKe7uH7Zianwfl3bGDmsmSLNHoR5dqH+nExarMFjTTgwzRfa39NI/cpdpyWt+JH
         U5Yg==
X-Gm-Message-State: APzg51AsORuiqsui6xodTO2MyzGRWNcywteViu2hfdafRoSHoJG/R4I1
        h+1EtpLG3FvdwkSIIrY3v1n92g==
X-Google-Smtp-Source: ANB0VdYPO0iBpKuVRoGywW1ArY9hZQe7qth59MHKosmlvdQv3rF67VxXt5EB1VAArbMhjVF710KvtQ==
X-Received: by 2002:a62:d113:: with SMTP id z19-v6mr9687344pfg.98.1536342135214;
        Fri, 07 Sep 2018 10:42:15 -0700 (PDT)
Received: from cakuba (89-66-82-92.dynamic.chello.pl. [89.66.82.92])
        by smtp.gmail.com with ESMTPSA id a15-v6sm16686153pfe.32.2018.09.07.10.42.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Sep 2018 10:42:15 -0700 (PDT)
Date:   Fri, 7 Sep 2018 19:42:07 +0200
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     jun qian <hangdianqj@163.com>
Cc:     Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        oss-drivers@netronome.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfp: replace spin_lock_bh with spin_lock in tasklet
 callback
Message-ID: <20180907194207.5f7c7386@cakuba>
In-Reply-To: <20180907170109.48150-1-hangdianqj@163.com>
References: <20180907170109.48150-1-hangdianqj@163.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  7 Sep 2018 10:01:09 -0700, jun qian wrote:
> As you are already in a tasklet, it is unnecessary to call spin_lock_bh.
> 
> Signed-off-by: jun qian <hangdianqj@163.com>

Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
