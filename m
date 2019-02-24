Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2656DC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 10:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE1C420663
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 10:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="WsJUohkr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbfBXKEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 05:04:21 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36982 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728257AbfBXKEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 05:04:20 -0500
Received: by mail-wm1-f67.google.com with SMTP id x10so5450543wmg.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Feb 2019 02:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fAtqABL6cQenMdXUJsGE8esaLRpodwJ26VC+hDleMSs=;
        b=WsJUohkrEZ0zMCmSxLNvfHiOGHQ0DX2HzXjAbvycAkSbljgBInxLUv8sCuxtHX14ba
         97yoL4ll+nkXiGwuj3hFKUn0GOLXP6vZOogh9ILlrqlSIc2aW/U3A84+cKej9SeMfMoK
         QJst9ovNB/uLzqqCykUtMvOJShC7aTjhrIrNi5XmDvJLBJ2xQ1ShBKbaaGRxNHdIG1+6
         c4MDOWwuWtIZnCGJwaIBr/Cf/hyFpXTrSGimKWUSD4Zu5db1aaUtOG3lSAsRQQiDZ6mS
         2YnvQyhkjQikizZNBwvflNmDcfX0rmRxZUAH3Gh+jK0JBq97T0wjHvExWBhq1cweA8Q6
         GnqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fAtqABL6cQenMdXUJsGE8esaLRpodwJ26VC+hDleMSs=;
        b=ogE6yzmycAYWdZyV00w9xdRgaWHaYfSFEonDFUgXvaVqlUNBLKnU16mMHtxtPjPcw2
         u+nvtrKjQLhLkzYgNWOZKW17AwQ1HgRRzZCnSerK9fuSmEEexmTalfyHRehCRjNop+xt
         QW39C+z026afJsYkZWS8qSVu6/R7hNDS+E+JXbMSfriGcVRFcfMgB3DkdhokZSKqQCpQ
         +V4Ul7INloYTCpjpKPtil5MJpwGhzM5Gp2NIlL6eXLKO70IKkT1k4LHQd8/y6QCL5tKP
         somCUi9W4EQMXC5Ro3mDpL3Wc2gcde0y/X5Fu83bw5mXozTn2SoDOH9trZyx1WHtRRvJ
         h7Nw==
X-Gm-Message-State: AHQUAubJ7ARA0pLRv2HzUonHbj0DNdL7orMlsl0VHnazmZfv0sNwQZmd
        dLrK6Y+96Za2TB1gKT8IsX7JRw==
X-Google-Smtp-Source: AHgI3IYqmXCcsabqwS/rehYTrbgy9HBj4yRBNFmEdnql6QbQyhgWPvA4m91iJ9z5novNKtDrFRn/Og==
X-Received: by 2002:a1c:6555:: with SMTP id z82mr7141722wmb.125.1551002658709;
        Sun, 24 Feb 2019 02:04:18 -0800 (PST)
Received: from localhost (jirka.pirko.cz. [84.16.102.26])
        by smtp.gmail.com with ESMTPSA id h62sm5584374wmf.11.2019.02.24.02.04.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Feb 2019 02:04:17 -0800 (PST)
Date:   Sun, 24 Feb 2019 10:54:38 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Davide Caratti <dcaratti@redhat.com>,
        Debabrata Banerjee <dbanerje@akamai.com>,
        Sun Lianwen <sunlw.fnst@cn.fujitsu.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 2/2] net: Remove switchdev.h inclusion from
 team/bond/vlan
Message-ID: <20190224095438.GD2759@nanopsycho.orion>
References: <20190222203134.19508-1-f.fainelli@gmail.com>
 <20190222203134.19508-3-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222203134.19508-3-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, Feb 22, 2019 at 09:31:34PM CET, f.fainelli@gmail.com wrote:
>This is no longer necessary after eca59f691566 ("net: Remove support for bridge bypass ndos from stacked devices")
>
>Suggested-by: Ido Schimmel <idosch@mellanox.com>
>Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Jiri Pirko <jiri@mellanox.com>
