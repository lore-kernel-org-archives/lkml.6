Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A36C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 04:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EAF022562
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 04:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="xoWVzDSD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EAF022562
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753757AbeGCEHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 00:07:36 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:39914 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753485AbeGCEHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 00:07:34 -0400
Received: by mail-qt0-f193.google.com with SMTP id q12-v6so480221qtp.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 21:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=x9mWv3XaCSB7qLRtEOA3YyIdHfZf5rVW7mfGGhZ+w1w=;
        b=xoWVzDSDu/2nUKjjq3Cqn9kE80EZXGMr2GVT/A87H/uJWp60v1lNXioq6UN4isSgQW
         LGE3lwfQl4isreP/gNWbdhaa5Yf3vqvhN8myXwYUcGSZU3IXx8WAK/nDurATL0wJYuBs
         CKI9sx9NDchsVS8v5zglaJC+MLNpjv0LrsFb1GR/tau527kHLE7bxos/DsVfiCIjQuVH
         IUkuzaGWgJnCNJRRT1Khj5zZf0kWyKW7nZ6B8ygzOdIizhkt/d8xFX/5u2Ekjs9tzu+f
         1ytOyYN/Myv+VPMikkItQPicN6fmQTdB5UoOdcXV7ZApSFcPfRhau0mdG0eU+wh0YFa3
         Yxvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=x9mWv3XaCSB7qLRtEOA3YyIdHfZf5rVW7mfGGhZ+w1w=;
        b=RCTAPNzOkKBuTeBx5oPXrYNpZ9a+L3i+rtmh0Q2fZTB2LPQRG1ppURoMy9CHTWZ6ou
         JzjM9M3V+5VBBu+3/wihz6dw2ATTVItlFVG5nHWQWV0+nrJL9QVQ5ikAklkWcckdTtkp
         JXOq6u2G7MaX5Bgz124Z6ro7irA+glGTpdhvCxv8jcQ6vXeUS6p+khlq/lyorK4ShDSN
         2LV8FSIQoOuoxG8YUcSXhbPhH511PgoVkLh9cnh9Te6IvtTmBl/JvpzoV4Z6bjCllL7y
         uezbB1tQ0GLgygU7ZxtuzvcpMmq7sWUqOdej/C084PR722HOIPN84zTWK13HiuIzwU5A
         OUlA==
X-Gm-Message-State: APt69E0Gf7g+AxZLLx8Sn/jTjeP+IUEWFOlaBfNWFK8jwgQJf3rgLveK
        M/dK19vipsTwoocYA/ObnnEZVw==
X-Google-Smtp-Source: AAOMgpcggBWgvOf08AJy5CvWEVTEz9g7hmfsKsvyAzvsAo0WUZx9agNMuCO5CnNEM5DZu/R9tFPzhQ==
X-Received: by 2002:aed:3bd2:: with SMTP id s18-v6mr10333247qte.324.1530590853731;
        Mon, 02 Jul 2018 21:07:33 -0700 (PDT)
Received: from cakuba.netronome.com ([75.53.12.129])
        by smtp.gmail.com with ESMTPSA id m31-v6sm125363qte.82.2018.07.02.21.07.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 21:07:33 -0700 (PDT)
Date:   Mon, 2 Jul 2018 21:07:29 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Okash Khawaja <osk@fb.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        "Quentin Monnet" <quentin.monnet@netronome.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: btf: export btf types and name by
 offset from lib
Message-ID: <20180702210729.69cfb63d@cakuba.netronome.com>
In-Reply-To: <20180702191324.476855192@fb.com>
References: <20180702183913.669030439@fb.com>
        <20180702191324.476855192@fb.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Jul 2018 11:39:14 -0700, Okash Khawaja wrote:
> --- a/tools/lib/bpf/btf.h
> +++ b/tools/lib/bpf/btf.h
> @@ -17,6 +17,9 @@ void btf__free(struct btf *btf);
>  struct btf *btf__new(uint8_t *data, uint32_t size, btf_print_fn_t err_log);
>  int32_t btf__find_by_name(const struct btf *btf, const char *type_name);
>  int64_t btf__resolve_size(const struct btf *btf, uint32_t type_id);
> +int32_t btf__resolve_type(const struct btf *btf, uint32_t type_id);
>  int btf__fd(const struct btf *btf);
> +const char *btf__name_by_offset(const struct btf *btf, uint32_t offset);
> +const struct btf_type *btf__type_by_id(const struct btf *btf, uint32_t type_id);

Why is BTF code using stdint types?  libbpf used to follow the kernel
coding style AFA int types go.
