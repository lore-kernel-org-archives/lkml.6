Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88BAC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 19:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1928218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 19:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJNROoRx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389289AbeLTTTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 14:19:21 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37714 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729641AbeLTTTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 14:19:21 -0500
Received: by mail-lf1-f65.google.com with SMTP id y11so2209448lfj.4;
        Thu, 20 Dec 2018 11:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VOgq0OztbfdSvEtyTC3tYeK3AlrkwdW39gM4Ncp34TY=;
        b=TJNROoRxJGlPhT9Nt0TMqpFUXYZWbuj0+lktjVLk/lCTJ7Oc0Cgb5/hmKndUl0FkNu
         l9MA09ZvMtHc+ada3prPmW1w9Rvus6fYlxXfcFQCDO+hA4b4vht0TiNV9AXb+p4PAQep
         LSkNrP1mIXcfM5t+pe1m9VL2e78CaCyxVc3UjVOSZfZHgCpW0s/sA1NHMeE3xeKIsZ2O
         geeeUOxf3hwKEK7ueTIlHMF+U3OnoH6A64yp1zlmUbPUJNFhHd07sflpwVhfAQgz7Uj5
         JHgk9old9o7WKCzgywQy57lRmRhNq3r2D5ovoyMa015q967k9WK0nsaeZgBBNWT/ruih
         KAMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VOgq0OztbfdSvEtyTC3tYeK3AlrkwdW39gM4Ncp34TY=;
        b=W/Mk7Aggfvv9Rl3Y9F2tDhccebfu+iIMVYOhXS1qcyDXDD+E9ZuphHKCHossufFz+2
         727In2z7Dvipm3d97vCZ9dwt95HUAHFtr7bTOHjKpihiJsIKGok5CTpMm9tt2hOTVT5J
         XV8Zbzemlqn/4q0o7iIHWrPYRPlql4iURQqMB+BOSTC4LnkeWiKzC/ikWFyds49uflbr
         +qseqbuMt5N9eMTYeCxHmuG9uM90ZcXbRIJRUNJPTPOmHMzP+b3DLw8DwAg6bbQtIcmv
         cNsNZ+I9REj5qGb0W57OPOFSypg5P3Is4aEbmN0oCOp28qcCvjqfyi2fK4F4DQdBmuk3
         6XMg==
X-Gm-Message-State: AA+aEWZc9gGIa8sCQrmjWk4HA5mcU4mypN/hv8oHuoeOftDXnCA3KBN1
        DQTo9Igbr1fTxvYYcOVOiT3m7hiFJQ4=
X-Google-Smtp-Source: AFSGD/VKz/h7wn00/eY2tOJKzhQzbN8y9F9Z15LVD0IETIyZ/AUjd3lZ3UVlDsZ6pECHfSd91JCccw==
X-Received: by 2002:a19:5510:: with SMTP id n16mr15583615lfe.68.1545333558356;
        Thu, 20 Dec 2018 11:19:18 -0800 (PST)
Received: from ?IPv6:2001:14bb:51:a4c8:5c24:24d7:ca5f:e7d2? (dmhwpt3bffxn8z3-j6k-4.rev.dnainternet.fi. [2001:14bb:51:a4c8:5c24:24d7:ca5f:e7d2])
        by smtp.gmail.com with ESMTPSA id k11-v6sm4320458ljk.40.2018.12.20.11.19.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 11:19:17 -0800 (PST)
Subject: Re: [PATCH 04/12] __wr_after_init: x86_64: __wr_op
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>, igor.stoppa@huawei.com,
        Nadav Amit <nadav.amit@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        linux-integrity@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20181219213338.26619-1-igor.stoppa@huawei.com>
 <20181219213338.26619-5-igor.stoppa@huawei.com>
 <20181220184917.GY10600@bombadil.infradead.org>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <d5e8523a-3afd-d992-1af3-b329985c5ed5@gmail.com>
Date:   Thu, 20 Dec 2018 21:19:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181220184917.GY10600@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/12/2018 20:49, Matthew Wilcox wrote:

> I think you're causing yourself more headaches by implementing this "op"
> function.  

I probably misinterpreted the initial criticism on my first patchset, 
about duplication. Somehow, I'm still thinking to the endgame of having 
higher-level functions, like list management.

> Here's some generic code:

thank you, I have one question, below

> void *wr_memcpy(void *dst, void *src, unsigned int len)
> {
> 	wr_state_t wr_state;
> 	void *wr_poking_addr = __wr_addr(dst);
> 
> 	local_irq_disable();
> 	wr_enable(&wr_state);
> 	__wr_memcpy(wr_poking_addr, src, len);

Is __wraddr() invoked inside wm_memcpy() instead of being invoked 
privately within __wr_memcpy() because the code is generic, or is there 
some other reason?

> 	wr_disable(&wr_state);
> 	local_irq_enable();
> 
> 	return dst;
> }
> 
> Now, x86 can define appropriate macros and functions to use the temporary_mm
> functionality, and other architectures can do what makes sense to them.
> 

--
igor
