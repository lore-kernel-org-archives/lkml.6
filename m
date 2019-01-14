Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858F2C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 554132063F
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="fGckE1ub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfANLjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 06:39:25 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45487 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbfANLjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 06:39:25 -0500
Received: by mail-qk1-f196.google.com with SMTP id y78so10270064qka.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 03:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=834xKIynk/o9voPxmczwLTwxDuUNC859N0LEpxFn33I=;
        b=fGckE1ubOKS2i7PI1U6t15AhGAXoHSA7giv/EiFhEyjjygpSABxFbKwNCFZxNpTYfz
         mX9O/mFN5/jXh8fWVhT7pK09L4/aXwnsM+YkudiGypNCYuJph0LmcokztBkVn30UBpjr
         FE4c6Kf84kEzGOiR3Ue61Xe4theNyKyUYOC4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=834xKIynk/o9voPxmczwLTwxDuUNC859N0LEpxFn33I=;
        b=noYp5p6zNPbc1TYuSVi2vtyHEoCtNYZPVDAQIj8FMjXOiAWyzatWJyEyX+zXE7JXE0
         WfdXEj0154DQJ2ksAHVbH3bjuNeoF/3HjHcuySMfak/A880GraxzfZRtkwAr5ZYYhoRD
         Tij2d4EckrDLnjMqytonkxIaipbC3LnGIO0G8zaZHAmH4DGRxQDYPevV+23udXIyQHjm
         uxewVJQ/d6hn7yIG/wBTMhKNDaMk+eJR90lLuE3ZUZBzIazWo+i/z2+5FEv408Op1+zl
         V7aY3A5jr95rEYLeMh/aJ4Ss0qLWTyYyzOlXdwYzw6+XUjJRhcLCsJSgOXf4eWzPu7M6
         18DQ==
X-Gm-Message-State: AJcUukcaAiZ2OmjufEGxWnQPYu2JG29o/IdRmb8dfNllh15i1GYMRS+2
        e8rKwoZ0L2f4r7aEqKS7IXN5cHxzOpPAJOecPys+8XLJ
X-Google-Smtp-Source: ALg8bN66R1hiIVUdRwNQToedgoHpv4ikmM+/P0uly/Kr6mguPbP+HegorMajkTCWHXRu/PyoLr4sDjlaU8Jl5hgzNCE=
X-Received: by 2002:a37:bc06:: with SMTP id m6mr22843777qkf.336.1547465964198;
 Mon, 14 Jan 2019 03:39:24 -0800 (PST)
MIME-Version: 1.0
References: <20190107214136.5256-1-jae.hyun.yoo@linux.intel.com> <20190107214136.5256-8-jae.hyun.yoo@linux.intel.com>
In-Reply-To: <20190107214136.5256-8-jae.hyun.yoo@linux.intel.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 14 Jan 2019 22:09:12 +1030
Message-ID: <CACPK8XcBKnN=CJy+pVruZh=8qZNdr4pNt=hV50Ev1k6YgYtAKQ@mail.gmail.com>
Subject: Re: [PATCH v10 07/12] dt-bindings: mfd: Add a document for PECI
 client driver
To:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        James Feist <james.feist@linux.intel.com>,
        Jason M Biils <jason.m.bills@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jan 2019 at 08:11, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
>
> This commit adds a dt-bindings document for PECI client driver.
>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Andrew Jeffery <andrew@aj.id.au>
> Cc: James Feist <james.feist@linux.intel.com>
> Cc: Jason M Biils <jason.m.bills@linux.intel.com>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Vernon Mauery <vernon.mauery@linux.intel.com>
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>
