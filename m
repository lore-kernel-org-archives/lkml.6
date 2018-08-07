Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032F4C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 07:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A26CD219DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 07:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="OgLP87wp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A26CD219DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388790AbeHGJhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 05:37:31 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:45485 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732910AbeHGJha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 05:37:30 -0400
Received: by mail-io0-f196.google.com with SMTP id k16-v6so13170460iom.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 00:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=A2O3JSlPu6pr1zQGD7P+WSvHOjQSOJ9y+mk0fbs1nWE=;
        b=OgLP87wp2T5pUJdH6MAiJbUdV7b6tozbQjx+n/P9Kpg+kQAN4NxmYSCOLm/GEyee26
         6ohQk/GN2Dd3O0BHVUv/Tt7VfaKIZBG0696VhuNiDgk9r4Wd4HDL9ivaXssxXUliAKMn
         z6nxW4HhnQGebul976J4IHdGOt0U7ztcTH/fc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=A2O3JSlPu6pr1zQGD7P+WSvHOjQSOJ9y+mk0fbs1nWE=;
        b=S6XI3InZDTgwII2uydcBydBBTVIT5L8tAzertC5W4FcLSOTR63BQNEIFx75HFDm7ji
         j22+7SPgddzEySDAARbfxXMMyJ9IDPMeUWgkaV0dUhpPzOOUpNibgWV5rUxgv+kHT96n
         eCKofLCZk4QaV9BygRCFU/8imR2RsCt7ASWLI5ovgb6qYsZYcNS2nvfnVXzsgE2aDQbJ
         R5guGj8L3XVMyiM7Z6qL0F6ca/kRIYU9b6DaEMI9JCmE2WP4qYA+Y9IQ2NE8E+cPntbE
         ESfhJVy/6RSpkhG/JwMWv4J8YwSdD91TWSwdqYumQDNFItPZHcXIGwL6j0ScJZDQFxLp
         Sq2A==
X-Gm-Message-State: AOUpUlGLs/ulMN5ePCKFUyKUGwe7gI5x3CksSOERqjNjxtzPjuDQ/4s/
        o1xULRKDdjS+j/9N17njTcTxBJaO4th1FqtxaMC8ag==
X-Google-Smtp-Source: AAOMgpffAWoe9821c5uJkYbj6JTX1Bj13Gc2M0cL6j77+gTvSspA89COFc3gx8RWWzszjTwGP9Sjz0C4/BRb7WXX+7o=
X-Received: by 2002:a6b:8f4e:: with SMTP id r75-v6mr18477029iod.252.1533626670309;
 Tue, 07 Aug 2018 00:24:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:a785:0:0:0:0:0 with HTTP; Tue, 7 Aug 2018 00:24:29 -0700 (PDT)
In-Reply-To: <2D1B8773-0019-458A-8C7E-20077AA27AD4@aosc.io>
References: <20180807071839.25305-1-jagan@amarulasolutions.com> <2D1B8773-0019-458A-8C7E-20077AA27AD4@aosc.io>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Tue, 7 Aug 2018 12:54:29 +0530
Message-ID: <CAMty3ZDMw3OkZdGvt6tRY6KsSCNKcvptsty7n_t2s_mOzQnr5w@mail.gmail.com>
Subject: Re: [PATCH] arm64: allwinner: h6: orangepi-one-plus: Add Ethernet support
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 7, 2018 at 12:49 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
>
>
> =E4=BA=8E 2018=E5=B9=B48=E6=9C=887=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=883=
:18:39, Jagan Teki <jagan@amarulasolutions.com> =E5=86=99=E5=88=B0:
>>Add Ethernet support for orangepi-one-plus board,
>>- Ethernet port connected via RTL8211E PHY
>>- GMAC_EN is connected via PD6
>>- GMAC-3V supplied from ALDO2 regulator
>
> Is the prequisite patchset merged?

Not yet, I guess. Do you suggest to squash if not?
