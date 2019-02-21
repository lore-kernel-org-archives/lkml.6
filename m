Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2891C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B04982147A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="edyNqcTf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbfBUKG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 05:06:58 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37234 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfBUKG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 05:06:57 -0500
Received: by mail-wm1-f68.google.com with SMTP id x10so9244067wmg.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 02:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8MOCgt95yWI292pdCojldnnMEjFevPEjYktsxACkKrM=;
        b=edyNqcTfN2S0UrhlCfaHD8P5gjJKMe0SMwzzO9gWQALYNiBJJ4bo+pxq/F61/MMdOc
         cBsdqxxJA0m30Ijql6asUPG1ff9QDA5lf/qW+wNz5ZUK8iCXDdRLyiZCqQmpZoFOfbIX
         ShBek05en0sBMgxiivk+yasx8ppEbxL4sw1h+lRzRwVOmClzDYVNmP0I440jCjAUaRaM
         IAI+Q8ob/SAXJRQJjKY50l0bIhFvmldyxJibvvdpMrTOyAUvPP+OGQHrPsBw3wRpWkUn
         qtyyOigOS1XL5N3iIpY9EamKECs4qnz2o8k2VSlyYZikV8zwCgVV8z505AfRN1vt8DIw
         S4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8MOCgt95yWI292pdCojldnnMEjFevPEjYktsxACkKrM=;
        b=WmMQJnr9JswzvbUCHnNgXrhhvCR0TfP0xOs/eoRWbv0LRXORARwbEbjzABa2rOSj6H
         Yy8ptl+L5jkgB7lM0/GlhQt+RrUqxDu3kj3ifliDKxsR/mnU+Tc7jkSW8Yjn1PCXKfBh
         ihzP1aKZd2xDWf01iiTSHqNFCYiwyyf15P14M3nQ640T1BXi2VUhDyU+KmivFv3AjgHe
         2lOccqmWYJWHUMre+whKm26nKX2te9tN/Drke5myBaUeDgv7599Apjru+W1QqbqgntdM
         lou23J/IEi+bnJziXA111Ws9FLJh82WGQU/xVnwmaalIHPxj2p9P7XuN5lwgd2tOnUs5
         0mjQ==
X-Gm-Message-State: AHQUAubXS/jq2rOgrt/6nW+mmgeNNOJcWijkqiJdYnBgaUxzKwv/cEjR
        V6I5urcbtkAMY8l0oAjqOq5ga3U1Ack=
X-Google-Smtp-Source: AHgI3IZsEmvAVc6FuiRcTpdXVcTbNzDHH/KoxAYGl4DYw9zlReyaRQgP6T71G8OIQ5oUuWH2/sXdmw==
X-Received: by 2002:a1c:480a:: with SMTP id v10mr9227039wma.57.1550743615725;
        Thu, 21 Feb 2019 02:06:55 -0800 (PST)
Received: from localhost (ip-89-102-139-73.net.upcbroadband.cz. [89.102.139.73])
        by smtp.gmail.com with ESMTPSA id x3sm27042383wrd.19.2019.02.21.02.06.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 02:06:55 -0800 (PST)
Date:   Thu, 21 Feb 2019 10:57:16 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>,
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: Re: [PATCH net-next v3 4/8] net: dsa: Add setter for
 SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS
Message-ID: <20190221095716.GG2312@nanopsycho>
References: <20190221005826.26317-1-f.fainelli@gmail.com>
 <20190221005826.26317-5-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221005826.26317-5-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, Feb 21, 2019 at 01:58:22AM CET, f.fainelli@gmail.com wrote:
>In preparation for removing SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT,
>add support for a function that processes the
>SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS and
>SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS attributes and returns not
>supported for any flag set, since DSA does not currently support
>toggling those bridge port attributes (yet).
>
>Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Jiri Pirko <jiri@mellanox.com>
