Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0A6C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 15:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8434820857
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 15:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="uw/3rf51"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbfBBP5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 10:57:39 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55518 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbfBBP5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 10:57:38 -0500
Received: by mail-wm1-f66.google.com with SMTP id y139so8970922wmc.5
        for <linux-kernel@vger.kernel.org>; Sat, 02 Feb 2019 07:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SNR7K3ca91hxNke7Mc6m88At/9fi9nnjgPZ6cpHIlKU=;
        b=uw/3rf51ZVDR08cViEt5HKJu3ORmX3eHj4/RYvLjhtp4/tWI2H1umb1tdvIM41mOYg
         7PZa5MAlukOGLAEs997lWpmiCtYQW1KXFXi59OWShUx+Fr7SgvkdYxAAOLUI7kFnBA/a
         7ku1QcR389zvk7f1Q7Sw7oIf0dbbsZ6yHe6j3g3H4EDclEcZYZfZ1Z8choIBMZbnTLep
         Kep47pJ7jVY6/oAVnDeUeBiowDJCNLgctsjkAO76ZaB5XC+iX72bC3iveOKhMp0+9KFl
         5pb+900C5dKO23p5hGhRPwuhj3txfjXyL+Im52utCXFAFB6lhwYWek2G4QXav/eWeMmI
         n1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SNR7K3ca91hxNke7Mc6m88At/9fi9nnjgPZ6cpHIlKU=;
        b=rzJjAO62vPV3vEalrNR/HXHLGVPuh6y/zeNl4tXw4SUhF4OgG/1LElcpQ+ZFGD6zBG
         TWWRFUG1/SSALm3wdbx9PcGaGJQhra+KVnjSxVX+bUrr6Eidp9TAAesD+PiTaRqubDKv
         IBEYkNNxz0WWpXcFgXCcOls8c2ux0FoSWvuZEJpIAJXtcII6QFgGR4unWLftdb1+EU02
         EdYvp27aZxQUra4MmtcCTi6FQJdhDoNmXoQU6IRU7YeBdCI+pNSW/FnyEe3IZjSb1udW
         WxsLKidgyTCmSh1CvOREHKiN44rptqrv90rggSMokv6PXajWeLCkfv15UNdHfRuE2UVe
         MnIg==
X-Gm-Message-State: AHQUAuYzSbpZoVOeWKgAueydFXhu1ETkgMLHznTAlbmOLkHVUwoLsAI4
        eca8WslE/Squhj/ZhTplvjp2Dw==
X-Google-Smtp-Source: AHgI3IbihZjkKuLM5wQ5KSn3DaNY/jqYQyL/0zWaRLCL7nbj0IFQbwk0gm5AJcL2IIFhRjZHnyUsOg==
X-Received: by 2002:a1c:cf0d:: with SMTP id f13mr5319941wmg.70.1549123056723;
        Sat, 02 Feb 2019 07:57:36 -0800 (PST)
Received: from localhost (jirka.pirko.cz. [84.16.102.26])
        by smtp.gmail.com with ESMTPSA id o4sm8593743wrq.66.2019.02.02.07.57.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Feb 2019 07:57:35 -0800 (PST)
Date:   Sat, 2 Feb 2019 16:48:32 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Derek Chickles <dchickles@marvell.com>,
        Satanand Burla <sburla@marvell.com>,
        Felix Manlunas <fmanlunas@marvell.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jiri Pirko <jiri@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Ioana Radulescu <ruxandra.radulescu@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        "Francois H. Theron" <francois.theron@netronome.com>,
        Simon Horman <simon.horman@netronome.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eric Dumazet <edumazet@google.com>,
        John Hurley <john.hurley@netronome.com>,
        Edwin Peer <edwin.peer@netronome.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:MELLANOX MLX5 core VPI driver" 
        <linux-rdma@vger.kernel.org>,
        "open list:NETRONOME ETHERNET DRIVERS" <oss-drivers@netronome.com>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>
Subject: Re: [RFC net-next 01/13] switchdev: Add SWITCHDEV_PORT_ATTR_SET,
 SWITCHDEV_PORT_ATTR_GET
Message-ID: <20190202154832.GC2778@nanopsycho>
References: <20190201220657.30170-1-f.fainelli@gmail.com>
 <20190201220657.30170-2-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201220657.30170-2-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, Feb 01, 2019 at 11:06:45PM CET, f.fainelli@gmail.com wrote:
>In preparation for allowing switchdev enabled drivers to veto specific
>attribute settings from within the context of the caller, introduce a
>new switchdev notifier type for port attributes.
>
>Suggested-by: Ido Schimmel <idosch@mellanox.com>
>Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>---
> include/net/switchdev.h | 10 ++++++++++
> 1 file changed, 10 insertions(+)
>
>diff --git a/include/net/switchdev.h b/include/net/switchdev.h
>index 63843ae5dc81..e62fb2693e00 100644
>--- a/include/net/switchdev.h
>+++ b/include/net/switchdev.h
>@@ -145,6 +145,9 @@ enum switchdev_notifier_type {
> 	SWITCHDEV_VXLAN_FDB_ADD_TO_DEVICE,
> 	SWITCHDEV_VXLAN_FDB_DEL_TO_DEVICE,
> 	SWITCHDEV_VXLAN_FDB_OFFLOADED,
>+
>+	SWITCHDEV_PORT_ATTR_SET, /* Blocking. */
>+	SWITCHDEV_PORT_ATTR_GET, /* Blocking. */

Not an UAPI, so you can put this right next to PORT_OBJ_* if needed.


> };
> 
> struct switchdev_notifier_info {
>@@ -167,6 +170,13 @@ struct switchdev_notifier_port_obj_info {
> 	bool handled;
> };
> 
>+struct switchdev_notifier_port_attr_info {
>+	struct switchdev_notifier_info info; /* must be first */
>+	struct switchdev_attr *attr;
>+	struct switchdev_trans *trans;
>+	bool handled;
>+};
>+
> static inline struct net_device *
> switchdev_notifier_info_to_dev(const struct switchdev_notifier_info *info)
> {
>-- 
>2.17.1
>
