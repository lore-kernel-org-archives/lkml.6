Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCE1C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE1F020844
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5gjOUcS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfBKIFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 03:05:35 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38528 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfBKIFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 03:05:35 -0500
Received: by mail-pl1-f196.google.com with SMTP id e5so4953169plb.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 00:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B3tSWadTEYw+gx7GjXMa7qqxCfztekdoMTiCcEiy0CI=;
        b=e5gjOUcSK664uR0kKPfeKFSLtlmQrp1+IPX1h2yd4fCuvjIxXI2L/NaoRuLLU6v86T
         P+BXehbnLKRzReGBCse7B9s/eaXbh+CRgT1crtxUplwkfyS9nM89jt07CL7bnLocxXvC
         0RWkQoSmoZaqkIkV844KPQuhgl1PYGYL+HUjbaTQJ9sW3FMu1A6HDAJKH9M77qDRQ5y0
         rwpFnbyH5eVTOJ3HibDe5B5ZJFiWnYKvS0/im1FMldDZaYgan3eT0oYGLe6YXbRKYj3/
         3dE3rGxN95WCYYAQqjBRN1txacFrnnoMZlc9eGrw1VBbWu8nAYcPGmJGmaEn20gX0PW+
         2qRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B3tSWadTEYw+gx7GjXMa7qqxCfztekdoMTiCcEiy0CI=;
        b=PP1bDjWv4ZI7CE4nngKvEnUIB9Jll7rjbQPhP1TvxF2mNCPY+BvjBVdI1l6HFrKtN6
         cM5W/p487YtH8Y9dy+W2NIrzwP8Ejk6nTZQFySCVhcjX8oBlLDQbQv+GRQs8aM+FZXZh
         QP7Srp4EgdRmk043epfv/TIeA/niDKSSmiJDnAT7vCopYjNkS5T80Ls1581jTsRvqJIM
         0Cw60uZkh61pzlRvhEJi+6xqihKbMruCsUFcaJYwOGzmwb24uKOL6ophyhWYSvc9LNjw
         kgtiT3CCD3+GWk6gCcr/DZ0jU4q9a03xO/fAqlOzLs5EgzrRa6XVVsilWv1ldus51Htw
         6CCg==
X-Gm-Message-State: AHQUAuYR7kPaJVJqlm4aFEnWZQ7sHPM6m8S5+/80LbTsGrYQj6tzrGPO
        n9V1+Kke96MMwKWDk3Vp/Zeu0nJ15YTW/jpgbh4=
X-Google-Smtp-Source: AHgI3IZZZ8QUu8JQNIDCyMofqEw74fz915ItBaLIk6aupaTuI23+N7LsdNlNX9opaETANw6fOe97VJA4mo6SUA/x4EI=
X-Received: by 2002:a17:902:12e:: with SMTP id 43mr18832067plb.31.1549872334811;
 Mon, 11 Feb 2019 00:05:34 -0800 (PST)
MIME-Version: 1.0
References: <1549553629-8414-1-git-send-email-Tianyu.Lan@microsoft.com>
 <1549553629-8414-2-git-send-email-Tianyu.Lan@microsoft.com> <alpine.DEB.2.21.1902102247100.8784@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1902102247100.8784@nanos.tec.linutronix.de>
From:   Tianyu Lan <lantianyu1986@gmail.com>
Date:   Mon, 11 Feb 2019 16:05:23 +0800
Message-ID: <CAOLK0pwdQGeyKYYkUbZtizR5+ydf-KAp1=+z3s+LfMnjhS1Enw@mail.gmail.com>
Subject: Re: [PATCH V3 1/3] x86/Hyper-V: Set x2apic destination mode to
 physical when x2apic is available
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        Sasha Levin <sashal@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, mchehab+samsung@kernel.org,
        davem@davemloft.net,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nicolas.ferre@microchip.com, Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger kernel org" <linux-kernel@vger.kernel.org>,
        devel@linuxdriverproject.org, iommu@lists.linux-foundation.org,
        michael.h.kelley@microsoft.com,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas:
          Thanks for your review.

On Mon, Feb 11, 2019 at 5:48 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Thu, 7 Feb 2019, lantianyu1986@gmail.com wrote:
>
> > From: Lan Tianyu <Tianyu.Lan@microsoft.com>
> >
> > Hyper-V doesn't provide irq remapping for IO-APIC. To enable x2apic,
> > set x2apic destination mode to physcial mode when x2apic is available
> > and Hyper-V IOMMU driver makes sure cpus assigned with IO-APIC irqs have
> > 8-bit APIC id.
>
> This looks good now. Can that be applied independent of the IOMMU stuff or
> should this go together. If the latter:
>
>    Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
>
> If not, I just queue if for 5.1. Let me know,
>

This patch can be applied independently. Thanks.
-- 
Best regards
Tianyu Lan
