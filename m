Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A2EC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 07:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B49C21829
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 07:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igP27H6K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B49C21829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728867AbeHMKTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 06:19:32 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41724 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728244AbeHMKTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 06:19:32 -0400
Received: by mail-pf1-f194.google.com with SMTP id y10-v6so7301138pfn.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 00:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZmVQu1xcdp8gosU+cNNImlNo9JoeUpkWVp6y4d0w3Bs=;
        b=igP27H6K6Z2Q0MN2SbqVdTLzgv8PKPJeBS+x/Z0Z+GDqtd5uVUEcRkDjwFpfVMsMpy
         Wm37a5i+sbYjVjHX3PUseH+IOH69Wnn19PbHsttvJtykvYDZW/CbVwl+HifzA8VaLKT/
         yN6Fms3nyXKViyvpNG0LPs/dwv7wK3/XeOniiT+qIfpbDaAQQe1gmE8RquEwhNjfCTn4
         RgNezAH6ihhyCfG7rTyLeRypnyNjsORGnB5y49ra/f1yaHme4kUIeaXknsUl4aKXX+h4
         grCc8z3HjNLkY1/BmgZL2aI/GPHHvOKnEftmsFi7C+84lWY2wU9bHlone8XYNpMJNe5s
         JSZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZmVQu1xcdp8gosU+cNNImlNo9JoeUpkWVp6y4d0w3Bs=;
        b=Xj3poYtN8fvar812SsOSNPYxpQkZfh7FGYix/ujAfqNjoN/M4VXoBY3DdM7o8cpOtr
         iNVubIf7+go+r9k+5noz0m7NIsFTUE8HAmGC1WfGcMfruy6aGP/QVaAr++7Kf5NOMQQL
         BFxWmJwVKPqIUJr+Qh1iN+5tdjTk6c0//Pfa9LmUmJN2yKRCRmRvsg4wiAEC+gki61hy
         Wx76m+QKdl/t04W68NrsFdlZ80ACM7Rj6cnGb4TLtdwIb/Tw5tgYbixSSC/wfWO21s5o
         xTET06bYq21zIL2gMF8q2qMWdacQxxXplKRovuMlRj4632SvjlePrJ9lftd1J4+knTBc
         nUAA==
X-Gm-Message-State: AOUpUlGd8mFFfrJiPGcchjNUu5bqOomuGcimrDQKD59bnshIge8a64lh
        gwmlA3K12TdoGjcw1MAm3Qc=
X-Google-Smtp-Source: AA+uWPyQm24aM50HobcAYEB7SvFiOS4joS4h7Sh2qkFqSMdIEvhi8bcUJPeYgK+NGrnC2iy2gPr/Dw==
X-Received: by 2002:a63:5b51:: with SMTP id l17-v6mr15661529pgm.165.1534145909942;
        Mon, 13 Aug 2018 00:38:29 -0700 (PDT)
Received: from localhost ([110.70.54.242])
        by smtp.gmail.com with ESMTPSA id h190-v6sm23131038pge.85.2018.08.13.00.38.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 00:38:28 -0700 (PDT)
Date:   Mon, 13 Aug 2018 16:38:25 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Peter Kalauskas <peskal@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] zram: fix bug storing backing_dev
Message-ID: <20180813073825.GA1062@jagdpanzerIV>
References: <20180808223100.225086-1-peskal@google.com>
 <20180813061623.GC64836@rodete-desktop-imager.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180813061623.GC64836@rodete-desktop-imager.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (08/13/18 15:16), Minchan Kim wrote:
> > The call to strlcpy in backing_dev_store is incorrect. It should take
> > the size of the destination buffer instead of the size of the source
> > buffer.  Additionally, ignore the newline character (\n) when reading
> > the new file_name buffer. This makes it possible to set the backing_dev
> > as follows:
> > 
> >   echo /dev/sdX > /sys/block/zram0/backing_dev
> > 
> > Signed-off-by: Peter Kalauskas <peskal@google.com>
> Acked-by: Minchan Kim <minchan@kernel.org>
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
> CC: LKML <linux-kernel@vger.kernel.org>
> Cc: <stable@vger.kernel.org>    [4.14+]

Thanks for Cc-ing Minchan.

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

> > -	strlcpy(file_name, buf, len);

This is quite interesting. The reason it worked before was the fact that
strlcpy() copies 'len - 1' bytes, which is strlen(buf) - 1 in our case,
so it accidentally didn't copy the trailing new line symbol. Which also
means that "echo -n /dev/sdX" most likely was broken.

	-ss
