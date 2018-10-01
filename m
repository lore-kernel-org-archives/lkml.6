Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F238C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F241720652
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jVzheXKQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F241720652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbeJAQHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 12:07:37 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46727 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728961AbeJAQHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 12:07:37 -0400
Received: by mail-io1-f65.google.com with SMTP id t7-v6so1342875ioj.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 02:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bCJwugkz5Qojv9M6xWVDp+lXOXLqHABjNmdyM5scqd8=;
        b=jVzheXKQ/MpFL4n+HklbMW/IHccZpe8RP3dPi937jqag2YITZOIKyExG8EKhOS4jlT
         Iq07Ayx0JkFQgYeA4wsYPfySb9Agy4AtXvcmBTltLAuF68RBTkddeyTgq890OJ+QZxuJ
         QS5jgZAY3ikMHaezGmzxSJbUwnmBKWSU1vWWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bCJwugkz5Qojv9M6xWVDp+lXOXLqHABjNmdyM5scqd8=;
        b=cba9ZJnjhHpiUCE1/KVjsFXOXRmm/MD2wEA4vsEWQRuTpVFNgFjHGMK7MUDCTGFQl6
         XB0q6uYoF4eBwSJ2CtE5sa08Pi2gX1/NM3UYKVCv3AkRDkuZsFi+U6k/OKWOozsBMTmF
         0i4QkAyYE3GBiL4IVDs46BP9rRfS0BCb1e6YRBb6MPxrhaWL3U5zGgIOXoGc7EcOyBy8
         oSh6Ns6fnvoeDRcG+Vzd/IBhuDQDi5MX3jwnkhZd8zV5nVClp7FFtpSnMIQt4NLEQMva
         Jw43pjqXc11ICV8h2l2qhIWpLn+oKMQ08dXtl3EjDXx9DDaa6MbvQIu8JjddGaklOsDB
         YNtw==
X-Gm-Message-State: ABuFfojzEvQ7iU8MgJTRXwXBL9tZWCaIKh50a65oL935tUEvcSXTHO7o
        qCtp/Fb2aOXEOxY9fudnH/jb/H3egu4L28azuIXVHev2
X-Google-Smtp-Source: ACcGV61PVbxpOLqMupImVv6Yw3kyUd4A+J639FW3UZ2PTLHpP+dsxX4YWvZUUaA9P8aib6pJq5i6GJIHf9Qi/UVWww4=
X-Received: by 2002:a6b:144b:: with SMTP id 72-v6mr6260311iou.218.1538386245206;
 Mon, 01 Oct 2018 02:30:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3941:0:0:0:0:0 with HTTP; Mon, 1 Oct 2018 02:30:04 -0700 (PDT)
In-Reply-To: <1537523181-14578-10-git-send-email-ludovic.Barre@st.com>
References: <1537523181-14578-1-git-send-email-ludovic.Barre@st.com> <1537523181-14578-10-git-send-email-ludovic.Barre@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 1 Oct 2018 11:30:04 +0200
Message-ID: <CAPDyKFq-KUNuftT1F7TXMU-Jceqi9GYTWC4Jb7qn3UdpXHR+9Q@mail.gmail.com>
Subject: Re: [PATCH V2 09/27] mmc: mmci: modify dma_setup callback
To:     Ludovic Barre <ludovic.Barre@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Gerald Baeza <gerald.baeza@st.com>,
        Loic Pallardy <loic.pallardy@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 September 2018 at 11:46, Ludovic Barre <ludovic.Barre@st.com> wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
>
> This patch creates a generic mmci_dma_setup which calls
> dma_setup callback and manages common next_cookie.
> This patch is needed for sdmmc variant which has a different
> dma settings.
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
>
> # Conflicts:
> #       drivers/mmc/host/mmci.h
>

Please remove this. Looks like some of the other patches in the series
have this in their changelogs as well, please have a look and fix them
all.

[...]

Kind regards
Uffe
