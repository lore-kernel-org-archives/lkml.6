Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E78C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C20C32083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WktduQmk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C20C32083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbeLGKLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 05:11:53 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33777 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbeLGKLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 05:11:53 -0500
Received: by mail-lf1-f66.google.com with SMTP id i26so2629808lfc.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 02:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YSWGdsQi0vhKA/DlRP53JX9l56Cn10UByWpqxpRZXHc=;
        b=WktduQmkM1H/PyMjzbTK33zBaZEl9fYlWsRDHaqyf5aZTMl6bOWjDx0XzwSBM4JeMk
         b8c+A8jt6aE/dLjQBU3RFrvt6vhP72n6ibPxbh8pbglqYtO4WmUPDESltekWXo/hW/9/
         lHajPWZ5SI1XfF0eGT6zBo/dmY9WBMje4BVIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YSWGdsQi0vhKA/DlRP53JX9l56Cn10UByWpqxpRZXHc=;
        b=dnS9MGOi6yaxUFEjmydxo1lh/n5AUNJC0DRJyKKXprJUVFwH8Hv93eo0COo6kxT2Pj
         QM/sjHm6XzO2iuwVcMwEQBKdKQX/7DF040Fn3EkPYyw0lvBIgjmwESN5LS58dYR+Mpo4
         LHFbCCxWdYlNhzJOfk8tzQ48PNeQ8t2cOgbN78jL2QTr1yqfKd6RUj7HNERzgn8JMUhh
         q37AtI5RwB6soURdsqmt3OZUQCEb3Q37wPy6KPChdyZ0JhzBBSnNkMJVl50i3iqdlssC
         cjNuwlHITuQNIbDD/MVFPDrX9pnjaWpR7iNFzXsxDgJYWesABTPYi5x342JY0dMI364D
         /DOQ==
X-Gm-Message-State: AA+aEWbcub9lAjXg7H0ltxEjzCfQE196HVNDwj+42kGiGFIO06B1OLao
        ChdkBl7KNTpr4ULeNoZJBY6ZWBdc+FN9t151wyQNrg==
X-Google-Smtp-Source: AFSGD/WS+9oDLr6J6MZ0zgP8+ZNdINL+0FEtQoAw1kpt0zhZ1G6n/+RRErPFv2hy/unUbyYnz5Iri9GRTzKtmchbYus=
X-Received: by 2002:a19:5154:: with SMTP id f81mr1016826lfb.96.1544177511701;
 Fri, 07 Dec 2018 02:11:51 -0800 (PST)
MIME-Version: 1.0
References: <20181130163617.3778-1-tiny.windzz@gmail.com>
In-Reply-To: <20181130163617.3778-1-tiny.windzz@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 7 Dec 2018 11:11:39 +0100
Message-ID: <CACRpkdbX0GyrxsxAvjk8mH-_zwkGD6MKxuNAyAo==OqOsdWAXA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: Change to use DEFINE_SHOW_ATTRIBUTE macro
To:     tiny.windzz@gmail.com
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 5:36 PM Yangtao Li <tiny.windzz@gmail.com> wrote:

> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Patch applied.

Yours,
Linus Walleij
