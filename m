Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C45C07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D93320823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="a4uqc+mB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbfARSTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 13:19:52 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53166 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728754AbfARSTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 13:19:52 -0500
Received: by mail-wm1-f66.google.com with SMTP id m1so5376743wml.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 10:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aNVoZsC7Y25LaGxXNGyBM1sEz1yZmA5YJTgOIBScQb4=;
        b=a4uqc+mBNOcKlLHejT19p7w1ZjOhgyxNnZy6wUy+oZq9BL1Ae9mvTqpVGXvaGtQGae
         Po5mTY2BZAyDHnZ7b/Z1PGjbmqU8wCmO6NlnlIkc9NFltLHilXvwoIg0eFVOU3Pwc/At
         1k5FMkf3K041E+wCYt35gqZYrZltCNOsfM7Bgkftrt3yxgknsNIrWzvr252WwDADZv2x
         tEK0tn2E/JPgB/ppD68E+giJTG+DQzjOzxMmfQfQ+X+NsGxDEbvjcp9s/wmnSl1opg8L
         pk5/XicyZAl+a0B7rpfyLzybzcx8BLP2sFRkVU7bj4bXpyiyYjy1RsWHkbek0DHSlYES
         a9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=aNVoZsC7Y25LaGxXNGyBM1sEz1yZmA5YJTgOIBScQb4=;
        b=pv+UjGC3iOmTv4FLc/f2SsF9Wj9fQmoxv7znFLhugBZ0VzjH88A0O/0XyzRxijIhDZ
         kxETcXIK//TZd1ZNTmLaaqHlV/HtIWnusizYY/G9hauxsgWcITGTGCNaQ373kqz9IkW4
         L3lqc+f1EJNm1JfBxGfjZx4b19AqkmvqNR5tIAM/2zTWc1ZXKrVgT5mrK/SdBjBlZL58
         sflTiXsJKMjpuM6fGy7x/72HouwHTvfF6qej5Tv3hdVs2APMOQ9JGZJgFgi1JQUEC13H
         //ANoSj9whUCOrhEW33v8yVaZLhxSMJM7RiZh8ygZMch3V8w9b/57TxBhftWrm/EDuDZ
         vJYg==
X-Gm-Message-State: AJcUukf87Z8vYFwMBO5g0Kv2aoI4/zO+R3Z5S87BUJFTOp/2dmEcb/z/
        k9ACTsJe7e+B22buOqGSnhGccQ==
X-Google-Smtp-Source: ALg8bN6Bs+xrx+fK0B4X9uuAwmzGu1cPE8RdoImhOxnb6OkRXzMOngSdDDvhH/YIFnoRcD8XZ0Mgzw==
X-Received: by 2002:a1c:c2d5:: with SMTP id s204mr17708072wmf.144.1547835589514;
        Fri, 18 Jan 2019 10:19:49 -0800 (PST)
Received: from [172.20.1.107] ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id h16sm174622797wrb.62.2019.01.18.10.19.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 10:19:48 -0800 (PST)
Subject: Re: [PATCH] bpftool: Fix prog dump by tag
To:     Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        Lance Digby <ldigby@redhat.com>
References: <20190118125817.10763-1-jolsa@kernel.org>
From:   Quentin Monnet <quentin.monnet@netronome.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quentin.monnet@netronome.com; prefer-encrypt=mutual; keydata=
 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
 RHhSHGnKaQ6MfrTge5Q0h5A=
Message-ID: <b4e278c0-00b3-379a-fe3e-a87d1f442f81@netronome.com>
Date:   Fri, 18 Jan 2019 18:19:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190118125817.10763-1-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2019-01-18 13:58 UTC+0100 ~ Jiri Olsa <jolsa@kernel.org>
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

Thanks for the fix!

Reviewed-by: Quentin Monnet <quentin.monnet@netronome.com>
