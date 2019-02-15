Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B95C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C16D321925
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posk.io header.i=@posk.io header.b="bNJ0NN3+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbfBORKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 12:10:51 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37348 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfBORKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 12:10:44 -0500
Received: by mail-ed1-f68.google.com with SMTP id m12so8552597edv.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 09:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vqvSX/2/fIBl118riJNMYt+kfHwPe23nI2BC5oSQwIM=;
        b=bNJ0NN3+w+WbKHzXmt2i0gpzGU8+pvJ81YHGqFoMCA46LzV432FvzYWb+ehgCP1Fjg
         FWiEUD7qvjcHtYScb6SNiLaLO8ZIqv1lgZ6VzcAXxNDQc/Ya+nPPw6A19poVw2QfXG3G
         BMMJX1rC5GIlaP+WAYNOOMAEGo9oZK2ITbwNQgTabnwtz4s9ESTRpfPoa5QcwlWLELx8
         gAsfHW0r6g+HfIIcuJ6aHhGBEcNftlO4ecDheZanPmqT5goPkNbNzS1ljYOlEt6uBwRa
         wabN0TaKk6Kjn/MWRFp1PZXisIywX/yCSvBfE/aLC9/vVo1rJPPprLGOnAq09rI6iKrD
         e/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vqvSX/2/fIBl118riJNMYt+kfHwPe23nI2BC5oSQwIM=;
        b=IFFlhwE17RibKtKUGC+k5BlBw+BleSSGvVMW4jJDRjo0imyr8GMoKvEaQhCt0+NE1x
         JlL8fUl8eJ6mIoBoFeUMSk+zf8fqQrqOaXrbpoxlb0uD2vmSRPFFEjnz8wdEodnyvc9f
         Ds+UC9LLIM0akgNAOmkbHG7l8u1GBVT/gDnlDin9Pg3hqKD+8KKrhFallB1VrOpabzeA
         S6Laf+JBHYj97xo9i8gISAzGSz/97JB7GFGMRZQWj+s04nDplaTAOHv5yXk5IjZaQUys
         F/6G2PAbkCJ01NJoCCVm3wSv+YQ88rz3sv2QcLPM/+bQHHy/pcOYkA/xfIorW/9oLhfh
         doNQ==
X-Gm-Message-State: AHQUAuZn60v7UNwoD729l7GE5YKSUrkQ2GdrNai/3SdxgYqRIpdpygWr
        xLrXn4JfOzK978YPp/uziVZDvoCQFi+h8c2ERIGV1lP9
X-Google-Smtp-Source: AHgI3IY8QzvMW4ZIFRN1RU9l8MI9lDc9XGIFgQ1suZ+ASKnSMVIWRxbWu/IFA2hocDwDR4gsZrCcfmWYcmreLay5EtQ=
X-Received: by 2002:a17:906:e2d5:: with SMTP id gr21mr7425632ejb.145.1550250643011;
 Fri, 15 Feb 2019 09:10:43 -0800 (PST)
MIME-Version: 1.0
References: <20190215170342.1b704e7c@canb.auug.org.au> <51ee23dd-b852-db61-ef21-ff5819488386@infradead.org>
In-Reply-To: <51ee23dd-b852-db61-ef21-ff5819488386@infradead.org>
From:   Peter Oskolkov <posk@posk.io>
Date:   Fri, 15 Feb 2019 09:10:32 -0800
Message-ID: <CAFTs51XSScFFa1DjzAikm8RuT7OHX7O7p3cHcvU_ypnpoyu=jw@mail.gmail.com>
Subject: Re: linux-next: Tree for Feb 15 (net/core/lwt_bpf.c)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 8:48 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 2/14/19 10:03 PM, Stephen Rothwell wrote:
> > Hi all,
> >
> > Changes since 20190214:
> >
>
> on x86_64:
>
> ld: net/core/lwt_bpf.o: in function `bpf_lwt_xmit_reroute':
> lwt_bpf.c:(.text+0x11e): undefined reference to `ip_route_output_flow'
> ld: net/core/lwt_bpf.o: in function `bpf_input':
> lwt_bpf.c:(.text+0x9d3): undefined reference to `ip_route_input_noref'

Looking into it.

>
>
> Full randconfig file is attached.
>
> --
> ~Randy
