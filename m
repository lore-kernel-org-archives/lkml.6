Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989C5C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C33526195
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="V1mf639E";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XvtM44RD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C33526195
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753076AbeFYVcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 17:32:16 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:44562 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752330AbeFYVcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 17:32:15 -0400
Received: by mail-yw0-f193.google.com with SMTP id k18-v6so5298612ywm.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 14:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ao8+iP/ZXc2zh/hTSz2WGZu6mq+doZvTp3RhLWoHv3A=;
        b=V1mf639EhXuQ60Zu2r78HRRDl39WHEV92qD/yjsebwtE5e59nmmn8qhkbV8V97nw8u
         QAZ57Ab1WC8v11oZoZmwUAgxIL1nv9zPx55UH67MBVlP1w3YkjRjXbn3sESPN+TIHBT7
         tKPvCtP1BPKvesKwHBb31+X5iDJp4xBbz6SMVNKN785GzzD43kiVqvnoMH4QUs+9RhtF
         hMX0b9es+0TEK7d1nQZ76n5UrHAl/cYrKBjMmmiBzI8YFQsftympNbUcKCBCzMZQLitH
         VJ94qZv2rfbiFj8BRtoJK0PaPhYasFBh3EG8Mz3R+UqD0teUFVOFhU00bsEphQgySZ5z
         USJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ao8+iP/ZXc2zh/hTSz2WGZu6mq+doZvTp3RhLWoHv3A=;
        b=XvtM44RD6v26mVIeuwVCAsy7dXv1k8c2VPwDd1JepR7aTp4fhrp1qdX3OlVVVam/cp
         e5Z+RnZNoC9Ehv6OKBJfsVf8o1mJ98jSuZR9pn+ELM68JyATHgZqQK4lphN24Ad7rS7c
         oO7s+oK4HctrvoRuFG4KGNMlYTbvq0Fs0tHfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ao8+iP/ZXc2zh/hTSz2WGZu6mq+doZvTp3RhLWoHv3A=;
        b=ulM6nKVeqa+q33CIu50JRn5UE/EBB16saRv31aISw2G1uUlXTCtlkpVPnpSukHsaYt
         ZyTr42enxAbHbg4M9fb9RrL8asJroQi7eY0+fufayRZBvCbC3oN+/yDnb7WDEaogw02y
         gKz6gfVAdfDy7XYS9JpklQdHmcHrzXp8sO3Lzxwchgyt7SguJiqj0EtPIAdwVubMPk/i
         4VlLfdzrUSa8mSf5lonYcx7rqF5pwFfGMiP1Ur9VufgMZe5wwiN2M0cFOnnfcx+t7qWe
         G2qNhn7eUUBVYLx40aIaQCH+BLwCNhUrqatBBbVyHVstxvX6F2zBYlIsb8JOO4ulRUKB
         0vEw==
X-Gm-Message-State: APt69E21ZiRsz6/cYztwnCb8FSd58VIoCnAVlFhpIGeAdmX8qoYzvwms
        bnWOiUp2I0P6bjt720chsfat4vAVGYVMMQcO5DkjOg==
X-Google-Smtp-Source: ADUXVKJ7i0B61EUNoAcvizfGoHnjlNHdyYdAXTbK0GTWQmm+nMYcDOiSX4RUiTuSC/qZ8NbJy9098XOnNsmRDEFfhi4=
X-Received: by 2002:a81:3b04:: with SMTP id i4-v6mr6486270ywa.38.1529962334364;
 Mon, 25 Jun 2018 14:32:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Mon, 25 Jun 2018 14:32:13
 -0700 (PDT)
In-Reply-To: <4d9f90abbf87539d3588f88117806f76c6826030.camel@perches.com>
References: <20180625211026.15819-1-keescook@chromium.org> <20180625211026.15819-2-keescook@chromium.org>
 <4d9f90abbf87539d3588f88117806f76c6826030.camel@perches.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 25 Jun 2018 14:32:13 -0700
X-Google-Sender-Auth: YfSQCYBgxvlEQhtB7rqTQJd1BeA
Message-ID: <CAGXu5jLbRdZVFqqzKEndogOktfTecBDxyUPvb-=+mgTmQ65v0Q@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] crypto: xcbc: Remove VLA usage
To:     Joe Perches <joe@perches.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        Alasdair Kergon <agk@redhat.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Lars Persson <larper@axis.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, qat-linux@intel.com,
        dm-devel@redhat.com, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 2:23 PM, Joe Perches <joe@perches.com> wrote:
> On Mon, 2018-06-25 at 14:10 -0700, Kees Cook wrote:
>> In the quest to remove all stack VLA usage from the kernel[1], this uses
>> the maximum blocksize and adds a sanity check. For xcbc, the blocksize
>> must always be 16, so use that, since it's already being enforced during
>> instantiation.
>
> Is it time yet to change this warning from 'make W=3' to W=1?
> ---
>  scripts/Makefile.extrawarn | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
> index 8d5357053f86..27ba478d40cd 100644
> --- a/scripts/Makefile.extrawarn
> +++ b/scripts/Makefile.extrawarn
> @@ -29,6 +29,7 @@ warning-1 += $(call cc-option, -Wmissing-include-dirs)
>  warning-1 += $(call cc-option, -Wunused-but-set-variable)
>  warning-1 += $(call cc-option, -Wunused-const-variable)
>  warning-1 += $(call cc-option, -Wpacked-not-aligned)
> +warning-1 += $(call cc-option, -Wvla)
>  warning-1 += $(call cc-disable-warning, missing-field-initializers)
>  warning-1 += $(call cc-disable-warning, sign-compare)
>
> @@ -52,7 +53,6 @@ warning-3 += -Wpointer-arith
>  warning-3 += -Wredundant-decls
>  warning-3 += -Wswitch-default
>  warning-3 += $(call cc-option, -Wpacked-bitfield-compat)
> -warning-3 += $(call cc-option, -Wvla)
>
>  warning := $(warning-$(findstring 1,
> $(KBUILD_ENABLE_EXTRA_GCC_CHECKS)))
>  warning += $(warning-$(findstring 2,
> $(KBUILD_ENABLE_EXTRA_GCC_CHECKS)))

I was going to skip the churn since I intend to make the default build
use -Wvla for the next merge window (assuming we've killed all the
VLAs by then). After crypto, only fs/ntfs remains, and I have that
half done already. There are a couple more still under some
development back-and-forth.

I'm not _opposed_ to this change, but I'd rather just make it the
default. And then the next cycle, I'd want it to be -Werror=vla, but I
may get shouted down. ;)

-Kees

-- 
Kees Cook
Pixel Security
