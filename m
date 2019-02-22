Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF3BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFEE420651
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="YSTjdAdQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfBVX25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 18:28:57 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44671 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfBVX25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 18:28:57 -0500
Received: by mail-oi1-f193.google.com with SMTP id a81so3041804oii.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 15:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6D7H3a9PPYZmjjan+tfEVDoVnXF+/XXrgr6BxjBrbKQ=;
        b=YSTjdAdQSUROhcKlSi8qfjmlfExMo8ob9rzh7Y8RJyVkazxFKX+4652KFlDbmaI4vU
         IUwLj1vZewGIfRE4DuKJwqGVkXYI1Ol0VURsY+j9xOcx0yewl+HMSUEIIaU2Ewb6wAch
         kPTsJvylw6yX/8V7DVZRe2BhytWURlBJRLYpXrNMpIFyQkb/T0lt83QzZWSjtrVmCeP4
         qC/KW1so9fMorxtH3DrTXb9a0yQ4quhuPMn1WNAcpds4C7w8TqkTu+qVLiXjouTpLaEf
         sk+f8pUVZkQ2tByqliokqlV9l+0YvRiwUeyfsXQw/brNAskOVP82Si3vrS79lqtJ3Kn5
         UEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6D7H3a9PPYZmjjan+tfEVDoVnXF+/XXrgr6BxjBrbKQ=;
        b=kpEPHvZZblpItHGIe1ZmOHFO4U+KRi4ah6Sy1rqJ/VaFj3H+6ijOoDDrGkuL8Ol30P
         p/oex0gw1Q+m9lzRLrCqPDgRS1cxggwu5UGKNukLS5fvpROavqycAcz3CMVyEcHUlqIn
         RtKyaWs2bcxXa3dimTOeMOXCEWAP4JiZ5g0ZqJlAwiPcraTq6UDm33BWMHSS9A6STlWu
         xXk9gdDOGyu+EZubkcrJ7lv/1a8rdTSF6zcMFjS3CRta5zHVCwVkuUyzyF9m2X+rJdlt
         3sWOUzLYj3rK+ZZlPd1jhZaTo7CNOGlXGQuIRY26ZIfPsQLffvoE+zF8/iAd8xcq7mDy
         8mPA==
X-Gm-Message-State: AHQUAuatio0Smkp6bsGANQO3irZn7V/KWFJiaxVLjU9ItCtT+xSVBXc/
        RTt90+SBS+4JoVNaHTATqw7ouyBpkTbDWrzBer29zt8lVLk=
X-Google-Smtp-Source: AHgI3IajqnMiyelBlUrcPiXx86RTujskPLdBXoEDiSM0TuLFJ+UCWFfpwnrfnfTLgv+f5ZlUw8B/ExuXsAMpTdI/Zts=
X-Received: by 2002:aca:4e06:: with SMTP id c6mr4141600oib.71.1550878136174;
 Fri, 22 Feb 2019 15:28:56 -0800 (PST)
MIME-Version: 1.0
References: <20190221002304.GA24732@us178.sjc.aristanetworks.com> <20190222.152226.1935918245873046733.davem@davemloft.net>
In-Reply-To: <20190222.152226.1935918245873046733.davem@davemloft.net>
From:   Kalash Nainwal <kalash@arista.com>
Date:   Fri, 22 Feb 2019 15:28:45 -0800
Message-ID: <CACBffj8eCCttTNtNbjs_OV0J8ufQpq=+JZ2xuWWe3UgM8OmjAQ@mail.gmail.com>
Subject: Re: [PATCH] Set rtm_table to RT_TABLE_COMPAT for ipv6 for tables > 255
To:     David Miller <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 3:22 PM David Miller <davem@davemloft.net> wrote:
>
> From: Kalash Nainwal <kalash@arista.com>
> Date: Wed, 20 Feb 2019 16:23:04 -0800
>
> > Set rtm_table to RT_TABLE_COMPAT for ipv6 for tables > 255 to
> > keep legacy software happy. This is similar to what was done for
> > ipv4 in commit 709772e6e065 ("net: Fix routing tables with
> > id > 255 for legacy software").
> >
> > Signed-off-by: Kalash Nainwal <kalash@arista.com>
>
> Applied and queued up for -stable.

Thanks Dave.
