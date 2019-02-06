Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76E4C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75FB12073D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X57ZZSFw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbfBFSVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:21:22 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41646 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbfBFSVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:21:22 -0500
Received: by mail-qk1-f194.google.com with SMTP id u188so4854661qkh.8;
        Wed, 06 Feb 2019 10:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:to:cc:subject:in-reply-to:references
         :mime-version:content-disposition:content-transfer-encoding;
        bh=sJY6SozMeweLkOESTHv5iTZYjJjXNBDdJF8oG18/R1U=;
        b=X57ZZSFwiaJVl+HqDuB3rf6KN3lt+A8nQfl+l+FH+iMoMBFB0G3WKCwUvrY1iCC0e1
         ASQL0F86v22n1YoTAZfE4QsEQAdCpffTeEWxWv2QFs2iDGLRC2NUfmMIWjB+lO2nnwVp
         m/DeJS0jAkhZCFLplthhzVkfJg8PKAFn42aaCmaKB007YWAVk9cogIMwxUurFuJXJ4tV
         ME8nJDNOHv109sL1lX9lLcc1OvrbpnN+FPobuQUDAGJTvheV9zd2uVO6K1zcl9F4eGUZ
         4bq3/hRl5DIw0yPZi+HQ4Rlnmiz/qQ9DnZo1Xyjan7cU+KHCy7McAluxHZ5lN4o5UH7B
         r/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:to:cc:subject:in-reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding;
        bh=sJY6SozMeweLkOESTHv5iTZYjJjXNBDdJF8oG18/R1U=;
        b=pBgDr81JzPP+/XKjZVvky+F/fQiG+loLagMg7m+a39yfJHZvQvWDenObUPighMMPU0
         AkhbvGRamG5EMSPIckTOa7rZccugouN799mtNedL8ABZf4/IwuwunYrMgmpVAxjMEgSm
         Pv7ppkPadY1Y8Zrdzjy+8rQXKJbOuqcvnO/bXDsdgXz91404CX48wrFBBi32Dkl7dGEy
         mSE3xbWtAA78yCK7prFWWRZ459SPg4361AcBgmQi+8UQQbapYbYCldaQZKgXsc1W3QMq
         wA0GTuB4KNlwB57FZIKFAPBucqF6j3fsdVOCCI6y/mQy9NMRx13lzwkoqMRhfJ0vhyuD
         9X/g==
X-Gm-Message-State: AHQUAuaApOrJwcq6yPOxZqYPQ5+bBEyJN0e3RKY8ce7UzcQ7K/HdnWhN
        A/Q0cBjaDcwRRHPHD7P1+5E=
X-Google-Smtp-Source: AHgI3IaqO0fxaTEQ6aHUC2sbzNGVPNtWiv+6xPjl/dG63hfiH85M2gz7NoUTjnw5VHhoObzVVBQEZw==
X-Received: by 2002:a37:6d44:: with SMTP id i65mr8311365qkc.73.1549477280676;
        Wed, 06 Feb 2019 10:21:20 -0800 (PST)
Received: from localhost (modemcable249.105-163-184.mc.videotron.ca. [184.163.105.249])
        by smtp.gmail.com with ESMTPSA id s36sm23167433qth.17.2019.02.06.10.21.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 10:21:19 -0800 (PST)
Date:   Wed, 6 Feb 2019 13:21:18 -0500
Message-ID: <20190206132118.GD9278@t480s.localdomain>
From:   Vivien Didelot <vivien.didelot@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:MELLANOX MLX5 core VPI driver" 
        <linux-rdma@vger.kernel.org>,
        "open list:NETRONOME ETHERNET DRIVERS" <oss-drivers@netronome.com>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>
Subject: Re: [PATCH net-next v3 11/12] net: dsa: Implement
 ndo_get_port_parent_id()
In-Reply-To: <20190205235326.14600-12-f.fainelli@gmail.com>
References: <20190205235326.14600-1-f.fainelli@gmail.com>
 <20190205235326.14600-12-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On Tue,  5 Feb 2019 15:53:25 -0800, Florian Fainelli <f.fainelli@gmail.com> wrote:
> DSA implements SWITCHDEV_ATTR_ID_PORT_PARENT_ID and we want to get rid
> of switchdev_ops eventually, ease that migration by implementing a
> ndo_get_port_parent_id() function which returns what
> switchdev_port_attr_get() would do.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  net/dsa/slave.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/net/dsa/slave.c b/net/dsa/slave.c
> index 91de3a663226..70395a0ae52e 100644
> --- a/net/dsa/slave.c
> +++ b/net/dsa/slave.c
> @@ -362,18 +362,23 @@ static int dsa_slave_port_obj_del(struct net_device *dev,
>  	return err;
>  }
>  
> -static int dsa_slave_port_attr_get(struct net_device *dev,
> -				   struct switchdev_attr *attr)
> +static int dsa_slave_get_port_parent_id(struct net_device *dev,
> +					struct netdev_phys_item_id *ppid)
>  {
>  	struct dsa_port *dp = dsa_slave_to_port(dev);
>  	struct dsa_switch *ds = dp->ds;
>  	struct dsa_switch_tree *dst = ds->dst;
>  
> +	ppid->id_len = sizeof(dst->index);
> +	memcpy(&ppid->id, &dst->index, ppid->id_len);
> +
> +	return 0;
> +}

Finally this will give us a way to distinguish two ports with the same switch
and port IDs on a system with two disjoint switch trees, thanks!

Reviewed-by: Vivien Didelot <vivien.didelot@gmail.com>
