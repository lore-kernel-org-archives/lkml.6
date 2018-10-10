Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9210AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46EA121479
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JWIuTXI1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46EA121479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbeJJOkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 10:40:49 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:37432 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbeJJOks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 10:40:48 -0400
Received: by mail-it1-f196.google.com with SMTP id e74-v6so6572229ita.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 00:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SfuyolRq1HBe5f1/Ccj4iZSwD1WB5iDmViUiQGCl1wA=;
        b=JWIuTXI1f82P7N2OlX27deyxLYF3J/dGnDU1YCsXncbUY/2ERwSyV/bpxAsHhqFent
         b4yPWqWnCbXU4B44fk2bmWQs5N11AVCyn8SpxP1aj1w1fvXqukKpFzzIOH35IWz+KCJZ
         AhsvqrSPfD9SeNNPLAaCcp6N02gwLaskGVbPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SfuyolRq1HBe5f1/Ccj4iZSwD1WB5iDmViUiQGCl1wA=;
        b=QPLHynK4Pn5pGEywdzlHAAkh+CLroBBlDF9xVhQpWCTopq3BHkSYZ0aRyYayLgIx1O
         INZpIW8nUK6pQZndYt+kMgfTO3pTGafiDCQ7FJrV74Ue27t3XXhGiR3tAy/PwRs1bgdU
         d8R8IUjtfIqnYO7GsvBQvzhXjqzulFiLbiJ2AKzPSI196cDf5nYgrz1Hl7S9aSJZ0aRB
         pL4dxI4/Coc9WYKVch4416+Ao1tGgL6865Ju+v5fiIgcWozhp+t5fVgHfdaITyGoI3FO
         n9zwyifZ7KWfX7Rfl1GMUqD8sSnPfvN8I0FbdJ6tPHgH846dIrD2gNz7+00iaD8tGTFj
         B+Yg==
X-Gm-Message-State: ABuFfogj/74DOHygCTGfdUoIDvJ4uCw0SWVcZTttUx0vBsCqnYSxtD7X
        yGrVxu55ALvMkFweazLS7jzfRtnKdi8MYFUz1gN1wA==
X-Google-Smtp-Source: ACcGV60/OgZsN5SOAHFpLoZK3X4ZHHQqXyPsUu3qejY6i2MiU/K59ksFa8SzlM7qDQfCeu1KxsZMIwQizl2ASxfJgyU=
X-Received: by 2002:a24:7b50:: with SMTP id q77-v6mr3820163itc.154.1539155999509;
 Wed, 10 Oct 2018 00:19:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180928131531.4598-1-Eugeniy.Paltsev@synopsys.com> <20180928131531.4598-2-Eugeniy.Paltsev@synopsys.com>
In-Reply-To: <20180928131531.4598-2-Eugeniy.Paltsev@synopsys.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 10 Oct 2018 09:19:47 +0200
Message-ID: <CACRpkdY6gUU8ck5PdjrWQeX_x4sxJ9qg14JYwjeZCKq6m2sXZQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] dt-bindings: Document the Synopsys GPIO via CREG bindings
To:     Eugeniy.Paltsev@synopsys.com
Cc:     "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 3:15 PM Eugeniy Paltsev
<Eugeniy.Paltsev@synopsys.com> wrote:

> This patch adds documentation of device tree bindings for the Synopsys
> GPIO via CREG driver.
>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> ---
> Changes v3->v4:
>  * Fix #gpio-cells description as driver is used generic GPIO binding.

Patch applied.

Yours,
Linus Walleij
