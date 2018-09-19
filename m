Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6503ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 19:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C1BC20880
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 19:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nx7FwvUL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C1BC20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732471AbeITBVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 21:21:55 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:40732 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732351AbeITBVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 21:21:55 -0400
Received: by mail-it0-f65.google.com with SMTP id h23-v6so9290690ita.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 12:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mnv5n65WnPoQRrR8ZglIYGfL/mOdF69NldNji9okAFo=;
        b=Nx7FwvULeJTSVPSBVe7xMrVaKThkbtsq+r6MXIWUfj/lI0pCj63cKU6HaXMK7/ykmQ
         BBolDrF61YHEYIKdcqEk3mqiWN8rQePyEj09P5CW5L6vob6hZDwab5zbjyk3qfXlsrUx
         WDzhnCkb2OI43EqE7ZRecN4xlSN7rEdkXQ/jE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mnv5n65WnPoQRrR8ZglIYGfL/mOdF69NldNji9okAFo=;
        b=AQbg3g2TRRVUh3XH2Vsm41jl1383xe5kVtGvPSHHJmwiZDdU/heif/aGOVau6jKxJQ
         HNuAl9j7DxcgmhcWf9cvVMFycQV7t03fgI5YD1kA7MZadr95VGzVNDq5U+o1DpC4QE+h
         CkSQJ+eEhohqFxFp7e0lUT5Cd7vJuSWggxecxKQHHco6Dq3uTtiEcNj4F6kQmmu+mM0g
         I8crRyZIDVduKjwjSEWztflgNRrLtKheShM/3QJb0BtbQJzt0KSMrFWN23SEwWepXh4f
         n+60OKRWbZx60/XUl1DGHB16tylqmYB9rQaNeQbfQyD+55QNIiswBCf90bGoShwenMok
         jOZg==
X-Gm-Message-State: APzg51DFwM0+fnCAScFyshB75KnbbJExIKxTlBP3VNfVu8GfCmuzdtNb
        87L0aou6b61tGck558RueA3mtUBo4eW+gRudUqxf7rUi
X-Google-Smtp-Source: ANB0VdadPgElP6YxxeT3pITRxRr6+fkW6L2pQP8zeET45+lXLb4a454bFtHBQgLMMMnCpG+CdlFmdavZ1m/bxPJ4RvM=
X-Received: by 2002:a24:6b0d:: with SMTP id v13-v6mr23765050itc.16.1537386150769;
 Wed, 19 Sep 2018 12:42:30 -0700 (PDT)
MIME-Version: 1.0
References: <1537363669-25991-1-git-send-email-amelie.delaunay@st.com> <1537363669-25991-4-git-send-email-amelie.delaunay@st.com>
In-Reply-To: <1537363669-25991-4-git-send-email-amelie.delaunay@st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 19 Sep 2018 12:42:18 -0700
Message-ID: <CACRpkdZeSxCGKMePTWiey=QshrW3reEe6aqZxJA0yU2UnDFETw@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] dt-bindings: pinctrl: document the STMFX pinctrl bindings
To:     Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 6:28 AM Amelie Delaunay <amelie.delaunay@st.com> wrote:

> This patch adds documentation of device tree bindings for the
> STMicroelectronics Multi-Function eXpander (STMFX) GPIO expander.
>
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>

This is looking very good. Simple standard properties, and
very clear information on the use. A bliss for developers.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
