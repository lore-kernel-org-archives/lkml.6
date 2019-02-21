Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B908EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87CFE21841
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="sNKTUHsQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbfBUKGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 05:06:37 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39046 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfBUKGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 05:06:36 -0500
Received: by mail-wr1-f68.google.com with SMTP id l5so28168086wrw.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 02:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1oMZO8BIU7PEFkmyLfYPoZtYKv5w5rfVUmfStIY8Siw=;
        b=sNKTUHsQPzwXWpfZ/aN6Oy+ZUrr0ZZay47AkCmUKXHxp8Nx5EK+yhYbQEeUm87z84h
         1DnKKoEZlH8SuTcfKrGLBt/r+A5/80EAoEKG3C+3+NnCoZy7BT+vj9h82Jjk51V1A2E1
         tRMthC88WUyXISMAF003ijcEIPk2k9pozBu0PZJ5zU0sgVwKo7+OA5ts8akce48LR9X0
         R5MM6EpZGM7cjSxpYRS3D4NcpRzrOm/JCMDzIoSJPc9yFXtvrMQYJAdPKSQ6E0bTTz/B
         unm5q7OMVMOB45XrK4egq3fljMxj0o/jUeRpBbN3jzXTXuRMt9+t0zPWSz3i+jIoiTKQ
         Efxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1oMZO8BIU7PEFkmyLfYPoZtYKv5w5rfVUmfStIY8Siw=;
        b=mylIuyUo1ILqElFW7syORPcXF6qjV9k/AaxGIeL8r12qVJFPV0Gtsy3CfOf0xEC1Y5
         evsve4g+qpBUO6q3H9QeZkhr39VYIB9JeJCjcuAiHh59EfLLAMKYVDAvaDQAv753e64Q
         BiVWGwWuFjzkedD2fILlhcVMKs45ozoF7l/R9OetATlI+VfTCzyf63fsdaTD6d8gjtOE
         8XNvlKJamdudOCuXwGbZa8gbdlOI7jkTU4QXTB9owbUSaiaZnF7hRM/FyiCTmvI2Y7dB
         j9wsP0PFBHOzEoA/LILRDCjHgQ6A6BJBDn/huk078tJfLRnQ1Y8NXFsRopmfi3uMeEYL
         vlRg==
X-Gm-Message-State: AHQUAuYHIxKkazkgFxMtc37x46lirgEjG5JFZXCM0SULZMYegkaQjD5X
        FJPjD80cZML1SnuwO/Qbi1zTcg==
X-Google-Smtp-Source: AHgI3IYAk5UfSjI+3HNUncEWyI6o3fQ2fuJ5AYtT+DP5YrCiy8HFPQMd0hucEFM8iEW+7u8Hcc61sw==
X-Received: by 2002:adf:a382:: with SMTP id l2mr23890178wrb.79.1550743595209;
        Thu, 21 Feb 2019 02:06:35 -0800 (PST)
Received: from localhost (ip-89-102-139-73.net.upcbroadband.cz. [89.102.139.73])
        by smtp.gmail.com with ESMTPSA id z15sm30584233wrh.18.2019.02.21.02.06.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 02:06:34 -0800 (PST)
Date:   Thu, 21 Feb 2019 10:56:55 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>,
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: Re: [PATCH net-next v3 2/8] mlxsw: spectrum: Handle
 PORT_PRE_BRIDGE_FLAGS
Message-ID: <20190221095655.GE2312@nanopsycho>
References: <20190221005826.26317-1-f.fainelli@gmail.com>
 <20190221005826.26317-3-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221005826.26317-3-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, Feb 21, 2019 at 01:58:20AM CET, f.fainelli@gmail.com wrote:
>In preparation for getting rid of switchdev_port_attr_get(), have mlxsw
>check for the bridge flags being set through switchdev_port_attr_set()
>when the SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS attribute identifier is
>used.
>
>Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Jiri Pirko <jiri@mellanox.com>
