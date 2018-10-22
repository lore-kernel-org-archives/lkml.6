Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D11C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32D3120663
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dx8sTZEG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32D3120663
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbeJWBhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 21:37:01 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:33425 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728649AbeJWBhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 21:37:01 -0400
Received: by mail-it1-f194.google.com with SMTP id h6-v6so10310716ith.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 10:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bkVUa1+/MOC7iuiS+1j+AH2HYD9X3AuCffRP/Nwy2Fo=;
        b=dx8sTZEGIRKm+BTzwFM+f6woS1a4+OEKFgHjIgwUvzHFRosfoEDj4TgYXQBPBCYskj
         mQbltjbwl7VoAcPKYVyqKmfZmYNqZH4oZO/ohpT3GpkJ5RABR7QuGK+3PsqnNME8Rg3D
         81MAeegGE/BrmsniA1gvQoejbp/izimKjjIwE+mowYj/jayWO4AK4nuqNERncuDBxXIs
         i7ZJCTMh1EgXF/5scvPgKFctxv8ZhXwbH8G1teqgwNRa48K29D8DZUneeSvkfnNaJ9IN
         zbsxituU2a5BMtG032CZgtf10YHPewH7dCiRDN2SamebwSS22wPTHanlyP19DN3wMdQi
         dFEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bkVUa1+/MOC7iuiS+1j+AH2HYD9X3AuCffRP/Nwy2Fo=;
        b=qOQWxlScwe/89h9VVTsinSITnBXn/njMa7NNw/xbYFm+snPbznDG1gpqGGZrufFRLu
         VFBMzeYwRI1u/khAmSlx2EDggKjWS0PSNDTMm/O9jpAZsRHiVIej8RPy9JtnC2NNC7Zw
         YJeQpz4Ya94CYSyVMajfqgThjgpQQha00YJMxqgPIUYwpNvgo0kBGHO7dK1ZeuygHRRP
         CscJ1CsaenrrHHC4LGW/jODh7HoPN8s54siDBMVVxxkhjlK2VnINTKE3RJvYzN5vC/c6
         FmiHhBKmi3YTJ4X8AgeyN4gSliCdUYbvKBmnrleimq2TRorKl7x0If+RBes/TDoWVBWW
         WX8w==
X-Gm-Message-State: ABuFfojXE+fI7qBZLov+bkwR4mf67Se5A2Gu8YNDs3CgYbOevWXk19mF
        gccI+JXyvKjINc5pPmOdwM14JkH6d45tN5EhZVjUmg==
X-Google-Smtp-Source: ACcGV62QSQJGXfWFrnd+Uk5Ss5JhCgKaEQeVRVkOUFkR7JliPTNl7TgcOSFyYcXOC8BbklG5BXxueHUMdM9wcE+ytqE=
X-Received: by 2002:a05:660c:383:: with SMTP id x3mr9261447itj.121.1540228658018;
 Mon, 22 Oct 2018 10:17:38 -0700 (PDT)
MIME-Version: 1.0
References: <20181015175424.97147-1-ebiggers@kernel.org> <CAHmME9p1aiqWZ4+viaLscO8+qmixdVhMA1MAtMAFEHPG36DcPg@mail.gmail.com>
 <20181019190411.GB246441@gmail.com> <20181021222341.GA742@sol.localdomain> <CAHmME9oEQVTJ0xB+dpi8MKxohRfdogqnV+bN63EWTaoS5dE6Pw@mail.gmail.com>
In-Reply-To: <CAHmME9oEQVTJ0xB+dpi8MKxohRfdogqnV+bN63EWTaoS5dE6Pw@mail.gmail.com>
From:   Paul Crowley <paulcrowley@google.com>
Date:   Mon, 22 Oct 2018 10:17:26 -0700
Message-ID: <CA+_SqcCBRgJVneAKbxTr0kY1gF9skbxME=ZdKbQLztDca_ri+Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/12] crypto: Adiantum support
To:     Jason@zx2c4.com
Cc:     ebiggers@kernel.org, linux-crypto@vger.kernel.org,
        linux-fscrypt@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Greg Kaiser <gkaiser@google.com>,
        Michael Halcrow <mhalcrow@google.com>,
        samuel.c.p.neves@gmail.com, tomer.ashur@esat.kuleuven.be
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Oct 2018 at 15:52, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > [1] Originally we were going to define Adiantum's hash function to be
> >     Poly1305(message_length || tweak_length || tweak || NH(message)), which
> >     would have made it desirable to export the Poly1305 state before NH, so that
> >     it could be imported for the second hash step to avoid redundantly hashing
> >     the message length and tweak.  But later we changed it to
> >     Poly1305(message_length || tweak) + Poly1305(NH(message)).
>
> Out of curiosity, why this change?

With the old system, Eric ended up implementing a function which took
"message_length || tweak_length || tweak || message" as input and
*parsed out* the lengths in the first 16 bytes to know when to start
applying NH. That struck me as not nice at all, and we worked together
to design something that fitted more naturally into the way that
crypto is done in the kernel.

With this change, the part that can be kept in common between the two
hashing stages is cleanly separated from the part that will be
different, and the Poly1305(NH(message)) construction is a relatively
clean thing by itself to be part of the Linux kernel, though by itself
it is only epsilon-almost-delta-universal over equal-length inputs so
it has to be combined with something else to handle varying-length
inputs. This is not too dissimilar from the caveats around GHASH which
is also part of the kernel.
