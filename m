Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFEEC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3426B2089D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FKhmomnF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3426B2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbeIZNpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 09:45:33 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38814 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727139AbeIZNpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 09:45:32 -0400
Received: by mail-io1-f65.google.com with SMTP id y3-v6so22518553ioc.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 00:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9tUwlxtjju7PUx3Y8Sxrig4iRFK3RYbfktecAdacTy8=;
        b=FKhmomnFwec2RejFSUsAbyd8BHQUKrSwQnrXOTswZpXxOWRGJpTfjqt1SW9wUlcuDQ
         sj9WIM+W7he5G7ePcNbdT4HdRlCy69eio3/H8oaQmxW05bbjardT8ZKiR2wwAiUVutxZ
         uDqxNt190+h3ak3S6Nte7/BHKub1iUGdgEbXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9tUwlxtjju7PUx3Y8Sxrig4iRFK3RYbfktecAdacTy8=;
        b=mmEMdQaEqzoyhAVtWQOw53avgGt1SVch+Nl6jndyIGV0wMuiF+N7TfkdfIb9QGlb8A
         X7U0Pd8yUYfEe5YpiO9QwWGc+qQ/HyLX0vUZBB+THie3zAHCs0vttXuJow6JvMrC9Kth
         DAHLWJ++i3GVlkG0hL2MjKf8bixBnNkTLUduZLit5Vea7F/LUOQ9c6EiSwFBfkdoIsZi
         mcmBCfuXMmhpTTbLluvsPpRol2LLGWXEZoe9+qk8Y028qx/HkGM2QCt3Ph0cBzxuRneq
         dgCATMo0Jl82id9yfP+A1u4BR6r2cV10TZ+hfYDULFsV9Z3AQKajdvGYN6BfZwoPWpyN
         nYtg==
X-Gm-Message-State: ABuFfogIkSnjjAf3QMskmf6NbMdZ4FFl3uETax2LgooSjojeqDZP/ziR
        vffeWJ3BHLTXli99Re5q6SrKjbkqXYwB5tHlpzOzEIBm
X-Google-Smtp-Source: ACcGV63abI2GLYktztonGAHPkM4XYVxUTqrW7wdBPMujVYABVWL+5d2xcWf2FwRJYWV0U+jBJcnYcDz2NQBZhClpmEo=
X-Received: by 2002:a6b:4006:: with SMTP id k6-v6mr3668337ioa.277.1537947238536;
 Wed, 26 Sep 2018 00:33:58 -0700 (PDT)
MIME-Version: 1.0
References: <20180924221748.21584-1-bjorn.andersson@linaro.org> <20180924221748.21584-5-bjorn.andersson@linaro.org>
In-Reply-To: <20180924221748.21584-5-bjorn.andersson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 26 Sep 2018 09:33:46 +0200
Message-ID: <CACRpkdbWVxQsSFtS6FUpn0sBygsQs-jHx0eX196K2UVQXFwntA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] pinctrl: qcom: Add qcs404 pinctrl driver
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 12:15 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:

> From: Avaneesh Kumar Dwivedi <akdwived@codeaurora.org>
>
> Add initial pinctrl driver to support pin configuration with
> pinctrl framework for qcs404.
>
> Signed-off-by: Avaneesh Kumar Dwivedi <akdwived@codeaurora.org>
> Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
> Signed-off-by: Anu Ramanathan <anur@codeaurora.org>
> [bjorn: Reworked tile handling and did some minor rework]
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Patch applied.

Yours,
Linus Walleij
