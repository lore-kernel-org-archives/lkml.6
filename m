Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 7hBMNnstGlsPKwAAmS7hNA
	; Fri, 08 Jun 2018 07:17:15 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id BD306607E4; Fri,  8 Jun 2018 07:17:15 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXrnp6un"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D78A5607A4;
	Fri,  8 Jun 2018 07:17:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D78A5607A4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752670AbeFHHRJ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 03:17:09 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:37475 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751255AbeFHHRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 03:17:07 -0400
Received: by mail-pl0-f65.google.com with SMTP id 31-v6so7755969plc.4;
        Fri, 08 Jun 2018 00:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=bVlLkNWGI07mJt+xIMbCvoa7h5wIO2IC6cmMOKp8lmA=;
        b=kXrnp6unWgGU7Snc5xwWV0KezWFG2loQTtH5rATLm08YvQaN5JYM09QCnwKnVeXhoF
         +zmOyJBL0fR3pVMPzkdHADBsQ8jpd671AtplJ0Xg4PZ7QpALEH3SQkroDmXbmtbtZW9E
         I60ZbGb87wpwUOBsYVi2zTECnoSNHCFOnbVoTVezhoPMmoATjD95Aa1YwjzGFgrGybat
         XoTtn/EdiXrrFO7ahu5rC3VQdPJamqaY5poEA+XQ3m/09YHYJUwqwYBamNkV/9WBkBVm
         6uAK3fzNIV/4QB4WciwdxarqF00k6D316jwPVCAVWsnnc8ETdzTQgbrZmYd4AIUrqTzW
         Yh+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=bVlLkNWGI07mJt+xIMbCvoa7h5wIO2IC6cmMOKp8lmA=;
        b=hiDq61PTcPJ2wmm9a+qwuR+OvfaX1T9yuGeRH7xCwJR6rFHbqBhra68ooTCEliB9yL
         lFJ7gVqh1w3KaZUNe1h+skir/MqysONsBBEcaMdUIvIcj+Zln8vgQz2uPVk7nlGgB49I
         X70QUb6o9vNE1NUDrs3PW8egQqEzMVQtM7WedBkPHFTH+ADGTyyN8LVSl4sD9p/jxent
         cQABwGyZSrx8WYqGbv/x409iNiPsCnyiXCLfD2uXD10HQj7Xg5Vs5jq7JDdY0XpWUQOc
         k2p0isxRDUxIeBTS3gBaIJS4ARqzauduLEO42rgEWG4XJsozuM1XwVN+ArQDYep8COWa
         hg5g==
X-Gm-Message-State: APt69E24i4F0FzXDk8Hl2qjdyZcmMIAkJh/ArdgT3AlHlfwvLw0WvD6s
        h3zZvwjYJypvhXKT0undqAbKjG54
X-Google-Smtp-Source: ADUXVKJs7EQNCqs/Wj7UzcUMJ/FZYE8UyLKGPVQYZw9ths7IfGGG6kcY2ezbfp5eHL+alUCLF/AAkw==
X-Received: by 2002:a17:902:bd8f:: with SMTP id q15-v6mr5194858pls.161.1528442226870;
        Fri, 08 Jun 2018 00:17:06 -0700 (PDT)
Received: from [0.0.0.0] (67.216.217.169.16clouds.com. [67.216.217.169])
        by smtp.gmail.com with ESMTPSA id a9-v6sm41919703pgt.57.2018.06.08.00.17.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 00:17:06 -0700 (PDT)
Subject: Re: [PATCH] crypto: arm64/aes-blk - fix and move skcipher_walk_done
 out of kernel_neon_begin,_end
To: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, jia.he@hxt-semitech.com
References: <1528441502-26425-1-git-send-email-hejianet@gmail.com>
From: Jia He <hejianet@gmail.com>
Message-ID: <ed457db3-2e3b-3f2d-7302-df6d70432e58@gmail.com>
Date: Fri, 8 Jun 2018 15:16:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1528441502-26425-1-git-send-email-hejianet@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+ Ard Biesheuvel]

On 6/8/2018 3:05 PM, Jia He Wrote:
> In a arm64 server(QDF2400),I met a similar might-sleep warning as [1]:
> [    7.019116] BUG: sleeping function called from invalid context at
> ./include/crypto/algapi.h:416
> [    7.027863] in_atomic(): 1, irqs_disabled(): 0, pid: 410, name:
> cryptomgr_test
> [    7.035106] 1 lock held by cryptomgr_test/410:
> [    7.039549]  #0:         (ptrval) (&drbg->drbg_mutex){+.+.}, at:
> drbg_instantiate+0x34/0x398
> [    7.048038] CPU: 9 PID: 410 Comm: cryptomgr_test Not tainted
> 4.17.0-rc6+ #27
> [    7.068228]  dump_backtrace+0x0/0x1c0
> [    7.071890]  show_stack+0x24/0x30
> [    7.075208]  dump_stack+0xb0/0xec
> [    7.078523]  ___might_sleep+0x160/0x238
> [    7.082360]  skcipher_walk_done+0x118/0x2c8
> [    7.086545]  ctr_encrypt+0x98/0x130
> [    7.090035]  simd_skcipher_encrypt+0x68/0xc0
> [    7.094304]  drbg_kcapi_sym_ctr+0xd4/0x1f8
> [    7.098400]  drbg_ctr_update+0x98/0x330
> [    7.102236]  drbg_seed+0x1b8/0x2f0
> [    7.105637]  drbg_instantiate+0x2ac/0x398
> [    7.109646]  drbg_kcapi_seed+0xbc/0x188
> [    7.113482]  crypto_rng_reset+0x4c/0xb0
> [    7.117319]  alg_test_drbg+0xec/0x330
> [    7.120981]  alg_test.part.6+0x1c8/0x3c8
> [    7.124903]  alg_test+0x58/0xa0
> [    7.128044]  cryptomgr_test+0x50/0x58
> [    7.131708]  kthread+0x134/0x138
> [    7.134936]  ret_from_fork+0x10/0x1c
> 
> Seems there is a bug in Ard Biesheuvel's commit.
> Fixes: 683381747270 ("crypto: arm64/aes-blk - move kernel mode neon
> en/disable into loop")
> 
> [1] https://www.spinics.net/lists/linux-crypto/msg33103.html
> 
> Signed-off-by: jia.he@hxt-semitech.com
> ---
>  arch/arm64/crypto/aes-glue.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/crypto/aes-glue.c b/arch/arm64/crypto/aes-glue.c
> index 253188f..e3e5095 100644
> --- a/arch/arm64/crypto/aes-glue.c
> +++ b/arch/arm64/crypto/aes-glue.c
> @@ -223,8 +223,8 @@ static int ctr_encrypt(struct skcipher_request *req)
>  		kernel_neon_begin();
>  		aes_ctr_encrypt(walk.dst.virt.addr, walk.src.virt.addr,
>  				(u8 *)ctx->key_enc, rounds, blocks, walk.iv);
> -		err = skcipher_walk_done(&walk, walk.nbytes % AES_BLOCK_SIZE);
>  		kernel_neon_end();
> +		err = skcipher_walk_done(&walk, walk.nbytes % AES_BLOCK_SIZE);
>  	}
>  	if (walk.nbytes) {
>  		u8 __aligned(8) tail[AES_BLOCK_SIZE];
> 

-- 
Cheers,
Jia
