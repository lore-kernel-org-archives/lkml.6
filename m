Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4C0C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 07:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ABBC2098A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 07:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=benyossef-com.20150623.gappssmtp.com header.i=@benyossef-com.20150623.gappssmtp.com header.b="q4oqcBuy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ABBC2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=benyossef.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbeJKPFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 11:05:16 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:37632 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbeJKPFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 11:05:16 -0400
Received: by mail-vs1-f68.google.com with SMTP id r83so7616332vsc.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 00:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eDbMI/mnCCRQww8mv+1LWyLg3KVyBDYESaHVMKoJFbs=;
        b=q4oqcBuyoiw98ii3zYwTzEQWCMRlXcihAwUUGK4W2x9tCEplQ8K8d5Lb2pCzfe9dKI
         XoYtcWSHNPJ0UH220HjcEc/yW4ogmm9Lxjho6Kl7Qx/woaExvSg7H0KgJksau4nmXu5f
         JIiQQBvgdB8DoZ56ueNvPUXn69zDuafEMOmLIlQW5zzdnPuAQv7mbioISgU2S7gUmO0q
         REtqzRqu/UEflH5FbkLhTocJNSXwGdx57Y6cMGLSNL7zr4masE2H9pQ4o8XygXWuy0cw
         iUTiMlHY1E1ktFKd/5dwi9eh0YMiMHA3kSrQN8eaS9r6/7UGxgTw/+MyvFas2DOv3NEj
         DC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eDbMI/mnCCRQww8mv+1LWyLg3KVyBDYESaHVMKoJFbs=;
        b=CSuz4pnBI6HiVkuAcwqavA00aeYIY9vUNnn0PkF8gxHTFpXK00AMWG2WB/D0Wiiwl1
         OloVv/QcesN+MHs7CpjXipqggthQHcB8HawJywVkZeMf9KsZfx7ByLXP6NGylSbgQyGb
         KHVmhJthHaS6mLn57sayFZz6Ju/gYgXe+kkz4Vg+pQg6LCNMl0//3vM9w558fV/Rxdq2
         CScE5zDxVaHt3xvRL/ViQnVWe0gaPWxSuUCZN2EF0hJ+FAsxCvNJlLwtU/rHmXFNIdYk
         LPuEWmreJm513y8LfQgovyiM4/wY8gzSumKXQ6wML+2+T/KrU/raY2p65Af55gc9s1m0
         GBpA==
X-Gm-Message-State: ABuFfohPqVS2/g4Q8a5VfMbLt3yFridzj+zlD7x/ooQ4Zm89aP07Figy
        Emdj9pBXm9N8sB0Eo332GBZt6GxRBTvPELtmvewUng==
X-Google-Smtp-Source: ACcGV61qf3sJ2eXYUiBGLXmscM9Gw4P/tQaLXLxBKfq3vGsUHLgzEITGYCcnyK+Ea2YiG7LVuEwNS+bureAc2beVOUk=
X-Received: by 2002:a67:d69e:: with SMTP id o30mr168458vsj.11.1539243553154;
 Thu, 11 Oct 2018 00:39:13 -0700 (PDT)
MIME-Version: 1.0
References: <20181010214006.21304-1-natechancellor@gmail.com>
In-Reply-To: <20181010214006.21304-1-natechancellor@gmail.com>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Thu, 11 Oct 2018 10:39:01 +0300
Message-ID: <CAOtvUMcwR6r24u0XEm4o_C5oPW-8wyuiQ++YHs=gioP9C4Wm1A@mail.gmail.com>
Subject: Re: [PATCH] crypto: ccree - avoid implicit enum conversion
To:     natechancellor@gmail.com
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        ndesaulniers@google.com, Yael Chemla <Yael.Chemla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

On Thu, Oct 11, 2018 at 12:44 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns when one enumerated type is implicitly converted to another
> and this happens in several locations in this driver, ultimately related
> to the set_cipher_{mode,config0} functions. set_cipher_mode expects a mod=
e
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
>                 set_cipher_config0(desc, HASH_DIGEST_RESULT_LITTLE_ENDIAN=
);
>
> drivers/crypto/ccree/cc_aead.c:1643:30: warning: implicit conversion
> from enumeration type 'enum drv_hash_hw_mode' to different enumeration
> type 'enum drv_cipher_mode' [-Wenum-conversion]
>         set_cipher_mode(&desc[idx], DRV_HASH_HW_GHASH);
>
> Since this fundamentally isn't a problem because these values just
> represent simple integers for a shift operation, make it clear to Clang
> that this is okay by making the mode parameter in both functions an int.

Thank you. We actually had a patch fixing this in the pipeline but
your fix is simpler. :-)

Acked-by: Gilad Ben-Yossef <gilad@benyossef.com>

Gilad



--=20
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!
