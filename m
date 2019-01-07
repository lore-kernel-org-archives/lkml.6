Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A65C43612
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CFC82147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcDe1/Sn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfAGVNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 16:13:42 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42014 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbfAGVNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 16:13:42 -0500
Received: by mail-oi1-f193.google.com with SMTP id w13so1549244oiw.9;
        Mon, 07 Jan 2019 13:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hc+4pFIEoZRJSnjuZ6K6IWUr2XH/ERn5nG/FVoZJaVI=;
        b=LcDe1/Sn3It1js7x36sN24Sc8vhwZqDzedMzwOCWp+ttrSweGnrKY08mks+iqVF0zH
         mE4+sjqlg1vNr/q4fFC5CoLqbSoCbvOXRCoHhvnaqe1PHkuxiBoZa0jjAvibYZiylgbM
         /xxddsRjmq/3obFIFcBxRDe9DguM854hAu0pyUWaKL8s64e0SahoIez3sYu/PWnCZcO6
         XTO82uP6rX5Wkx7TjbD/STc4YHQyhLYrVyQl7JDh6v4bUm2KHZOcW9bpPilAazwWsMHw
         pINFKu3F1FfnNpHgzsUE73pjJKEUPk/q/CXllpfpb49nMS++cFy0ITdrnBaVKzBdOnNU
         iQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hc+4pFIEoZRJSnjuZ6K6IWUr2XH/ERn5nG/FVoZJaVI=;
        b=GWiHprvA+x2puNyf530+JLaj7/R7c4bAeM3dHVGsd4TF1g5p81DgTRbC1uQKDWSVQ/
         yzG5KgBKvKWK1ZxQRTDTnvQ/i/RUtr2QlrjNksYndO3PA4WoKtR2jXFBJt7aILm/TOuK
         pqBsdmPwnO6b147knxVBJiW2ZXCma2fvs4pGmCX0Lp1QGGoq5mguxImg1V1AHMj4STX7
         QmmFtxZDcLRCLnkppCf9aTyl1vaGeHQYao4DLoYeGDfdNo29Ze73srvGzI2JrpGFCB1t
         rEgukrcUsa/pJ9jFb7Nerh7ozN3W+QRy1se87trhzogBjoMfgi8qm1bIZeSocSuzzj48
         fhpw==
X-Gm-Message-State: AJcUukerV/+ntFJ99lW9FSsIO3F/huKMo/hsffy3WI1WBNIC/9GsFFxa
        T66ffxlMESqQ/Tnca6jlN8olJLSGk5WCYVeHV0U=
X-Google-Smtp-Source: ALg8bN6Omlt4l1LE3FRiESykbxWVQPtweBLy72ylE47mHcXbWzRWZ4ZmaxRdz5musejInM7UPJUhCh9iLv4dBskfYHo=
X-Received: by 2002:aca:4ed8:: with SMTP id c207mr9468249oib.276.1546895621745;
 Mon, 07 Jan 2019 13:13:41 -0800 (PST)
MIME-Version: 1.0
References: <20190107105330.372621917@linuxfoundation.org> <20190107105330.528127680@linuxfoundation.org>
In-Reply-To: <20190107105330.528127680@linuxfoundation.org>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Mon, 7 Jan 2019 21:13:06 +0000
Message-ID: <CADVatmOxZngMs8foHj0mOTjC5NhAZvZyxRJXREkEsKvG-6z6Ug@mail.gmail.com>
Subject: Re: [PATCH 4.14 002/101] net: core: Fix Spectre v1 vulnerability
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Mon, Jan 7, 2019 at 1:00 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 4.14-stable review patch.  If anyone has any objections, please let me know.
>
> ------------------
>
> From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
>
> [ Upstream commit 50d5258634aee2e62832aa086d2fb0de00e72b91 ]

This has been reverted upstream by f2ab95814103 ("net: Revert recent
Spectre-v1 patches.")

-- 
Regards
Sudip
