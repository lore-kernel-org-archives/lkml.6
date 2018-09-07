Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE35AC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A1BF2077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="Qgt/lBP+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A1BF2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbeIGVPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 17:15:22 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45667 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbeIGVPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 17:15:22 -0400
Received: by mail-pf1-f193.google.com with SMTP id i26-v6so7259706pfo.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 09:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=tEIuLLe9PUfFRv2Bgo3DJ5r8ldqFsGz/X7WhewxB/tY=;
        b=Qgt/lBP+KgwGQQ4u94UIHF/4pEKFdtQib072Y6MJIjYEZmZIaGV5M7g7aoJME6ywLv
         rHGEkTPRBpaWyHfzgUeeFVXnkeGy3SVO5UIfrFF9kwamRaT0tEWInDpoi2iW4+YtN9R0
         SXogn63mARtVv/TBuBrg/f4WTMX1Q3ghL6J6f5esbMKmuB+RyZJJuuVSjL/qz5ZmPSPS
         Yz4lQHTKVFCfsT4AUCOx10L9ce2mNdowDgVG1PfP5A0KCTDpTvXK2H6I0DhPEVFiDP5R
         rDatfCM17NRdEIsRfqQugRcdul2tdBqDB77t9GWvmCZ+PCSRxpIv6ioLsLzS3GsYC6ge
         Bc4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=tEIuLLe9PUfFRv2Bgo3DJ5r8ldqFsGz/X7WhewxB/tY=;
        b=WwzvXokT5gRfLH0vIm3hId9WcrJhV/UakSy48XWS59Smpvc0FZQiGEov1jnT+eTgct
         KoOtN+Sy+9WJY2BDlfO/zjQZpMhZX9eTk5ckIOHfNNBqvsam3zqDOP8Y5mdoX345BAxs
         YB+8vh9n2qq1Q2jgPRLPGtS3MfqspWx8H2RDoN/l0mkCM4Ao7rwnEyfT9ssCA4qNvi4f
         dpxl/345TZ4cXzCDYB9WvzZCISjckNp4+3h4BmyonTPeSv+E36U4zQg/FBQFBmn2UOFE
         rzZqW/OpIFmPqZWEZ7XZYJ1vYM70bcEBpAbbsOBwybV7GSnxcMPEb0J40ZlC4sKlPZP2
         5X2g==
X-Gm-Message-State: APzg51DHh7mTKzgErMer74QJjDyl16BCmyXmtIAyPAJqvFOdc3bzQAar
        mnDgQnXRGrrSB3mvcd9lgsxYelA7jqQ=
X-Google-Smtp-Source: ANB0VdYrBQhSRrSPT8IoGPZxcIPtColathFFQVuEez2Ucs6LHWuOAY8pgbky4QigQFf0n3ii+WRFmQ==
X-Received: by 2002:a62:9541:: with SMTP id p62-v6mr9588115pfd.194.1536338019738;
        Fri, 07 Sep 2018 09:33:39 -0700 (PDT)
Received: from cakuba (89-66-82-92.dynamic.chello.pl. [89.66.82.92])
        by smtp.gmail.com with ESMTPSA id k4-v6sm14761965pfj.30.2018.09.07.09.33.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Sep 2018 09:33:39 -0700 (PDT)
Date:   Fri, 7 Sep 2018 18:33:31 +0200
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     jun qian <hangdianqj@163.com>
Cc:     Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        oss-drivers@netronome.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ethernet:netronome:nfp:move spin_lock_bh to spin_lock
 in tasklet
Message-ID: <20180907183331.7ed99ae3@cakuba>
In-Reply-To: <20180907162117.47361-1-hangdianqj@163.com>
References: <20180907162117.47361-1-hangdianqj@163.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  7 Sep 2018 09:21:17 -0700, jun qian wrote:
> As you are already in a tasklet, it is unnecessary to call spin_lock_bh.
> 
> Signed-off-by: jun qian <hangdianqj@163.com>

We had more of those at some point, I wonder if you(r tool) can find
them :)

Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
