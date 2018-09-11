Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28215C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D82762086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MAucD1gf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D82762086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbeIKVyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 17:54:11 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:40434 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727795AbeIKVyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 17:54:11 -0400
Received: by mail-it0-f67.google.com with SMTP id h23-v6so2415553ita.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 09:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=b9CXSRE87eSJzjaH0yEsS+vkUlTeQBiqMjVybS75GBo=;
        b=MAucD1gfsPBZ3pXr1nG8oo5XVIjDHTUyABHtTajfbaANFJmzJ0JYIe8MnppYgCzoWH
         hif3xEIBrkYPTfs0fyABSB+UA0sOzGLzctgZZHZX8mtt8EWw7jnq6iimMKCwZb2II4kn
         ZYYvSWJvl8yXJV5EL6PUKx6jGCoIFSxHXI5F4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=b9CXSRE87eSJzjaH0yEsS+vkUlTeQBiqMjVybS75GBo=;
        b=GXSoywx3DpK/oUdgGMuLc9sN57MHoZ+wr7Aps3bHuXQEB3Q6CQZENZ/z5ziwaBbzjN
         JjDSjd+xjt4mCIFHvj0/OYBYJOlZCrCqTfNAN+P2n5qazajg25N7Nih7MgWiGDfQuO5o
         ix+8GYrHVNhFN+X9VKw+BG1l7rt7cKuNMJJjyxUQvcr22h4ObzOpBAP410jNQD/KASYg
         gWA02127WR2exUhemLwP61Cd+fSvIN2qxoADUXCkAdN2Ot4DUxyh5FuGaxD0xIAPEAs7
         A+6m5URLUbWcBfFHVotqQcLr39M6cVJe8h80mhj1h7Ny86COOS/JVap2yC2R9HY1k4uB
         l/Qw==
X-Gm-Message-State: APzg51C97rkHy0KBs3glG4VlzAuj12jMfUS4kWWWGOvMBIlEhTX90oWP
        +Z+B/YG8lYwB+1vbjZ8bO/FfS4VWs/UFwi6BSUXD1zCE
X-Google-Smtp-Source: ANB0Vdba9E8Iv+f94DGJ/jmYKEWTTAd4VBsuRw82L8VXxWXtCHFKLC8hMRpbInIhh3qXSbDLq4J2vwzyLG/xcS+erxM=
X-Received: by 2002:a24:cf06:: with SMTP id y6-v6mr2400434itf.5.1536684839916;
 Tue, 11 Sep 2018 09:53:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5e:870a:0:0:0:0:0 with HTTP; Tue, 11 Sep 2018 09:53:59
 -0700 (PDT)
In-Reply-To: <20180829170015.7729-2-semen.protsenko@linaro.org>
References: <20180829170015.7729-1-semen.protsenko@linaro.org> <20180829170015.7729-2-semen.protsenko@linaro.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Tue, 11 Sep 2018 19:53:59 +0300
Message-ID: <CAKaJLVvSHZq9eZd2uqojHb9bdLOnLhQn1X-i=YBWMXMeexrWYg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] codafs: Fix build using bare-metal toolchain
To:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        codalist@coda.cs.cmu.edu, coda@cs.cmu.edu,
        Jan Harkes <jaharkes@cs.cmu.edu>
Cc:     Praneeth Bajjuri <praneeth@ti.com>,
        Paul Sokolovsky <paul.sokolovsky@linaro.org>,
        Miklos Szeredi <mszeredi@suse.cz>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 8:00 PM, Sam Protsenko
<semen.protsenko@linaro.org> wrote:
> The kernel is self-contained project and can be built with bare-metal
> toolchain. But bare-metal toolchain doesn't define __linux__. Because of
> this u_quad_t type is not defined when using bare-metal toolchain and
> codafs build fails. This patch fixes it by defining u_quad_t type
> unconditionally.
>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  include/linux/coda.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/include/linux/coda.h b/include/linux/coda.h
> index d30209b9cef8..0ca0c83fdb1c 100644
> --- a/include/linux/coda.h
> +++ b/include/linux/coda.h
> @@ -58,8 +58,7 @@ Mellon the rights to redistribute these changes without encumbrance.
>  #ifndef _CODA_HEADER_
>  #define _CODA_HEADER_
>
> -#if defined(__linux__)
>  typedef unsigned long long u_quad_t;
> -#endif
> +
>  #include <uapi/linux/coda.h>
>  #endif
> --
> 2.18.0
>

Hi guys,

It's been a while since I sent this patch. Can we please merge it if
there is no objections?

Thanks.
