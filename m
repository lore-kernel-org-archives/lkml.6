Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57FBC64E75
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 15:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7393720866
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 15:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20150623.gappssmtp.com header.i=@mojatatu-com.20150623.gappssmtp.com header.b="Pz+zrBkN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725801AbeLXPcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 10:32:12 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:55005 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbeLXPcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 10:32:10 -0500
Received: by mail-it1-f195.google.com with SMTP id i145so16170699ita.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 07:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hcQc4njU3S+o4H6gOXq6XyYcomBr/RPp5eE5oN5qNlg=;
        b=Pz+zrBkNiRIxetJud78i8fm8KjnPxodmWyIygYk2UWDjTLqOZ7Xa2cFJjbUp6H9hhC
         YZld0bcfhsx7Yl/bDNGwbLSLdIojbLSjEif0bk2WylQ1fk2pRRgiOsLLcQMQEBTae2HZ
         iVatpgpP6LXPcNr0fzfkc5uO9DWeWnPhv0TMuPnE6a/yoAuBu1rL6PkBsBWWajLoPwqT
         TLBL8BGQKYnp7CSWumfmwLhj4ng9CrKhvItIDBTLVgnNvqJ1D07XTFsF1HEoY0lhr1K3
         OmvZLM5+JuAGtpwiw2sDk6KnlAT0gsf199sHcS5kSsRqFSH+sXT5MdZ4VYXnQvU6bSpn
         /X7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hcQc4njU3S+o4H6gOXq6XyYcomBr/RPp5eE5oN5qNlg=;
        b=UPKrPNrPE4hTESKuKvc5vhYYMg4HpB/3mBR7ltLS07ibjkaVumGlbEUA2zUn0vsD+X
         DeHlXeMBZ09PWO64GnBi6tY1sJ6bpZhgO9BgW0xNkyYRw1TOD8ClQ6YrWnWNAg+R5102
         FM1xdUlwG28h3UE2rRM9iSK7076z7wFvD5JpdEIdHXLVkDVOSgoquiih3WE6B3+72Rkx
         ywHqnsCstflqXvio83O/m7NGYztoc3EGbS3G+gIrY+lctpQVa7VCRApjLKkzGqc/PZjB
         YEqGm2qZV+Z0JvTk8M4seoGUMS6GAtIhQgO8T3enoLoqFZ09wcm84Z1Z+8XmR9f3XaCM
         cNWA==
X-Gm-Message-State: AA+aEWZqqA+X7wUT3QhjZZXbHsrW4JET0oeQrcTufKieectgee6+vtSF
        s9qyy+bVFtq+1+cVl2KB2dAswA==
X-Google-Smtp-Source: AFSGD/UJxNItKX+WMvijj4yYoHXYsp5ZHgB6W7TmS43iHP4K8IQ/Ek7Gfjl7V2oPs05PoKmFm/RugQ==
X-Received: by 2002:a24:6fc4:: with SMTP id x187mr9931961itb.93.1545665528818;
        Mon, 24 Dec 2018 07:32:08 -0800 (PST)
Received: from x220t ([64.26.149.125])
        by smtp.gmail.com with ESMTPSA id w129sm11502194ita.0.2018.12.24.07.32.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Dec 2018 07:32:08 -0800 (PST)
Date:   Mon, 24 Dec 2018 10:32:05 -0500
From:   Alexander Aring <aring@mojatatu.com>
To:     Xue Liu <liuxuenetmail@gmail.com>
Cc:     Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
        Jian-Hong Pan <starnight@g.ncu.edu.tw>,
        "David S . Miller" <davem@davemloft.net>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        linux-lpwan@lists.infradead.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>
Subject: Re: [PATCH v5 6/6] net: lorawan: List LORAWAN in menuconfig
Message-ID: <20181224153205.ycr2zdrjbyklulfh@x220t>
References: <CAC=mGziyi1ierhg++SUcHMrq1JQ0vH4gZCKUZgchzb8aD1Rv5Q@mail.gmail.com>
 <20181216101858.9585-7-starnight@g.ncu.edu.tw>
 <CAJuUDwtS3c7NhcNqijyFNtZeupO2HLQ8ZuMA1a-azEQL5yHjng@mail.gmail.com>
 <8bfdccbf-fb47-daa5-fbd0-ed16a3d6d334@suse.de>
 <CAJuUDwsypFMEbTXZO+NwQ_FnD1wsO3ZRc3dthZphFGJ-u0n_=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuUDwsypFMEbTXZO+NwQ_FnD1wsO3ZRc3dthZphFGJ-u0n_=Q@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Dec 18, 2018 at 02:50:58PM +0100, Xue Liu wrote:
> Hello Andreas,
> 
> On Mon, 17 Dec 2018 at 15:19, Andreas Färber <afaerber@suse.de> wrote:
> >
> > Hello Xue Liu,
> >
> > Am 17.12.18 um 09:50 schrieb Xue Liu:
> > > I have a question about the architecture of your module. AFAIK LoRaWAN
> > > is already the MAC Layer above the LoRa technology. Why do you want to
> > > make a new layer called "maclorawan" ?
> >
> > I had asked Jian-Hong to separate between his soft-MAC implementation
> > and the common bits needed to drive hard-MAC implementations found on
> > several of the hardware modules made available to me.
> >
> As a reference Linux 802.11 uses cfg80211 to talk with hard-MAC devices.
> We may also use the name “cfglora” for hard-MAC implementation.
> 

There exists also a cfg802154. :-)

Note that cfg80211 is also for providing a backwardscompatibility to the
wireless ioctl() interface.

In theory it's simple:

netlink API -> SoftMAC (macFOOBAR layer) -> cfgFOOBAR implementation -> driver layer
            \-> HardMAC (driver layer) -> cfgFOOBAR implementation

The "difficult" part is providing one userspace interface for both
either SoftMAC layer and all HardMAC drivers.

There both maintainers need to be synchronized.

As a side note I want to mention that the 802.15.4 subsystem supports
currently a HardMAC transceiver in the SoftMAC layer. We don't have
quite HardMAC support yet but are somehow prepared according the
wireless architecture above.

The people who did that didn't wanted to investigate time to implement a
whole HardMAC layer, as I told them when we support more in the SoftMAC
layer it will break their transceiver... so they was fine with that as
warning it seems. :-)

- Alex
