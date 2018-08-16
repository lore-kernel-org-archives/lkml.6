Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A082EC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 10:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49EBA2148C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 10:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Q+dkWdls"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49EBA2148C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391042AbeHPN2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 09:28:10 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:45217 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbeHPN2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 09:28:10 -0400
Received: by mail-qt0-f193.google.com with SMTP id y5-v6so4582220qti.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 03:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aCnH6lnjvaMn8WNGrMxOF/DgJ+jdC3xDsu7GYUDnc+A=;
        b=Q+dkWdlstYpe0AGMEguuzAqydHOblZSlglmT/qFsXaX05xS81+5BWsN4ATqIj5/6A7
         /lgjzdj8lLx97leCccx/5qokHM/psO+s/oud7hYWyNxWGelUhOJBZ0XsxmUo7m4JYQGv
         456N+d/HLwYPoVJ/CIfpLjiy+36ZTwN271SL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aCnH6lnjvaMn8WNGrMxOF/DgJ+jdC3xDsu7GYUDnc+A=;
        b=HE8aL80IfxbWs5Y33QBDwqrATsy+8Q3Gk3DovYUR1UsQLjzcNgR6/0m05NElGKm1yB
         8Dv0Qczuz6tn3upgVzQyp9+vQ4mxB19ZcYCdAcl0O5lYZjBCYvLZRZGLMWwXVoQLeevG
         48+6Avjeavlsj97fFwkS5VjWJuA1kqId9CurD53PB6XqqbwmuKGGCRwBjfVtrpB0DnCH
         hMtphomIHX8uMO7p+HyNMoVyr3ZAV25CCuD9hND/odnc7QqP6mdAhRsIBdTkEwnzYpOn
         4snZKrwpMC0hKV8RyLZh0hfS7jVbKzlJI8tkP0F/ZbkOZVqspTpFy3vZQosq7ZEWxrHZ
         /cbA==
X-Gm-Message-State: AOUpUlGMyQ8mEHWbG2ZxFmDcsm+rNP6SRm/pFOXL6+qK5KI5VU+hS7Es
        HWwVud9J5lY2afIFFcVFfSIr442/QXwPq1OHZeUt4g==
X-Google-Smtp-Source: AA+uWPxv608BvRXjVOKgZ1GLqWZCbMb7acYyt/KNDnFMYg9WIJpRvcEgCcQswGHhGXF/y4U8wpPSMP1fT7yTDN/BQ60=
X-Received: by 2002:ac8:274a:: with SMTP id h10-v6mr22034517qth.187.1534415433601;
 Thu, 16 Aug 2018 03:30:33 -0700 (PDT)
MIME-Version: 1.0
References: <fe07a1dbe1f6699b4a64444505ae2dbacc2155cc.1533926549.git.joe@perches.com>
In-Reply-To: <fe07a1dbe1f6699b4a64444505ae2dbacc2155cc.1533926549.git.joe@perches.com>
From:   Selvin Xavier <selvin.xavier@broadcom.com>
Date:   Thu, 16 Aug 2018 16:00:22 +0530
Message-ID: <CA+sbYW2bHrV_Tx6rMYj1h9f3i_sJ=7zPMDbrfWWx229CNeQc2g@mail.gmail.com>
Subject: Re: [PATCH] RDMA/bnxt_re: QPLIB: Add and use #define dev_fmt(fmt)
 "QPLIB: " fmt
To:     Joe Perches <joe@perches.com>
Cc:     Devesh Sharma <devesh.sharma@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 11, 2018 at 12:12 AM Joe Perches <joe@perches.com> wrote:
>
> Consistently use the "QPLIB: " prefix for dev_<level> logging.
>
> Miscellanea:
>
> o Add missing newlines to avoid possible message interleaving
> o Coalesce consecutive dev_<level> uses that emit a message header to
>   avoid < 80 column lengths and mistakenly output on multiple lines
> o Reflow modified lines to use 80 columns where appropriate
> o Consistently use "%s: " where __func__ is output
> o QPLIB: is now always output immediately after the dev_<level> header
>
> Signed-off-by: Joe Perches <joe@perches.com>

Thanks for the patch, Joe.

Acked-by: Selvin Xavier <selvin.xavier@broadcom.com>
