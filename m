Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4CBC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 05:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3239B222D7
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 05:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RC1/aUTc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725779AbfBPFA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 00:00:28 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42753 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfBPFA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 00:00:27 -0500
Received: by mail-pg1-f195.google.com with SMTP id b2so61630pgl.9;
        Fri, 15 Feb 2019 21:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h50wuIkgPy/qyFGSaZxSTYNZJN7wATVvm0UweSkAxxc=;
        b=RC1/aUTcVkkn96aP43fi1L6JH8LFFZGpK5qk7i1h2cC6BZTudzXnBI/je4g3ydqZJg
         GB95wJ3wCMS18xlKjn2PvuIXg0T8rG9OHKH2HVF+np6kUhPYOlVnpuSvdsF0CAwVxje0
         8LA6YQ7GHA470Xx/aX1mS357fQhZTOapmgW/T3Kd8LDTfr8FAwC+sdTW7pmYSW5gSQFg
         a61/6L8etNfi6fQKQzsp/cMFVmn3rJqN3fo7HKuCOWSvpJVGZCkM2cVQd+1ZxvYdCl7V
         60oRwJyOVF1nBewQWDpiDFH017yPdr4cVB1O1CubqscOXIfMRcwKmQMPrEdUXl89tPod
         QDLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=h50wuIkgPy/qyFGSaZxSTYNZJN7wATVvm0UweSkAxxc=;
        b=k09dEY1dVbu9E6Cg7DPrF/XIU3von63BfGD7sRxiY7zsNUR8kpUhZBho5kUPasMysm
         9/tJ3tiIdembf2/IxDnt5ZWRN+OvBtPgfCOjLnQvmgpx5PdenWltazHH4XSo4sk+y9eD
         dyzhBn+BDAVuW6Gmznaaez6wQywVyfz71TN1tGb+rpW9PNoPtfB6Zb6dHyy+OJi1iBoc
         hAJxXN4SH7/9Ks6DIFHus0+njW4ErE4X/IPmlLa0qlsdWvH0HQZIK7bwq/gJozyCV+hi
         N3XdsUCqMVWxeMe22Wo91CUEO68KKnHsnQBreN9/aMYTNwiLEiOENGyf44l87wjxwMp1
         Kh8g==
X-Gm-Message-State: AHQUAuZwG1BK8/SBtrXKgSHldJeisnMFE+SHoNO9VbKS51ddmjqiemWs
        STq8q2ih4vqnn4icoOygw1U=
X-Google-Smtp-Source: AHgI3IZrKoSAczRIWq39OHWBNj6OCg6kwhxrWAoQLs61/F2n+22ohI90L1wc5EWgZizx0M4A6JTlaw==
X-Received: by 2002:a62:2008:: with SMTP id g8mr13062681pfg.121.1550293226441;
        Fri, 15 Feb 2019 21:00:26 -0800 (PST)
Received: from [10.230.28.107] ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id d11sm10691357pgi.25.2019.02.15.21.00.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 21:00:25 -0800 (PST)
Subject: Re: [PATCH net-next v3 0/9] net: Get rid of switchdev_port_attr_get()
To:     netdev@vger.kernel.org, David Miller <davem@davemloft.net>
Cc:     idosch@mellanox.com, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, bridge@lists.linux-foundation.org,
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
References: <20190216045556.3514-1-f.fainelli@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 w0j9Sw==
Message-ID: <3ee70578-e2d7-d890-fb36-9ac11dde96d1@gmail.com>
Date:   Fri, 15 Feb 2019 21:00:18 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190216045556.3514-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/15/2019 8:55 PM, Florian Fainelli wrote:
> Hi all,
> 
> This patch series splits the removal of the switchdev_ops that was
> proposed a few times before and first tackles the easy part which is the
> removal of the single call to switchdev_port_attr_get() within the
> bridge code.
> 
> As suggestd by Ido, this patch series adds a
> SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS which is used in the same
> context as the caller of switchdev_port_attr_set(), so not deferred, and
> then the operation is carried out in deferred context with setting a
> support bridge port flag.
> 
> Follow-up patches will do the switchdev_ops removal after introducing
> the proper helpers for the switchdev blocking notifier to work across
> stacked devices (unlike the previous submissions).

OK, I really need to use the long weekend break here and stop sending
stale patches series apologies everyone, work will resume when I have
put my head, hands and keyboard back together.
-- 
Florian
