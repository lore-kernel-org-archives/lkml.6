Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D4FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C272020851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dy87YF6n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbfAQPqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 10:46:45 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34831 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfAQPqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 10:46:44 -0500
Received: by mail-qt1-f196.google.com with SMTP id v11so11822916qtc.2;
        Thu, 17 Jan 2019 07:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:to:cc:subject:in-reply-to:references
         :mime-version:content-disposition:content-transfer-encoding;
        bh=jHJk2JTrGPsgGJESLAmFG+JEDl1c8XvxhK7trGqKLyY=;
        b=dy87YF6nHNfQFAyyhEG/QprjUrGpaKSU4YoGhKkFIYDCuQLeM5wClc/wBILCuJl7Kb
         QH2q+P15pUSGg7TDdrHR0BXmmTaCRLc88rZW0X1cq5irbI/F2cHmDWvTn/D3aWtPmgUn
         7Jd0+sk1514iAew+xmQDSaehtmwuDCgqVGO+LR36qkQs2U+gqq6F/ODhHmbz9W/fe/Po
         sveBvkX2z8sjgl7PFTIPg2CVIjChkyRjZ7Kmkc1Blq/lBwj32zB7N4S3JTNyQOeym/+v
         W/GpYjrreeoVvWWXGIv6FzQnboYRW7JW8fKxiNd9Y0jVhE41uu6g1jzMCMxRCkY/WXZY
         Lxkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:to:cc:subject:in-reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding;
        bh=jHJk2JTrGPsgGJESLAmFG+JEDl1c8XvxhK7trGqKLyY=;
        b=LDN+55MDjNJv9LLzwQg4KbwVM8VNgyN0//ymjoJeB+v090Ad6pOKJoEgth0J/d5dwI
         0pXVe7DUI6Ok+eFvSuPTZvl2fk4TMoM6EhqgCRyiUUwKIE4xI4z7Yylrm5nmtAsSTYeZ
         YgxAetRTDTp/EC6vyTLG6/hDrSDmUY/7Orcg8Yj7Xpb8htAjMW3Py5EkFEovsYmYgPo9
         V61JbEUJu4zuYNhQ6tBBQecpLg4DOTq9Sj+nTZIBBwawihemoTCskRnDfu+VfBq3MA3t
         6DLi6tCWMFxeD79dk6xspD3TojA6xl1BhNkWncOWxF73wqPy6TFXQNPhiNNBaKums+E3
         k2Dg==
X-Gm-Message-State: AJcUukdTdSAx6LiMif/uES0nSeohoacKLvnI4o4kGAtJT0W3pM4WLBHn
        kUoS53lGgpDbEwS4kZN+keM=
X-Google-Smtp-Source: ALg8bN6WMIEYJMbTrV/z/3fobiFMxYp+0JXaL1Px2bUsMX7HGNJhl5JerDdpZYC5iBFBOdDBOaq5Jg==
X-Received: by 2002:ad4:50ca:: with SMTP id e10mr11312408qvq.20.1547740003219;
        Thu, 17 Jan 2019 07:46:43 -0800 (PST)
Received: from localhost (modemcable249.105-163-184.mc.videotron.ca. [184.163.105.249])
        by smtp.gmail.com with ESMTPSA id o42sm62686855qtc.90.2019.01.17.07.46.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 07:46:42 -0800 (PST)
Date:   Thu, 17 Jan 2019 10:46:41 -0500
Message-ID: <20190117104641.GD13242@t480s.localdomain>
From:   Vivien Didelot <vivien.didelot@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>
Subject: Re: [PATCH net-next] net: dsa: mv88e6xxx: Add suspend/resume
 callbacks
In-Reply-To: <20190116222329.GP29244@lunn.ch>
References: <20190116153419.3208-1-miquel.raynal@bootlin.com>
 <20190116155651.GC29244@lunn.ch>
 <e9ac5203-87ba-c14f-8140-5b100808a8a4@gmail.com>
 <20190116222329.GP29244@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 16 Jan 2019 23:23:29 +0100, Andrew Lunn <andrew@lunn.ch> wrote:
> Hi Florian
> 
> > A possible approach could be to call the port_disable, port_enable
> > callbacks from dsa_slave_suspend() and dsa_slave_resume(), I might have
> > some patches doing that already somewhere.
> 
> I expect it is also on Viviens TODO list, since this really could be
> in the core.

Indeed that is!
