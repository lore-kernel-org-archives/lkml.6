Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E24C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D650327EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSz/caJD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D650327EA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936283AbeF2LrJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 07:47:09 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:51131 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932615AbeF2LrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 07:47:05 -0400
Received: by mail-wm0-f45.google.com with SMTP id v25-v6so896199wmc.0;
        Fri, 29 Jun 2018 04:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HRbL3PlIctTXEEN/IvgYP1ccGi6kOzv+Ii52FofKrgQ=;
        b=hSz/caJDZQtePfFQUvWpHFzHhb79kKkMI7YBaxgtoycVbKWk+aOpQV5ahrY6+X/uij
         7Yyg4thofqx6F+JA+zQVQAyOqxulw8hO8tXlQGDQ9vlpOOIm5tbKGmo/hAETyLv6H93a
         pszx2VVZZwZ5zoY4zClV6VRQzEUElLSnxafz1+q/wKSbWciyc+0lI/5mmMCp/hWg4kfH
         3Z/uymSzWhTpH7QprbCbKlbgVvCilLSiaGj6yEvGAJE7hOJ3WhOvmqCFJqzY3GXSe+qC
         ZWuHXvnzp+Tz2ul8ft7Q9s1Nmmy5hnVq8H5nTpvcUdQK8QI7pc9N47BnWAvROmJzOnuM
         WjWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=HRbL3PlIctTXEEN/IvgYP1ccGi6kOzv+Ii52FofKrgQ=;
        b=oXVOCjnx3zLx4NlPM0RZE93w3qLrAc1wQxixmFdS2InUIivIhLFwwlGXdGw8lQNw2j
         +RESFqZcC6GZfQDKZ8gGRPLLaFCvazTtB1U2NZeYhCLix93CBp/LAaRqKZ5JD6ZorYbe
         SSAPnSQCjWHug1R06iFkeuMa1CsTEICJw+n/VklyuOEwVK08fouHGlPoueZ7fskX+38N
         qQQAfktwpkfr8vhb7JRkhf7m/Hjq2l1z8nho6h3OVbkXUG92Qs3Ay+50O64a8KMC0KtU
         tZRO52YJk2Z2KUb5rosYOh2DUGQCD/YXWqbJDLh/FcFgxYCxxu4l62RwP/OKqjc1zQ8s
         khRw==
X-Gm-Message-State: APt69E2N6umgExD/UV/0FOJZ2Yz5PCrw+R5WaN7myYLIqRFVUwjpyRmX
        BmEIq0FhY9iMZJchBZgohyyKVZm5
X-Google-Smtp-Source: AAOMgpe6HAFrxhELDcVb+w+i1z6OkstB+z8hJK4WS9N+86bzNvtgkGAebzBSgynWEciuVuQ/XJhxdA==
X-Received: by 2002:a1c:f906:: with SMTP id x6-v6mr1573097wmh.63.1530272824108;
        Fri, 29 Jun 2018 04:47:04 -0700 (PDT)
Received: from [192.168.10.165] ([82.84.124.111])
        by smtp.googlemail.com with ESMTPSA id r14-v6sm8719390wrl.4.2018.06.29.04.47.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 04:47:02 -0700 (PDT)
Subject: Re: [PATCH] kvm: implement VEX prefix decoder, bextr/andn
To:     Mason Lee Back <masonleeback@gmail.com>
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180626121449.30353-1-masonleeback@gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
Message-ID: <166497ae-c4d8-54f4-55a6-57a5f2c04023@redhat.com>
Date:   Fri, 29 Jun 2018 13:47:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180626121449.30353-1-masonleeback@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, I have some comments on the decoding logic.

On 26/06/2018 14:14, Mason Lee Back wrote:
> +	if (ctxt->b == 0xC4 || ctxt->b == 0xC5) {

This should be exactly the condition that you are removing below:

	if ((ctxt->b == 0xc5 || ctxt->b == 0xc4) &&
	    (mode == X86EMUL_MODE_PROT64 || (ctxt->modrm & 0xc0) == 0xc0))

so that you don't need the "reinterpret as LES or LDS" todo.  It should also
be moved earlier, right after done_prefixes.  The existing code starting
at

	/* Opcode byts(s).  */

and ending just before

	ctxt->d = opcode.flags;

will become the "else" branch.

Otherwise looks at least... sane. :)

Paolo

> +		ctxt->vex.prefix = ctxt->b;
> +		if (ctxt->b == 0xC4) {
> +			ctxt->vex.value = insn_fetch(u16, ctxt);
> +		} else {
> +			ctxt->vex.value = insn_fetch(u8, ctxt) << 8;
> +			ctxt->vex.r = ctxt->vex.w;
> +			ctxt->vex.w = 1;
> +			ctxt->vex.x = 1;
> +			ctxt->vex.b = 1;
> +			ctxt->vex.m = 1;
> +		}
>  
> -	/* vex-prefix instructions are not implemented */
> -	if (ctxt->opcode_len == 1 && (ctxt->b == 0xc5 || ctxt->b == 0xc4) &&
> -	    (mode == X86EMUL_MODE_PROT64 || (ctxt->modrm & 0xc0) == 0xc0)) {
> -		ctxt->d = NotImpl;
> +		if (mode != X86EMUL_MODE_PROT64 && (!ctxt->vex.r || !ctxt->vex.x)) {
> +			/* todo: reinterpret as LES (0xC4) or LDS (0xC5) instruction */
> +			return EMULATION_FAILED;
> +		}
> +
> +		ctxt->rex_prefix |= ctxt->vex.r ? 0 : (1 << 2); /* rex.r */
> +		ctxt->rex_prefix |= ctxt->vex.x ? 0 : (1 << 1); /* rex.x */
> +		ctxt->rex_prefix |= ctxt->vex.b ? 0 : (1 << 0); /* rex.b */
> +		if (mode == X86EMUL_MODE_PROT64 && ctxt->vex.w) {
> +			ctxt->op_bytes = 8;
> +		}

Please set ctxt->rex_prefix too for consistency.
> +
> +		ctxt->b = insn_fetch(u8, ctxt);
> +		switch (ctxt->vex.m) {
> +		case 1:
> +			opcode = twobyte_table[ctxt->b];

"ctxt->opcode_len = 2;" missing here.

> +			break;
> +		case 2:
> +			opcode = opcode_map_0f_38[ctxt->b];

"ctxt->opcode_len = 3;" missing here.

> +			break;
> +		case 3:
> +			/* KVM doesn't support this */
> +			return EMULATION_FAILED;
> +		default:
> +			return EMULATION_FAILED;
> +		}
>  	}

