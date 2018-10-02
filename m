Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00E1C64EBC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98FBE206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="VRy6LDS9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98FBE206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbeJCES3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 00:18:29 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46048 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbeJCES3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 00:18:29 -0400
Received: by mail-ed1-f67.google.com with SMTP id v18-v6so2379148edq.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 14:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=RU7OfRHO3WVHYl+yBsKCY867QZa/g8kuTuocIF+bI00=;
        b=VRy6LDS9dqI2chSCT2OxonEX8KyC+IRhNRBCR5pM5wpjW0WEJAUhAQ5SYGsfEPWGLB
         N4kvn2OxUXHHKF+tuiZlIdMnr9WxhjCr1bH2JW8ZiyiFjlf+EVfVLevfX5aqnjCQo+Bz
         6YH2rI7T0fgtDA4kHcLNCPLBA0ys3sxCNLrJwk9S3a48TJNHjA8L5Cm69E2fZcrcu5gd
         PyQeGgYMrOkVRvaFXDEBiuLz7Q7RS1i+Sl8JIqbZuReRob966Nbq2xIwmE+M9M7dFn24
         zZahdJyAzO7d2OKtKtja4QUeA9WNc5G+fI1R3vfA11lemki+NhfIcnDcuxmFmLk3KV0O
         1QTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RU7OfRHO3WVHYl+yBsKCY867QZa/g8kuTuocIF+bI00=;
        b=TU7tUiM0JAuuQpSFv9mWBenABS3GHIRt2CkQn3As0/+TYS3giZITpKid4KshJK0qPs
         wZJyhFr5sbeHMFobPmikkvSAiwmgwW3ks7uIgDx+1bnPbVs7AZM9MqgqSOJreTrLmP7+
         ixG3u/c5flCZzQHp4rrhKfPK5nENeMQoMgHJX00f88n4ZaBV/uHsBo9NFJIYROFjFT5k
         R0uXm43hFH2dnHF6IyR4GOexkjHtgGEjD47vJuhSyo32sWtHHoKTXyMgLuGeBUPyo/qZ
         ROirlwOFtH3jyDpqPWoEZt6OYCM8ECVDeJIDRvlLZoQAIxJg4ilvOK078mt1YDRZRm3C
         hM6Q==
X-Gm-Message-State: ABuFfoiXgh/eoSjFxjmvMk6vZ8cZjOZBDHrOBb2hyBMhP96Zu7sxa9Td
        cj5phBDipgoZen3s//DCAGP8UA==
X-Google-Smtp-Source: ACcGV61Msb6+aSfWnaHJphAhAAABiLUO2rDBTLMVqwgpKylWxKNG7HAheeso0eLa1mjYV471D0SmCw==
X-Received: by 2002:aa7:de17:: with SMTP id h23-v6mr14834235edv.100.1538515985109;
        Tue, 02 Oct 2018 14:33:05 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id c27-v6sm709283edc.4.2018.10.02.14.33.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 14:33:04 -0700 (PDT)
Message-ID: <1538515983.4348.93.camel@arista.com>
Subject: Re: [PATCHv5 3/7] tty: Hold tty_ldisc_lock() during tty_reopen()
From:   Dmitry Safonov <dima@arista.com>
To:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        linux-kernel@vger.kernel.org
Date:   Tue, 02 Oct 2018 22:33:03 +0100
In-Reply-To: <99f1353a-e1a0-5ade-4aad-3eb62ea42a66@canonical.com>
References: <8c61fd04-969a-cb09-6595-7ee23d214ab1@canonical.com>
         <99f1353a-e1a0-5ade-4aad-3eb62ea42a66@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guilherme,

On Mon, 2018-10-01 at 16:01 -0300, Guilherme G. Piccoli wrote:
> On 01/10/2018 15:32, Guilherme G. Piccoli wrote:
> > Hi Dmitry, thanks for the patch. It's very promising, we have some
> > reports of this issue and I'm building a kernel with this patch in
> > order the reporter can test it. But based in the previous feedback,
> > this seems to be very mature now and ready to get merged, right?

Well, v5 passes 0day, so all previous reports are fixed.
But there is a new one about reboot on parisc platform which takes ~3
mins after the patch with ldisc locked on tty_reopen().

I believe it's related to holding read side for too long..
So, the patches still need another fix, heh.

Unfortunately, I was a bit busy with other bugs hitting more in Arista.

> > I'd like to ask you if you did respin the patch with Greg's
> > suggestion
> > for the tag - I couldn't find it in LKML heheh
> > 
> > Oh, if you can CC me in future spins of this patch (in case there
> > any),
> > I'd really be glad.

Sure, will enlarge Cc list ;)

> > 
> > Thank in advance,
> > 
> > 
> > Guilherme
> > 
> 
> 
> Sorry, forgot to CC linux-kernel...

-- 
Thanks,
             Dmitry
