Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C0DC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 10:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A4E20663
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 10:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="L6fGNwWS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbfBXKEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 05:04:13 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52933 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728061AbfBXKEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 05:04:12 -0500
Received: by mail-wm1-f67.google.com with SMTP id m1so5496587wml.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Feb 2019 02:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=34rweYW/F/9vJ+KRiBoUtRM8280EYIoDKWNi/lCnydI=;
        b=L6fGNwWSGb45L/yXgortRJqRMmCLQSSDZxUGVhP7vPxusHuOKdqANZgjsnH+lO8+8E
         +TvYiGblT/zGsaqg2/Q0JpsBVd4IgXgvkDomLF+GAwwi/e47brNcW+K8csqXZpWmpwqD
         Urxr9yhLd0+l9BvQ9EBaoRsfC1g4LVZ22beb9IGHLBD4eXjGxEwzXGrxc1sMx5iaLUan
         zqnxJz3yiAR0ZglOfgvH2ZWskx+DmBT0x/gUdR1wFRINzN5wQ8AAGFZtH2cgkUPjPFgh
         U+IfYE/h71Em9ULsPJsSL/+iCZ2P2f6/WLIFBdiB7h5im6k2leIUKFuztKN0HqlPAA20
         hmAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=34rweYW/F/9vJ+KRiBoUtRM8280EYIoDKWNi/lCnydI=;
        b=j4PkFcDd8FRAMDRS/g3A8S+tDCKOzo9BwxytgU2ZS9sYGthBdNgQ0PPT8PXPlResZe
         lwvIsZD80KrSioXWYzpLipYvsa/ai3FlGv1uH9JnqN/hO00u+Z/lRBgo0BV8x+6so8Qt
         fJBqehXcawS6OuB2V2I7DBPhhw1YdMsbm8L2lDl+iG16Mm5Oey0cJgtvluWm7N1mkfoD
         vtNIldrVzrzkzS37aoqqNiede8UTlQ1lOMy9E+F0o2ExWF0ZwUR72xLu7nwO43hXzzj0
         D0/GYZ5PUUxI01YiWZu2oky8E5re/GmXobYOkiK8AhuwQtD8ZSTm2kW8TcCda6KYxFJy
         tNvw==
X-Gm-Message-State: AHQUAuYUpw7kpkPCe24Te62BKC+2P23l/DhLCDifih1XL1fdWsvsOblo
        tPd9K7SBpB1ONx3axMPG2QmTcw==
X-Google-Smtp-Source: AHgI3IZDz+ry4EG+fep/CcacmRnLOsbnyRTpsAfaLokdKJi5Bo7R5CBAATil0BpgA+o3PRNT8SO8pA==
X-Received: by 2002:a7b:c4cb:: with SMTP id g11mr819320wmk.84.1551002651068;
        Sun, 24 Feb 2019 02:04:11 -0800 (PST)
Received: from localhost (jirka.pirko.cz. [84.16.102.26])
        by smtp.gmail.com with ESMTPSA id n129sm5440065wmf.21.2019.02.24.02.04.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Feb 2019 02:04:10 -0800 (PST)
Date:   Sun, 24 Feb 2019 10:54:31 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        Jiri Pirko <jiri@mellanox.com>,
        "open list:NETRONOME ETHERNET DRIVERS" <oss-drivers@netronome.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 1/2] nfp: Remove switchdev.h inclusion
Message-ID: <20190224095431.GC2759@nanopsycho.orion>
References: <20190222203134.19508-1-f.fainelli@gmail.com>
 <20190222203134.19508-2-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222203134.19508-2-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, Feb 22, 2019 at 09:31:33PM CET, f.fainelli@gmail.com wrote:
>This is no longer necessary after a5084bb71fa4 ("nfp: Implement
>ndo_get_port_parent_id()")
>
>Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Jiri Pirko <jiri@mellanox.com>
