Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F87CC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0576D20850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WyXyKKIm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0576D20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbeLFJY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 04:24:26 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35126 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbeLFJY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 04:24:26 -0500
Received: by mail-lj1-f194.google.com with SMTP id x85-v6so21021003ljb.2;
        Thu, 06 Dec 2018 01:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yPQVP8JTQ4KzcddgF1WE6uBEXF/pHlDt46krXsOLGTQ=;
        b=WyXyKKImD9BlaLe/Q5Dbgw2QL3r5Ahh2nerF5u9ILk5Jz1UmBHyHb4DcX9A6w0bNA8
         N/LM7XSm1dwU2rs20yoM6zYveknrr5Cu3PG0ow8sclzRJ+btwR3AvKnb9iEdubRPt0zF
         nY9itLrcyp99caTOGkPm3pjF36zacoDHSNO9MKvYY0dqLnvLP05Ok+B7+Ty9h6oCtFkK
         liESIHeJOMkH9SKtZQfmJW7Hj2GHvGCRNfclNJF47eWj1qbARSSukO2eP3SB8u4jJ/2G
         L9Mi1mhcDlsg9FmtxBhOUapFYlzPgiWZ21izOTdPbIRRIZqOSHm0o1Iy/1SjBalLi6WB
         srMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yPQVP8JTQ4KzcddgF1WE6uBEXF/pHlDt46krXsOLGTQ=;
        b=TD9lv9Cc2FW3a3RZMrM+ZpP480KdNY+FmqCOq7QcBz4fe51P54PJDTwmQxodwmgnwz
         pftVe4IcszVF7bZGcd5yxSwvKoQ/zGzhjYLNto6sj/qB9mprltC6DhFocZdFhtJGhGKH
         Uf+S4zYi4IJeLAFL6SM5wd8XN8BHGN0jx0DsXXSSV27KtFP/q+MJgvsPhBEng3YEnzkX
         9GDLKAlYL96Tk2QEWrn+FgX2HNew72fxNbGrRF44Ci/HEGOLdxHoGghsz+k9mHvzYHnl
         ABqWvoL3w3fRSeujWa/N/kpcE+SP791vuyKyF2y5gevmxHfqKSSlKcjwqWd8xQyk4yxC
         2FyQ==
X-Gm-Message-State: AA+aEWaFj0Gmz4CBsqtmyNALCHDKBo+LpBt2anJtgJ8UgeYtXZZGxdRw
        ENIPNMdp+EdSIc06W+DGx0YKpmGY7vZ/CUxt09o=
X-Google-Smtp-Source: AFSGD/W1jYlsk4sl/gM1PlXTKT8NA0/NyGJk3WGiIw/1Uk9ESauZbHkYQ/Y/1WZUB1tTRJ1tyWV3AI9YY1xWeoZf7lo=
X-Received: by 2002:a2e:4601:: with SMTP id t1-v6mr19342235lja.111.1544088264028;
 Thu, 06 Dec 2018 01:24:24 -0800 (PST)
MIME-Version: 1.0
References: <20181205230336.GA23462@jelly> <82d624a7-349b-c706-cda9-81a22f2473e0@ginzinger.com>
In-Reply-To: <82d624a7-349b-c706-cda9-81a22f2473e0@ginzinger.com>
From:   Benjamin Tissoires <benjamin.tissoires@gmail.com>
Date:   Thu, 6 Dec 2018 10:24:11 +0100
Message-ID: <CAN+gG=FVvUFcYYcBnaOaj-YRQCgu4-FYFuJGccHhK+u31EjuvQ@mail.gmail.com>
Subject: Re: [PATCH] Input: restore EV_ABS ABS_RESERVED
To:     Martin Kepplinger <martin.kepplinger@ginzinger.com>
Cc:     Peter Hutterer <peter.hutterer@who-t.net>,
        linux-input <linux-input@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 9:36 AM Martin Kepplinger
<martin.kepplinger@ginzinger.com> wrote:
>
> On 06.12.18 00:03, Peter Hutterer wrote:
> > ABS_RESERVED was added in d9ca1c990a7 and accidentally removed as part of
> > ffe0e7cf290f5c9 when the high-resolution scrolling code was removed.
> >
> > Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
>
> Reviewed-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>

Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Dmitry, I do not think this one will conflict with the high res wheel
patches, so I think it should be safe to take it through your tree.
If you think it'll be an issue, I can also take it through the HID one.

Cheers,
Benjamin
