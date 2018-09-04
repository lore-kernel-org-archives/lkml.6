Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8E8C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7364720645
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SfJ7gN29"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7364720645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbeIDUkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:40:25 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40366 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbeIDUkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:40:24 -0400
Received: by mail-wr1-f65.google.com with SMTP id n2-v6so4592596wrw.7;
        Tue, 04 Sep 2018 09:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XZS2dev/OJ2ucWD5JX5kCSLiDWgOopB4a4ElJHCBwVk=;
        b=SfJ7gN29k7ILy7LtBggYr/lrM102hRHqfNBPrdz+fBq2p8A366+bqHm1gSGb5gRBOf
         /MGgJV/5T27SL8nc9YY2SK1u1Xpd8Tqi+NN89Sq5D+lhqcMmwfKJmUcS7EYp1qxPOFUY
         8XVlu7hvMdBtwKHO8xTNHMxh4RrhJdXTgkKe2S2h/YAKdzT1luC1WydjDRQOiAXIBcr7
         CtTaqzzBdqx146TRBrcHSwF53N8LqxFGgkZ2qb72MdEaYHhiOuNh7r7n7L6Xtu3HDC6w
         w9NcGrdoXTL2UAIZQ6dvb5JYTLSzWpJf6bfhx5Hc9zmrb/ufW98YZZ4QWaPfqQwjDfHW
         GbEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XZS2dev/OJ2ucWD5JX5kCSLiDWgOopB4a4ElJHCBwVk=;
        b=qKTAP4toz5sA9dvW/PjA3QJJ0cYjgscX7d2Nz3+y65DOu+wqMSrWUENtUpcuaA3BSc
         aDtXfxi4KyH0faQLd+0wYhxJcIeHNoQDo+OiLI95JJvj66y1lOIXeOb7AymiuZwEkgv0
         to0x3sHZGmR9O5kKiFpgOE0NcIK1EV+P8dXNuMZT0v68EQYmKZlf/mU1lG57IzgqmSVW
         P8hia84mM7oVHFQKsTLoSEyY6nhzVavI+3c2vAvDFyxmvMMuz1EAs9fgboNWyGaiwCX2
         OxbWyCBw48gkjB7yVZ9j2K6asTFXdNCwGKT2LOZePbxgfBfnBLM01NUpjIn7LCx8wdvF
         KD8Q==
X-Gm-Message-State: APzg51BXsC9BnKOmLRUb+mIQRmNhYRjIOBFAjMgnSrpyBvee+dRDryG8
        aZPkbnPqxuUa1wW4TSOcWzVzJwNc68R/ZemQ11Dq5w==
X-Google-Smtp-Source: ANB0Vda+M5kWAV6txz2U/r2FXnHoML2z4trOALZth3bJuud7qxSzjhXC17F8kUdErb9NQbbKY/1NtE4uc2scayfw0/4=
X-Received: by 2002:a5d:4c49:: with SMTP id n9-v6mr24201708wrt.71.1536077674973;
 Tue, 04 Sep 2018 09:14:34 -0700 (PDT)
MIME-Version: 1.0
References: <1536062090-30446-1-git-send-email-sunil.kovvuri@gmail.com> <20180904124620.GC29121@lunn.ch>
In-Reply-To: <20180904124620.GC29121@lunn.ch>
From:   Sunil Kovvuri <sunil.kovvuri@gmail.com>
Date:   Tue, 4 Sep 2018 21:44:24 +0530
Message-ID: <CA+sq2CfF2L5yyrXOhdv5omhrHcjP+tJBcBMFVyQJQ0EmCbftdQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/15] soc: octeontx2: Add RVU admin function driver
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        olof@lixom.net, LAKML <linux-arm-kernel@lists.infradead.org>,
        linux-soc@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Sunil Goutham <sgoutham@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 4, 2018 at 6:16 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Tue, Sep 04, 2018 at 05:24:35PM +0530, sunil.kovvuri@gmail.com wrote:
> > From: Sunil Goutham <sgoutham@marvell.com>
> >
> > Resource virtualization unit (RVU) on Marvell's OcteonTX2 SOC supports
> > multiple PCIe SRIOV physical functions (PFs) and virtual functions (VFs).
> > PF0 is called administrative / admin function (AF) and has privilege access
> > to registers to provision different RVU functional blocks to each of
> > PF/VF.
>
> Hi Sunil
>
> Please keep netdev in the loop. The people with most experience with
> PF/VF tend to hang out there, not arm-soc.
>
>       Andrew

Sure, will submit again with netdev in loop.

Sunil.
