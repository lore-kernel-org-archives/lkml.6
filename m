Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198ACC4151A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE4AE2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="c1Ia/WbI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbfBLJFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 04:05:53 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42156 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728718AbfBLJFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 04:05:51 -0500
Received: by mail-wr1-f65.google.com with SMTP id q18so1738282wrx.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 01:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FGlRX8iU3dsg9Re1O0Nu5kG4icOIqx1hSSVLsi3ol6g=;
        b=c1Ia/WbIO3VoZseD1tcxKz+3ryGaufvujLHDWtP8Gn0KK16/gZsR0W5Unr4ixG5UMr
         9IqGVM0qy++8m0x7knoYO5GLs13H+iz5YGti46V1oRK4czVGgFfvEXB/NL1/gKOIMeyB
         pak1+Ju3zh10030tDegHXKIO96cV2QU6QnmvXlH+D7wWbZ/NwfSVi2jCLb527byIojWX
         5gSysgyJySKY1FpTOmjZQ/iL6ArxvIvBLzVS0D/MPiWW4vsdrCm9byW9cz8kWh0f+WwL
         l7/CGIEWkst79yiGR1+mlQCeEYX3tT+Kdl9AxYsgArn8L9+sKTTnBJcaft83j1n5OqQy
         5wxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FGlRX8iU3dsg9Re1O0Nu5kG4icOIqx1hSSVLsi3ol6g=;
        b=NbNRF9RaZUFFLObEf3A/j6h8XmNCQTwyjk/RuFHrmz45zqvw9e42j4wPbnDishVzXe
         JlSmE+IRNBz+WtdQ05bgYTx4hhzn7OW3vZcL7PvAhTsyKhUqidA/u6R1LhS6o4H6Qrht
         MMGbx7XbwJFXcp1pp6HrBZOaMUYjdmSZ4U46wzOzYBuKQNcuCgli8z1jS+tjWvEU2Mtg
         AwPcC5tEmNT9dVHx1rmCCrcSbp5xXzVqt7PMj27AAr5POpC3yJexNVcf01BHsQpi7RIR
         tXrXD7TFvvdTsEv5tu9FPfJbZDl9D0AFy/s0+ri7/p4Ou6xn2pdL7PBc2HFpz4qmZRpI
         fXGA==
X-Gm-Message-State: AHQUAubEKOqg5wyQSfaldALBLdRY1LhVEImLKGVFxZFOK2dbrgSn6cU1
        r4KuJFDMDtfXQB6wAriMWJPxsQ==
X-Google-Smtp-Source: AHgI3IZGJ6wL/+0XUlPBNCw+CZNS9ZApURrN0/NCeAXwOBzT9u3PNFSVGlEZhn8PcAl7WdMXiVG2vQ==
X-Received: by 2002:adf:dd4d:: with SMTP id u13mr2184440wrm.284.1549962349156;
        Tue, 12 Feb 2019 01:05:49 -0800 (PST)
Received: from localhost (mail.chocen-mesto.cz. [85.163.43.2])
        by smtp.gmail.com with ESMTPSA id d16sm10350117wru.52.2019.02.12.01.05.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 01:05:48 -0800 (PST)
Date:   Tue, 12 Feb 2019 09:56:23 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>,
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: Re: [PATCH net-next 3/3] staging: fsl-dpaa2: ethsw: Remove getting
 PORT_BRIDGE_FLAGS
Message-ID: <20190212085623.GE2881@nanopsycho>
References: <20190211211749.19847-1-f.fainelli@gmail.com>
 <20190211211749.19847-4-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211211749.19847-4-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Feb 11, 2019 at 10:17:49PM CET, f.fainelli@gmail.com wrote:
>There is no code that tries to get the attribute
>SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS, remove support for doing that.
>
>Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Jiri Pirko <jiri@mellanox.com>
