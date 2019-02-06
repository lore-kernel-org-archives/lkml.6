Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B6CC282CC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 722EB20821
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="BIrBRhjt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730205AbfBFNEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 08:04:06 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43935 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729989AbfBFNED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 08:04:03 -0500
Received: by mail-wr1-f68.google.com with SMTP id r2so7419296wrv.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 05:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QyI8Y4yCJ6naNkvbWvQPQL8YrSWH9uhMAEnZaRLwPbg=;
        b=BIrBRhjtqcr5L5Fie75HAiTfAwTlFDLKLFwRhnUizEi0jR2XJTnHAUywngVDjjF4Pm
         xzpXKQisyRWdG2p7aGHVx0kNK6EDZ94JB0GBGLTjumJCVYpWdJMvL2lhOQh2nsLP0L5m
         r7z85hpxKeuuKjDcKOJmDg4hXL4SN8iNRH98/+J33Wh6WfUExEyvUYHE9R+TR0q9NfsL
         5okPNCJYAjF/3Nk0/RpijyINXfh9P12LVINMn9di/c9oa0xdStqHyD36a7tz6KsOKr9b
         mF2ifOEVQFhVs6a9Ploz0hoLSePO04su/BrKVQDqMxbCf55i++9UJUOuKcpljvKD9ZD0
         0+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QyI8Y4yCJ6naNkvbWvQPQL8YrSWH9uhMAEnZaRLwPbg=;
        b=qrCPXOmRcWx4PVVf04F/psk0uGYibhclLhzGN6C65QiuPhUG+t5cu8kYCij4ik9s+W
         iUPOBX6nQqumTqq7d8wmEcQbtxzaKEdqIOliFragslqHKxygZCOPLfSmL8n4hU8z0oXE
         GsNsZNPNsCl0f+Sf1Wd992fkeF22DvlpD5IjTs+bi9/wcSfm9XdqpRCRc/N0NprZOD8Y
         oUXEEBy8lxAFn3HoMP4Ee25/ele/MkajNpy4LLsjpkjqgeGrv1kBPOPGyKt/UKmUTglh
         IJjAF9bIDVUAeise5ieAs4kkkVJSuu+VAtprZU6zpDUdrMD8heU0KnQv9zi0EZQz7RYN
         +BtQ==
X-Gm-Message-State: AHQUAuYfVB9eeiS2sBZ9kOE/RXSm6vEDfQS2+nAI/qtGi2pWyaIvUSl5
        8ceDi4xY8UgE4CUtKFZgfGvFKw==
X-Google-Smtp-Source: AHgI3IZXzhzZcTYq8cBobiDT3scti72xJhrbM7sARHCvXUYjSJKJXda7NgFj5R9k+6W3t4Sdks9n3g==
X-Received: by 2002:adf:f8c1:: with SMTP id f1mr7722383wrq.31.1549458242045;
        Wed, 06 Feb 2019 05:04:02 -0800 (PST)
Received: from localhost (mail.chocen-mesto.cz. [85.163.43.2])
        by smtp.gmail.com with ESMTPSA id y25sm4213525wma.6.2019.02.06.05.04.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 05:04:01 -0800 (PST)
Date:   Wed, 6 Feb 2019 13:54:50 +0100
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
Subject: Re: [PATCH net-next v3 01/12] net: Introduce ndo_get_port_parent_id()
Message-ID: <20190206125450.GB2189@nanopsycho>
References: <20190205235326.14600-1-f.fainelli@gmail.com>
 <20190205235326.14600-2-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205235326.14600-2-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Feb 06, 2019 at 12:53:15AM CET, f.fainelli@gmail.com wrote:
>In preparation for getting rid of switchdev_ops, create a dedicated NDO
>operation for getting the port's parent identifier. There are
>essentially two classes of drivers that need to implement getting the
>port's parent ID which are VF/PF drivers with a built-in switch, and
>pure switchdev drivers such as mlxsw, ocelot, dsa etc.
>
>We introduce a helper function: dev_get_port_parent_id() which supports
>recursing into the lower devices to obtain the first port's parent ID.
>
>Convert the bridge, core and ipv4 multicast routing code to check for
>such ndo_get_port_parent_id() and call the helper functino when valid

s/functino/function/


>before falling back to switchdev_port_attr_get(). This will allow us to
>convert all relevant drivers in one go instead of having to implement
>both switchdev_port_attr_get() and ndo_get_port_parent_id() operations,
>then get rid of switchdev_port_attr_get().

[...]


>@@ -3651,6 +3657,9 @@ int dev_get_phys_port_id(struct net_device *dev,
> 			 struct netdev_phys_item_id *ppid);
> int dev_get_phys_port_name(struct net_device *dev,
> 			   char *name, size_t len);
>+int dev_get_port_parent_id(struct net_device *dev,
>+			   struct netdev_phys_item_id *ppid, bool recurse);
>+bool netdev_port_same_parent_id(struct net_device *a, struct net_device *b);

One is "dev_" and the second is "netdev_". I see there is this
disconnect all over the code, but I wonder if we should not be
consistent for new things. But I don't insist. I see why both are named
differently (netdev_phys_item_id_same())

Acked-by: Jiri Pirko <jiri@mellanox.com>
