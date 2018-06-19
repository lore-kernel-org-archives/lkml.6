Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8CDC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 20:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50166208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 20:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nv4Z/4KG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50166208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030711AbeFSUJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 16:09:33 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:42746 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030645AbeFSUJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 16:09:31 -0400
Received: by mail-vk0-f67.google.com with SMTP id s187-v6so579723vke.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 13:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bL2LYEU7AWbgmzm3aAj4bxXXVJEPKp2k9UgJecYG7K4=;
        b=Nv4Z/4KGx5I/CnwJBhyUJNm04Flefiuc8PZqAfgl0rlstIuaFYjwk6UHcmDLgEipBs
         Pos3kGroq2+CQGiCet9r4lLmzcDJVIBvuNO8pr2KyHX/YLi0CUMW44KuBJWsoNZ7lBSE
         FLdTFuvp70+85n50p2iWQjBv2ympvQLU/Db9aucjeqkAOKxPO48CYfayhfbcK2ms4dc2
         D61JMkMOCas9DIwlzuZcNnGeTo+zBGSXyQ1qdtSb06vOZHJ2R6Z3ILFSbSpSA+LW39Or
         9Ex0f+/n6BqlgQJuTVLHbNBAhCmeoyUY/rMVYRcNWolJMDOABfePVoelw+tdL0AWhe9G
         hf8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bL2LYEU7AWbgmzm3aAj4bxXXVJEPKp2k9UgJecYG7K4=;
        b=Yl+wf3QBsg9nIiyk4XAnGvUmK2+vMXpodQ4eXb2MGRR02cTan+rhca9AmJYtUgke5a
         +4mKy4dR8qsHvVKggWKxEBpS0SeNV3UX+WW0Dc/hGVbgAG5RRxv84VtVn8dZriEqhmKn
         f2IeuQS9orT2YEMJfHPGr823i3+9QKikIxa4NPQKmm9UWZ0NjX17vTxOxG+RtZw6yw75
         bPErcrSWCQDbc6tn6EeuBk0KnazYkJK06I4tmDdWOkyj/0crD7e9AdGXuaVR5ZS8NGmH
         t5/HrhmdVzpnH4Q/s3nwTE2OLDLpWiysvXM5nGxZde85MYqjupYRDuZhcX4niwR512fH
         4cQw==
X-Gm-Message-State: APt69E3IsYy5fWvPpt2pN2UFIQZTio2KgcHmEM7tjZlrQHYLT1BEH+ed
        xOw0TLfr2wT6q/DioqkjdSfZlsf5cgnXCSKoF5Y=
X-Google-Smtp-Source: ADUXVKLSAMBYrb64VqoJsRwzaLapKQoWxJLDSFiDtS+zU1YcLmGZhWB2nLQmZxIktmH6h/zwrDjVtdixVYG9UwuDYL4=
X-Received: by 2002:a1f:a8d6:: with SMTP id r205-v6mr1556019vke.129.1529438971137;
 Tue, 19 Jun 2018 13:09:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 13:09:30
 -0700 (PDT)
In-Reply-To: <20180619195605.31321-4-johnfwhitmore@gmail.com>
References: <20180619195605.31321-1-johnfwhitmore@gmail.com> <20180619195605.31321-4-johnfwhitmore@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 19 Jun 2018 23:09:30 +0300
Message-ID: <CAHp75VebpdEujHFeE=_ZHqHSKq+LD2V5SqL6J+YM_2R2CX4jiQ@mail.gmail.com>
Subject: Re: [PATCH 3/9] staging: rtl8192u: Truncate block comments to 80
 character length - Style
To:     John Whitmore <johnfwhitmore@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 10:55 PM, John Whitmore <johnfwhitmore@gmail.com> wrote:
> Where possible truncation of block comments to the 80 character length
> prefered by the coding style.

Is it somehow automated?!

>         /*
> -        * 8190 only, Realtek proprietary aggregation mode
> -        * Set MPDUDensity=2,   1: Set MPDUDensity=2(32k)  for Realtek AP and set MPDUDensity=0(8k) for others
> +        * 8190 only, Realtek proprietary aggregation mode Set MPDUDensity=2,
> +        * 1: Set MPDUDensity=2(32k) for Realtek AP
> +        * and set MPDUDensity=0(8k) for others
>          */

This is just an example how it should NOT be done.
The original looks better than the result in terms of understanding.

Had you (re-)read the result?

-- 
With Best Regards,
Andy Shevchenko
