Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51BBC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 679442086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r+Z/dNgD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 679442086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbeJKHNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 03:13:48 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37343 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbeJKHNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 03:13:47 -0400
Received: by mail-pf1-f193.google.com with SMTP id j23-v6so3413557pfi.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 16:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NOnNKA+BPQHDXkQ+f4bV8YHQFlqZSI5gcRRte4E5qS0=;
        b=r+Z/dNgDNdTgG1Bw2leR6ELMQJr3jQXUbwBSjCHjqX+fOYgNl0Q3MyxlEO62cgxH9d
         LJXbeLVDUUSv+qdYWtSK8WpdU8kpIK7QXrshXkuUaXla0GaFOd+lPNiLmALtv9MMhkkL
         aWrbw75UpGgwfJlrY5VKMVl9YANyXCqiXeLJctpW1JPxnX7Tu3GViJea6RQ5x8WfnP7J
         riMpCWokPDef5rak0Ry9k+LwbdPjh5D8YPQyr42dTIf4ZQYmpHzCz4LZSyAX8f/ozUTH
         HpE29Zq0OrXL4Bg9pPGmvoQ78RnoEkKcoQ5T+sjWgrwwWlqe4r0bwPxavTcVxgTQ6kwx
         oqLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NOnNKA+BPQHDXkQ+f4bV8YHQFlqZSI5gcRRte4E5qS0=;
        b=JuaQVS6kJBiWS9s7l92BacVob/quGRaCCmi382pwH7aZzL8JyY7h6sWRca96WH0BDG
         etUk680ckD7gK44Kl1NM+QRg2++i42qrY3nKAQyy8p2VuDS38rLO4TMJi9IQtAmGfTlU
         MsMr/Hil4QXQUw8ACHBuTwS6N5oA3uya+4cnIUlRcz0zbflCFJ0oznQ/bAusO/KidP2c
         CdurWF/Rwsnve7Mbt8s5WAsxSLsgA57S1Hbsjv+eMYrDgUWNzsP5o0RFhUpXTWSCMCxA
         EFZ4KxfKJZIHzGRDiGQzR2WupDCQtAANqxIoG7pk2CrOznbIOr21VIOH/LQwrlaa7eiZ
         u9xw==
X-Gm-Message-State: ABuFfoi+hgvotPkn8n+SHROagcuIUT14G20VULUiVxYKJ0y/UF13YTyS
        A+I1znFaHBdvEf13RzJqiWUh4CE3C0vXNjQwiDq3pzQ106c=
X-Google-Smtp-Source: ACcGV621ezPJzHf85oVxbL8t9MoH0ySogCq5XldyuzGFhsMzI10O+U3frzkYvPTadl3vrfgU3ZUmn/mO/Se+eji+2qI=
X-Received: by 2002:a63:df06:: with SMTP id u6-v6mr31472276pgg.202.1539215358111;
 Wed, 10 Oct 2018 16:49:18 -0700 (PDT)
MIME-Version: 1.0
References: <20181010214006.21304-1-natechancellor@gmail.com>
In-Reply-To: <20181010214006.21304-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 10 Oct 2018 16:49:06 -0700
Message-ID: <CAKwvOdk+JmBP4TBAG+DfhehofM0sO0vWRXbAbEifYy+T+u_SVQ@mail.gmail.com>
Subject: Re: [PATCH] crypto: ccree - avoid implicit enum conversion
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     gilad@benyossef.com, Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 2:44 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns when one enumerated type is implicitly converted to another
> and this happens in several locations in this driver, ultimately related
> to the set_cipher_{mode,config0} functions. set_cipher_mode expects a mode
> of type drv_cipher_mode and set_cipher_config0 expects a mode of type
> drv_crypto_direction.
>
> drivers/crypto/ccree/cc_ivgen.c:58:35: warning: implicit conversion from
> enumeration type 'enum cc_desc_direction' to different enumeration type
> 'enum drv_crypto_direction' [-Wenum-conversion]
>         set_cipher_config0(&iv_seq[idx], DESC_DIRECTION_ENCRYPT_ENCRYPT);
>
> drivers/crypto/ccree/cc_hash.c:99:28: warning: implicit conversion from
> enumeration type 'enum cc_hash_conf_pad' to different enumeration type
> 'enum drv_crypto_direction' [-Wenum-conversion]
>                 set_cipher_config0(desc, HASH_DIGEST_RESULT_LITTLE_ENDIAN);

$ grep -r set_cipher_config0 -n

shows a healthy mix of DESC_DIRECTION_ENCRYPT_ENCRYPT,
HASH_DIGEST_RESULT_LITTLE_ENDIAN, and DRV_CRYPTO_DIRECTION_ENCRYPT
(all enumeration values of different enums).

>
> drivers/crypto/ccree/cc_aead.c:1643:30: warning: implicit conversion
> from enumeration type 'enum drv_hash_hw_mode' to different enumeration
> type 'enum drv_cipher_mode' [-Wenum-conversion]
>         set_cipher_mode(&desc[idx], DRV_HASH_HW_GHASH);

Looks like a lot fewer call sites using DRV_HASH_HW_GHASH; same value
as DRV_CIPHER_OFB (different enum), but can a block cipher mode and a
hash be valid values for pdesc->word[4]?

>
> Since this fundamentally isn't a problem because these values just
> represent simple integers for a shift operation, make it clear to Clang
> that this is okay by making the mode parameter in both functions an int.

This also looks like the simplest fix to me, assuming the values of
all of these enums are valid for whatever pdesc->word[4] is.  Can the
maintainers explain what is CC7x-DESC what the comment makes reference
to?

>
> Link: https://github.com/ClangBuiltLinux/linux/issues/46
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>
> Alternatively:
>
> 1. The uses of DESC_DIRECTION_ENCRYPT_ENCRYPT could be replaced with
>    DRV_CRYPTO_DIRECTION_ENCRYPT since they are the same value.
>
> 2. An enum of value 2 could be added to drv_crypto_direction which is
>    what HASH_DIGEST_RESULT_LITTLE_ENDIAN is equal to (not sure what that
>    should be named).
>
> 3. DRV_HASH_HW_GHASH could be removed and replaced with DRV_CIPHER_OFB
>    since they are the same value.
>
> This patch seems to make the most sense to me given that the enums are
> just functioning as integers but I'm willing to fix this however the
> maintainers want.
>
>  drivers/crypto/ccree/cc_hw_queue_defs.h | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/crypto/ccree/cc_hw_queue_defs.h b/drivers/crypto/ccree/cc_hw_queue_defs.h
> index a091ae57f902..45985b955d2c 100644
> --- a/drivers/crypto/ccree/cc_hw_queue_defs.h
> +++ b/drivers/crypto/ccree/cc_hw_queue_defs.h
> @@ -449,8 +449,7 @@ static inline void set_flow_mode(struct cc_hw_desc *pdesc,
>   * @pdesc: pointer HW descriptor struct
>   * @mode:  Any one of the modes defined in [CC7x-DESC]
>   */
> -static inline void set_cipher_mode(struct cc_hw_desc *pdesc,
> -                                  enum drv_cipher_mode mode)
> +static inline void set_cipher_mode(struct cc_hw_desc *pdesc, int mode)
>  {
>         pdesc->word[4] |= FIELD_PREP(WORD4_CIPHER_MODE, mode);
>  }
> @@ -461,8 +460,7 @@ static inline void set_cipher_mode(struct cc_hw_desc *pdesc,
>   * @pdesc: pointer HW descriptor struct
>   * @mode: Any one of the modes defined in [CC7x-DESC]
>   */
> -static inline void set_cipher_config0(struct cc_hw_desc *pdesc,
> -                                     enum drv_crypto_direction mode)
> +static inline void set_cipher_config0(struct cc_hw_desc *pdesc, int mode)
>  {
>         pdesc->word[4] |= FIELD_PREP(WORD4_CIPHER_CONF0, mode);
>  }
> --
> 2.19.1
>


-- 
Thanks,
~Nick Desaulniers
