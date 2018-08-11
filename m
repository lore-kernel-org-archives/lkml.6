Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2120C46464
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 02:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B4DA223DC
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 02:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pp2z2xJ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B4DA223DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=twiddle.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbeHKFE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 01:04:27 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38041 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbeHKFE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 01:04:27 -0400
Received: by mail-pf1-f196.google.com with SMTP id x17-v6so5312485pfh.5;
        Fri, 10 Aug 2018 19:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wDw+JblCaadP75M6mLwIy7gYuAzotitPgHhtAIhqJtA=;
        b=Pp2z2xJ1DP6Aj6ZX0g1uKPzFJ/KLxRGTRYLnC2Qb6vub3ZeHaoEf01/lsVzUdzKxBn
         qbNeugbt+FXYTXTOEKCBhIfDMTAwEjt84hrLm/IoK3eo2KleJm96304fxKmhR3VxyuAP
         OcPSRgvfK2XfQRZ+LglZbYecQ7ARTXO69I3NjdedADzgdHHbVionnGPm45t8+EWjWdk+
         VBsvouP/dI7Uf10EwEdq79PXo2Jwj1QuohoSaULG/9fIYnj6J3jrQOEtHOJDgp8tEcJ3
         tI9EzUIniv/ppY9zvT7EYPDGzaCjwWlCPY1vfY7aMJRN1BxtdFROeAfoX7m6z0kjVC/n
         iXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=wDw+JblCaadP75M6mLwIy7gYuAzotitPgHhtAIhqJtA=;
        b=J87QJp9n9BVFC0qCBWaTl9e48u3Qj4FJq7rYM5GL3CRVdXbGzuayaV4FK8r4bnWkpe
         /evkRWgX+O1H+R70o5ztrgsGVSDC/oXkM110+CjEEJfr3/p77RzPZLx67SMx5ov58Fl2
         uZ6G6Q9axVAwXMsEMmcDjJihnUQ1oOKnDW3moTjIuPmzQqdHgY0G0ULnayQBqA7/w9Kc
         eHg+yt12eRsB0PNrq6M2cEq5h3wemHUhR8y50tdz5LXxavPC2JrQDmNYSUzRBkdBnUA6
         LLhcnBGyagRRRbwbOU8MUMGYW+WD4oUejnIPMWVfwDwY9AeYwQjsOvSgXNQD7m1EiFrs
         /Q6Q==
X-Gm-Message-State: AOUpUlEzT5V081/LOQ5LqGR4Z51dYksK08nQSmsN6A6FHq8zq/1vXlTr
        hdnyhrDXDiYElGx7A/9rWpI=
X-Google-Smtp-Source: AA+uWPxC7imj9z6Tj9dyLwlOmhT01Nq7KOtYsc+HDxY10AVfyrRnaAn3Ltswl1VCvJ1AtBPQuigb4Q==
X-Received: by 2002:a62:2c95:: with SMTP id s143-v6mr9495552pfs.3.1533954718020;
        Fri, 10 Aug 2018 19:31:58 -0700 (PDT)
Received: from cloudburst.twiddle.net (97-113-8-179.tukw.qwest.net. [97.113.8.179])
        by smtp.googlemail.com with ESMTPSA id 21-v6sm14767543pgx.20.2018.08.10.19.31.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 19:31:57 -0700 (PDT)
Subject: Re: [PATCH 3/6] alpha: Unify the not-implemented system call entry
 name
To:     Al Viro <viro@ZenIV.linux.org.uk>,
        Firoz Khan <firoz.khan@linaro.org>
Cc:     linux-alpha@vger.kernel.org, ink@jurassic.park.msu.ru,
        mattst88@gmail.com, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        arnd@arndb.de, deepa.kernel@gmail.com
References: <1531736638-15294-1-git-send-email-firoz.khan@linaro.org>
 <1531736638-15294-4-git-send-email-firoz.khan@linaro.org>
 <20180811000455.GC6515@ZenIV.linux.org.uk>
From:   Richard Henderson <rth@twiddle.net>
Openpgp: preference=signencrypt
Autocrypt: addr=rth@twiddle.net; prefer-encrypt=mutual; keydata=
 xsBNBFGuLC8BCADcAoWcnW9lTsDMzbO3MBU+KbiGaj5JPatEUscRDkQYM2fyNjJp2tIWDK5a
 n4yngeXB3eX61WbYR3QraRK8mlYLGxyAdHMEQfPipbqf3TmN043fssT2bc82ApJcs1zvLYgI
 rhMht7Dck7A0wNC1jo+ZjVVFig5gDTN7gOzaAdBtV8tVNUddwkLzzaGpfihhSD6U46NdqKOG
 Wlnn6TrkMy0QGdQ5NaXHkRlUjnnUTSW/nKfoxD+EI+A9V4sYOd8mc/TL4aJh/i/AiU57eLbo
 n17uQI6/VTWDUWl8USiz4x9c8vmqlywLx00tAFxxoRWqk4KVJlj+Sh0up/D/sJ+vPpgBABEB
 AAHNI1JpY2hhcmQgSGVuZGVyc29uIDxydGhAdHdpZGRsZS5uZXQ+wsCBBBMBAgArAhsDBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgAUJC7UHogUCWaDNVgIZAQAKCRCtEnDMTdAnm9N5CADO
 cB8F/SudJ72IupxQf40hbJdBK176+gb3sHMsixyLtrU59lee+lIM1OZmlNjsnCYmiSnbA5ks
 Q7p0HfO7DgdmfLzcK6xsHZukqSZy5LByw348Y913ZyjOrJZFdPP7kDg1MnqRqH4+3ZdzxV4y
 eYBWFU9GYMIF06JbUubossOOO4ArNVZbnIPu8Vn2tDZVVqsCBqkoCSBMj519xrvyOu5z4mHS
 LkCglXmVDOXMbqLuNAC3rfNXSnyM4hYkLUyfALJlAAy1Ro+jUqYhu7XUFV/MiwRuFMh5GbtY
 Urkx7tqsWQXLT3GeDk/LqvpWJQwk4cHHckYjRih+70CHIenm81PVzsBNBFGuLC8BCACyEx3x
 94HIkTX0CHu2sA0w75+h9wuoA8ggJ7+S4ri0y2YsijWad5TTt6z6MMiqxk9kSA5bppaj4HXh
 86hBF/dWCtMpNr3Rb8FNOKyeA/qkYHVD6HiAiw9c6D8Dr9hWmOk3/HSmGrNURxeUFOckDXsv
 I+yGGKBNshj59j7QZr7ZiuIi2rWlBL8dFN/OWa/o3x7HKsE4k6K8ngwvCKP/QbDLwLLBOWH+
 VEUtpyeyxTr3OJ47ECTxdYvXoAV2iJaKr+6doVQiiR5eVFiMYrUPUECJeolOCwqc/JlWE18L
 +PCAFaW1H+/mpPVfSpN4wnkJ5cQiQVB41IaCM4p20iRzx7ZJABEBAAHCwGUEGAECAA8CGwwF
 AlmgzYEFCQu1CEoACgkQrRJwzE3QJ5s7rggAwABzDAGrZ6uWsMxg5PeiiAYPy6LBnCBJSpB5
 Tfy5jH8QTmLfXW+u4Ib4sWXG7PYNR7sIrtqUHjRqXLVXrSnBX9ASGcYw/Xil45khW6LsRpO1
 prHv9gkwQfa6fTiWXVfSfm2Nant6u02q+MaYtQpCVTiz/9ki4FfftUwUHFLU0MhIQogjd11y
 /E08RJsqBwaHQdt14PwU1HphDOzSkhOXRXQLSd3ysyeGUXvL+gqQoXl5XYdvk8IId4PoJRo4
 jcyJ4VbnldvXh5gdGhFA/f9JgkLk9tPW+C3wNtNWyRUq8azR9hF2fg2HJUf4IXQlIu8OOgh1
 VcROBqvtH3ecaIL9iw==
Message-ID: <98937991-cefa-b7f3-11c3-12727b3159b1@twiddle.net>
Date:   Fri, 10 Aug 2018 19:31:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180811000455.GC6515@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/10/2018 05:04 PM, Al Viro wrote:
> Once upon a time it used to have a C part that printed a warning
> about unimplemented OSF syscalls.  That's what it's been doing
> all over the OSF syscall range, while the native Linux syscall
> range uses sys_ni_syscall().
> 
> With those warnings about unimplemented OSF syscalls gone (circa 2.4),
> alpha_ni_syscall() has shrunk to that little bit of asm and the
> only reason it hasn't been replaced with sys_ni_syscall() everywhere
> is that extra twist needed in case of syscall #0.
> 
> Let's keep it only for syscall #0 and replace the rest with sys_ni_syscall.
> And use sys_ni_syscall for "number out range" in ptraced-call case, as
> we'd been doing for normal codepath since 2.1.86...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Acked-by: Richard Henderson <rth@twiddle.net>


> +++ b/arch/alpha/kernel/entry.S
> @@ -473,7 +473,7 @@ entSys:
>  	bne     $3, strace
>  	beq	$4, 1f
>  	ldq	$27, 0($5)
> -1:	jsr	$26, ($27), alpha_ni_syscall
> +1:	jsr	$26, ($27), sys_ni_syscall
>  	ldgp	$gp, 0($26)
>  	blt	$0, $syscall_error	/* the call failed */
>  	stq	$0, 0($sp)

Once upon a time I had a patch to make the hint
be sys_gettimeofday, as the most common syscall.
Dunno what happened to that.

But I must guess that an unimplemented syscall has got
to be the anti-hint of the ... long-ass-time-frame.


r~
