Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2ACC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2695C20B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="W9/2gOvD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730627AbfBFNcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 08:32:15 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40072 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728549AbfBFNcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 08:32:15 -0500
Received: by mail-wm1-f66.google.com with SMTP id q21so2725476wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 05:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0GdtiC6WRnK+vEdQsZ2cFcruSI1cFvQFQ7uw7F1Tsik=;
        b=W9/2gOvDyWSl9EJ46nIpQ0i89kbIYNRwGV4Fp5Qg+yaEo83NKByxy1/Smsq8mqs01N
         Phrn/krIxomeLyO90q2hDkqj9FJ1Wjna5Hu/Se1KJ/wGFWBbN59oG4yh4/wJ6EK+Tc25
         lnICEOWzGeSAuz8sk0liSF2dw4Q+cSKXvxWJxv4OHYGahC/0DkwF62mCxD2ZWEhhbn1b
         zGNMLzZVkTLg+Mpc4+oBiErF9d5evY0WH8ahq+aHCqavKZ5xxxld9s+50t/W5nYNJZi5
         lBcd7QtrG2lJjVFIjrVS+7C4R2WWkk6H0mgSQYib3JszebaBJgK10B0qtumEB9/9pWEZ
         qrVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0GdtiC6WRnK+vEdQsZ2cFcruSI1cFvQFQ7uw7F1Tsik=;
        b=k8kgKnbs7sfHxwTn2qfYDRgG2AsMkfI2/DcxXucT4ZSkE1dVA1urAWfGUQE2QcOoD2
         Wxb/r9VmoZ/cCPHHF3SNlBHERhyg9IiiJoc4g+wJhPMFac/a+ZYGplH30PpK1dVsgZdM
         rn0e8cDIoAGgJnxDde8E5wbwWTqK9gilSG3euyfY4h3W0C6kLRPTd4YuoGkchC5/1vYa
         SwppNiaIxYWPI3MFz5FJE8IcxGdJDkc43hrZ+GeDEL8EsrFEijbisW3cY/ur57+PsgQn
         2aNjXCWXK+7TNhpHaPj49yCOrVDURKY9QpJ0iy6BEIZ4mqmCma9Qw9G4AFfKgKebIDam
         /9Mw==
X-Gm-Message-State: AHQUAubWwXCRhPdvwmrd6jo+nxrbn3641DrGKnTx56E/4NAo2+SAwe9G
        B1Ercg72xAEgA3qrUvsLADe+pQ==
X-Google-Smtp-Source: AHgI3IZ3l3YSX9t0hW03jRKiwxBu7DUm99g97iVQ8VmpZvJHFpPxJ9RLExaK2inuvcNCAHgKdp1MHQ==
X-Received: by 2002:a1c:c90b:: with SMTP id f11mr3190787wmb.33.1549459933522;
        Wed, 06 Feb 2019 05:32:13 -0800 (PST)
Received: from localhost (mail.chocen-mesto.cz. [85.163.43.2])
        by smtp.gmail.com with ESMTPSA id c7sm6304891wrn.71.2019.02.06.05.32.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 05:32:13 -0800 (PST)
Date:   Wed, 6 Feb 2019 14:23:02 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:MELLANOX MLX5 core VPI driver" 
        <linux-rdma@vger.kernel.org>,
        "open list:NETRONOME ETHERNET DRIVERS" <oss-drivers@netronome.com>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>
Subject: Re: [PATCH net-next v3 07/12] nfp: Implement ndo_get_port_parent_id()
Message-ID: <20190206132302.GH2189@nanopsycho>
References: <20190205235326.14600-1-f.fainelli@gmail.com>
 <20190205235326.14600-8-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205235326.14600-8-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Feb 06, 2019 at 12:53:21AM CET, f.fainelli@gmail.com wrote:
>NFP only supports SWITCHDEV_ATTR_ID_PORT_PARENT_ID, which makes it a
>great candidate to be converted to use the ndo_get_port_parent_id() NDO
>instead of implementing switchdev_port_attr_get().
>
>Since NFP uses switchdev_port_same_parent_id() convert it to use
>netdev_port_same_parent_id().
>
>Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

[...]

>@@ -31,34 +31,23 @@ struct nfp_port *nfp_port_from_netdev(struct net_device *netdev)
> 	return NULL;
> }
> 
>-static int
>-nfp_port_attr_get(struct net_device *netdev, struct switchdev_attr *attr)
>+int nfp_port_get_port_parent_id(struct net_device *netdev,
>+				struct netdev_phys_item_id *ppid)
> {
> 	struct nfp_port *port;
>+	const u8 *serial;
> 
> 	port = nfp_port_from_netdev(netdev);
> 	if (!port)
> 		return -EOPNOTSUPP;
> 
>-	switch (attr->id) {
>-	case SWITCHDEV_ATTR_ID_PORT_PARENT_ID: {
>-		const u8 *serial;
>-		/* N.B: attr->u.ppid.id is binary data */
>-		attr->u.ppid.id_len = nfp_cpp_serial(port->app->cpp, &serial);
>-		memcpy(&attr->u.ppid.id, serial, attr->u.ppid.id_len);
>-		break;
>-	}
>-	default:
>-		return -EOPNOTSUPP;
>-	}
>+	/* N.B: attr->u.ppid.id is binary data */

Comment is not updated. But I wonder if we really need it...

Otherwise this looks fine.
Acked-by: Jiri Pirko <jiri@mellanox.com>


>+	ppid->id_len = nfp_cpp_serial(port->app->cpp, &serial);
>+	memcpy(&ppid->id, serial, ppid->id_len);
> 
> 	return 0;
> }
> 
>-const struct switchdev_ops nfp_port_switchdev_ops = {
>-	.switchdev_port_attr_get	= nfp_port_attr_get,
>-};
>-
> int nfp_port_setup_tc(struct net_device *netdev, enum tc_setup_type type,
> 		      void *type_data)
> {

[...]
