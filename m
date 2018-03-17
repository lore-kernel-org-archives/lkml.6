Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1141603-1521283177-2-864592512559086987
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: from='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521283177; b=pGk+PWjaXLuI3ThgAAfl8CMUNBbra4znoETM88v9acykrAO
    p4WXz06xKDFkKpSsvOZ3G09PH5FoIj1bUd6U17nGP2oZCsrxhnNtEmZDjQgpp1FT
    ywVV7ZfoJfLbgijJhGmN//7Z+qZVZ8ze5IKvgzccrHGAWRs/flHOyakJ41J2N1eC
    lrUVBlxAb30Ik32LcxbsuMlCo6NhvqTRF/eX7/YCRq46nqiigJDr+IXKyNhbBKmZ
    dAztERKwa/R/MSWarZWtmZrOF/1lMzAHZFA7kDLv57GzxqrK8rDkOxg2hiFxUNKx
    GWk6qqFrOZk7Ef0vTaau8BD4oqBUf1MxTODtRSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1521283177; bh=GyBqTLY5aNDt4PVWD0H0EnoR8pa1RBaJs1AFnl
    Fzvi4=; b=hvnVThY5M7hAoauPmlgRlFZTC14kis8OSH596aXrVvBx3FBf/+hcHa
    VH3h0vI8G3rjX5J1hI+UNyUo6HWrEzXucpawhUBoG/8TSN1tkNXFeQbWzPEvbylc
    LHX6WiLZpMFzal9/C4A2MHXfMTChWM+F0Xu15whX3/ECui2h7a7/kgtd9niglq9/
    YtJyAy26XIPyHBxv/9+fiOIMeReKb899Sz+OpylkMqgJOW9qZFLLaIoKPN/jTAlH
    Eh77NkxK5ckzAYH8/BT/wcc/i/FI2dtQOyp4+E5n8fVUrS+6EyU9uRsBn5gAEI9m
    8mRWxIzNigC/MZSUtARCnCMDIto0Qdog==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=pIbFJm0R x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ojZ/sK4p;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=pIbFJm0R x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ojZ/sK4p;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751591AbeCQKjd (ORCPT <rfc822;greg@kroah.com>);
        Sat, 17 Mar 2018 06:39:33 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:45835 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751453AbeCQKjc (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 17 Mar 2018 06:39:32 -0400
X-Google-Smtp-Source: AG47ELtTLcyTZ2qFrqPwUOwfmJtEv6MfbbUdMLNdKLa5Uj7g0QrqC52ZFhtOPNMRadzcCN9zXVF3TnY3LE/AwJlCnPc=
MIME-Version: 1.0
In-Reply-To: <20180314135902.GA21622@kroah.com>
References: <20180218170629.6045-1-paweldembicki@gmail.com>
 <20180218171927.6414-1-paweldembicki@gmail.com> <20180314135902.GA21622@kroah.com>
From: =?UTF-8?Q?Pawe=C5=82_Dembicki?= <paweldembicki@gmail.com>
Date: Sat, 17 Mar 2018 11:39:11 +0100
Message-ID: <CAJN1Kkzsys9XAJcDS2-CvE5+Z+z=kkvi6YN96G+kufqh9xakag@mail.gmail.com>
Subject: Re: [PATCH] w1: gpio: fix problem with platfom data in w1-gpio
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Evgeniy Polyakov <zbr@ioremap.net>,
        "Andrew F. Davis" <afd@ti.com>, Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-03-14 14:59 GMT+01:00 Greg Kroah-Hartman <gregkh@linuxfoundation.org>:

>
> Patch does not apply at all to my tree :(

Patch works with stable kernels (e.g 4.9 and 4.14).
On which tip You test?
