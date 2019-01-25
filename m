Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BABC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C0B7217D4
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avJUcxFk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbfAYX5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 18:57:10 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:50711 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfAYX5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 18:57:09 -0500
Received: by mail-it1-f193.google.com with SMTP id z7so13196276iti.0;
        Fri, 25 Jan 2019 15:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rT0GBAJuHiOrkO6N/sjWlEPNUpohQzYR7nEe8SWv2nU=;
        b=avJUcxFko2J6pEAUgYfrvpBrQJxfETTL80Isa6GEjzKa9uvdlopWUnMcpwtFs7JCi1
         TwMa2EypM0yRFHjqav7Tn/VGWr2x/YnIayRYujfNYZGblPcL6DWEeI+FizG5CoEjJDOB
         zS52VnLAid5Wf19b5yakRxF/bAjrJ2/YwLrBMWEjosYuylzQVpQZ2rt39IP3GChin9re
         GxIm2Itm8Aq2cMEo74NWq44Y26+ogTdrx/t0qme83roG6PL8S5cd1ermSO3Q5pnAyiFy
         zV267M4LRRg5b39OBND4EQDdTCp17Yoom1t7N0j6w/Srf1kiwH8MGUM+j72LRCuHmksQ
         toAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rT0GBAJuHiOrkO6N/sjWlEPNUpohQzYR7nEe8SWv2nU=;
        b=FS6hm8EZkrOlT8bTrpPhzTX/incnyaZXt2xPiy1bpgAPF6ztoJoD8gJtV9gAfYJnW/
         bSIQVdFB1lWw1rF5zuVJz4uc+fFQZCosYKfuWHqlRn5EwRcdYJbXuU3NY/waKSt0rt1N
         ZNRVYWbf0Z9kAORoU/Fe6umXZWigKciamC62UQPpl46374ima0JcwtSeo3glNtzFMh47
         SmKojSd2ii66tY2Gju+OOEj2y0CaRDTn0VoKANr94ko+UJF0e9hoXy8CHiGHnbpoYIsd
         n9qhDFATcdq4d8DKf3FWZw7GLttAWx5XqckIVSqnhgFJrPCIn4uCRk2Jck1TwjE1alA0
         8D7Q==
X-Gm-Message-State: AJcUukfesbal63ovtv6Z1Nk2DOHEyKfGyilvDU1SGS0bUvvJWc1SsnQl
        1ITSDypkbEm17LBHzXq9wjLexjy29TmrFO/Ehck=
X-Google-Smtp-Source: ALg8bN6ojTRVfAsXGToKOVC1XqzGy97Bf4ZGr2cV0+TjIShGJh6I8mty0+pumYb3ZPfsJayHACgJscNfw/KEnshRjvE=
X-Received: by 2002:a24:36cf:: with SMTP id l198mr5920219itl.102.1548460628208;
 Fri, 25 Jan 2019 15:57:08 -0800 (PST)
MIME-Version: 1.0
References: <20190124220954.2147f1da@canb.auug.org.au>
In-Reply-To: <20190124220954.2147f1da@canb.auug.org.au>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Fri, 25 Jan 2019 15:56:56 -0800
Message-ID: <CAKdAkRRBVDd80e4zjmwqqMH-dt4-1paVdrriu2Fn=-Zv+7qgrg@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the input-current tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Thu, Jan 24, 2019 at 3:09 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Dmitry,
>
> In commit
>
>   ec87da107d11 ("Input: olpc_apsp - assign priv->dev earlier")
>
> Fixes tag
>
>   Fixes: commit af518342effd ("Input: olpc_apsp - check FIFO status on open(), not probe()")
>
> has these problem(s):
>
>   - No SHA1 recognised
>
> The "commit" at the start of the tag value was unexpected.

Hmm, this is really weird:

dtor@dtor-ws:~/kernel/master (for-linus)$ git log --oneline --
drivers/input/serio/olpc_apsp.c
ec87da107d11 Input: olpc_apsp - assign priv->dev earlier
2a58dd767bf9 Input: olpc_apsp - remove set but not used variable 'np'
ed22cee91a88 Input: olpc_apsp - enable the SP clock
af518342effd Input: olpc_apsp - check FIFO status on open(), not probe()

As you can see there is that SHA1 in question present in my for-linus branch.

Thanks.

-- 
Dmitry
