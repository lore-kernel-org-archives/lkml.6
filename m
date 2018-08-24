Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62729C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 06:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B97D2147A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 06:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4zvFocD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B97D2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbeHXKOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 06:14:20 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43827 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbeHXKOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 06:14:19 -0400
Received: by mail-lj1-f193.google.com with SMTP id m84-v6so6024902lje.10;
        Thu, 23 Aug 2018 23:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3PFxjWiIvvuU4j6tQi2oufaKGXSJXyEPKfqHX/nj5Qc=;
        b=h4zvFocDapxScqEF3Qgx93c7/1IVnqdiSjeF8QOxAPaQTifuOPBPfPwIsXHB5Ho2SU
         UnDbEZsUDSRCoSRc9cnHxlRokp8M9QtCEeSFwiM7NT3AqCLX1tMxjzk7v9MCdxw4IAZ0
         1Jkzy6SN0kZECrNcXyiHc8ziBXC9hhtVD+ZSzhfruno5t+IJXHB5qWf2PUsXTnpNJP8i
         wDhJmtTSWKk0cnoGHcL9tPdiqTrBj9N5EtbhLKGiZPaiHW8MG27oqEmT+VdfdtQCsva0
         bQxXjjiLOfMCtVi8EsJ1fkVrIl6vHcQQdQwQD5gP0uT62YKI6ELmMHF6UO6hV1ZfUQ91
         oVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=3PFxjWiIvvuU4j6tQi2oufaKGXSJXyEPKfqHX/nj5Qc=;
        b=klDmVB/MB2Dj5Ww0gK9n90fnlX80izQnxCXNDKUZ8qkvT4oJrt3slzK8NiJnb64V9K
         oagDgDQliyZ9hrjg7YQf3DmFY8eCrVwZR5UcTLpW3CteDNbEopUYryd2+PkqqPoQ4jxq
         YhhRxJwWxEDScZ11eJg3gb35fq6L5/xC906R/o0l4RsoJnUYcJMrr3pLq5Vg2+ttmNrN
         m98c/9z9MOpb2zVcVDMt5vAOqhIej6zqYw4Njus8MJzhbLI86w7cdI/bZ/EiNQo77Po/
         DqTcD5eEi/p3NL1iDO6HcPAoTmJCCuD+/OkCMmYnQmXU+T+e6y4RD6FGgEZMmi3wi1S+
         LTsg==
X-Gm-Message-State: APzg51BADqJSrmpcbfWAfbx3Qqpti6fjSShjmHVXK12M1vGPrV5FJA7o
        ZORUPkpryyIWa0pa7p8LAs8=
X-Google-Smtp-Source: ANB0VdaET7QUJnAkNQcShG8nqXJ/DWIFNggfmEy2MW3aZ5NKACzRLBBcTsuqc+OFzSlLcMkBwuMpRg==
X-Received: by 2002:a2e:658a:: with SMTP id e10-v6mr286305ljf.99.1535092865213;
        Thu, 23 Aug 2018 23:41:05 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id t25-v6sm1080482ljb.89.2018.08.23.23.41.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 23:41:04 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1ft5mH-0000Wg-DG; Fri, 24 Aug 2018 08:41:01 +0200
Date:   Fri, 24 Aug 2018 08:41:01 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     johan@kernel.org, robh+dt@kernel.org, gregkh@linuxfoundation.org,
        frowand.list@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        carlo@endlessm.com, ulf.hansson@linaro.org
Subject: Re: [PATCH 4/9] mmc: meson-mx-sdio: fix OF child-node lookup
Message-ID: <20180824064101.GT14967@localhost>
References: <20180822105547.9634-1-johan@kernel.org>
 <20180822105547.9634-5-johan@kernel.org>
 <CAFBinCAKNUA5_fz4bXqj-aCaDEHk--Ax5GXJt+nzVKSjbVHxLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFBinCAKNUA5_fz4bXqj-aCaDEHk--Ax5GXJt+nzVKSjbVHxLg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 08:50:23PM +0200, Martin Blumenstingl wrote:
> On Wed, Aug 22, 2018 at 12:57 PM Johan Hovold <johan@kernel.org> wrote:

> > Fixes: ed80a13bb4c4 ("mmc: meson-mx-sdio: Add a driver for the Amlogic Meson8 and Meson8b SoCs")
> > Cc: stable <stable@vger.kernel.org>     # 4.15
>
> backporting only works if the patch introducing
> of_get_compatible_child is also backported
> do we have to inform Greg somehow?

Greg is on CC, but he also sends out a notice in case a stable patch
fails to apply or compile.

Note that if the helper had gone in before the rest of the series, I
could have referenced it in the stable tags using its commit id in order
to facilitate the process:

	Cc: stable <stable@vger.kernel.org>     # 4.15: <commit id>

> > Cc: Carlo Caione <carlo@endlessm.com>
> > Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Thanks for the ack.

Johan
