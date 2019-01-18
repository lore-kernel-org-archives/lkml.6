Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452A1C07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 19:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 135692087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 19:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="Qe+56cQi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbfARTQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 14:16:10 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39098 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729199AbfARTQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 14:16:09 -0500
Received: by mail-qk1-f193.google.com with SMTP id c21so8670479qkl.6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 11:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=w6ZmAvWp7VHJfVq/cx3Xyc4lPF+lIn6FIm7mNS9JWj8=;
        b=Qe+56cQiedB1bRSMPePsd89o9WE5gc0KTUDHleOADdK5HA2Ve6+fZBzcVUidyl89qx
         mB1OfPf7daQaaljXHDlUaTEx5b7DR/r1/BHBtv+zYNPNBhmXfFI5iCTvYySCUIW5jFXg
         AZ1GVKeVByVaBcdMOolLBdaagmpKSq9ep3aqS9WvHLr2fjz2yUir+BBAKAhg7XRTCTj1
         49LMwpsUknFoan05IQWpYb/wwoxJ7KptiT5zcuhJzDJ6p/3Oi30kvB1iMCaJP/NAVWgd
         1XEgYDBH2Lpa1xRxTIBAynAmsly/RNqoaqemLK96r5tBj8utgbOv/Lyurs5bhOfRx17f
         lX2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=w6ZmAvWp7VHJfVq/cx3Xyc4lPF+lIn6FIm7mNS9JWj8=;
        b=TaYKYe8xx58XUDMnGqtK8Y2FNFfYfTDPdg586Wm2N8ZBPQk+3oqXerS0ZO6WXMun3A
         aRjgEJnTsRuV/gyQDXPcYqzSFbwtJB0dcgPB7aVSPuRZtpQlT9qL7VNvHKniTiI6pVVi
         vtbz8UcBxZCzvTP5SPg9u8RIAFovbu4BZNNNOp9JwpcirMHh7rArR9KutOaccu5OX29r
         P6huP6FJqRj/5jN+TI60rjf5R1zr/N9JjRDdByvkIdtUypkKSnExso++CW4MohpKqWKY
         A9uRCFnFHi3HV0VfJaOb34kqOsylU6hNVE7jSUcxN+u0vG/WHQRpL80l9Ei7/CgVd6Ja
         uZ9w==
X-Gm-Message-State: AJcUukfdDbux7dycnwhY/nAZTkmnflOl1+dnKwxymBisrYCa3Yc8M7I3
        ziSurVlFrExXGEmgAQLePQo8BQ==
X-Google-Smtp-Source: ALg8bN7w/8nEQNzJuEaxTSIOWTdhE6Q16Ak/P39ECcVHsPvZEwWiKq0oE9chsIo49xbRbgk3vC1SnA==
X-Received: by 2002:a37:7cc5:: with SMTP id x188mr15440957qkc.307.1547838968218;
        Fri, 18 Jan 2019 11:16:08 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id v50sm56476226qtc.7.2019.01.18.11.16.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 11:16:08 -0800 (PST)
Date:   Fri, 18 Jan 2019 11:16:03 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        Lance Digby <ldigby@redhat.com>
Subject: Re: [PATCH] bpftool: Fix prog dump by tag
Message-ID: <20190118111603.5f0d7206@cakuba.netronome.com>
In-Reply-To: <20190118125817.10763-1-jolsa@kernel.org>
References: <20190118125817.10763-1-jolsa@kernel.org>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2019 13:58:17 +0100, Jiri Olsa wrote:
> Lance reported an issue with bpftool not being able to
> dump program if there are more programs loaded and you
> want to dump any but the first program, like:
> 
>   # bpftool prog
>   28: kprobe  name trace_req_start  tag 1dfc28ba8b3dd597  gpl
>   	loaded_at 2019-01-18T17:02:40+1100  uid 0
>   	xlated 112B  jited 109B  memlock 4096B  map_ids 13
>   29: kprobe  name trace_req_compl  tag 5b6a5ecc6030a683  gpl
>   	loaded_at 2019-01-18T17:02:40+1100  uid 0
>   	xlated 928B  jited 575B  memlock 4096B  map_ids 13,14
>   #  bpftool prog dum jited tag 1dfc28ba8b3dd597
>    0:	push   %rbp
>    1:	mov    %rsp,%rbp
>   ...
> 
>   #  bpftool prog dum jited tag 5b6a5ecc6030a683
>   Error: can't get prog info (29): Bad address
> 
> The problem is in the prog_fd_by_tag function not cleaning
> the struct bpf_prog_info before another request, so the
> previous program length is still in there and kernel assumes
> it needs to dump the program, which fails because there's no
> user pointer set.
> 
> Moving the struct bpf_prog_info declaration into the loop,
> so it gets cleaned before each query.
> 
> Reported-by: Lance Digby <ldigby@redhat.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Aw.

Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>

Thanks!
