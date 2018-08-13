Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A510C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 17:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4AC42175D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 17:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="y40NGeN9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4AC42175D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730673AbeHMUi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 16:38:27 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:51687 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728661AbeHMUi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 16:38:27 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 7505206a;
        Mon, 13 Aug 2018 17:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :in-reply-to:references:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=q5/OgsqGWfSWINvOijzS0RjkkBU=; b=y40NGe
        N9Q660lP1Ox3b8NS+COlJAY7idr+8Ryk0d/+/u3i/FhzCWKGVjVbcizXTaA0z9pZ
        8Y5KS7PPWAckLB5INAA9obLekrCNiegCGMNMEEg0VCjjf+mAFyT/TSbQmw7k8yTW
        Nzdcg6czP7AOU4Id492NpfubY7azJeLptIHpEJNQwC5Vx2Cxc9IM6onZtUHgiK6R
        WFZvVqKlp4566jix16TpJUlQzGG8IzUrRDh7K8AvveZsOMUPDOx86u3ZqqoMC6xf
        P6FFpi1E+YonzUBEwQ575cbASc07O39Vsb96PZoSG/gJarKZP0gHNYF3DueiuLHF
        kMf4BkR+UOPMEG0Q==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ac2c62a6 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Mon, 13 Aug 2018 17:42:10 +0000 (UTC)
Received: by mail-oi0-f45.google.com with SMTP id q11-v6so28759270oic.12;
        Mon, 13 Aug 2018 10:55:10 -0700 (PDT)
X-Gm-Message-State: AOUpUlEHQ7bJDIHBrZDexwVVIQMtmchLh0fb0/UMYGr3sV95ySlWRezi
        LbxGNFyPZEleEBmyMDun7XUGa0GFLAErSFUbWJY=
X-Google-Smtp-Source: AA+uWPwFLzUGNDxnsysGIYkj2X/QXOUkh0JRlpAK1V7n1yIuJk3q3rJExvWf/AtFXFmQFNB3F5rzCP2U8G2238Dgg5A=
X-Received: by 2002:aca:f189:: with SMTP id p131-v6mr18163386oih.14.1534182910088;
 Mon, 13 Aug 2018 10:55:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:a025:0:0:0:0:0 with HTTP; Mon, 13 Aug 2018 10:55:09
 -0700 (PDT)
In-Reply-To: <1534181830.7872.10.camel@HansenPartnership.com>
References: <20180731191102.2434-1-Jason@zx2c4.com> <1534174811.7872.3.camel@HansenPartnership.com>
 <CAHmME9raa81A_hH_Zykp2r8zOk0ySroFEsk+8384vnVOCuSa=g@mail.gmail.com> <1534181830.7872.10.camel@HansenPartnership.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 13 Aug 2018 10:55:09 -0700
X-Gmail-Original-Message-ID: <CAHmME9pn+zm67mmDDrkMLpSAXNEugCT3z2L-QXO2eQw+31V=YQ@mail.gmail.com>
Message-ID: <CAHmME9pn+zm67mmDDrkMLpSAXNEugCT3z2L-QXO2eQw+31V=YQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] WireGuard: Secure Network Tunnel
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        davem@davemloft.net, linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> but it's very hard for a flow classifier because you have to

The construction and identifier strings might not obviously help with
the extremely narrow idea you've brought up, but it is very important
for safely introducing additional versions. Namely, it prevents
against cross-protocol key reuse attacks and type confusion bugs. So
don't be too quick to dismiss the importance of these for
accomplishing what we're after.

> so lets pick one of the above and try it out.

We have, multiple times, and it's absolutely trivial to do and works
well. The exact thing you're concerned about has already been
researched and worked with on live systems quite a bit over the last 3
years, and it works in a pretty straight forward way. I'm not sure
there's much more to add here: the thing you want is already there and
has been tested extensively. At this point the "pick one and let's try
it out!" is an old story, and the focus now is on making sure the code
quality and netdev api usage is correct for merging
