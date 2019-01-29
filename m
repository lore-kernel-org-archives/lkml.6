Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD30C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B76382175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmHTGU4B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbfA2PqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 10:46:17 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34962 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfA2PqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 10:46:16 -0500
Received: by mail-qt1-f193.google.com with SMTP id v11so22720197qtc.2;
        Tue, 29 Jan 2019 07:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:to:cc:subject:in-reply-to:references
         :mime-version:content-disposition:content-transfer-encoding;
        bh=jaGvAbXhC5dIi1Ogf34SSUSae29H2KVsiNffc9aYcAI=;
        b=fmHTGU4BFN3JldI/opjH6+FX43epwJ2Mvzaik//vy0JD51ENWuCb9fFzEBK/7c1icL
         qFla7GN7aHMrqZc3rEBY36GwQEobJEsZ/qSa+BvQOlMowjW+3X9UJC63Ha6vTozKxnpA
         Kzh0rSk2IZvKfXvz9eMNdiD5U+YehyACJ7p1cmLbriv8HOYxccV/sZ/WPdswxDjnOOBh
         XEGEvMqO2fV+zp6TAMVbZZg6OmW38k8cENIITV3252e8IC97BbZ3I+kTOeaMfnmtXrWu
         hE9oOHFRPovCgOs6mKIczPCB8Ha3wZQw5j5LyNA1tadX0hv0tbwT3+GnU6yeZtdIYKQ2
         e/ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:to:cc:subject:in-reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding;
        bh=jaGvAbXhC5dIi1Ogf34SSUSae29H2KVsiNffc9aYcAI=;
        b=P1/GdH1FPhb8oQCYfH1PjSQg3Bp6tPBYXxl67Q73xJBoV39npQ8WTHMPKikYNcFXwp
         IWzxu3YnjFas6AJgFEJxm9zu5MLe0u5U9iiJe2UJIjX1owv5enjuPnjcl1yxOnPur8yE
         kikE9gX16awhz2NWPpR4wmxmPXOC9xWdf6H2Ju8OZO+QHy3jjbo+s7y/HPidpxd/ZUTp
         x/S2pWHFnBz4Cm/WnEVo1bDefZcZutpKGIzcGUtQSwUZQ8Kp1WP0IXZ3Ffo4XZBcyGuw
         1J69g1Dl3mtKyuRnQg771Z5BTPIdpR8Aw1AjtaixA6G8ctjPQoXIPCLITzZjsnkgc89S
         SaUQ==
X-Gm-Message-State: AJcUukdBpo6BV3V3O0pKPeETBzURK7ka21by3g7rPiQakkLW9pgBokKU
        zjwzBU41doYdHjRVscfpjAQ+jtbK3NA=
X-Google-Smtp-Source: ALg8bN6cs+GD5NtqFV/g7Ky1wPOILWPL7M+ruC2sbXfHZ7W0RQkOGTTGO22yUqsD7LEh0VypBWEljw==
X-Received: by 2002:aed:2b01:: with SMTP id p1mr26165859qtd.101.1548776775209;
        Tue, 29 Jan 2019 07:46:15 -0800 (PST)
Received: from localhost (modemcable249.105-163-184.mc.videotron.ca. [184.163.105.249])
        by smtp.gmail.com with ESMTPSA id 18sm51904571qki.35.2019.01.29.07.46.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 07:46:14 -0800 (PST)
Date:   Tue, 29 Jan 2019 10:46:13 -0500
Message-ID: <20190129104613.GC20920@t480s.localdomain>
From:   Vivien Didelot <vivien.didelot@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>
Subject: Re: [PATCH net-next v2 1/2] net: dsa: mv88e6xxx: Save switch rules
In-Reply-To: <20190129145157.GK4765@lunn.ch>
References: <20190125095507.29334-1-miquel.raynal@bootlin.com>
 <20190125095507.29334-2-miquel.raynal@bootlin.com>
 <c1421a5d-5f92-bb86-b5cc-9fa19a1c8d9f@gmail.com>
 <20190128152456.212ae5ac@xps13> <20190128144417.GG4765@lunn.ch>
 <20190128165749.6abf2dc4@xps13> <20190128174246.GD28759@lunn.ch>
 <20190129100117.5ef6774c@xps13> <20190129145157.GK4765@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquèl,

On Tue, 29 Jan 2019 15:51:57 +0100, Andrew Lunn <andrew@lunn.ch> wrote:

> > Today, there is no S2RAM support for switches. First, I proposed to add
> > suspend/resume callbacks to the mv88e6xxx driver - just enough to avoid
> > crashing the kernel.
> 
> Then i would suggest the mv88e6xxx refuses the suspend. Actually that
> probably is the first correct step. We don't have suspend support, so
> stop the suspend happening, so preventing the kernel crash.
 
I am not confortable with adding support for S2RAM in mv88e6xxx yet because
as it was explained, we are aware of much complicated scenarios out there
to pretend that DSA /partly/ supports suspend-resume. The prefered approach
for the moment is to keep things simple and not supporting this feature yet,
especially at the mv88e6xxx driver level.

However crashing is unacceptable so I'm backing Andrew's point here, please
submit a fix to prevent the suspend (and crash) for the moment.

Sorry if you felt that your work is being delayed, it is much appreciated!


Thanks,

	Vivien
