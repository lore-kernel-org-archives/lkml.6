Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4AFC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B21C2080D
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="0TZMpau3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfBIR50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 12:57:26 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38203 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbfBIR5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 12:57:25 -0500
Received: by mail-wm1-f67.google.com with SMTP id v26so9077879wmh.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Feb 2019 09:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eMUZKGn4Gtk1IDFbROQt4KnQm+QHcApHmqZk+SrKedE=;
        b=0TZMpau3fiZXlYPX8ZTNz4BXtRRdsaTe+MBdyiuvscVqBtaJiJeAx2rSo3CUbLgjLe
         8J1q2crboRnd/7lc9e/W6rOZ+uWGHdXaUgIsDbQXdipHI0NXZMKqaKLHN/Rz6U76dcaQ
         LvE4KGys4nHm+46bbT4E0KaTlcIaEjLzo2n+wW5bFfAtZzxF0JIG1q+mtrnQ1Rr9bbhz
         AMTme5Bd3WTnxkLKkzKAyk3xR1QK0uuy3EIP64odra754KLy1yY1mZn6Ov6szAY88qrh
         3zJ5m834EQJmWS/G3Ygo3fCc252uxVzE2BTLDtYJyibCavalBc458oT4wfewKm3bP928
         QGzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eMUZKGn4Gtk1IDFbROQt4KnQm+QHcApHmqZk+SrKedE=;
        b=dO3QfoUNQcqrbJ/PhEVZpI6EiYjRchOpMOg9R/oEfXgLPw7O9L7SSgjKXLKbZAAigQ
         bb2jaotxcBNq4rBjVvD/ixX0HPseueRHssaUEFrwEFkz9O+bZnlnIZjEkFtNm22UHWuN
         MPZVntNjVrW6mi5CRRx8NU/OEQ3RbZPSL0H1TUPgXoYY7kdFj+QjI3eKeZEqRBg2HT2G
         V7MqLYIfHUaMlmJMp1CDuH/HIKlp8R8dm4NlWblVO83oDmxtInGxF+6X+LVJlY08Tn5Y
         fRGuzo4C1JAbmW0inktmrOq4qSdH8g8Ktf1u7U3AKnwfaNGIWssbkruiOgQwbRycyxzN
         LMrA==
X-Gm-Message-State: AHQUAubLSudOljxh/GYeQhpKDDcEdt4yiwpiH/fJ3Y+H42yGN2tFwvbb
        u78p7HIW7g8Z9y0lGNl3NqOQMA==
X-Google-Smtp-Source: AHgI3IZbZtswDTzeqfwIGtiXQgy24UkazC3qwik8xrEv8HcEQD5RvTHt9nY5YzEngz90uK1ZxYXtmw==
X-Received: by 2002:a1c:7409:: with SMTP id p9mr3626405wmc.136.1549735043655;
        Sat, 09 Feb 2019 09:57:23 -0800 (PST)
Received: from localhost (ip-94-113-219-55.net.upcbroadband.cz. [94.113.219.55])
        by smtp.gmail.com with ESMTPSA id i11sm3320613wrs.85.2019.02.09.09.57.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Feb 2019 09:57:22 -0800 (PST)
Date:   Sat, 9 Feb 2019 18:48:10 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>,
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: Re: [PATCH net-next 02/16] mlxsw: spectrum: Check bridge flags
 during prepare phase
Message-ID: <20190209174810.GI2353@nanopsycho>
References: <20190209003248.31088-1-f.fainelli@gmail.com>
 <20190209003248.31088-3-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190209003248.31088-3-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sat, Feb 09, 2019 at 01:32:34AM CET, f.fainelli@gmail.com wrote:
>In preparation for getting rid of switchdev_port_attr_get(), have mlxsw
>check for the bridge flags being set through switchdev_port_attr_set()
>with the SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS attribute identifier.
>
>Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Jiri Pirko <jiri@mellanox.com>
