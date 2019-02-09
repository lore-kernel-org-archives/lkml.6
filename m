Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAC5C282CC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 20:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9913421934
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 20:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="sK5FrpGH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfBIUrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 15:47:33 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38488 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbfBIUrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 15:47:32 -0500
Received: by mail-wm1-f66.google.com with SMTP id v26so9554769wmh.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Feb 2019 12:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=csrjhkRzeoBG9RYahcJ1RChGphXHuhQU3Z0mh2YlWlg=;
        b=sK5FrpGHQrEpK9TWWzj3O2pYPzRsb8iiEnkAZS5UFGUn1Prl+mHhYLF1exQMi6/u8g
         UsPGJ1n0LyLIEKOmdAFgNXyTTsuyHPlQss2stmFskJ8tmpq5PbvSglUeVi5FtjvHN5Mk
         +RLjuvcAYZIRtrbl2owbO4V3M70eY5rh4hoejVoEXHc3z8fLiWzG+e3OOjCEvVpsbzAF
         VJ+GxLgyDgdB+If4JXCesGZCpXrx4NyvYYno6UR8RZAzXrwmpZujKa8nqCviJCNAs6b3
         hKi8qjBv8ADyY8hWZZwX5ITP+qH3/tGo3FRCYj/IhWnWsmMBacGJdM7qyDtN+jsLnRxZ
         igew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=csrjhkRzeoBG9RYahcJ1RChGphXHuhQU3Z0mh2YlWlg=;
        b=TVCZFRI8AnEZDbtk8IZyCH9f36AudZRlgryb21oRsoI3N0WokaCg/1SrAr0Z7JSlI1
         P99+4SR26HPRL1DLTku3fDnZZaXsWj6aY67sS6fzH8iu7RLDdf3Y2rnn8ELWRKLjEvhS
         OlknDPlSAwNvGAaI7evPc4OR//laKUORzqOddR1KOXeEauz1SXGOf4Ypa+cxe5mEtfMx
         EfD2IE0WMA+/yO0/78ehHJS0MNbI31Jli2ihrruO9BCkhyIJxlkbVM9B8LZQ21auOl+x
         qGlWrwkra9t6i+5QXBdOdyIlr8GEGpsaBTQLNy6NC1kipvrVP2iBYEMZoO/UeELv/gAb
         VYNQ==
X-Gm-Message-State: AHQUAubkqKer4FDBy/uj+5OahwInZuxhKLIcX/0qml/O9eWqNePmWN4O
        qJ+DCo5oWE+n/pXmAsPbUFrZnQ==
X-Google-Smtp-Source: AHgI3IbA2+HmK4ntAWNkvmLI35jk0sRq73ZE+DOChQ9yPkWuCBX3nLX/ASCswqsFKcZJ2nM61eNKAw==
X-Received: by 2002:adf:eb85:: with SMTP id t5mr10716351wrn.157.1549745250365;
        Sat, 09 Feb 2019 12:47:30 -0800 (PST)
Received: from localhost (ip-94-113-219-55.net.upcbroadband.cz. [94.113.219.55])
        by smtp.gmail.com with ESMTPSA id q15sm3588923wmj.46.2019.02.09.12.47.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Feb 2019 12:47:29 -0800 (PST)
Date:   Sat, 9 Feb 2019 21:38:18 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>,
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: Re: [PATCH net-next 15/16] net: switchdev: Replace port attr set SDO
 with a notification
Message-ID: <20190209203818.GW2353@nanopsycho>
References: <20190209003248.31088-1-f.fainelli@gmail.com>
 <20190209003248.31088-16-f.fainelli@gmail.com>
 <83d8f16f-a73d-5aa7-4718-fc45e0fed226@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83d8f16f-a73d-5aa7-4718-fc45e0fed226@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sat, Feb 09, 2019 at 01:36:18AM CET, f.fainelli@gmail.com wrote:
>On 2/8/19 4:32 PM, Florian Fainelli wrote:
>> Drop switchdev_ops.switchdev_port_attr_set. Drop the uses of this field
>> from all clients, which were migrated to use switchdev notification in
>> the previous patches.
>> 
>> Add a new function switchdev_port_attr_notify() that sends the switchdev
>> notifications SWITCHDEV_PORT_ATTR_SET.
>> 
>> Drop __switchdev_port_attr_set() and update switchdev_port_attr_set()
>> likewise.
>> 
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>  include/net/switchdev.h   | 18 --------
>>  net/switchdev/switchdev.c | 92 ++++++++++-----------------------------
>>  2 files changed, 22 insertions(+), 88 deletions(-)
>> 
>> diff --git a/include/net/switchdev.h b/include/net/switchdev.h
>> index 4c5f7e5430cf..5387ff6f41c5 100644
>> --- a/include/net/switchdev.h
>> +++ b/include/net/switchdev.h
>> @@ -111,21 +111,6 @@ void *switchdev_trans_item_dequeue(struct switchdev_trans *trans);
>>  
>>  typedef int switchdev_obj_dump_cb_t(struct switchdev_obj *obj);
>>  
>> -/**
>> - * struct switchdev_ops - switchdev operations
>> - *
>> - * @switchdev_port_attr_get: Get a port attribute (see switchdev_attr).
>> - *
>> - * @switchdev_port_attr_set: Set a port attribute (see switchdev_attr).
>> - */
>> -struct switchdev_ops {
>> -	int	(*switchdev_port_attr_get)(struct net_device *dev,
>> -					   struct switchdev_attr *attr);
>> -	int	(*switchdev_port_attr_set)(struct net_device *dev,
>> -					   const struct switchdev_attr *attr,
>> -					   struct switchdev_trans *trans);
>> -};
>> -
>
>This and the hunk below bisection, I will move that into patch #16 after
>receiving feedback on this.

Looks good. Thanks!
