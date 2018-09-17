Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0DCECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 354E420883
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="hTeIUA3e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 354E420883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbeIQU1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 16:27:46 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:49937 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726885AbeIQU1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 16:27:45 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 84441187;
        Mon, 17 Sep 2018 14:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type:content-transfer-encoding; s=mail; bh=Ercf+4xJW2ws
        4s1oN+cY4Leyfs4=; b=hTeIUA3eRXE3X6YRZlg+jX1Abrqfr0/RZtv/xY4vv75k
        7sRpLuk1Y3iODnJ0R7EACXSFjoWjC4Da6c58lGPrc7JDS21a+ZLK2g9M621VHX5D
        4kHcErp/r+PqpEZZs+fvZ2k41GvGTert7Gs4Pg3MI+Pq2Fy4vCUV2JjS1NTZY/wo
        ASJu4Usrfk0ozdyq3/XchdW2/LMEdahmLXnpZyxgN79aVicjmqrrNYtD3V+GPW0p
        bzrUJgft63+2TA2lLOI453AV6IlIzH1wBDjnt9ocO2Zz2MJGe+vTw/RHp422GLCG
        skPz184U6hUxV6M2QONFsJkoT1a2IukBFpnb5Sg52Q==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 81c48ef2 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Mon, 17 Sep 2018 14:42:33 +0000 (UTC)
Received: by mail-oi0-f48.google.com with SMTP id r69-v6so19191091oie.3;
        Mon, 17 Sep 2018 07:59:59 -0700 (PDT)
X-Gm-Message-State: APzg51C7liiFhHuhlXJIwWj8kU1nq5HC4dbKsznRZkraRmxm3ToBlmY1
        dq3/OLOnjRKCI8FoV4/3Zz06KuhtywKhoKjIyrQ=
X-Google-Smtp-Source: ANB0VdajfI/nLJyYg/Rlg3O2PoWEQnqVCkdlNgno21pH2iuD19QhnpKa+uCzZZamHf4sBxs42gq6MsJcWjHlte+Pt6k=
X-Received: by 2002:aca:b256:: with SMTP id b83-v6mr18405827oif.235.1537196398717;
 Mon, 17 Sep 2018 07:59:58 -0700 (PDT)
MIME-Version: 1.0
References: <20180911233015.GD11474@lunn.ch> <20180911.165739.2032677219588723041.davem@davemloft.net>
 <CALCETrXrJPcs3h9CtF50N4k2AGx3qzspJd_UW3t+KGYOj7+p=Q@mail.gmail.com>
 <20180916.214549.234387075817326903.davem@davemloft.net> <40088431-D4EE-4D1C-A369-2CE15F758483@amacapital.net>
In-Reply-To: <40088431-D4EE-4D1C-A369-2CE15F758483@amacapital.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 17 Sep 2018 16:59:46 +0200
X-Gmail-Original-Message-ID: <CAHmME9oxv248pQ9+T6Jc50_3Wb6HELGtpVZod6dGQ4KoAp6+jA@mail.gmail.com>
Message-ID: <CAHmME9oxv248pQ9+T6Jc50_3Wb6HELGtpVZod6dGQ4KoAp6+jA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 02/17] zinc: introduce minimal cryptography library
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     David Miller <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Andrew Lutomirski <luto@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Biggers <ebiggers@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, Samuel Neves <sneves@dei.uc.pt>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 4:56 PM Andy Lutomirski <luto@amacapital.net> wrote=
:
> Would you accept Ard=E2=80=99s (and/or Eric Biggers=E2=80=99, perhaps, as=
 an alternative)?  Or, if you really want Herbert=E2=80=99s review, can you=
 ask him to review it?  (Hi Herbert!)

Preferably Eric's.
