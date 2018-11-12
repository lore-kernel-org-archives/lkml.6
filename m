Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F420C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 23:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E1120835
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 23:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="S2LYS5q3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57E1120835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730273AbeKMJte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 04:49:34 -0500
Received: from frisell.zx2c4.com ([192.95.5.64]:51403 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725847AbeKMJtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 04:49:33 -0500
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id a21e0e28;
        Mon, 12 Nov 2018 23:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type:content-transfer-encoding; s=mail; bh=2DIHXbpX1OMF
        Cu4+OSE4jAkuJOk=; b=S2LYS5q3v4pzjEapbSgpBi2jaZjcm/RmUBsfqzRwcfFZ
        bHjiQA+gfgSqXWe2YqhtGGhzQ4FVeTNGp+/oAn9hxkX78AF/pTaDRHav7iHqU8LD
        9fZ2vMtoI+M2AeuotbPzdkRTr1pT0RVXTQsHDVD1O5Sh72s3U3kLxmd9tWA+9TCL
        xDGOOwv0xw41NQ2KUxjaO1TQ/ziU+44G/XzYerOOei4pQpWsFbOE4kynmHemYkSQ
        76QaKmAQi7jF8U4gsaRk/4e8h6VmWwue1AXJVmH+GXimYGqJzWjo4fqOJtBSVjlq
        LxqLBUb9N65Gx+5C6iH7EkD8IHGrVOQle/MM2J77Qw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a3b3a91a (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Mon, 12 Nov 2018 23:48:58 +0000 (UTC)
Received: by mail-ot1-f42.google.com with SMTP id 32so9138443ota.12;
        Mon, 12 Nov 2018 15:54:07 -0800 (PST)
X-Gm-Message-State: AGRZ1gLdQ4DiMiKmXSTDn1zxNjCO5XMz5vrI4WNPYYEKaOmen/NHZYxt
        qcOzug6pEShTSqYf3WOkDUokGcUnK/FxkKteHek=
X-Google-Smtp-Source: AJdET5f6x/sspWSRVs53aImmj9Rvey2gggVPt/B2fUgLW3Ft6ySFlSJA54gm3lUkhvzhQmZFdKRjQ+bjcDpeipzL1BA=
X-Received: by 2002:a9d:60cf:: with SMTP id b15mr1762630otk.144.1542066846685;
 Mon, 12 Nov 2018 15:54:06 -0800 (PST)
MIME-Version: 1.0
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-24-Jason@zx2c4.com>
 <7830522a-968e-0880-beb7-44904466cf14@labo.rs> <CAHmME9oQJ9y51Pv7U=+=5uDA_tb+U1zWZdsLcyNMhdcFZmjM8Q@mail.gmail.com>
 <e4b500e9-f24a-43c5-c2df-834dafc3aae5@labo.rs>
In-Reply-To: <e4b500e9-f24a-43c5-c2df-834dafc3aae5@labo.rs>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 12 Nov 2018 18:53:55 -0500
X-Gmail-Original-Message-ID: <CAHmME9q8tp3Ch43o3D6zYTVujcjBWLVpNdzVw6RqYqHisd_suQ@mail.gmail.com>
Message-ID: <CAHmME9q8tp3Ch43o3D6zYTVujcjBWLVpNdzVw6RqYqHisd_suQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 23/23] net: WireGuard secure network tunnel
To:     labokml@labo.rs
Cc:     Dave Taht <dave.taht@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Ivan,

Sorry for not getting back to you sooner.

On Mon, Nov 5, 2018 at 8:06 AM Ivan Lab=C3=A1th <labokml@labo.rs> wrote:
> Any news on this?
>
> To be clear, question is not about an insignificant documentation
> oversight. It is about copying bits from inner packets to outer packets

The short answer is RFC6040 with DSCP fixed to 0 so as not to leak
anything. I've added a description of this to
<wireguard.com/protocol/>.

Regards,
Jason
