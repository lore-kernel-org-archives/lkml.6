Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C78C468C8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 03:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CE5A21471
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 03:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="do99QaHG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CE5A21471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbeGLDhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 23:37:48 -0400
Received: from mail-qt0-f173.google.com ([209.85.216.173]:41263 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbeGLDhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 23:37:48 -0400
Received: by mail-qt0-f173.google.com with SMTP id e19-v6so8788302qtp.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 20:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=zpCSxbgbEqNTM1oa1T+S8oVdFZpm1WQ2YqFA4Mg5bNQ=;
        b=do99QaHG8vsYs0is00s2EHDr9Af7yWYr3yQXeReLTdxNq2gqYnDC74tqY9CTPlHS59
         /dZiWorSJgSCAwuIBT3pVv42a0D745VToDQJzra7mJrUsLtUpfXhAWLVPfkRX6L9xkXr
         dQEtHHVV0KF5ESdUU5gqZ2jUVFEJeFMTmsCyREmicsuF9RDGAzcATmszHGWvS39AYcVf
         REEv2aQXQgDOZoQulKZACZvzGlwxkAEBS8PCNzbJEoy2VUG3iYwquFstYQi3HKXplW9f
         g4W8DvlMKHm+TYPV0Zfetg2aqu3GdJMBSfAYxTWGSisWqAIqVLF4VQgjpKmeI54Vy/Qu
         mP/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=zpCSxbgbEqNTM1oa1T+S8oVdFZpm1WQ2YqFA4Mg5bNQ=;
        b=d8Q9Ks5ArgITt/zFmfFArHI7LPMbST7rjI1mVaigXyjLjd29NRTaK4shEEKUZwaH1b
         vc88U3SJmAZStTwuLEufApT1rIHXXIN+/SK5oY0WBM/bS6lheL5qsbu5YEuHSKUK3n5d
         I5yzDrlMgiixSEDa7KSKeImTrv4iQ1T6vdtuDdAkNIu8YU3rDp19fkwuCMy+RgCqIdRW
         pM/SCE+QkAtJKP5+s1G+4VEgT0BMQG1CgI2XLSSQOcwVCRG+KqQOZCbTOooMn7HItmr+
         kip3xY3dcix9lAwmkt6teZ6vdPL0p5jFk2SGr/MUN4yVQioDCwte31lR1LZAY2TdAtTM
         3JoQ==
X-Gm-Message-State: AOUpUlEgj0fG3iI/K8G/hinmOlL29EBsRIeRdKWPz2ZeS1meXeqD23Rs
        kvgzjM/zy1yvkVdF5rd4grNpLA==
X-Google-Smtp-Source: AAOMgpeBN2198p+fkTR4t+ae+Ua6VrELJ5RjROMQ0WxTcxa/LBjf6kRxe3ff7+rri18zT3BYTqusXg==
X-Received: by 2002:a0c:e60e:: with SMTP id z14-v6mr531909qvm.244.1531366213949;
        Wed, 11 Jul 2018 20:30:13 -0700 (PDT)
Received: from cakuba.lan ([75.53.12.129])
        by smtp.gmail.com with ESMTPSA id i32-v6sm1577307qtb.21.2018.07.11.20.30.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 20:30:13 -0700 (PDT)
Date:   Wed, 11 Jul 2018 20:30:10 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Okash Khawaja <osk@fb.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v5 0/3] bpf: btf: print bpftool map data with
 btf
Message-ID: <20180711203010.51bab0cf@cakuba.lan>
In-Reply-To: <20180712030803.875913594@fb.com>
References: <20180712030803.875913594@fb.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2018 20:08:03 -0700, Okash Khawaja wrote:
> Hi,
> 
> Here are the changes from v4:
> 
> patch 2:
> 
> - sort headers in btf_dumper.c
> - remove extra parentheses
> - include asm/byteorder.h
> - compile error when big and small endian bitfields macro undefined

Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>

Thanks!
