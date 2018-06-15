Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7EE93C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 15:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3162C20896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 15:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=profitbricks-com.20150623.gappssmtp.com header.i=@profitbricks-com.20150623.gappssmtp.com header.b="vKUOoby1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3162C20896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=profitbricks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965934AbeFOPoB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 11:44:01 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38996 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965684AbeFOPn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 11:43:59 -0400
Received: by mail-wm0-f65.google.com with SMTP id p11-v6so4649744wmc.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 08:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=profitbricks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GQOFAutXBWiG9B4xuWV7EbrHAbBfE5+ZBzsNGbC/ATw=;
        b=vKUOoby1Hj+F5hrfRj6q5Xpd+JaWj+oudczYTf5xPjonKpm6/tACX5q6AYdwb5JI78
         NYbwUFjYdourX93ro9DTimDlMp9C16kIpCxmNUnPAc8dEQLjgVbWy6bU3On4PjijNEGl
         Z+oo62xhiV34WcQVK5x6BpRrmdNXtbw0pK4aoGHqsIBRSUpFOqNMDk8hwhKsVIgXWXqP
         wbzeeVvXBcDEJiX9byfV2cUJU88ml7qEdc+y3s8Euy01y9o1KAsZ+Ai4M+z7MA4R3sqd
         8Y89+LBgcS2fzy6jjhqL+wuNzMjWk1NR9QARMcEKERijFhAGtlUUM3JYboPTL/uzujw7
         ZNig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GQOFAutXBWiG9B4xuWV7EbrHAbBfE5+ZBzsNGbC/ATw=;
        b=BEtgLztgB3yjPCjfDbDZ2GWddp0fi1nl1h5w94xM/FPd07xIcRCjSX+AdGwXuZJFiv
         dYm2JvcJJyAcz2sL9TeysC4azVZKBxCEmW8+mos/Ww8qFYg9rO0MazzTeXGbasal6Gf9
         ROiE3H8AVU6cB6OlkXrfG7Zm+4KvnqGpmDtb2M8QZ4MDZshNoj97+CKbZrNqfaIrTNws
         uX5K0iSm3D0+QsMHX4UCGlZtjtYMRFg5kt9b5NqYexX2c3eMvEBFpK1DBgCbJ7C7054p
         6+1AxxTOEOJFJr9L+5Z4R5tDGgJ2GQ0ebjWQ83Fjf6ebTINpb6xjKOP2WdBhH3VSB/Bo
         BrEw==
X-Gm-Message-State: APt69E2fBnxyPNUa1QoZRsHyRxOP4MY/T/iE1hMhz+V9jDpDhHrNVRDC
        bbIfRUjcGYHvQj+Jyd229lPcqIgut6HL3+rEF8Z1og==
X-Google-Smtp-Source: ADUXVKJV2hhugdriI0K0Id2lFu3tYeS8cSSGTRxwgqlj2BieTeW5b9vYYFM9ZDU1VYfll7hfl75Td14BjWsWAhF8juA=
X-Received: by 2002:aa7:c756:: with SMTP id c22-v6mr2355057eds.144.1529077437994;
 Fri, 15 Jun 2018 08:43:57 -0700 (PDT)
MIME-Version: 1.0
References: <20180609123014.8861-1-ming.lei@redhat.com> <20180609123014.8861-31-ming.lei@redhat.com>
In-Reply-To: <20180609123014.8861-31-ming.lei@redhat.com>
From:   Gi-Oh Kim <gi-oh.kim@profitbricks.com>
Date:   Fri, 15 Jun 2018 17:43:22 +0200
Message-ID: <CAJX1YtZYrRwQgASEX_CQtBEcYuk02LA=cKibsx=TitC70_=+zg@mail.gmail.com>
Subject: Re: [PATCH V6 30/30] block: document usage of bio iterator helpers
To:     ming.lei@redhat.com
Cc:     Jens Axboe <axboe@fb.com>, hch@infradead.org,
        Al Viro <viro@zeniv.linux.org.uk>, kent.overstreet@gmail.com,
        dsterba@suse.cz, ying.huang@intel.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, tytso@mit.edu,
        darrick.wong@oracle.com, colyli@suse.de, fdmanana@gmail.com,
        rdunlap@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 9, 2018 at 2:36 PM Ming Lei <ming.lei@redhat.com> wrote:
>
> Now multipage bvec is supported, and some helpers may return page by
> page, and some may return segment by segment, this patch documents the
> usage for helping us use them correctly.
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  Documentation/block/biovecs.txt | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/Documentation/block/biovecs.txt b/Documentation/block/biovec=
s.txt
> index 25689584e6e0..3ab72566141f 100644
> --- a/Documentation/block/biovecs.txt
> +++ b/Documentation/block/biovecs.txt
> @@ -117,3 +117,33 @@ Other implications:
>     size limitations and the limitations of the underlying devices. Thus
>     there's no need to define ->merge_bvec_fn() callbacks for individual =
block
>     drivers.
> +
> +Usage of helpers:
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +* The following helpers, whose names have the suffix "_all", can only be
> +used on non-BIO_CLONED bio, and usually they are used by filesystem code=
,
> +and driver shouldn't use them because bio may have been split before the=
y
> +got to the driver:
> +
> +       bio_for_each_chunk_segment_all()
> +       bio_for_each_chunk_all()
> +       bio_pages_all()
> +       bio_first_bvec_all()
> +       bio_first_page_all()
> +       bio_last_bvec_all()
> +
> +* The following helpers iterate bio page by page, and the local variable=
 of
> +'struct bio_vec' or the reference records single page io vector during t=
he
> +iteration:
> +
> +       bio_for_each_segment()
> +       bio_for_each_segment_all()

bio_for_each_segment_all() is removed, isn't it?

> +
> +* The following helpers iterate bio chunk by chunk, and each chunk may
> +include multiple physically contiguous pages, and the local variable of
> +'struct bio_vec' or the reference records multi page io vector during th=
e
> +iteration:
> +
> +       bio_for_each_chunk()
> +       bio_for_each_chunk_all()
> --
> 2.9.5
>


--=20
GIOH KIM
Linux Kernel Entwickler

ProfitBricks GmbH
Greifswalder Str. 207
D - 10405 Berlin

Tel:       +49 176 2697 8962
Fax:      +49 30 577 008 299
Email:    gi-oh.kim@profitbricks.com
URL:      https://www.profitbricks.de

Sitz der Gesellschaft: Berlin
Registergericht: Amtsgericht Charlottenburg, HRB 125506 B
Gesch=C3=A4ftsf=C3=BChrer: Achim Weiss, Matthias Steinberg, Christoph Steff=
ens
