Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E1CC43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 11:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EB3624EAB
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 11:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDImOa3v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EB3624EAB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751018AbeFXLKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 07:10:03 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37679 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750743AbeFXLKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 07:10:02 -0400
Received: by mail-wm0-f47.google.com with SMTP id r125-v6so6971428wmg.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jun 2018 04:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Za3K3TIJP/2eTh1XMOEJpBALaqfvxh2m3vMiSApMsM8=;
        b=GDImOa3vCxNQriVSv5YmYHIV1qsHGI76c7TVZN8k724mZUDVIY6/vDoghuhqeIEOna
         ql310SuQDG42cR2W4OVlJK8OA48FiKuS2z/MIbOxZi9H4tRmfangbUwK3BtY70yBhT/S
         frKLiBvWmsbLHO/Af7aN1UJ7utPUre0PlDYhndCR8PnNx08eWSQaOz472DipCA0WcyqL
         qt4CzLV15/DFkVZzSy/tCCO+kRg2zbQJCQuLDZcVm5lYnu2lHC2mck8VeHX52wxn5o+v
         bFcmmPV/GnEA+Z4iVd8h1MWO3lUyUoirIF3ncrLN3PTZv9i7UIFKfuqtbnVb3EO44Ksi
         ou/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Za3K3TIJP/2eTh1XMOEJpBALaqfvxh2m3vMiSApMsM8=;
        b=RRGm52abmY1kvacbm3EVhLYpepDG2/mYOQkxNsrgCvmYv1CMjVAXnXH+qT7ag2SivD
         kEtpXpSwBZNIfQf5RXXPvcnVWh0D5Sm6AD8+q2kK5Rm+DbOzDz+5CoB+ErYzFsumebz3
         Dn8Pf2ZsylAeic/x0d2Bt1MjkdsfH4YfkzXrsOz73Lro1HOUa8aq0uqdKiIEhqvK7wmA
         6It/2FCfg/flq94Ve/vVXRUUd8w4iy02jqBslf/u32nsWHvLG7BBtWBaR+r1fWSqAL0n
         DsrZcmoMuHfoJOmqJTxgsTQPsZumGnYarNGr1lma/eqE1dt5M70+inTiUrmDGqIdFMYq
         TWNg==
X-Gm-Message-State: APt69E22WH1QKxORICtMouQY3R4XdtrWdW6/Ti8PB81z+/6IXjFgwhbG
        jtswpwQ2P+FEv9s53vgCPog=
X-Google-Smtp-Source: AAOMgpe1B6ScIvnQMu05qDoQODKLZA0rE4nvLcCxVR4RLPe7PBOKqpQgux+q2SslP2w0wiQkNqbOvQ==
X-Received: by 2002:a1c:96c8:: with SMTP id y191-v6mr6266051wmd.37.1529838600936;
        Sun, 24 Jun 2018 04:10:00 -0700 (PDT)
Received: from xux707-tw (host86-190-130-185.range86-190.btcentralplus.com. [86.190.130.185])
        by smtp.gmail.com with ESMTPSA id x6-v6sm1072328wmc.42.2018.06.24.04.09.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Jun 2018 04:09:59 -0700 (PDT)
Date:   Sun, 24 Jun 2018 12:09:55 +0100
From:   John Whitmore <arigead@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     John Whitmore <johnfwhitmore@gmail.com>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: Re: V2 Coding style changes. Plus one change to use memset()
Message-ID: <20180624110952.dy5qqv2ni2ax2cje@xux707-tw>
References: <20180624095732.12082-1-johnfwhitmore@gmail.com>
 <20180624105324.GB24157@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180624105324.GB24157@kroah.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 24, 2018 at 06:53:24PM +0800, Greg KH wrote:
> On Sun, Jun 24, 2018 at 10:57:24AM +0100, John Whitmore wrote:
> > Simple coding style changes to single file
> > drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
> 
> Nit, please include the driver and subsystem in your 00/XX emails,
> otherwise they get lost in my filters and I see an odd semi-completed
> series of emails...
> 

Certainly will and sorry for any inconvenience caused by the omission,
should have been obvious in hindsight.
