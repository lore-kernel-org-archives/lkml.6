Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C067C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 21:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BDC82171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 21:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="BWUNZDIv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfA1VWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 16:22:11 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:41355 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbfA1VWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 16:22:10 -0500
Received: by mail-yb1-f195.google.com with SMTP id n6so1913023ybg.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 13:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R1tczXKUFzCTDG0EEeYL9B/rEiyBaMRbEigEvPcalsM=;
        b=BWUNZDIv09sdTYAuXBiMqvx25t8xYdms70LlJhXdraVVD4ND8QZS1Egu8kl28LrAv4
         2rsNe0xfjtXsa/7pAXDQX6XO7sQieqd+EoOUKyCtprrkAymp9xe1Aeo74Y3eoOJVKeVx
         I0w6f357EMaAsZhJCUprEfPEHCLSP0tmMJuLaozqSHfrax7T2Pd23uVXFhJM/TXo9Rtj
         PtLwtSrHs9eF41prnQYcst3HKBz6IZj/I4ryQ30PPfy07J7OPxoEMq7LNSjHJp/VE7vL
         sg4s3VlxembefLFtixuvyf9Ov0Z+CqLqVM1dYMADBiaWsKBM2idCLIzQtE30kWIsBQOi
         9yig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R1tczXKUFzCTDG0EEeYL9B/rEiyBaMRbEigEvPcalsM=;
        b=Re8QqoU1TNOIRFZGnSwepsZQKfOXoOD73l+9CzZVgthleUTr37LJv7k4Uhn8ajfJ4q
         9ALfDLVo73xRMkcKEMKPDWNSVrw4hguu6IfAkVxaRZrK1aaeG+AS9LkbEe22KaZh+BSO
         q5q8Pv4cmJybzvepNcDO+NkgR0fjRA64dN3UblpIaH1o9ZnC1VCgDoRG3KwAFkBjkv7p
         TXH0uRDKEqLYsiRm8607YeOyMWdjACiiy4uWsE8BvoHufke9wJOJ9uNO5t9mrrqNfN6i
         vYqR5HiVPhSO0ZN8fbwKbpK+YIxtkzl9qe6b/QOlSg6N4/QJekbl4hzz0NUdzzDr96cQ
         Abhw==
X-Gm-Message-State: AJcUukceSFMbNrJBvyND6ar6qlL1QmzXdT0eoRHfNaSb4hjqzq22CwLQ
        sVf8UGAGMFssTZ1vg3Hy3DYU+g==
X-Google-Smtp-Source: ALg8bN67pMPbU43pXLl6O/DjG+0UAfhqYH7oETTn698WBm4AXKfHjyzns7FKkPi/tFPcEFuAgdI2CA==
X-Received: by 2002:a25:cc04:: with SMTP id l4mr16091947ybf.50.1548710529969;
        Mon, 28 Jan 2019 13:22:09 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::5:42c8])
        by smtp.gmail.com with ESMTPSA id i128sm13849151ywb.82.2019.01.28.13.22.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 13:22:09 -0800 (PST)
Date:   Mon, 28 Jan 2019 16:22:08 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     gregkh@linuxfoundation.org, tj@kernel.org, lizefan@huawei.com,
        axboe@kernel.dk, dennis@kernel.org, dennisszhou@gmail.com,
        mingo@redhat.com, peterz@infradead.org, akpm@linux-foundation.org,
        corbet@lwn.net, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v3 3/5] psi: introduce state_mask to represent stalled
 psi states
Message-ID: <20190128212208.GA1416@cmpxchg.org>
References: <20190124211518.244221-1-surenb@google.com>
 <20190124211518.244221-4-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124211518.244221-4-surenb@google.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 01:15:16PM -0800, Suren Baghdasaryan wrote:
> The psi monitoring patches will need to determine the same states as
> record_times(). To avoid calculating them twice, maintain a state mask
> that can be consulted cheaply. Do this in a separate patch to keep the
> churn in the main feature patch at a minimum.
> This adds 4-byte state_mask member into psi_group_cpu struct which
> results in its first cacheline-aligned part to become 52 bytes long.
> Add explicit values to enumeration element counters that affect
> psi_group_cpu struct size.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
