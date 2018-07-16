Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824B3ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 03:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DC2E208E1
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 03:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="dN6jkffY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PwpRulol"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DC2E208E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbeGPEFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 00:05:19 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:38184 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725731AbeGPEFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 00:05:19 -0400
Received: by mail-yb0-f193.google.com with SMTP id i9-v6so14916315ybo.5
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 20:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=qfFKWZRAd8A6St1lFrwzwl/HfrYnmB7ez0Df59JaH/A=;
        b=dN6jkffYCy2ZBnjVfQDR6dd6UZlwBCppeBy7kLjF4dyhxvEOzRMgxSg4kMED15krvV
         HkNAFY+t8gaqwtcemXFTt51C+PwmSaMFtO2siQ5J+TMCKbUCV/MFch3IioIo9iCz35Tw
         Oacmia4i4RIuXzgEhtKZONAMbp4lOPCmWLPEixlcsFPEWqWYssgeIGxTqzDLyZWfgv/X
         USYk/o8qJwvlPCoR/gWGMvDfo5OAT+Y7uVckwtviGrTuYQ/4fKAYwKJYqNhfR8UjFiU6
         rblVmvABnXgwpFMWQxGUe++nyfMpA5RvptRBtLQmZUzizHOLj8NtX8ff4hljKAtX/TrF
         bpyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=qfFKWZRAd8A6St1lFrwzwl/HfrYnmB7ez0Df59JaH/A=;
        b=PwpRulolaL3mfg2/eA+8pxNG/q59jaEmIu7v9qHaCj2g4icMrvu2I6NRzYo2PykjFS
         cnFHrJfCO4pgWKWgPHSdQdGIvJSgF61aUuGuBL44W2Kq9CdqmfshB+UkIPXFkuaOJioJ
         guXL/7/Id4xLOPoX6OJdx+FHRZsVJNGH6l7l4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=qfFKWZRAd8A6St1lFrwzwl/HfrYnmB7ez0Df59JaH/A=;
        b=pnO1Hs8Pu2Wr5ILBCoK8IDbHIZOKO5zCK1YKpukh17LANaIR3iaS6pDZnyk+/Bri93
         uGxyGl6xdDSLsFoLYCGeY0UmTU1+gen9C3NXQMk21M26VqC2PVN2fU1o0U2mYJdj6Skh
         huwiWIf67y58GaUI9fRIK3iCMaDdLPR0T/7bCpbQxmDwOFK5oNaj5LjtT+Ke5EGuEVGl
         ZEknX40LKiH2YkXESETfDEvfvejfdN76hyw+o8DlPoPP550a7Jhkka8MX0t2PGvkRymI
         fZ1YhvodlkRjWIak9x+5S1tnlhWKiRALq4hmyhEILeceMyqlIJ82Gha2KgnBFeEXJVGR
         eRig==
X-Gm-Message-State: AOUpUlEaBuIOitTxODUvrRjGuP63TwA6xBGHZvSytEwaOLLQsvulLxco
        3Qy3L8tLw3feuZ1rQNrE+06YRiW6wqdUFQyY1zYNKg==
X-Google-Smtp-Source: AAOMgpfk1P/+eQ3g4wldgGHiAlKsLgVJLOXTF7oWBrU0lkMX73N24zQFabElsMi78DIJF4Jl/6BmicFWnb4UKXuZQrA=
X-Received: by 2002:a5b:b44:: with SMTP id b4-v6mr8173915ybr.463.1531712400285;
 Sun, 15 Jul 2018 20:40:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:6602:0:0:0:0:0 with HTTP; Sun, 15 Jul 2018 20:39:59
 -0700 (PDT)
In-Reply-To: <20180716000118.nna5jkgcjxofbsup@gondor.apana.org.au>
References: <20180711203619.1020-1-keescook@chromium.org> <20180711203619.1020-12-keescook@chromium.org>
 <CAK8P3a3356dbruUfS_+fj9f+X-0jbNE8WMe5sWhJmuRY9Nvcbg@mail.gmail.com>
 <20180713004038.lwibdesz7ohhoind@gondor.apana.org.au> <CAGXu5jJOZ3u1BTf8U20wErphfjKzaGK+m1sdhA89LqVP3MDYZA@mail.gmail.com>
 <20180713062204.2o7gz5xri374nii6@gondor.apana.org.au> <CAGXu5jJp3Y4RZD+ZUYsWqf+sTbGJwdN3M=KOiPBn9VecYE4OgQ@mail.gmail.com>
 <20180715024430.n6bcnb4k7cm3ugtj@gondor.apana.org.au> <CAGXu5jLkhC8Jb0zVXuVZnbJM6tmMpyGkaoCvw=jACLA3fnoChw@mail.gmail.com>
 <20180716000118.nna5jkgcjxofbsup@gondor.apana.org.au>
From:   Kees Cook <keescook@chromium.org>
Date:   Sun, 15 Jul 2018 20:39:59 -0700
X-Google-Sender-Auth: X4T_K2kjDI_1zzmQVj0b_R88aaQ
Message-ID: <CAGXu5jKQV+qiLjbDoS=8QYfG_hdiYeRqeDdov_of5wn5Sek0KA@mail.gmail.com>
Subject: Re: [PATCH v4 11/14] treewide: Prepare to remove VLA usage for AHASH_REQUEST_ON_STACK
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Eric Biggers <ebiggers@google.com>,
        Alasdair Kergon <agk@redhat.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Lars Persson <larper@axis.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, qat-linux@intel.com,
        dm-devel@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 15, 2018 at 5:01 PM, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Sat, Jul 14, 2018 at 07:59:09PM -0700, Kees Cook wrote:
>> On Sat, Jul 14, 2018 at 7:44 PM, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>> > On Fri, Jul 13, 2018 at 08:07:10PM -0700, Kees Cook wrote:
>> >>
>> >> On a plane today I started converting all these to shash. IIUC, it
>> >> just looks like this (apologies for whitespace damage):
>> >
>> > Yes if it doesn't actually make use of SGs then shash would be
>> > the way to go.  However, for SG users ahash is the best interface.
>>
>> Nearly all of them artificially build an sg explicitly to use the
>> ahash interface. :P
>>
>> So, I'll take that as a "yes, do these conversions." :) Thanks!
>
> Yeah anything that's doing a single-element SG list should just
> be converted.

There are a few that are multiple element SG list, but it's a locally
allocated array of SGs, and filled with data. All easily replaced with
just calls to ..._update() instead of sg helpers. For example
net/wireless/lib80211_crypt_tkip.c:

-       sg_init_table(sg, 2);
-       sg_set_buf(&sg[0], hdr, 16);
-       sg_set_buf(&sg[1], data, data_len);
...
-       ahash_request_set_tfm(req, tfm_michael);
-       ahash_request_set_callback(req, 0, NULL, NULL);
-       ahash_request_set_crypt(req, sg, mic, data_len + 16);
-       err = crypto_ahash_digest(req);
-       ahash_request_zero(req);
+       err = crypto_shash_init(desc);
+       if (err)
+               goto out;
+       err = crypto_shash_update(desc, hdr, 16);
+       if (err)
+               goto out;
+       err = crypto_shash_update(desc, data, data_len);
+       if (err)
+               goto out;
+       err = crypto_shash_final(desc, mic);
+
+out:
+       shash_desc_zero(desc);
        return err;

-Kees

-- 
Kees Cook
Pixel Security
