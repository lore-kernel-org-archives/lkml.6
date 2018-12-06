Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990B0C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6051120892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hINl6urH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6051120892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbeLFS1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 13:27:36 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:37864 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbeLFS1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 13:27:36 -0500
Received: by mail-ot1-f47.google.com with SMTP id 40so1342073oth.4;
        Thu, 06 Dec 2018 10:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5n+zWl4xbkMx8mGg8ZcgMlW8k79qQc8MJHDCwegTH0w=;
        b=hINl6urHHIw71EbDX4T8ARBUFbs3OCSyX/9brproxk85J2cDDftpPLlUAMJZOfBFfq
         DJknljxyDEpn0BbawoqJhOLEUhQsFe1rRknYWoMuFPNJkxx59SfRn8/zlk6U0k4RwDwE
         gOBEOqmsDdu+u04duI2/vYaUpHqpRW1vBGmCkCymRiZ7AaxesTcqvYBWje/sMnlfTZYH
         dOtgbC5zDYw4zEpZRtsQkXTE6xGTSJlPXWpx3QAaxoyeZ0ZXRyPVFpzKAr+Uau8hMF4Q
         LaqcPyUVmBm4OmBh91LyCFAU59KW16pHcKjt1D15nUXXP5ZA1oB0s3OMCg8d4d8Q8WF8
         kMfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5n+zWl4xbkMx8mGg8ZcgMlW8k79qQc8MJHDCwegTH0w=;
        b=K5K4KntjybWoGoDJG02EeMOj0P8uZOwXSBA7Do/wXwmN3pKzzhNMdnAN4batB27cXB
         U9UhUxONOxAyq54hbRPx+EPSX92SQ0Ia2VZOtxLneVXdj92GMWAZCpuD1zo2gDQYrIMU
         rQUxG5qkiAHbikc68ywO4fliDCdJzDLOKsZy26UGXCViZEYG9j+/jlmCr54FTnF6rZDa
         QfJWPAgq7Gvy1v5BA25QUVBv8M8VRJGlK2N4guRaVYlvmsgjDlx5LxG26tlrUit771Wm
         u35JaoYcyZ11ZutPpZI/jj4rqHHs5b5ulks3HJzE1YwGsMRGKkzF+fD/WZ/8mFEiApW9
         JQqA==
X-Gm-Message-State: AA+aEWYi4eu27odCDa/bf0kUggtLCbqTT48WKBiVs15B6G9+oI00OD6u
        w7UjtJuOhdycv+l1w1FN9R6APDGb0YE2nDu6CvY=
X-Google-Smtp-Source: AFSGD/XmSXjTsgXmDFqMhPPtYTK67ngc4vbkAoPzCY7lqQEEjgwdmfVkxYiKaapEiIeOSkDWKVuVDZhfcP/UENyYus0=
X-Received: by 2002:a9d:1b0:: with SMTP id e45mr19997378ote.16.1544120855310;
 Thu, 06 Dec 2018 10:27:35 -0800 (PST)
MIME-Version: 1.0
References: <20181025110530.22826-1-muvarov@gmail.com> <20181025230611.GE6276@lunn.ch>
In-Reply-To: <20181025230611.GE6276@lunn.ch>
From:   Maxim Uvarov <muvarov@gmail.com>
Date:   Thu, 6 Dec 2018 21:27:24 +0300
Message-ID: <CAJGZr0+fJR1uF8H=sH6FgHxt6xP1cc=FHdGpbqPjqJOuZZ8P8Q@mail.gmail.com>
Subject: Re: [PATCH] dp83867: fix speed 10 in sgmii mode
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=BF=D1=82, 26 =D0=BE=D0=BA=D1=82. 2018 =D0=B3. =D0=B2 02:06, Andrew Lunn=
 <andrew@lunn.ch>:
>
> On Thu, Oct 25, 2018 at 02:05:30PM +0300, Max Uvarov wrote:
>
> Hi Max
>
> > For support 10Mps sped in SGMII mode DP83867_10M_SGMII_RATE_ADAPT bit
>
> speed.
>
> > of DP83867_10M_SGMII_CFG register has to be cleared by software.
> > That does not affect speeds 100 and 1000 so can be done on init.
>
> It would be good to add a Fixes: tag. Has this always been broken?
>

I somehow skipped this reply. I guess that was always broken. More
likely 10M is not the speed what people use nowadays. But anyway it
will be great to fix anyway.

Max.

> Thanks
>         Andrew
