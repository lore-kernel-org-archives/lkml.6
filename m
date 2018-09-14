Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFC7C070C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F8F720861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind-com.20150623.gappssmtp.com header.i=@6wind-com.20150623.gappssmtp.com header.b="z7AnqtIi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F8F720861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=6wind.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbeINNO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 09:14:59 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41929 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbeINNO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 09:14:58 -0400
Received: by mail-lj1-f195.google.com with SMTP id y17-v6so6771587ljy.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 01:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=x74HoJSqQfCB8Z5Lb4LcgZvgqTAwUhUcK/T5a7KFt+U=;
        b=z7AnqtIiZB7H/85aHBOlfL37hGU8sTdX/EARRV3vNm+t4EuHEk9mADFHBmR98TGN57
         QjnSLadXIa+ZL39DXVB61kc4jr3l6WekEUjzR3zr19Wi4qckkWWI6p+eLHlfjTgpCB3H
         pLTtd7jyzMQwk/ZW8YM9f2YbAyfDKs1IpLjC3L4F6GHIMeSjTvEBAe1GCDcctwBU8v63
         /o7iLgxP9p9osfJAEsJXe1NFqKt+Ng1slcCgGtYlm3vs+JkAN9osPanZdVhr9HUJ7NRn
         OJzl5c0epDmvQ8v0hIMcEodxVSS81G8p7V5gLWRprZm9Vm+lpuYh1FhubPy6f263q+2c
         dcIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=x74HoJSqQfCB8Z5Lb4LcgZvgqTAwUhUcK/T5a7KFt+U=;
        b=mkwFcFvQFVH/VfsuZ5kY6AGpYU3agqMaruiZJs0QWXIg1TUIvEPsCtsbTOFKOG/Fv3
         OgE3tCN2I7uzWDDNU6D1ifxBBXy0GIl5oVQUo3oZIcnkA+kbFcv7kgbU5b4+/gAtUnAm
         cgEM58mbI4mZ2QjDPTYgch77nU7o0furFYWNQZ0yllC8lcx27k0pmvKrW2gzEUgwXxoN
         qhFPf86eov8AR0iNlb8t16fYqvfhGGk8Uw9f+XniVu1eHEvBfdUqQflVxlMCGD1kTRmf
         KjoZonXhWbSVjJNs6LE9y9wETgyceJ+Mb4o/Z3IJV2wRV5XP1jurxNq4dKk8SP1XMJA1
         vK7g==
X-Gm-Message-State: APzg51BIdNCJ0OV08dzA3PNrcFt5OnIFkPKuk3a/tF0F+zEhcab8z5dI
        /wrMaMrj7qgJVzsPLzJZOt5NfqCVKkTnjGLLLmA9Gw==
X-Google-Smtp-Source: ANB0VdbA5tFeWjpwlQaCeVXiwxdz8qEssZfGYdwgqCAHPc+IR0XuUO91OARZil2IWh56GY774j5chZSiR1OsHjVen4s=
X-Received: by 2002:a2e:c49:: with SMTP id o9-v6mr6794855ljd.16.1536912098027;
 Fri, 14 Sep 2018 01:01:38 -0700 (PDT)
MIME-Version: 1.0
References: <20180913135844.3ut6fxgx67t6ndtu@breakpoint.cc>
 <3448099.9yk84El3Sa@stwm.de> <20180913163848.ni5xc4gc4d6uusdn@breakpoint.cc>
 <20180913.102305.939671149040995911.davem@davemloft.net> <20180913210325.5usfj2rorvuvtyc7@breakpoint.cc>
 <20180914050651.GD23674@gauss3.secunet.de> <20180914055437.77pffp2jrbfnykbp@breakpoint.cc>
 <20180914060132.GE23674@gauss3.secunet.de>
In-Reply-To: <20180914060132.GE23674@gauss3.secunet.de>
From:   Christophe Gouault <christophe.gouault@6wind.com>
Date:   Fri, 14 Sep 2018 10:01:11 +0200
Message-ID: <CADdy8Hox-zji01dAqpAh9=BLZRHX88qt65yrL=Noe1yYoCJwtA@mail.gmail.com>
Subject: Re: Regression: kernel 4.14 an later very slow with many ipsec tunnels
To:     Steffen Klassert <steffen.klassert@secunet.com>
Cc:     fw@strlen.de, "David S. Miller" <davem@davemloft.net>,
        linux@stwm.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le ven. 14 sept. 2018 =C3=A0 08:01, Steffen Klassert
<steffen.klassert@secunet.com> a =C3=A9crit :
> > > The hash threshold can be configured like this:
> > >
> > > ip x p set hthresh4 0 0
> > >
> > > This sets the hash threshold to local /0 and remote /0 netmasks.
> > > With this configuration, all policies should go to the hashtable.
> >
> > Yes, but won't they all be hashed to same bucket?
> >
> > [ jhash(addr & 0, addr & 0) ] ?
>
> Hm, yes. Maybe something between /0 and /32 makes more sense.

Indeed, hash thresholds not only determine which policies will be
hashed, but also the number of bits of the local and remote address
that will be used to calculate the hash key. Big thresholds mean
potentially fewer hashed policies, but better distribution in the hash
table, and vice versa.

A good trade off must be found depending on the prefix lengths used in
your policies.

Best regards,
Christophe
