Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5737C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB1B2089A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGW+nFFl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AB1B2089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbeKHUr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 15:47:56 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35434 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbeKHUr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 15:47:56 -0500
Received: by mail-wm1-f66.google.com with SMTP id t15-v6so812193wmt.0;
        Thu, 08 Nov 2018 03:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S6FLKX2nPrhTp2cff3vvhcZgwpMwhGkG+At5DyiLUPw=;
        b=QGW+nFFlGMldUIZuOPvG8D1IH0qVYrIWbaJYjLYhv4oTX1/oVktvNNKvy6uuohqGNW
         M12d+C3CnAJQALWybxhoOy9poIVaaHASs5++NrbnepIHQwg+j59/atv84B4dCg6WXeX4
         B7Fx7e1u/6KBZeoQd5fa6Z7r+dBmfCWmmpn5WuOtXshUS8K709vCPLXe/bjFZ1cH/7a+
         dBZCK6xnTxPH35hpuf+tTtj4c3+lceB8u8NVrrYGjU8JpBKkLKcI3lKkUIfo3PIRRMsY
         y4Dg1AUoW0bd9iczybsCyCjvs+7z3N0qoEFa5cSaGk1V+cZHF5Mac5DaxsAsOMf9XNNU
         75EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=S6FLKX2nPrhTp2cff3vvhcZgwpMwhGkG+At5DyiLUPw=;
        b=gjzLcGlT70XZuZRHlnTTI8e0TwIZTAy2oUwIkqlyv5JPH+ghlsD6EucvolFd3DxEM2
         RVWHwRGn9DOgKIS2Lk20bji/2gboUuKl9wd2/jWVVkeI9i4JXdoothxzoxqKek6aXhh1
         kCxp8hkEBfrZTxAhrg2uKVV1grUhWmRWt4kpGKbuwHP+X3AagMrhkg640/Qp66ViyRSL
         pyPmqzlas5f2ss7ar804YaBdgctSVRLVHxfukrNC9yiYJR/U359SiDBhWfg1cAEW1U0c
         SyjWr0mLVZfK26JZJk+nsCK+xIXtCUYtEYzYojSl/zG5t8Sb3uaYxnQJpOb6HXcst+QG
         uFxQ==
X-Gm-Message-State: AGRZ1gID1J3mhCunfU/2/sir7GHnHmoyE+3aQkRpfDSHIwzHEHeXCZP+
        Ikx3Qdcrwv6OTGzjU4Lc7zQ=
X-Google-Smtp-Source: AJdET5fX6bDIocHSka8gJFm7630XQgtS3TEYtI24sLDKiTvLp/qD5p5CsuvE1/exqM1OZGTy1xiM/g==
X-Received: by 2002:a1c:7ec9:: with SMTP id z192-v6mr873076wmc.43.1541675574910;
        Thu, 08 Nov 2018 03:12:54 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:d044:7580:7601:a7bd? ([2001:b07:6468:f312:d044:7580:7601:a7bd])
        by smtp.googlemail.com with ESMTPSA id 65-v6sm1266052wmj.1.2018.11.08.03.12.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 03:12:54 -0800 (PST)
Subject: Re: [PATCH 17/23] x86/fpu: Eager switch PKRU state
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20181107194858.9380-1-bigeasy@linutronix.de>
 <20181107194858.9380-18-bigeasy@linutronix.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
Message-ID: <1d4b7b5c-9c3d-1ef5-3336-b7945b7978d4@redhat.com>
Date:   Thu, 8 Nov 2018 12:12:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181107194858.9380-18-bigeasy@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2018 20:48, Sebastian Andrzej Siewior wrote:
> index 375226055a413..5b33985d9f475 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -811,7 +811,7 @@ void fpu__resume_cpu(void)
>   *
>   * Note: does not work for compacted buffers.
>   */

The comment is wrong, which was already the case before but it becomes a
bit more important if the function is used outside its module.

However, why not use get_xsave_addr?  I don't see why it is important to
skip the checks, and if it is it probably deserves a comment. "Raw" and
double underscores in the function name is scary...

Paolo

> -static void *__raw_xsave_addr(struct xregs_state *xsave, int xfeature_nr)
> +void *__raw_xsave_addr(struct xregs_state *xsave, int xfeature_nr)
>  {
>  	if (!xfeature_enabled(xfeature_nr)) {
>  		WARN_ON_FPU(1);

