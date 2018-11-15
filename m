Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C6CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 16:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57CFF21582
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 16:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20150623.gappssmtp.com header.i=@ndufresne-ca.20150623.gappssmtp.com header.b="lPxX3qiO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57CFF21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388702AbeKPC7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 21:59:45 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41183 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387839AbeKPC7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 21:59:45 -0500
Received: by mail-qk1-f195.google.com with SMTP id 189so32812238qkj.8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 08:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version;
        bh=Njrrwv7gYgnhlN1RZoEAZpK1DIdPZHu2/5Vc+mBvzqE=;
        b=lPxX3qiOduI1d4mOBssy5bUHuuRDtx70Q0j+UvO1RTKtuwBZUEGNob3L6IlvyJqUHR
         XXDqbFWeFVZEwwT+42mKGrnlfa1yd1AQ95H8ohMvJa0H+B1l/dQbK99kU76PQyfj1etS
         PN2ZoW8lSsr8EWUX5z86AveEwCOlaWBBg9C8jOC8suOFNH6w62NK1yLUHd0neOSXAVvO
         NZbg+JmqT3yKXRmsJT0NVbzrNwIRSUSkhYXNW1JU4Kp+jr9jdj2oHO62fwYtn+qVruWS
         PnnWdp91W+Mive0dQR12O11BQuF7jKRaWpXIOVD3ChJJITPNX0MDcr8AEKU+SpKqpVu5
         Og+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=Njrrwv7gYgnhlN1RZoEAZpK1DIdPZHu2/5Vc+mBvzqE=;
        b=Ipvm5EHm7tcBTbC4F11H0yYhoPb5ZRSz64ly/K/2aqP9ytMKyoA155RcmLcbhE1Gw5
         ny21825vM+u/Ehj2xvCEmH8h1Qv9EFeJjQJihWSEVviJx6VT9irla3Ezj1dmbdm6YAUN
         ZnOI+AZOcencaIFRTazlTMWbkcorwOirrpEDqE75aI3Y+I2jCb5SurtFQKox34PV9brV
         vDonkK9FiBINL1lMDCdFtgNHAofyN3+UwPWZQwzSeyfnKJljXV2GdMhtZ5DpMZjCCMo0
         yK2EoOZbPy+Ej9tkiq16iU2kuTVr0n/8I76xDFHqMNTWsz98+srKmG++Pc1W/Pf2vJSS
         Cvxw==
X-Gm-Message-State: AGRZ1gJYB8HInFKFrua1KTiDQvw/h5MAVZh/5ihVyeHwokhXQIgKP+uD
        8AFok55osKd94BRmNoVOFkzO4g==
X-Google-Smtp-Source: AJdET5fjGpseOVoJKwsXGWYpFSNFElm1WV7OSIdT/moDelwqAPqAMqKOp7hXMvucB0Kz/B6zNBYIzw==
X-Received: by 2002:a37:3753:: with SMTP id e80mr6473720qka.207.1542300669969;
        Thu, 15 Nov 2018 08:51:09 -0800 (PST)
Received: from tpx230-nicolas (modemcable154.55-37-24.static.videotron.ca. [24.37.55.154])
        by smtp.gmail.com with ESMTPSA id g5sm4342220qkd.55.2018.11.15.08.51.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 08:51:09 -0800 (PST)
Message-ID: <f3572cbeecbcbeeb37a6e2d29b4e72e2a9ae75bc.camel@ndufresne.ca>
Subject: Re: [PATCH] media: venus: fix reported size of 0-length buffers
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Alexandre Courbot <acourbot@chromium.org>
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 15 Nov 2018 11:51:08 -0500
In-Reply-To: <463ac42b795933a54daa8d2bbba3ff1ac2b733db.camel@ndufresne.ca>
References: <20181113093048.236201-1-acourbot@chromium.org>
         <CAKQmDh-91tHP1VxLisW1A3GR9G7du3F-Y2XrrgoFU=gvhGoP6w@mail.gmail.com>
         <CAPBb6MWJ1Qu9YoRRusOGiC7dioMkgvU=1dCF6XZ4xDUxp7ri9A@mail.gmail.com>
         <463ac42b795933a54daa8d2bbba3ff1ac2b733db.camel@ndufresne.ca>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
        boundary="=-zHZ7Ei4DWZbZ/lADHTh8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zHZ7Ei4DWZbZ/lADHTh8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeudi 15 novembre 2018 =C3=A0 11:49 -0500, Nicolas Dufresne a =C3=A9crit=
 :
> Sending buffers with payload size to 0 just for the sake of setting the
> V4L2_BUF_FLAG_LAST was considered a waste. Specially that after that,
> every polls should return EPIPE. So in the end, we decided the it
> should just unblock the userspace and return EPIPE.

errata, DQBUF returns EPIPE, not sure why I keep saying poll.

sorry for that,
Nicolas

--=-zHZ7Ei4DWZbZ/lADHTh8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSScpfJiL+hb5vvd45xUwItrAaoHAUCW+2j/AAKCRBxUwItrAao
HEN5AKDdT0awi1JnbZR4oAi4PaDyutHeegCfXblCg4heJ0HpNxGyNq+4pP2Tewk=
=0c25
-----END PGP SIGNATURE-----

--=-zHZ7Ei4DWZbZ/lADHTh8--

