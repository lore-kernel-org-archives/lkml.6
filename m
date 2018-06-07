Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 4ibCCoeEGVtlMAAAmS7hNA
	; Thu, 07 Jun 2018 19:16:23 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 114576074D; Thu,  7 Jun 2018 19:16:23 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="sRV7AJln";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VxD7FxMz"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 706FD60590;
	Thu,  7 Jun 2018 19:16:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 706FD60590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753042AbeFGTQU (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 15:16:20 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:36896 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751793AbeFGTQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 15:16:18 -0400
Received: by mail-vk0-f67.google.com with SMTP id w8-v6so6763337vkh.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 12:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=KmvToFAAxJrFTi6ZJWeZiyjDXgBVVY6MPj7XMEujz3w=;
        b=sRV7AJlnQOtFpnGh2iYhIXqHUnP7BLC867aeY0/Kgu/yYYGTNxyahe8lVHVk/vbf/m
         4PP2ryHRKDgYQF/Hksy8Cipj6Wr0FM1Cjmdj7gw0Rd9cLe8gt+zOQO8cynQZQ7jny2ux
         AOv3Uk6ePpvOGJ9RVoSrmDQEUdOmFP0h3TRsPPt3dj7ruGB08HjclNFj8NLqRDAKa2ZS
         5RN3x7hVe/xjTMNW1D/bcgkDPW03ZTA67Ez6pv7BbgEbkrGBM/32LbFSS8CvJds6h7kl
         VL6PGw/kFexflwZnkpmjmp6/oVeh3jg0LDnNGY4VAqzWlDtTUeyd15JlG0f+i/LsghTi
         338g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=KmvToFAAxJrFTi6ZJWeZiyjDXgBVVY6MPj7XMEujz3w=;
        b=VxD7FxMzEq+UqQ4+4+0niypR6GcCbZzn7zNtd0hDEjACeoAhkiDehNSi5y617SenXM
         TYhtl9GGBtCD0GZXNqyjo5Y8sI7GasTt01C5tefLMNsdbRi3JoRIh59LP/1kesOmC+oA
         AnXXyjeJM6ovEH5ced5w8apHJIM/lN5stSYNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=KmvToFAAxJrFTi6ZJWeZiyjDXgBVVY6MPj7XMEujz3w=;
        b=OOVmYTgp8sHW3Se2ZJ96u7FHNKlA+FWHboS2ju3vnIZaXXxnoLiPpMMmfSN5+Xnt/s
         6ViRKPA2hLO5YkpJZ4OW+KfgVkYGVkFTvfPB0t9aQAK4Ok6U2Qqadlc1U5J7kNxY2hmj
         rlxP9yj8/mqUkBs8jB+R7ju9u9k53zTmQxK1BH9HrNVQFpKZIvM13Ah/CSW3rQBapW3n
         Xx/lzvlRwGOOm7/ROeAf6EpPy0fYRlNbnyiHcOYUrREaW5xcsGVFDUmsCKhV5RmwRhSK
         XvmlquHd//9NHKtcNMTGidsVH8aApa4GPcADqcRUoF0EjKb9yochhSthrwx2pC5ehJai
         LmFQ==
X-Gm-Message-State: APt69E07Q55dB+iC59V2cuo0ySRFioI2uVp/B0wnWwqeslFgxdOzFqns
        YNv8wVAW24tO/OWASu2jGQEU+vSNQRuZCIvu4PXNCQ==
X-Google-Smtp-Source: ADUXVKKlAtvhAfeGuAarnbINbwvEZhOPWFKBG2qb9M0k5W2FFEKBkubhuwPEBa5uRhuLMZ+6jni7r53M+B/jVkZoHxs=
X-Received: by 2002:a1f:e483:: with SMTP id b125-v6mr1973069vkh.149.1528398977297;
 Thu, 07 Jun 2018 12:16:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:a085:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 12:16:16 -0700 (PDT)
In-Reply-To: <20180607191201.97080-1-ebiggers3@gmail.com>
References: <0000000000009c221d056e0cf53a@google.com> <20180607191201.97080-1-ebiggers3@gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 7 Jun 2018 12:16:16 -0700
X-Google-Sender-Auth: WjiM3Ld1K5i00AN1SZUDV17bzhs
Message-ID: <CAGXu5jJf-cW8WkwMoPZT8zM2aUoO6P-EQs7MK6_uUTneZr0ehA@mail.gmail.com>
Subject: Re: [PATCH] dh key: fix rounding up KDF output length
To: Eric Biggers <ebiggers3@gmail.com>
Cc: David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>, keyrings@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com, Tycho Andersen <tycho@tycho.ws>,
        Stephan Mueller <smueller@chronox.de>,
        Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 7, 2018 at 12:12 PM, Eric Biggers <ebiggers3@gmail.com> wrote:
> From: Eric Biggers <ebiggers@google.com>
>
> Commit 383203eff718 ("dh key: get rid of stack allocated array") changed
> kdf_ctr() to assume that the length of key material to derive is a
> multiple of the digest size.  The length was supposed to be rounded up
> accordingly.  However, the round_up() macro was used which only gives
> the correct result on power-of-2 arguments, whereas not all hash
> algorithms have power-of-2 digest sizes.  In some cases this resulted in
> a write past the end of the 'outbuf' buffer.
>
> Fix it by switching to roundup(), which works for non-power-of-2 inputs.

round_up() vs roundup(). Wow, that's not confusing. :( I wonder if we
should rename the former to roundup_pow2() or something?

> Reported-by: syzbot+486f97f892efeb2075a3@syzkaller.appspotmail.com
> Reported-by: syzbot+29d17b7898b41ee120a5@syzkaller.appspotmail.com
> Reported-by: syzbot+8a608baf8751184ec727@syzkaller.appspotmail.com
> Reported-by: syzbot+d04e58bd384f1fe0b112@syzkaller.appspotmail.com
> Fixes: 383203eff718 ("dh key: get rid of stack allocated array")
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Regardless:

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  security/keys/dh.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/security/keys/dh.c b/security/keys/dh.c
> index f7403821db7f0..b203f7758f976 100644
> --- a/security/keys/dh.c
> +++ b/security/keys/dh.c
> @@ -142,6 +142,8 @@ static void kdf_dealloc(struct kdf_sdesc *sdesc)
>   * The src pointer is defined as Z || other info where Z is the shared secret
>   * from DH and other info is an arbitrary string (see SP800-56A section
>   * 5.8.1.2).
> + *
> + * 'dlen' must be a multiple of the digest size.
>   */
>  static int kdf_ctr(struct kdf_sdesc *sdesc, const u8 *src, unsigned int slen,
>                    u8 *dst, unsigned int dlen, unsigned int zlen)
> @@ -205,8 +207,8 @@ static int keyctl_dh_compute_kdf(struct kdf_sdesc *sdesc,
>  {
>         uint8_t *outbuf = NULL;
>         int ret;
> -       size_t outbuf_len = round_up(buflen,
> -                                    crypto_shash_digestsize(sdesc->shash.tfm));
> +       size_t outbuf_len = roundup(buflen,
> +                                   crypto_shash_digestsize(sdesc->shash.tfm));
>
>         outbuf = kmalloc(outbuf_len, GFP_KERNEL);
>         if (!outbuf) {
> --
> 2.17.1.1185.g55be947832-goog
>



-- 
Kees Cook
Pixel Security
