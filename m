Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F53C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F0A921C2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20150623.gappssmtp.com header.i=@mojatatu-com.20150623.gappssmtp.com header.b="mvLob/O4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F0A921C2B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732554AbeHIRrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:47:06 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:51823 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732232AbeHIRrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:47:05 -0400
Received: by mail-it0-f66.google.com with SMTP id e14-v6so776686itf.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 08:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NfD5o0iOgURatQi67n00Mwts7KqF3vu2CKLpdF9GOEA=;
        b=mvLob/O4J/9DmXKXFAXdXouOzTvnyzxKnYq0RmkxpOalA9ylQ6L7AFYNQTFNCpE4kB
         Dh8q8SQt9jXh68jnNQ1BJZTLJzmn2hgggYIzbcS3Q1Riy/W2kEfy7QO18REeytFXLLJy
         KK2qEIvD32Pj8u3mVCBJEQVFfvs4FwtFrUeazl8uKOlXErd1VEYkycPWocLWv1Jv0YKz
         wZSiDTWAdK0W4ymcAhb1KDxbCg29gTM4ExUKd8at2IMDVpRvEMFey9a9zlbWhZ4pEaQi
         PkQ7uOmBBNP0hT4jUpVJnw38kWyuCIvYBL4UOPtoSbeM7YaObQv40Y2oKv9BQ8C65WUp
         ELWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NfD5o0iOgURatQi67n00Mwts7KqF3vu2CKLpdF9GOEA=;
        b=E1CCyuQX0vRB+pORGgEhv25dTKxIkv9mT50lpYCN1QGBfkbLcFPIl3dMGaSUUHp4DB
         ivM6EM+WcGDnqa5LOFVClCKCmlvAhkNbqwk3ry+fMFZwtyppAJsObq4uZkk1HGZfZDot
         f0rJ9IoGhKjGkS7ly+enaRaM6KLN7pnYpRtQLwPL/v2/lQV5vYw1FPhdW5u5qghPKRkq
         yGrHwcJweTskAKGjRchqEeCV/DLQGDtjaId9bJces7BK4Ijj62lffHJI/aV8wHUkezbO
         oonY2VAomjPiG/Py8JDK3g7wVCKZrXUIwmIdGx0HZBJa1D2jFbZBKVWINlr0mMpHIfwk
         LNcQ==
X-Gm-Message-State: AOUpUlGsJCABEOo3qjBW6oHs+0LEXtcXiCw82Mr5Vu94HyzFvis+KbKX
        RR3uEKk+5IV0DEMz82LPkT7z2Q==
X-Google-Smtp-Source: AA+uWPx+Tb/zAXSgeG/DU6BmJ7BfcR87CZOlPdYLU2wvdWgD1zlgprXIwvzrUVJlDuvstkeGVJx7ng==
X-Received: by 2002:a24:5c93:: with SMTP id q141-v6mr2163306itb.133.1533828101616;
        Thu, 09 Aug 2018 08:21:41 -0700 (PDT)
Received: from x220t ([64.26.149.125])
        by smtp.gmail.com with ESMTPSA id 14-v6sm3765968itu.20.2018.08.09.08.21.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 08:21:40 -0700 (PDT)
Date:   Thu, 9 Aug 2018 11:21:34 -0400
From:   Alexander Aring <aring@mojatatu.com>
To:     Jian-Hong Pan <starnight@g.ncu.edu.tw>
Cc:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
        netdev@vger.kernel.org,
        "<linux-arm-kernel@lists.infradead.org\\" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org>," <linux-kernel@vger.kernel.org>,
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
        Jon Ortego <Jon.Ortego@imst.de>,
        "linux-kernel@vger.kernel.org>," <contact@snootlab.com>,
        Ben Whitten <ben.whitten@lairdtech.com>,
        Brian Ray <brian.ray@link-labs.com>, lora@globalsat.com.tw,
        Alexander Graf <agraf@suse.de>,
        Michal =?utf-8?Q?Kube=C4=8Dek?= <mkubecek@suse.cz>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Steve deRosier <derosier@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        pieter.robyns@uhasselt.be, Hasnain Virk <Hasnain.Virk@arm.com>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Daniele Comel <dcomel@mipot.com>, shess@hessware.de,
        Xue Liu <liuxuenetmail@gmail.com>
Subject: Re: [RFC net-next 00/15] net: A socket API for LoRa
Message-ID: <20180809152134.gcql2lsh4sigx3hg@x220t>
References: <20180701110804.32415-1-afaerber@suse.de>
 <CAC=mGzgUCopz2xTOA0R-WD8a1DOaOOUn=YpfdMiJ33y3hnh6kg@mail.gmail.com>
 <92ee4016-1da9-826b-3674-b2d604a64848@suse.de>
 <20180808213640.10a1d76f@alans-desktop>
 <a70e9715-beac-d9a8-145e-de00175e56fa@suse.de>
 <20180809125939.39ac2cc9@alans-desktop>
 <CAC=mGzjn4Kc-q9NFwX6NhU4V_thnzBP8SHtFQKyRbpSKR=yx3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAC=mGzjn4Kc-q9NFwX6NhU4V_thnzBP8SHtFQKyRbpSKR=yx3w@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Aug 09, 2018 at 11:02:45PM +0800, Jian-Hong Pan wrote:
...
> 
> For LoRaWAN, it is a star topology.
> 

In sense of 6LoWPAN that means "border router" in the middle which runs
radvd on it and sending RA messages. Then doing a route (or even allow nd
proxy) between capable $IPv6 (ethernet?) and LoRa 6LoWPAN interface.

All others listen for RA messages with PIO and doing autoconfiguration.
(In 6LoWPAN you would also pass a 6CO option to compress the PIO
prefix, which would make sense to fully elide all IP addresses in the
header).

- Alex
