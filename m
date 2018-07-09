Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B37C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FF3F20878
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20150623.gappssmtp.com header.i=@mojatatu-com.20150623.gappssmtp.com header.b="lYm8bIED"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FF3F20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933267AbeGIVSG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 17:18:06 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:36078 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932928AbeGIVSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 17:18:04 -0400
Received: by mail-it0-f66.google.com with SMTP id j185-v6so28138164ite.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 14:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7Yo4EBSOz2hbXRb22cox2tJc/ZCWlAas5nbC7zP7umU=;
        b=lYm8bIEDb1s53MvqFmwDNEE9wMiWgc3HCd++E4S+N3r2fR9AdDbNtLjdS3mzMKH+V0
         geIdCoBVzI5XXyUs+EJ9+lGa+L97rwJ7M1SNENHvLrp+PaEnWBOrg2SMf4nunK4TcndR
         DuwifUfkUSxpvXHPBkp5zeVS5S1xdrMYF8qG6PAUoQrxj+8sxFXnK5f46HNj1W6R1xn9
         tn03DEitqy7sm9IdGlRQyxPSE9z2xU/cPUMX1GniyJUpqszNgtZJF7gO5SI1CFTPXi8H
         9ic4wMmQlzl6Ht8FaFFsnS0LWPvE6z0jHiyDM2XIpyafBbxmzJXBqzvmlisYcgWMzeKD
         SDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7Yo4EBSOz2hbXRb22cox2tJc/ZCWlAas5nbC7zP7umU=;
        b=YvUuzPKGYaDXKGAMsvIXlS38rMGxpkU19MZVReysiWwVyo6fu18+K8eNlTmvEGXkz2
         cn0rE+OZBcsS1ZCOQXXSB6xr3Pn3Zf06SprmdQGud81oxoyAv0JFLV+8BN683hXGQe5M
         7BkDL56xwiP97YYYLxn3AK2Jg7qfEpympUlJaXbkBkIbVKWb/uLVUBwqQCgHYduubz65
         MpUrW/+l6JFBdLJ+KYAIu5j9FE+WvSjLwesiF2//imt7y1gLuMgu2klyu+bEJBk0AyFk
         kB1pm2JZ8WT3b1k5cpPDfiwvdvAPLE9n08zGO8PqaCMzlnv8YxXxLqnvaosial7LY+Oi
         vQkA==
X-Gm-Message-State: APt69E0YlFrG6R/m4NxA7FbAuPI1BCOh0PBUHAAvngeIIBouAzf+L/fr
        jCDN3ePstb+xvb1idnYmYa60Dg==
X-Google-Smtp-Source: AAOMgpd+LhTMrJ/dVoiR8p04GVmeol+TPIl5e0xHfdqu7Y2gg+Fu6z6uompmbowowGcn2WjcsI3iGg==
X-Received: by 2002:a24:c246:: with SMTP id i67-v6mr18319489itg.45.1531171083968;
        Mon, 09 Jul 2018 14:18:03 -0700 (PDT)
Received: from x220t ([64.26.149.125])
        by smtp.gmail.com with ESMTPSA id l26-v6sm742909ioh.27.2018.07.09.14.18.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 14:18:03 -0700 (PDT)
Date:   Mon, 9 Jul 2018 17:17:54 -0400
From:   Alexander Aring <aring@mojatatu.com>
To:     Stefan Schmidt <stefan@datenfreihafen.org>
Cc:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Romuald Cari <romuald.cari@devialet.com>,
        linux-wpan@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@osg.samsung.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?Q?Cl=C3=A9ment?= Peron <clement.peron@devialet.com>
Subject: Re: [PATCH] ieee802154: add rx LQI from userspace
Message-ID: <20180709211754.v2oqe3y77fvdd5qa@x220t>
References: <20180607140802.22666-1-peron.clem@gmail.com>
 <ac0ff951-627d-9694-741d-03f6bc4d6ddc@datenfreihafen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ac0ff951-627d-9694-741d-03f6bc4d6ddc@datenfreihafen.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 10:49:08AM +0200, Stefan Schmidt wrote:
> Hello Clement.
> 
> Finally coming to review the patch. Sorry for the delay.
....
> >  
> > +	if (ro->want_lqi) {
> > +		err = put_cmsg(msg, SOL_IEEE802154, WPAN_WANTLQI,
> > +			       sizeof(uint8_t), &(mac_cb(skb)->lqi));
> > +		if (err)
> > +			goto done;
> > +	}
> > +
> 
> I am wondering a bit about the LQI you get back here. Maybe Alex can
> also shed some lights on it. The LQI value stored here is always from
> the last frame send (to any peer)? Or is it the last frame send to this
> specific peer?
>

LQI is available only for per received frame [0], it's important to store
it always when address information are available for the received frame.
The peer you get from the socket layer so far I understood.

Storing means: maybe with some intelligent logic behind to calculate the
average... one LQI value alone don't say anything. With this patch you
can do such logic in user space as a LQI to peer database[1].

Otherwise we already talked about a similar handling as wireless does
with "iw ... station dump" to have such handling in kernel - out of
scope of this discussion.

Side notes:

[0] Ack frames has no address information but it refers to a transmitted
    frame with address information... so not always true. But ack
    handling is offloaded anyhow in the most cases.

[1] Getting complicated how to map a short/pan _and_ extended to _ONE_
    peer entry. -> MLME assoc()/IPv6 ndisc information are needed here.

- Alex
