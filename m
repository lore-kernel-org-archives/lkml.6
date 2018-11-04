Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DC8C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 15:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E56AF2081B
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 15:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OO3Xdjbo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E56AF2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731465AbeKEBM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 20:12:29 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41058 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730047AbeKEBM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 20:12:29 -0500
Received: by mail-lj1-f193.google.com with SMTP id z80-v6so5779875ljb.8
        for <linux-kernel@vger.kernel.org>; Sun, 04 Nov 2018 07:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jvkhNvnM9ZohD39AzfHzWqWMrYlBFhEa9Q4eftnxma4=;
        b=OO3XdjboQzZThg7hQO+go+1j7TKrvWpaNR1lUmBpkfz9pCGdhutjnnTU35zpHi7SrH
         8nGFRXz5dKk0Z5m6XlVGRzpkoJIdrSS8pqyi+HbUYHTQUNeVOSxJT7Q1ullJkjnaEVEU
         0ORFsgZUHT1xhaFL1Uy8ryKb2v/Ok+DqOA7SA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jvkhNvnM9ZohD39AzfHzWqWMrYlBFhEa9Q4eftnxma4=;
        b=hzKWKjVD6c21uI+q79MMvfnB6WUbudvtK0K64CdoR0CcawUi6fRXaCXlD7r3GftLej
         grWOFaMLAyPBxYdrgExoCs4efvzTl0PEqOiZ5Lm3/ub+ZnAOpSGUqtwy7AibuUA8xT6E
         Lln6FtemcqQ+T5BgiclsaNsJJK17BAY/G2CZgaeXXxk2IGSZw4+15KL1mjuRAYT6FteH
         cWlHo02M9smth0ScIjgM5urHjMPI4d3HTVUWb4IfDRFRp6l5ggX9fE4PGiTHjieGI2rC
         DLldoDy/x2Bu/zI+Ccja8cT+uPjFbBjSYeJlRrN3XzzQF5ZcQdvNClnU7dbZUE7GyTV3
         elWA==
X-Gm-Message-State: AGRZ1gLcmU/sb8AaMSyodwEbBy9GX70g0le8NseCfo3Spj6uB/oJgLy8
        oTjlw6G/lQWiCSKdsKopTOk39oln+K3/BOQ3n5AuNw==
X-Google-Smtp-Source: AJdET5fblVUJAc0VHAn+KUnb+kFPjN6zyMYxwwVYxsFyT3R/l119vByGLGvTtu4ZIasBoJzDm79Gy5LhCAZJ+34VQ9A=
X-Received: by 2002:a2e:874e:: with SMTP id q14-v6mr9101453ljj.120.1541347021176;
 Sun, 04 Nov 2018 07:57:01 -0800 (PST)
MIME-Version: 1.0
References: <20181102214532.17661-1-bjorn.andersson@linaro.org>
In-Reply-To: <20181102214532.17661-1-bjorn.andersson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 4 Nov 2018 16:56:48 +0100
Message-ID: <CACRpkdaynN0hfHukkxd55VZj4a4qZY-GrTjVDjv8_N3dJ679-g@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: sdm845-mtp: Reserve reserved gpios
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 10:42 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:

> With the introduction of commit 3edfb7bd76bd ("gpiolib: Show correct
> direction from the beginning") the gpiolib will attempt to read the
> direction of all pins, which triggers a read from protected register
> regions.
>
> The pins 0 through 3 and 81 through 84 are protected, so mark these as
> reserved.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for fixing this up so elegantly.

Yours,
Linus Walleij
