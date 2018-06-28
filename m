Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DA4C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 02:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A0B32565E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 02:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="P8D7QDHb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A0B32565E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753289AbeF1CvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 22:51:14 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:45065 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752946AbeF1CvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 22:51:13 -0400
Received: by mail-yb0-f194.google.com with SMTP id h127-v6so1551989ybg.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 19:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nFMmSrZuFbjVb7YmIyT9WnSx3P+us22Xm5Ob/5MvISE=;
        b=P8D7QDHbo0jvu743hogL8BRS7Jcsa0jyP7zVpcbF05N/3RCVKvnjCOYZ7YV7XUyjtJ
         o7pGF1/NLJfQw1jP5E6boNhbUeAenqR58J/E5r+HFsImyNWmlQ0dmp7HvD4fWoIRcyMe
         wxpNVjDLTdTOoKKlELSV73nrceIYLYP5iey5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nFMmSrZuFbjVb7YmIyT9WnSx3P+us22Xm5Ob/5MvISE=;
        b=Yj04YKBJdBapSiKI6XphY4e0sNULCIoRu4QmNjdJihAZRuU3sepaEWstJ43II3iYgH
         eKxWx84Ejhn9mmKZROcnlQJsfjCvmLy/pZUs7qWakAjVTah0PFj7IMTYUOrNUOES5MD9
         KguEUJo+kiw5X9t4A9dCQn6w97Uf3luuA+OgaufwrsDxw7743PiENLHfpqc52KzumY4q
         ioxHvELT47SDIniPR2vo3t8Ja0CRK8J1bpv5F1hEL/YFOQ/n9u8iNlA7h5k9WRxIktCl
         jevc4ZXjJIX47pU/9aneUb0OEpnpbYkXs7U80PU86IHtNWfOaYdOaOVHSZBkEBno5uc8
         cz5Q==
X-Gm-Message-State: APt69E1E7M2hDJXsElmE7+ZIG1L1Q7QiVgql62WxrAeIr7pS0mpnupJ0
        Kr8ndEh69eZCwBm3ipejuOcTZb7HBXgVw41lkbRacg==
X-Google-Smtp-Source: ADUXVKJily5HK6cezhsOLdU6i2Jy+zSL1HmAcECyAyzRKoXTugHIsOk2E27nMhA7RP/9t5bBnvi5oonmJYRyeEcBJqk=
X-Received: by 2002:a25:c885:: with SMTP id y127-v6mr4271258ybf.496.1530154272404;
 Wed, 27 Jun 2018 19:51:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:4fd6:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 19:51:11
 -0700 (PDT)
In-Reply-To: <20180628014524.GA26061@embeddedor.com>
References: <20180628014524.GA26061@embeddedor.com>
From:   Michael Chan <michael.chan@broadcom.com>
Date:   Wed, 27 Jun 2018 19:51:11 -0700
Message-ID: <CACKFLimSr-z2DTEPZoOioHC6jOy-ow-EjMkCzCfbPXzkbVBiGA@mail.gmail.com>
Subject: Re: [PATCH] tg3: Mark expected switch fall-throughs
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Siva Reddy Kallam <siva.kallam@broadcom.com>,
        Prashant Sreedharan <prashant@broadcom.com>,
        Michael Chan <mchan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Netdev <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 6:45 PM, Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Michael Chan <michael.chan@broadcom.com>
