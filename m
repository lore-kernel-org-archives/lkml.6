Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95798C00319
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 645C62147A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="jR2bXCXG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbfBUKHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 05:07:15 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34079 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727765AbfBUKHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 05:07:14 -0500
Received: by mail-wr1-f65.google.com with SMTP id f14so29357881wrg.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 02:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HqdgBkYNS/neJhKCf+oOyRMwcBJqLhQt7+NMOL23En8=;
        b=jR2bXCXG4SGWrS/VcaC+oXl4+W3cSzGT00a8RMUDG3NTmMMANwYh3Iz6EGQjmE/Swh
         grb8JVcMLNz8GlotLwSIK5gLRZLil06zjgNv9GYgaQxEAh1DRWvljXUyFcPt6r39hjKn
         L/zIxccCANJtrBQnP7J5LY5YSAmDKb5oArxV8PWziI8aGuipTeAWf4/22BphAiSGWIx7
         6RgAxZ+Qd0X+B21NEqdoDr+h6M7RdcX4CwzrBhKFsxGhOi5oBfOOz+jsLm4R03dBcoJS
         kn8Yo6HySPt3tPT7DYX3Q8N9wrGmcKPGvYsFPoRYTnE0YerNeXbGAVkUptLYRfn3nq4N
         nrJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HqdgBkYNS/neJhKCf+oOyRMwcBJqLhQt7+NMOL23En8=;
        b=Q/QUy5jbhym1tHseQId3zP5A+cihc/SVIQXszsFqWgb6n/daklVWrdWpxhw0vXKGB/
         cih0gwpwguZjlzud6wGsoBTQdrU0Gu6yfe0+Eohm2lWgRm6jCW5WAAm5/NP5cpbhvi7o
         IMgenOT7gY6PDYUtYHvqYu1mNeaD+x/PR2PC8FMxXN9nTpDzdHXuD9OS7PCdQ5HI403O
         yUnz/k7AqRFp9eYnak+NuLrYKfEMdlLqRE5OAjxUmS9hnjg5/t8/IRaXb1Ai7S30+77o
         p8y+8OV80aLp+4CB2UzSgUqKC3hzVQJkdWBlKbj9vpcIFUymQIuAUSBFIQ6qyIktGq+S
         ea8g==
X-Gm-Message-State: AHQUAubY3uTS4jdkUWyF+GTeGWUt6IkqZbwIjAncpLSamdNgIJJKKjlM
        3I8F5xML62pxViz+pqdpDHmXTw==
X-Google-Smtp-Source: AHgI3IaP38HtOPmXulepzHppKDP3rhiAG4uDzAyhHOOrgUkcyVRiCTLlVv4rpFY+ibKC5I6/41e6LA==
X-Received: by 2002:a5d:4585:: with SMTP id p5mr30200262wrq.178.1550743632826;
        Thu, 21 Feb 2019 02:07:12 -0800 (PST)
Received: from localhost (ip-89-102-139-73.net.upcbroadband.cz. [89.102.139.73])
        by smtp.gmail.com with ESMTPSA id h184sm14212397wmf.0.2019.02.21.02.07.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 02:07:12 -0800 (PST)
Date:   Thu, 21 Feb 2019 10:57:33 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>,
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: Re: [PATCH net-next v3 6/8] net: bridge: Stop calling
 switchdev_port_attr_get()
Message-ID: <20190221095733.GI2312@nanopsycho>
References: <20190221005826.26317-1-f.fainelli@gmail.com>
 <20190221005826.26317-7-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221005826.26317-7-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, Feb 21, 2019 at 01:58:24AM CET, f.fainelli@gmail.com wrote:
>Now that all switchdev drivers have been converted to check the
>SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS flags and report flags that they
>do not support accordingly, we can migrate the bridge code to try to set
>that attribute first, check the results and then do the actual setting.
>
>Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Jiri Pirko <jiri@mellanox.com>
