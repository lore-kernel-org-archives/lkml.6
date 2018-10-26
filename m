Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BA3ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 18:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4D952085B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 18:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="Lr2nCuKs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4D952085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbeJ0Dep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 23:34:45 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:34100 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbeJ0Dep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 23:34:45 -0400
Received: by mail-ua1-f67.google.com with SMTP id e16so748087uam.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 11:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RiAZyIg20J8F4FG2smIiyk53xruTQooAwEseJ4vnSDY=;
        b=Lr2nCuKsq5I4Y2zxC0KoGMcMEKJ0SQrmtDu7VJaW9UKBGeke8mtVuQ7d3Z65Bn0/5/
         OgNjcfAjkvwUVWRM5a+nvFnLqkREZB7/A8v5L1YLn4VYRfQAPh+XXyjmwcv4PJrlAW6w
         jDDca5cgIWhNJk1OfI2cuZ7WveoSTYI74QeZkuZkCE6Dx9fyB5kDGXqYcvsYwImJH4X0
         02jFJI/x7YW2t25lGzTMnhW2Wp9t4AUNaLjqF6bN9KG5CWt0yUcSFWXosA2jG2o7f9C4
         1AOHRQDSqMw/+Pql/on0i9Yx/7qCXx4/H5/ohdZgep5bOeU17Lj8lfnuD6ykzHVCsKIf
         qj+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RiAZyIg20J8F4FG2smIiyk53xruTQooAwEseJ4vnSDY=;
        b=oZswk2E0v5CQ8QA3Ebm88jl+Y8OWa7M2wx0ynnsVrMz0WSeBAg0RC+r/y/MpP6x20i
         r3hUej1uYHqiAkIrCPiutoSn7ShDCMt3AiskukhyGgqw2tSwMENm7u5MD+mhdrwt1XPR
         C6BLJka3FlRK/Czxss4b3a9ezRuM96+U2zjpWa+wAEgtDcA5B8DKJjVxcCqejKgpUPp+
         El9P7iJnurWnksMX+BOBqJnUc0zW7bqPG19p9+n03ICTv29KpZ/5Xu0ZG8rd/Nn9wGxq
         3pryboF36mIPw33PnrUuycMC3R3U4jgsMZ6EdsQYD/tQIVivxALSmVLexS6aic4vCFTb
         vVMA==
X-Gm-Message-State: AGRZ1gI++5Ave6j9IZiR71WijEYgT8ZGGDl2r+4TLpUMfRFYUaMXYZ3f
        Xufjtozn//YcK9CPLe6lk8YJtxFqM/QNBATUnSb4QQ==
X-Google-Smtp-Source: AJdET5dSgxYK/GVORGEmv0CsV0K7U74fDFhD3ZL1Tw7/bhLXkyz3CGrExlM4s1rPIc6TyLDPPV8sGQyHz8gyTXmwccI=
X-Received: by 2002:ab0:15a1:: with SMTP id i30mr2198412uae.11.1540580193552;
 Fri, 26 Oct 2018 11:56:33 -0700 (PDT)
MIME-Version: 1.0
References: <20181026004512.31012-1-matheus.bernardino@usp.br>
 <20181026004512.31012-6-matheus.bernardino@usp.br> <20181026100422.lvz2avowd6ddix54@mwanda>
In-Reply-To: <20181026100422.lvz2avowd6ddix54@mwanda>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Fri, 26 Oct 2018 15:56:21 -0300
Message-ID: <CAHd-oW5gePV54sEsrbcGdZo=hvcV5rqKVRS_Oq=vxvMCwzSwhA@mail.gmail.com>
Subject: Re: [PATCH 5/6] staging:iio:ad2s90: Add IIO_CHAN_INFO_SCALE to
 channel spec and read_raw
To:     dan.carpenter@oracle.com
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        Victor Colombo <victorcolombo@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 7:04 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Thu, Oct 25, 2018 at 09:45:11PM -0300, Matheus Tavares wrote:
> > From: Victor Colombo <victorcolombo@gmail.com>
> >
> > This patch adds the IIO_CHAN_INFO_SCALE mask to ad2s90_chan and
> > implements the relative read behavior at ad2s90_read_raw.
> >
> > Signed-off-by: Victor Colombo <victorcolombo@gmail.com>
> > ---
>
> You should be adding your S-o-B here as well because the patch is
> passing through your hands.

Thanks for the review! I'll be sending a v2 with my S-o-B there.

> regards,
> dan carpenter
>
> --
> You received this message because you are subscribed to the Google Groups "Kernel USP" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-usp+unsubscribe@googlegroups.com.
> To post to this group, send email to kernel-usp@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kernel-usp/20181026100422.lvz2avowd6ddix54%40mwanda.
> For more options, visit https://groups.google.com/d/optout.
