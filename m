Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA57C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 924E7208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WaMNCFoq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 924E7208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933189AbeFRPrN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:47:13 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:36215 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752765AbeFRPrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:47:11 -0400
Received: by mail-ot0-f193.google.com with SMTP id c15-v6so19031706otl.3;
        Mon, 18 Jun 2018 08:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VIF0q25lrG4JYObPzZsdGexK5EJlSyx/wtPLT7veHQE=;
        b=WaMNCFoq5UzjbKc7CEqr0akwmkGWCNzLPNaBebHAVD7cZd7S3DetyNJgKoHmwFtKKt
         cxZIcz3svcJNY816X9vRs0l2bLJSBjY0YME02Zo62L2TP2OuD1ID3PS7mT47ACE5LEid
         U3TQ7xIxHQ9IxB+dw6bbcDAjhHlK0NTaf4Dq217PNkJ7KyR7HAk+KxIYUBEk94CD6Anv
         hWf7lzgGbJcpeQOH2vToivXfnTvrov4xm+eF1XfVkXHpIHF5OGmX/5cZCGMPBwQIH2iU
         +kYcrAt5tmAvrxMa/vzmU3U+lDSLWeB4WNlK+pWiOOFxRrW69h6k+uJ2nx8JApT0Oxt9
         QXAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VIF0q25lrG4JYObPzZsdGexK5EJlSyx/wtPLT7veHQE=;
        b=Px+RZItBUFWjAtQIKC9GoR8PB5R6rI75kn4xXZSfoU3ck73gl5duW6HBLUYRINjYnk
         9ncMiGgZyVlIGDnuk0dRTWiR5Urmsd/WTsq8KCnd7jlDsXSopJTVtPGlfjrmbb9opXrN
         80+630rRtFO5evy5Zg3EzAp9IUy2NexslQySA6G0J2yoa4nhWYAwofcULL8w9uAddhEv
         c4kgaBznCHl9/PT5MHhQlsmHiEHy60Yv7NI0kw1z6GZ0dfumSbxYQLFLIs/gaT86c4F+
         l1sstsJwcFjpa6TQykPtFBpszDAOxrcXRAYUD/UCOSQnOn6VVL/jPMzMTSwO3qzIo7dZ
         F51w==
X-Gm-Message-State: APt69E1M9c+jXN3YuzlPEqNQBDcV1IATZ3nMq1kpbsDPoxwmvykoqtZJ
        W3CnwwkCE2D6LY0QLek2+gtlaAWIsE/13z3jyXE=
X-Google-Smtp-Source: ADUXVKKeBUn4yOx4a9lo9l4fnpdlgXsEjiBmXNT4vrKtMkkRicAr15znf8IP313I2e49VRW+zEjqpmF0nyrqk3x/fyM=
X-Received: by 2002:a9d:1813:: with SMTP id b19-v6mr8309514ote.128.1529336830745;
 Mon, 18 Jun 2018 08:47:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1049:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 08:47:10
 -0700 (PDT)
In-Reply-To: <20180618154257.16919-1-manu@freebsd.org>
References: <20180618154257.16919-1-manu@freebsd.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 18 Jun 2018 12:47:10 -0300
Message-ID: <CAOMZO5Bt+7FGT4Xk7HZdVjukNsG=eY5-P+9Qnig6h-cQSJvOvA@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx6: RIoTboard Add chosen stdout-path property
To:     Emmanuel Vadot <manu@freebsd.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 12:42 PM, Emmanuel Vadot <manu@freebsd.org> wrote:
> The RIoTboard debug uart is connected to serial1.
> Add a chosen property in the DTS so OS knows what serial port to use for
> the console.
>
> Signed-off-by: Emmanuel Vadot <manu@freebsd.org>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
