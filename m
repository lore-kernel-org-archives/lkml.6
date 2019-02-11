Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D547C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C87F9218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="Erv/8S/E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbfBKMkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:40:35 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35075 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbfBKMke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:40:34 -0500
Received: by mail-wr1-f68.google.com with SMTP id t18so181978wrx.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 04:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EasQbeCUSruWqIP7dBgkGAAonxlGmmw3y/af3p9SxcY=;
        b=Erv/8S/Ehi2+gIvmb7p6DSgwiCHXQSQOF7uHWc136Tnx5xO+SCaM0Ol+OlxYnaP642
         SZKXEbhR1X5h063fOvwUSxOQVBVukbD1lA6uO+/W8m7OSdtwMQnbu4Yhd39I6w+O0q0Y
         GR2QRWptbx1g5lrbOAe0SiCf8rk1Kg9utDv+V1fSCX4s/s7dR/4W7mOjH7+g3TJDiMdb
         kVjLpk4PLGQbjUq8Iy1UGdIPlAjeda43h+0ykuKA39KjrGefzjcDIEh7RzXm293UrqNj
         Vuf/hZbeXTNMND8N6VC1TJJQy/7e4sKgiif7DkVOtXprnhEyikKHYkKCLcnZGZoApOU1
         te0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EasQbeCUSruWqIP7dBgkGAAonxlGmmw3y/af3p9SxcY=;
        b=bZgr4LT6n0wtCFqvSU+VFv3sgPlxCh2FvEwKltYnASx6MLlT09a2ejeU0ZjMT06v62
         7P9Iz5GOIddttusJoR/dH6NUalyk5AHZrkGgOInzMCWgYYgwgpmzsf7rYUinKro9QlF8
         usue8f/7Xrx9SVUj8/YuW9w+SsRGUZrbj6d6z5cVOJLJUTHLRu+HXjVuQTRSorslgrTm
         wjUemWKLxINRw7TrQArYb1wF2CPXxGgWNZU2Yc4Nz4GxcgLfWlPHjcpcSiSoCLZp2qGN
         C4qmp6ah39vqnMOYAA3pZlOR1ZRiZ0yDwWsZxMxMLctVngSyfphyIxDlrwwsymivFxTn
         KgfQ==
X-Gm-Message-State: AHQUAuZhR+7oaxkq+VC9xTZl0BiiOTV1qXx1ki89SZxXSM13LPeahBxi
        Vq11NqkYGjcbKbjbFe9u67fvmQ==
X-Google-Smtp-Source: AHgI3IaCNE/UjqHo5qt5c4pFKvxE/8X/LS7JVHLg3GNSy8Br7Ws6nlkhmhD0e2WGcxyp51Z2SOTW9g==
X-Received: by 2002:adf:deca:: with SMTP id i10mr12819360wrn.312.1549888833098;
        Mon, 11 Feb 2019 04:40:33 -0800 (PST)
Received: from localhost (mail.chocen-mesto.cz. [85.163.43.2])
        by smtp.gmail.com with ESMTPSA id v6sm22894690wrd.88.2019.02.11.04.40.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 04:40:32 -0800 (PST)
Date:   Mon, 11 Feb 2019 13:31:10 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, idosch@mellanox.com,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        bridge@lists.linux-foundation.org, jiri@mellanox.com,
        andrew@lunn.ch, vivien.didelot@gmail.com
Subject: Re: [PATCH net-next v3 7/9] net: dsa: Handle
 SWITCHDEV_PORT_ATTR_GET/SET
Message-ID: <20190211123110.GJ2251@nanopsycho>
References: <20190210234007.16173-1-f.fainelli@gmail.com>
 <20190210234007.16173-8-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190210234007.16173-8-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Feb 11, 2019 at 12:40:05AM CET, f.fainelli@gmail.com wrote:
>Following patches will change the way we communicate getting or setting
>a port's attribute and use a blocking notifier to perform those tasks.
>
>Prepare DSA to support receiving notifier events targeting
>SWITCHDEV_PORT_ATTR_GET/SET and simply translate that into the existing
>dsa_slave_port_attr_{set,get} calls.
>
>Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>---
> net/dsa/slave.c | 24 ++++++++++++++++++++++++
> 1 file changed, 24 insertions(+)
>
>diff --git a/net/dsa/slave.c b/net/dsa/slave.c
>index 2e5e7c04821b..2a14a38f5f93 100644
>--- a/net/dsa/slave.c
>+++ b/net/dsa/slave.c
>@@ -1558,6 +1558,27 @@ dsa_slave_switchdev_port_obj_event(unsigned long event,
> 	return notifier_from_errno(err);
> }
> 
>+static int
>+dsa_slave_switchdev_port_attr_event(unsigned long event,
>+		struct net_device *netdev,
>+		struct switchdev_notifier_port_attr_info *port_attr_info)
>+{
>+	int err = -EOPNOTSUPP;
>+
>+	switch (event) {
>+	case SWITCHDEV_PORT_ATTR_SET:
>+		err = dsa_slave_port_attr_set(netdev, port_attr_info->attr,
>+					      port_attr_info->trans);
>+		break;
>+	case SWITCHDEV_PORT_ATTR_GET:
>+		err = dsa_slave_port_attr_get(netdev, port_attr_info->attr);
>+		break;
>+	}
>+
>+	port_attr_info->handled = true;
>+	return notifier_from_errno(err);
>+}
>+
> static int dsa_slave_switchdev_blocking_event(struct notifier_block *unused,
> 					      unsigned long event, void *ptr)
> {
>@@ -1570,6 +1591,9 @@ static int dsa_slave_switchdev_blocking_event(struct notifier_block *unused,
> 	case SWITCHDEV_PORT_OBJ_ADD: /* fall through */
> 	case SWITCHDEV_PORT_OBJ_DEL:
> 		return dsa_slave_switchdev_port_obj_event(event, dev, ptr);
>+	case SWITCHDEV_PORT_ATTR_SET: /* fallthrough */

The case above has "fall through". It would be nice to be consistent.

Anyway:
Acked-by: Jiri Pirko <jiri@mellanox.com>



>+	case SWITCHDEV_PORT_ATTR_GET:
>+		return dsa_slave_switchdev_port_attr_event(event, dev, ptr);
> 	}
> 
> 	return NOTIFY_DONE;
>-- 
>2.19.1
>
