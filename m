Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CF5C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D6C21EA0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20150623.gappssmtp.com header.i=@mojatatu-com.20150623.gappssmtp.com header.b="wENKxfiw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84D6C21EA0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732410AbeHIRiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:38:07 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:37443 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731793AbeHIRiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:38:06 -0400
Received: by mail-io0-f180.google.com with SMTP id z19-v6so5052360ioh.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 08:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b3OMUVbzieyNK1XyBIGFoBkzd7O2HKrhCfDn+nw8TN4=;
        b=wENKxfiwz1NXc6noK2DIPXOeAz/Yqi/Jxh2gvl+q7X99m2H9efqbQE3agdg6ZhcqQ+
         WM1/HPGjkTGpolJXnz8IEr9lx6rNHIL+wK7+XBIUAjhs521BKEu29ktXrGgEAWNZsmUF
         JRC/23S5ReG4sk5U71+dilc0jCsxX822fklHO6WTow9pRstezktdbq1KFB3VVPuLNyMi
         3wDI365Mi4SCxZxZgSrX5H8MQtFLnz7z/oy9HnPrSAJRx2Rwala485omiPZRxfugDN7f
         1e8Ekg1xb6v58oGiNTZ3GwfNbKRy2H7+S+VSCd2c5YYanp+DkqcsdUjc3jXFfN0P7EcW
         Kyog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b3OMUVbzieyNK1XyBIGFoBkzd7O2HKrhCfDn+nw8TN4=;
        b=sSym4erm1iNyjyP+ACINODl8gTtY0f1DLfm4JxDkfhwN+R+zVUHLT75UO4z28oCoWZ
         F+wzAXPnw+HKV2+Onjr063ZMezL19IJ8TntZ/h9qYbkSJoa06Nk72s5wrOsD+8Ul/23V
         4UtUqKJ3avwJrwUVeunjDi/pN3CcDPTh75mVhm3Gl0WTykxJWEPZBHbB7es3PWlerZO+
         vJAtWIs9L0AhRHNGDD4hblHOwIq0jZ/cQDZEa917k7lTI9ricUKCuI/sWgdIU1r/YUCz
         XL+eef1BiEECghuXXv0Jbulgr8Ow3Is1WpeXLBNk1NmqxrMHanW2ts3AU/b0TypwYn5f
         CbKQ==
X-Gm-Message-State: AOUpUlE25RmkkjYgedx6CnA201NxI6KAfk2M17T46olhwGzmlJccbAoW
        KfP4DcOigW1aOhX1BFnwS4mHmw==
X-Google-Smtp-Source: AA+uWPysKcMQET8aC6zbjFZewaXFSq8D7Ve5I45JC83963tQl74M1jUz3gaRp5O6L8OrFgxl35NAxg==
X-Received: by 2002:a5e:c106:: with SMTP id v6-v6mr821696iol.262.1533827565116;
        Thu, 09 Aug 2018 08:12:45 -0700 (PDT)
Received: from x220t ([64.26.149.125])
        by smtp.gmail.com with ESMTPSA id e129-v6sm4758284ite.35.2018.08.09.08.12.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 08:12:44 -0700 (PDT)
Date:   Thu, 9 Aug 2018 11:12:35 -0400
From:   Alexander Aring <aring@mojatatu.com>
To:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc:     Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
        Jian-Hong Pan <starnight@g.ncu.edu.tw>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jiri Pirko <jiri@resnulli.us>,
        Marcel Holtmann <marcel@holtmann.org>,
        "David S. Miller" <davem@davemloft.net>,
        Matthias Brugger <mbrugger@suse.com>,
        Janus Piwek <jpiwek@arroweurope.com>,
        Michael =?utf-8?B?UsO2ZGVy?= <michael.roeder@avnet.eu>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>,
        Konstantin =?utf-8?B?QsO2aG0=?= <konstantin.boehm@ancud.de>,
        Jan Jongboom <jan.jongboom@arm.com>,
        Jon Ortego <Jon.Ortego@imst.de>, contact@snootlab.com,
        Ben Whitten <ben.whitten@lairdtech.com>,
        Brian Ray <brian.ray@link-labs.com>, lora@globalsat.com.tw,
        Alexander Graf <agraf@suse.de>,
        Michal =?utf-8?Q?Kube=C4=8Dek?= <mkubecek@suse.cz>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Steve deRosier <derosier@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Pieter Robyns <pieter.robyns@uhasselt.be>,
        Hasnain Virk <Hasnain.Virk@arm.com>,
        linux-wpan <linux-wpan@vger.kernel.org>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Daniele Comel <dcomel@mipot.com>,
        Sebastian =?utf-8?Q?He=C3=9F?= <shess@hessware.de>,
        Xue Liu <liuxuenetmail@gmail.com>
Subject: Re: [RFC net-next 00/15] net: A socket API for LoRa
Message-ID: <20180809151235.4yiu75pnq4ww5mdx@x220t>
References: <20180701110804.32415-1-afaerber@suse.de>
 <CAC=mGzgUCopz2xTOA0R-WD8a1DOaOOUn=YpfdMiJ33y3hnh6kg@mail.gmail.com>
 <92ee4016-1da9-826b-3674-b2d604a64848@suse.de>
 <20180808213640.10a1d76f@alans-desktop>
 <a70e9715-beac-d9a8-145e-de00175e56fa@suse.de>
 <20180809125939.39ac2cc9@alans-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180809125939.39ac2cc9@alans-desktop>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Aug 09, 2018 at 12:59:39PM +0100, Alan Cox wrote:
> > Yes, and we are talking about that concrete sx1276 driver here, whose
> > chipset has a state machine that only allows either rx or tx and also
> > has standby and sleep modes with differing levels of data retention.
> 
> It's a hardware limit, it should never influence the protocol stack
> itself just the driver. Linux always tries to design to optimize the
> non-crappy case. In the long term that works out best because hardware
> improves and you don't want to be tied to an old limit.
> 
> > > (Some ancient ethernet cards do this btw.. they can't listen and transmit
> > > at the same time)  
> > 
> > So when do they start receiving?
> 
> When they are not transmitting. The transmit path switches modes and when
> the frame send is done it goes back to receiving. As old ethernet was
> also half duplex that worked.
> 

We do the same at some IEEE 802.15.4 transceivers. A transceiver has
_one_ framebuffer only for tx and rx. Another one has two framebuffer
separated tx and rx, but is half duplex.

There is a little performance tweak in separated framebuffers that you
can fill up the tx framebuffer while the transceiver receives the frame
(completely independet from any bus communicaten/linux handling).

> > The issue here was that my original description, which you appear to
> > have cut, suggested a continuous listen mode, interrupted by transmit.
> 
> I don't think I cut it but if so I didn't mean to and your approach is
> the one I agree with.
> 
...

> 
> There is a heirarchy. Let me us IP for an example
> 
> (historically it was SOCK_PACKET nowdays PF_PACKET - the layering got
> sorted better)
> 
> PF_PACKET SOCK_RAW ETH_P_ALL		
> 
> Everything on that device minus some things like hardware pre-ambles
> 
> PF_PACKET SOCK_RAW ETH_P_SOMETHING
> 
> Everything on that device that has the underlying protocol (and the
> protocol might not be in the packet but a property of the interface
> because it only does that format - simple example SLIP is IP packets over
> a serial link a SLIP interface is IP, not because there is anything
> saying it is but because that is *all* it can be)
> 
> You get the two above for free. PF_PACKET is built into the stack so
> providing you label packets with the ETH_P_xxx you have for Lora, you can
> use PF_PACKET interfaces to dump them and write raw packets at the kernel
> layer.
> 

In 802.15.4:

We recommend nowadays to use PF_PACKET raw sockets for construct L2
frames in userspace. We use that mostly to connect some user space
stacks to make some interop testing without hardware being involved.

For DGRAM sockets, due lack of UAPI limitations of sockaddr_t we
have our own implementation. DGRAM in PF_PACKET use some limitated
feature to "just send something" to an unique address scheme... but some
users need more access because 802.15.4 address scheme is complex.

> PF_INET SOCK_RAW

I think LoRa should look into the 6lowpan subsystem of the Linux kernel
for that. 6lowpan is known as some "IPv6-over-foo" adaptations. Mostly
you just need to implement some mapping from L2 address to SLAAC IPv6 address
pattern only. I see there is a draft at 6lo wg [0] for that which is
expired 2016 (But I would not care about that).

At the end you have a master IP capable interface and your slave is your L2
interface. The 6lowpan interface is a RAW IP interface and do a protocol
translation in the background. On L2 interface you will see L2 + 6LoWPAN
+ $IP_UPPER_LAYER.

Current benefits are more compression, but there exists also some ndisc
optimizations for low power networks which we don't support right now.

- Alex

[0] https://www.ietf.org/archive/id/draft-vilajosana-6lpwa-lora-hc-01.txt
