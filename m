Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26EE3C43612
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1EF02087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546882287;
	bh=jEtJZK/3w4NvAKD/2Vid3GLq/LIc7NIhvT4e+SnT0Qg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=haitOBzJGzXNq+EqKMaX9Itfq+Ij5l3W/PnWIZDHk3rQ4FIZll11kc8z74OR7bAio
	 bn8bLbrZHKlttnIzjUimaveRhSxpfpd2Me2m/DBJkBlFE4Sj7x6diTtyo+lHELX66w
	 nUQv8ceDWbSoYMGJFMCPY3UzMqGg3g7WfqCSn2GQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbfAGRb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 12:31:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:43822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726886AbfAGRbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 12:31:25 -0500
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEDEA2183E;
        Mon,  7 Jan 2019 17:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546882284;
        bh=jEtJZK/3w4NvAKD/2Vid3GLq/LIc7NIhvT4e+SnT0Qg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=u+zeCdSYHg5jbKckyD8h4iyrdqEkXAjWB5Vse5c4sYLWDExlcUCfKLFgdpo34wY82
         Rq94PyDQUkVn1BEuQtZUapRoHQcWfILctvvkxdBST0QBgIeZlzF5rdfL7iYTf/sbt+
         oYUXzJDcW13TZ6gJDuXwS9R2GxRgaBTfWhI9cot8=
Received: by mail-qt1-f172.google.com with SMTP id l12so1309064qtf.8;
        Mon, 07 Jan 2019 09:31:24 -0800 (PST)
X-Gm-Message-State: AJcUukcmG7EekSdC8xg5vmI4KR5p5EWgx3UgANdUqjnsuGgd+2ilotUN
        NC/CYBajgQhKuV3TqT46+/9QlWjD1LGOkU7fxA==
X-Google-Smtp-Source: ALg8bN7qp/XTxMAJqAp6bP+UN4v2WYOWOeDRkPBA/o6Ll5Yllrtx7ckzxCZSK7aonxWJHK1lzGPX9z10VUYu0aH7mHk=
X-Received: by 2002:a0c:e2ca:: with SMTP id t10mr63129488qvl.77.1546882283974;
 Mon, 07 Jan 2019 09:31:23 -0800 (PST)
MIME-Version: 1.0
References: <20181207125844.18775-1-malat@debian.org> <CA+7wUszBpmd2r18WZVjAXv2xq+ySrnKTqaRT7bGcHa71_M_j7g@mail.gmail.com>
 <CA+7wUsxN664BUjetUX3LhjN4JvZAAWY_Atv2d_eE9_UFGGwg2Q@mail.gmail.com>
In-Reply-To: <CA+7wUsxN664BUjetUX3LhjN4JvZAAWY_Atv2d_eE9_UFGGwg2Q@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 7 Jan 2019 11:31:12 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL=Q4cct+ZQR4VOnxxDsUog5D54hUqjjTYhtHV4d1LB-Q@mail.gmail.com>
Message-ID: <CAL_JsqL=Q4cct+ZQR4VOnxxDsUog5D54hUqjjTYhtHV4d1LB-Q@mail.gmail.com>
Subject: Re: [PATCH] video: offb: Pass actual name in offb_init_palette_hacks
To:     Mathieu Malaterre <malat@debian.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "# v4 . 11" <stable@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Elimar Riesebieter <riesebie@lxtec.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 2, 2019 at 2:03 PM Mathieu Malaterre <malat@debian.org> wrote:
>
> Bartlomiej,
>
> Do you need an Acked-by from Rob, or can you take it in the next round
> of fixes for v4.20 ?

Sorry, I missed this.

>
> Just to repeat myself, previous code would call
> offb_init_palette_hacks(), which in turn would do:
>
>        if (dp && !strncmp(name, "ATY,Rage128", 11)) {
>
> with name=NULL.

I prefer to fix this properly using node name helper in
offb_init_palette_hacks(). I'll send a patch shortly.


Rob
