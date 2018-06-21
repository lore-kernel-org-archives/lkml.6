Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64792C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 087D422458
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="bzLlziw0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 087D422458
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933701AbeFUV7m (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 17:59:42 -0400
Received: from mail-qt0-f172.google.com ([209.85.216.172]:42518 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933485AbeFUV7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 17:59:40 -0400
Received: by mail-qt0-f172.google.com with SMTP id y31-v6so4305278qty.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 14:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=PrBHSaMFy3OjbtxlU0zAUwkcvyUVYjmEHVqAi7rr9+U=;
        b=bzLlziw0XA4fQAaMZLDMNl26RBu4lKXfwy0ZMaPv8rx41jApVg5JR0+J4YDuKekLqr
         hUEXulPEhSpZXfP+GKQrijBhm3K/5RrlZSTuzkhZA64ZCDWG0XGpLDN7ScpmK6CnQWYs
         4yjGpAFVXazkek1ivGBQQxm6uK3YA8pKcQJNg2THQC01+V5Rh4YKvIr/UUgxEogoBqFN
         nmfKbaERxVXPnJCUfKLC4ueeCAW6ywXpY8aPfwnQUnfMpVYlzIPBY6Z9DgyVGw1evea7
         +V1mCMsBt8J/wlUFAQv28MowtMu9u7/3nglno9b2a5RYTx39H4RySDLxmM0Fur+QuRG5
         ZTyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=PrBHSaMFy3OjbtxlU0zAUwkcvyUVYjmEHVqAi7rr9+U=;
        b=r5GFPSD3xBN2cGXs49VNi03lSjlLiftN+qMnZaEcDrLJlrX3QOOzHrjHjHGav4RHl1
         UlPh1rdFfmE7amX9ldcC6y+zoS3JJesuWY91mnww6vkp5iGk0QdRilBbPE4gjV+G0bYM
         GW+P5H7QuLJ9RMqiPLSGkv0fe5bl1wg0fGoG6RKhZSyVfdrH2Dh0GXiGZbq3rukt3PUq
         fbpRMvNj50bPrIycwbAPePTq8CAHPZ72VMc0GzYuPt6TV9NeGvj7XtfYG5VLy07YNTiQ
         y1PAokfwVLl81HGJKiG7xMrja7a5y+M8d0s0Dkxi45EhN/vg2WiICtA96iuo9o0mRWvM
         BDyQ==
X-Gm-Message-State: APt69E2qdS4RGb1bjLbCW3maLwokRZk4EQe52YScF6TZI4Bvnds6Q4vA
        7NtsM+yTVRYq/E11ttEAZVyu2g==
X-Google-Smtp-Source: ADUXVKLEtho//h5LtF7++4whBy3b5Q381YKfQcDqK2siFmPzeEhUurNChAAcx5QFxeWRiPHJkGjygw==
X-Received: by 2002:a0c:8601:: with SMTP id p1-v6mr24266433qva.184.1529618379718;
        Thu, 21 Jun 2018 14:59:39 -0700 (PDT)
Received: from cakuba.netronome.com ([75.53.12.129])
        by smtp.gmail.com with ESMTPSA id y128-v6sm4057265qkc.1.2018.06.21.14.59.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 14:59:39 -0700 (PDT)
Date:   Thu, 21 Jun 2018 14:59:35 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Okash Khawaja <osk@fb.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 2/3] bpf: btf: add btf json print functionality
Message-ID: <20180621145935.41ff8974@cakuba.netronome.com>
In-Reply-To: <20180620203703.101156292@fb.com>
References: <20180620203051.223156973@fb.com>
        <20180620203703.101156292@fb.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jun 2018 13:30:53 -0700, Okash Khawaja wrote:
> $ sudo bpftool map dump -p id 14
> [{
>         "key": 0
>     },{
>         "value": {
>             "m": 1,
>             "n": 2,
>             "o": "c",
>             "p": [15,16,17,18,15,16,17,18
>             ],
>             "q": [[25,26,27,28,25,26,27,28
>                 ],[35,36,37,38,35,36,37,38
>                 ],[45,46,47,48,45,46,47,48
>                 ],[55,56,57,58,55,56,57,58
>                 ]
>             ],
>             "r": 1,
>             "s": 0x7ffff6f70568,
>             "t": {
>                 "x": 5,
>                 "y": 10
>             },
>             "u": 100,
>             "v": 20,
>             "w1": 0x7,
>             "w2": 0x3
>         }
>     }
> ]

I don't think this format is okay, JSON output is an API you shouldn't
break.  You can change the non-JSON output whatever way you like, but
JSON must remain backwards compatible.

The dump today has object per entry, e.g.:

{
        "key":["0x00","0x00","0x00","0x00",
        ],
        "value": ["0x02","0x00","0x00","0x00","0x00","0x00","0x00","0x00"
        ]
}

This format must remain, you may only augment it with new fields.  E.g.:

{
        "key":["0x00","0x00","0x00","0x00",
        ],
	"key_struct":{
		"index":0
	},
        "value": ["0x02","0x00","0x00","0x00","0x00","0x00","0x00","0x00"
        ],
	"value_struct":{
		"src_ip":2,
		"dst_ip:0
	}
}

The name XYZ_struct may not be the best, perhaps you can come up with a
better one?  

Does that make sense?  Am I missing what you're doing here?

One process note - please make sure you run checkpatch.pl --strict on
bpftool patches before posting.

Thanks for working on this!
