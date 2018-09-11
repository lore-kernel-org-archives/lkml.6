Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08359C46469
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 01:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B300420839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 01:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNGd3xFe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B300420839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbeIKF5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 01:57:07 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34200 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726570AbeIKF5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 01:57:01 -0400
Received: by mail-oi0-f67.google.com with SMTP id 13-v6so44097468ois.1;
        Mon, 10 Sep 2018 18:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F/Ujmlt8E/VVdfTBhg3WWtj8otY/h1MAxTTeNdLwcoo=;
        b=mNGd3xFe9RnHw0mgiTexji1wEGMMEIz3Yl+FIgGUe5sFxNy1/hX8o2R7MpLgHOp7/B
         IIZYp+x1M/bqdXoRW27/ahqSGVOsWQtOS/WtqP/ycfCFMg9g6GOUqOLr7vKTZ50FfR16
         Sn7HdL/jlLjH+AdlRT8J3WIGiU5B85rDNWJtLXnN9FnXp92oL2LNYuBFkGfw4K6QrMqK
         RWir2PpLCb3ltV3iv7qKcj1RRiSDaLrNT1pcUkL0Gj1/afOgBAyFxn7poSe9/sSEpzS5
         R6zwFq0vlqUrsHbsjfLjXA4VHifglkKAVv7TNluNmJ1xGX2aKo1mvoimOnoYquE45v6Y
         e4DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F/Ujmlt8E/VVdfTBhg3WWtj8otY/h1MAxTTeNdLwcoo=;
        b=b/SIfx7JK9aVW2gH/DwZzcG9dWP0KJ7vwrrcfRlm/BdtsgUagqwfRUx2UYr+E5RWWh
         0byFm2hRObeYog4CvGr40yT2IozDXR+u9qlnFE9yGuxkerACNfBBHkCV++PI2QUbuvj9
         LfV9MX1lkAKq5K2Cg6qIQzhfL9jur8dxW220qCzLxXZ59EC+pglKHVyvCMaMkNBWLbuG
         6FQwv2IQMNAFeux5tcx9YUCBhCBh1XRLMhcfpkpJXPsxok3yFl3ytIWHRcdNve0mm0Dg
         pnt3PHUJ5nC6uBF8zw4YbFVSEma6n4nUJqPlVqRNOULKqdE46C9okAwv5GBwXj/XOBtx
         w2Jg==
X-Gm-Message-State: APzg51Abq6X38kuucAv4hufxQQWSt2/iObnAT3a7LIj/L0Os6NiAMx8r
        zTajk245p2CgWHB+TQU+/8fGplI1cOTwJxVZO7E=
X-Google-Smtp-Source: ANB0VdZovHyiRno7dP14jlBujDCt/6mgqTHY0Rx+mrGNxtUPBfkXHesn4Y5Eks2XcRkBZfB/KSzxcUsTrFtAKsV8ZHg=
X-Received: by 2002:aca:e643:: with SMTP id d64-v6mr25782882oih.81.1536627619919;
 Mon, 10 Sep 2018 18:00:19 -0700 (PDT)
MIME-Version: 1.0
References: <1536406766-27021-1-git-send-email-zhongjiang@huawei.com>
In-Reply-To: <1536406766-27021-1-git-send-email-zhongjiang@huawei.com>
From:   Junhui Tang <tang.junhui.linux@gmail.com>
Date:   Tue, 11 Sep 2018 08:59:52 +0800
Message-ID: <CA+NNRhEo-qryWzGoVbUtQVSbOhbTTwVuzAA7DYmTOcVN8oYehQ@mail.gmail.com>
Subject: Re: [PATCH] bcache: remove unnecessary null poiner check in cache_set_free
To:     zhongjiang@huawei.com
Cc:     colyli@suse.de, Kent Overstreet <kent.overstreet@gmail.com>,
        linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is NOT OK to me=EF=BC=8Cmaybe many cache in a  cache_set, and so=
me
cache are not registered yet, so ca is possible NULL.
zhong jiang <zhongjiang@huawei.com> =E4=BA=8E2018=E5=B9=B49=E6=9C=888=E6=97=
=A5=E5=91=A8=E5=85=AD =E4=B8=8B=E5=8D=887:52=E5=86=99=E9=81=93=EF=BC=9A
>
> The iterator in for_each_cache is never null, therefore, remove
> the redundant null pointer check.
>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/md/bcache/super.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
> index 94c756c..2d26f9e 100644
> --- a/drivers/md/bcache/super.c
> +++ b/drivers/md/bcache/super.c
> @@ -1513,12 +1513,11 @@ static void cache_set_free(struct closure *cl)
>         bch_btree_cache_free(c);
>         bch_journal_free(c);
>
> -       for_each_cache(ca, c, i)
> -               if (ca) {
> -                       ca->set =3D NULL;
> -                       c->cache[ca->sb.nr_this_dev] =3D NULL;
> -                       kobject_put(&ca->kobj);
> -               }
> +       for_each_cache(ca, c, i) {
> +               ca->set =3D NULL;
> +               c->cache[ca->sb.nr_this_dev] =3D NULL;
> +               kobject_put(&ca->kobj);
> +       }
>
>         bch_bset_sort_state_free(&c->sort);
>         free_pages((unsigned long) c->uuids, ilog2(bucket_pages(c)));
> --
> 1.7.12.4
>
