Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C24C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 16:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D64182244B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 16:58:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D64182244B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lxorguk.ukuu.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbeHJT3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 15:29:30 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:55784 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727522AbeHJT3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 15:29:30 -0400
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id w7AFvBD3010872;
        Fri, 10 Aug 2018 16:57:12 +0100
Date:   Fri, 10 Aug 2018 16:57:11 +0100
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     Jian-Hong Pan <starnight@g.ncu.edu.tw>
Cc:     Andreas =?UTF-8?B?RsOkcmJlcg==?= <afaerber@suse.de>,
        netdev@vger.kernel.org,
        "<linux-arm-kernel@lists.infradead.org\\" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org>," <linux-kernel@vger.kernel.org>,
        Jiri Pirko <jiri@resnulli.us>,
        Marcel Holtmann <marcel@holtmann.org>,
        "David S. Miller" <davem@davemloft.net>,
        Matthias Brugger <mbrugger@suse.com>,
        Janus Piwek <jpiwek@arroweurope.com>,
        Michael =?UTF-8?B?UsO2ZGVy?= <michael.roeder@avnet.eu>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>,
        Konstantin =?UTF-8?B?QsO2aG0=?= <konstantin.boehm@ancud.de>,
        Jan Jongboom <jan.jongboom@arm.com>,
        Jon Ortego <Jon.Ortego@imst.de>,
        "linux-kernel@vger.kernel.org>," <contact@snootlab.com>,
        Ben Whitten <ben.whitten@lairdtech.com>,
        Brian Ray <brian.ray@link-labs.com>, lora@globalsat.com.tw,
        Alexander Graf <agraf@suse.de>,
        Michal =?UTF-8?B?S3ViZcSNZWs=?= <mkubecek@suse.cz>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Steve deRosier <derosier@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        pieter.robyns@uhasselt.be, Hasnain Virk <Hasnain.Virk@arm.com>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Daniele Comel <dcomel@mipot.com>, shess@hessware.de,
        Xue Liu <liuxuenetmail@gmail.com>
Subject: Re: [RFC net-next 00/15] net: A socket API for LoRa
Message-ID: <20180810165711.59bf26f7@alans-desktop>
In-Reply-To: <CAC=mGzjn4Kc-q9NFwX6NhU4V_thnzBP8SHtFQKyRbpSKR=yx3w@mail.gmail.com>
References: <20180701110804.32415-1-afaerber@suse.de>
        <CAC=mGzgUCopz2xTOA0R-WD8a1DOaOOUn=YpfdMiJ33y3hnh6kg@mail.gmail.com>
        <92ee4016-1da9-826b-3674-b2d604a64848@suse.de>
        <20180808213640.10a1d76f@alans-desktop>
        <a70e9715-beac-d9a8-145e-de00175e56fa@suse.de>
        <20180809125939.39ac2cc9@alans-desktop>
        <CAC=mGzjn4Kc-q9NFwX6NhU4V_thnzBP8SHtFQKyRbpSKR=yx3w@mail.gmail.com>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Except saving power, mitigating the wireless signal conflict on the
> air is one of the reasons.

If the device level is always receiving when not transmitting it has no
effect on this. The act of listening does not harm other traffic.

> The sleep/idle/stop mitigate the unconcerned RF signals or messages.

At the physical level it's irrelevant. If we are receiving then we might
hear more things we later discard. It's not running on a tiny
microcontroller so the extra CPU cycles are not going to kill us.

> > How do you plan to deal with routing if you've got multiple devices ?  
> 
> For LoRaWAN, it is a star topology.

No the question was much more how you plan to deal with it in the OS. If
for example I want to open a LORA connection to something, then there
needs to be a proper process to figure out where the target is and how to
get traffic to them.

I guess it's best phrased as

- What does a struct sockaddr_lora look like

- How does the kernel decide which interface it goes out of (if any), and
  if it loops back

remembering we might only be talking to a hub, or we might even be a
virtualized LORA interface where we are pretending to be some kind of
sensor and feeding it back.

Long term yes I think Alexander is right the inevitable fate of all
networks is to become a link layer in order to transmit IP frames 8)

Alan
