Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E6DC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 04:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA722087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 04:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="aqmzHBbv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbfAHEBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 23:01:32 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36871 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbfAHEBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 23:01:32 -0500
Received: by mail-pg1-f196.google.com with SMTP id c25so1111799pgb.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 20:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hI3HFiiQiOBTLixuPxZ9I+eYojMS0YjMnMKMa+vFZv0=;
        b=aqmzHBbvoLVOt7Kzd0jPRPAXuG0MwgDzU65fDYLm0mvdSLfTYsGF/j5wjnjs66hAMy
         3SkmSAYSBAEMLq/Z1oHm/cHUXTbrjipWjnnT4yig3mAZdNbXf1UgnVbG6P+VV2gb8SgI
         hN5fF0DVkSi1e8TLsQV6Bo5BcDEODI8r7HNLU98uaeNKI6iymOkd7Hn6us+oGui1cjkS
         8hlxeLMeV8tZvOxTgTSIDOeJhKtYX7Rn2A2ybKszGIbWZRspawStiEfEs78uThE9JKya
         b0Kjx5Z2Frg2AJUyLdloUVN0BGGOTuzFi/HPKdxI/pHTE96zgHlCzbtTJ9d2yehubXR8
         PypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hI3HFiiQiOBTLixuPxZ9I+eYojMS0YjMnMKMa+vFZv0=;
        b=LnlXt5qCE5JvBY8AFNz0EPwXIAcuyNY678B2qwflUpFIOex2Hq8duH8QZbAwtb7gWV
         /0Om5Bw52G6tec0y8F5Jv2M0il8TnRw+QuVoX85LEtcQ41KH5aOJyjrkjl2ZthvQF+jy
         MXxFdJy6QBTzo6IL0LR2aD0JEfwqPMekhn39hpJSs+ayN4WkuNj6LPdZgeABZEsAatrU
         c6mVtedtzO1jCPZ8nAEX/LYWI0hNC8+N1eFU5qU7zmXkOb2lrnFp2Q+WIqeF61/ABvHm
         NQXllF37GNsxA7KwcJqenEU1O99pPUcZJrMMtlI22ugUFz5qwu5bUmjLKOqAlk+DJim3
         h9SA==
X-Gm-Message-State: AJcUukeewdhY/1AN18+8NdXiAaXzHrS8GHnF/yHte6JiGCM48LMaDTzu
        YMLlNKO0OlYJPpAFVoN+ZyDduA==
X-Google-Smtp-Source: ALg8bN5lzQ0TEnC4tGM2QWkSvlrK0kiKtDXVTjW+AYsWMmHGaLKZPdjkTUkbSM05fVQOqZwN2LmacQ==
X-Received: by 2002:a63:b24a:: with SMTP id t10mr135492pgo.223.1546920090935;
        Mon, 07 Jan 2019 20:01:30 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id g15sm298482974pfj.131.2019.01.07.20.01.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 20:01:30 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1ggia1-0007HO-C7; Mon, 07 Jan 2019 21:01:29 -0700
Date:   Mon, 7 Jan 2019 21:01:29 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     David Gibson <david@gibson.dropbear.id.au>,
        Leon Romanovsky <leon@kernel.org>, davem@davemloft.net,
        saeedm@mellanox.com, ogerlitz@mellanox.com, tariqt@mellanox.com,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
        alex.williamson@redhat.com, linux-pci@vger.kernel.org,
        linux-rdma@vger.kernel.org, sbest@redhat.com, paulus@samba.org
Subject: Re: [PATCH] PCI: Add no-D3 quirk for Mellanox ConnectX-[45]
Message-ID: <20190108040129.GE5336@ziepe.ca>
References: <20181206041951.22413-1-david@gibson.dropbear.id.au>
 <20181206064509.GM15544@mtr-leonro.mtl.com>
 <20190104034401.GA2801@umbus.fritz.box>
 <20190105175116.GB14238@ziepe.ca>
 <c1296ee9120a6a04dc75d0fdb2a641c722cb65d6.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1296ee9120a6a04dc75d0fdb2a641c722cb65d6.camel@kernel.crashing.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 06, 2019 at 09:43:46AM +1100, Benjamin Herrenschmidt wrote:
> On Sat, 2019-01-05 at 10:51 -0700, Jason Gunthorpe wrote:
> > 
> > > Interesting.  I've investigated this further, though I don't have as
> > > many new clues as I'd like.  The problem occurs reliably, at least on
> > > one particular type of machine (a POWER8 "Garrison" with ConnectX-4).
> > > I don't yet know if it occurs with other machines, I'm having trouble
> > > getting access to other machines with a suitable card.  I didn't
> > > manage to reproduce it on a different POWER8 machine with a
> > > ConnectX-5, but I don't know if it's the difference in machine or
> > > difference in card revision that's important.
> > 
> > Make sure the card has the latest firmware is always good advice..
> > 
> > > So possibilities that occur to me:
> > >   * It's something specific about how the vfio-pci driver uses D3
> > >     state - have you tried rebinding your device to vfio-pci?
> > >   * It's something specific about POWER, either the kernel or the PCI
> > >     bridge hardware
> > >   * It's something specific about this particular type of machine
> > 
> > Does the EEH indicate what happend to actually trigger it?
> 
> In a very cryptic way that requires manual parsing using non-public
> docs sadly but yes. From the look of it, it's a completion timeout.
> 
> Looks to me like we don't get a response to a config space access
> during the change of D state. I don't know if it's the write of the D3
> state itself or the read back though (it's probably detected on the
> read back or a subsequent read, but that doesn't tell me which specific
> one failed).

If it is just one card doing it (again, check you have latest
firmware) I wonder if it is a sketchy PCI-E electrical link that is
causing a long re-training cycle? Can you tell if the PCI-E link is
permanently gone or does it eventually return?

Does the card work in Gen 3 when it starts? Is there any indication of
PCI-E link errors?

Everytime or sometimes?

POWER 8 firmware is good? If the link does eventually come back, is
the POWER8's D3 resumption timeout long enough?

If this doesn't lead to an obvious conclusion you'll probably need to
connect to IBM's Mellanox support team to get more information from
the card side.

Jason
