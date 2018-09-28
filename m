Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D33EC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3AD8216FE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="I9Lb0Z40"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3AD8216FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbeI1Nng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 09:43:36 -0400
Received: from mail-qt1-f178.google.com ([209.85.160.178]:38782 "EHLO
        mail-qt1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728825AbeI1Nnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 09:43:35 -0400
Received: by mail-qt1-f178.google.com with SMTP id z13-v6so5599779qts.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 00:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NGenF/m9ckJHYVDUVTri8N4wb7OxwY51oo+K75pNda0=;
        b=I9Lb0Z4030h/BK62Ocw4q46XUhF6ypBy88iTUluVPvpHBHAH3+SuZ9sWfL3Yci30iA
         1Lv50ZNNBCTGgW3tGiYPxpU1j7H5cYV6/jbbuSUZ6TaZQIPwyo30EUE3oAraLju5Ckh3
         JVTINviCPPkR4/+VVKr7xjC66HiStfDiVxnCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NGenF/m9ckJHYVDUVTri8N4wb7OxwY51oo+K75pNda0=;
        b=pLTxLporGmgwhgBayzoprC0GZCGzZbkHPJ9cC88aB680ACKoGLh05wCHvTShXJhju2
         zcFX9aCYIqVy04zqeEmTOnCg7OjB2uupD9FCbxawNip+/b+NPnlYhD5w5xDbGw1uPxA5
         4x0ThFG/HfNySNn0I5EJ8opWZ6aY30+DPS+H9y8YLB5Y/GLXq8jRo0pjuC/KnZ8JeGXl
         C1OTuAyRKAl9GBenudcsvdSIaTjIvCr3R3Y+G1Ij2iVLLycas8P2a36hV6ta2aHlj+O1
         Hht63nsdC7rk1u0A2FLSHJmD9oL2MGC+/MqZVrsbQGktOLqvB/axI5fgdhxiQc7Xq9vS
         VouQ==
X-Gm-Message-State: ABuFfogxDSQ3pnOQDcGOY3Qa++xs8L4anWpr3veUnLDh7LlFovGBUBuL
        lGxpLGfXfu2m9rXLSVMoeW0bku4xdl9MaCWK27iHlg==
X-Google-Smtp-Source: ACcGV60aVMzbV5dkZLBpjx6ID3fhYHdEneJPaklANc+rm2Pl7Xbl7tqWwwTGOal47pyqJw7Bis8fMisF8unrFbeWniw=
X-Received: by 2002:a0c:c202:: with SMTP id l2-v6mr10833840qvh.209.1538119272699;
 Fri, 28 Sep 2018 00:21:12 -0700 (PDT)
MIME-Version: 1.0
References: <20180812142413.20856-1-ctatlor97@gmail.com> <20180925173801.3835-1-ctatlor97@gmail.com>
 <CACRpkda4SuPVz8Awg6OhhanmZKEs4URw3WBMv0Fa8iJa2MD-KA@mail.gmail.com> <43F103C6-7ADF-4D4C-A930-376D66F538F0@gmail.com>
In-Reply-To: <43F103C6-7ADF-4D4C-A930-376D66F538F0@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 Sep 2018 09:21:00 +0200
Message-ID: <CACRpkdasDARc-5F7tp_AMsWKCHG3hEhexrfMFbZjWkawdxTOog@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] pinctrl: qcom: Add sdm660 pinctrl driver
To:     Craig Tatlor <ctatlor97@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, neeraju@codeaurora.org,
        vabbar@codeaurora.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 6:30 PM Craig <ctatlor97@gmail.com> wrote:

> You seem to have missed the bindings, it might be an idea to drop and reapply with the new ones I just sent off when they get a review.

Nah I just didn't coordinate things. It gets too messy sometimes, I will
apply the bindings separately I guess.

Yours,
Linus Walleij
