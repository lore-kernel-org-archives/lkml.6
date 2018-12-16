Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCF5C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 20:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D15720672
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 20:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMPDenEH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730971AbeLPUGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 15:06:22 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:47060 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730746AbeLPUGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 15:06:21 -0500
Received: by mail-ed1-f67.google.com with SMTP id o10so8990088edt.13;
        Sun, 16 Dec 2018 12:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=embUt4OQuxexrASWjJT1QY6OICWg4LTo72Jdxuk4M/k=;
        b=kMPDenEHNpJc1FvUo52wjoK+PdJ1jPv6tU3uQAT6L6ePpMaGNQtrdvt1vJaFhrN9qB
         dX2jGnjORXu38dxdfLdJDybNY4+5cxHD4aMF8HL8eTLJdZF2D389dwcgkVxETGUl95sy
         Z00HxyOo52eHuijumFDd6w06lwlMOGWg40vryZF+4aw6Zkqn/NrZcfKyEuSkq2m6tA7t
         qpA0+u+pgV2MGqYLncq4mFDxm17IK8ttW9ebhb7JhAC54GmAAAxS6WeiV/LWWMNH+ODz
         cxSkvJJqJfg5ncIbKqUd8/hgp9+d0tXb6LEQOk9nmU24rarG9D3amvofeItWsng+m56Q
         RAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=embUt4OQuxexrASWjJT1QY6OICWg4LTo72Jdxuk4M/k=;
        b=byTfE6mExGgOChuvpMOqrAKVkRpK9aTcPtIydfcUAhU9t00JYNBzDC+tkGmxS2u7rd
         +ZapHROR1nuISRpPSt/0ufsNdUekw78RmdqQ4shZXeyNnVnHwZUTe/cJFiee/Ylmek3Z
         ymFkoM24O+V6SGOUvZ7Vox6sdpJg+Q8Yz0cXOtDzcNviZIgeJxZ7p2UsgZ9VCAYOewBO
         DzZTeB65un3jlgydMKBuYz4H3r5Bbx4K3b5dmLXUHJXN5hCzipDc/kSut502wXu+8/Jo
         XAuAVGP1MATB5WqYOFI07LazmTdp7dnfjUHHIkshP6IMwsF3B1CSnjdIg6igIRy+vjW4
         LcmQ==
X-Gm-Message-State: AA+aEWYJGocV6bSj3dUvp30QUI9z8f8Vguah4rtGFtc7HXTNfrejn1/a
        iGebAmA2Jm7Dp8BDfUis0rQn8z1JAZgvV2PHStQ=
X-Google-Smtp-Source: AFSGD/UUmBCFsaxRIgmVBa1UTyxocVDiCemkuaXOGpDp/BiphMWJWM2HKB1ZYSkWLmPSvymGi9PrS9/iCGLzhk5IbIA=
X-Received: by 2002:a50:ac81:: with SMTP id x1mr10599907edc.71.1544990780148;
 Sun, 16 Dec 2018 12:06:20 -0800 (PST)
MIME-Version: 1.0
References: <cover.1544784419.git.pabeni@redhat.com> <20181215.132333.867660599141318055.davem@davemloft.net>
 <2444a44091ae292166c6cad1e31fd85ed2b77fe7.camel@redhat.com> <20181216.111340.1916211375637201418.davem@davemloft.net>
In-Reply-To: <20181216.111340.1916211375637201418.davem@davemloft.net>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Sun, 16 Dec 2018 15:05:43 -0500
Message-ID: <CAF=yD-+SdynkS3zhE34ykMja_JsH1C61wT61c+fEHqFCMmsWXQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/4] net: mitigate retpoline overhead
To:     David Miller <davem@davemloft.net>
Cc:     Paolo Abeni <pabeni@redhat.com>,
        Network Development <netdev@vger.kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>, pjt@google.com,
        LKML <linux-kernel@vger.kernel.org>, ecree@solarflare.com,
        dwmw2@infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 16, 2018 at 2:19 PM David Miller <davem@davemloft.net> wrote:
>
> From: Paolo Abeni <pabeni@redhat.com>
> Date: Sun, 16 Dec 2018 19:55:40 +0100
>
> > Again, I messed it! I'm really sorry to waste everybody's time.
> > I was unable to give proper coverage with different configs. I tested
> > vs.:
> >
> > CONFIG_IPV6=ymn
> > CONFIG_INET=yn
> >
> > but
> >
> > # CONFIG_RETPOLINE is not set
> >
> > fooled me. The following patch should fix.
>
> Please submit this formally with a proper signoff and let's see where
> it goes.

I just happened to run in to this, too. Had to disable retpoline for
some unrelated issue.

The above draft patch fixed the compilation for me.
