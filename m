Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66725C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3620D21720
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fx+Rxv05"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732527AbeLTQxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:53:31 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36331 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbeLTQxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 11:53:30 -0500
Received: by mail-lj1-f194.google.com with SMTP id g11-v6so2201778ljk.3;
        Thu, 20 Dec 2018 08:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:reply-to:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1/aWidBb1eIpcCX56RAhuCsGgWAXVJZX0LZz7ZBJrSw=;
        b=Fx+Rxv05DKVwzrtTreWsOYBScWO16AhXeFd7XpJeQs2absJ3PRoSzGZf3Z3+r7IizK
         tRf9l7NsgDs5RouvcFCzdeqxIVzMfiUw0ekmlemDCHrPzBHZtm2oyLOGue5qGR+XElkf
         4Ci2DZynUjMlafg76trWwerhyKfgcRdLt03nGYcc2g6ZqiyWusm84BjgQGEOBRYwB27g
         gi44/JOK63w4kKceQ5FPDk55rKzcOVDhnP+Os+OODqG/TOupmp9B29oSmFJrTJBqpKAz
         KqkbhXY+Fe0q5ptkZC58V73sxmzHIYATiJvPoflOSZHNendWEgg782iNZPTjgSyK9RLK
         dCsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:reply-to:references
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=1/aWidBb1eIpcCX56RAhuCsGgWAXVJZX0LZz7ZBJrSw=;
        b=r3wGpT/9rLiwhiLbTgpJjqhVJCeoZwL34uUp+ZA0UW1ol4u0sZw1uevJrDphKrl/Uy
         +6xKKuFXliGVpSKgaOZ4Gzkqo42M3pFYF6Bmj3oagq4vAMAWlGOl5X6be5d0pABr8FCJ
         +XU0HjYftor1gvxVstXVvdNO5BeL78szTd7PfRgnNHubPhNWIESZXSVkdzt8+lOQslvs
         /8M170XIynNJzZitkXEwZ+znfG2TgMBvKd2SJsL5Qd1SVrqLwHg5O+AJlKkPSkBJMmr9
         NpxN7JddQ5g0Hw/E+c0M4LVP/BeM1MkNucMmaRRZRQOASAVAiY8s9HzalhvXBRIEO0UN
         nYgg==
X-Gm-Message-State: AA+aEWaFMTTj+uTlAXsQlDv7Xq27rnLO1HZcO05ezGfyASlSE0W526g5
        3HswFr1GEXnhaDz2S8RZY+z1FC6pU0Y=
X-Google-Smtp-Source: AFSGD/WHzuboCJAKJUCrq9zBfKaGQoowKCIbHDv+KBfSVaIj1TLw04pBcjpqWglC77+aXXvoNxxojQ==
X-Received: by 2002:a2e:9694:: with SMTP id q20-v6mr4922059lji.173.1545324808027;
        Thu, 20 Dec 2018 08:53:28 -0800 (PST)
Received: from ?IPv6:2001:14bb:51:a4c8:5c24:24d7:ca5f:e7d2? (dmhwpt3bffxn8z3-j6k-4.rev.dnainternet.fi. [2001:14bb:51:a4c8:5c24:24d7:ca5f:e7d2])
        by smtp.gmail.com with ESMTPSA id d5sm4343117lfi.65.2018.12.20.08.53.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 08:53:27 -0800 (PST)
Subject: Re: [PATCH 04/12] __wr_after_init: x86_64: __wr_op
From:   Igor Stoppa <igor.stoppa@gmail.com>
To:     Andy Lutomirski <luto@amacapital.net>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc:     igor.stoppa@huawei.com, Nadav Amit <nadav.amit@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        linux-integrity@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Reply-To: Igor Stoppa <igor.stoppa@gmail.com>
References: <20181219213338.26619-1-igor.stoppa@huawei.com>
 <20181219213338.26619-5-igor.stoppa@huawei.com>
Message-ID: <f800ee0f-9ac5-f91c-c1a6-3e094721c91d@gmail.com>
Date:   Thu, 20 Dec 2018 18:53:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181219213338.26619-5-igor.stoppa@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/12/2018 23:33, Igor Stoppa wrote:

> +	if (WARN_ONCE(op >= WR_OPS_NUMBER, "Invalid WR operation.") ||
> +	    WARN_ONCE(!is_wr_after_init(dst, len), "Invalid WR range."))
> +		return (void *)dst;
> +
> +	offset = dst - (unsigned long)&__start_wr_after_init;

I forgot to remove the offset.
If the whole kernel memory is remapped, it is shifted by wr_poking_base.
I'll fix it in the next iteration.

> +	wr_poking_addr = wr_poking_base + offset;

	wr_poking_addr = wr_poking_base + dst;

--
igor
