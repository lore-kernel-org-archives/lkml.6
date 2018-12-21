Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D19ADC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3A3D21917
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="QiZ6QXX7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731931AbeLUPhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 10:37:47 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36373 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbeLUPhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 10:37:45 -0500
Received: by mail-wr1-f68.google.com with SMTP id u4so5692746wrp.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 07:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dXhQBukfKWvAIAwxIDey7FTgXKt5X0FJHC3d9IIOa3Y=;
        b=QiZ6QXX7LOzYWcy4f20zoVA+VTc2UVic3ktRvPXQO6G9W1GhAsjErvGsKvy1y/ijM1
         t2/e5qoBCGn5zmH21/rH6yI8roh4hmJf5SH9XqUg5XxvyvGH9f/Gx0WW0Yd6TAYMpV7E
         j1gs/KaEqcWC52lMjKtzyWe617mlaoq2SwQr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dXhQBukfKWvAIAwxIDey7FTgXKt5X0FJHC3d9IIOa3Y=;
        b=P92GZnRJsJdwQ+Y03976Dy6Gf1EiGmSFlMi7mYonkNZMxmtgxkA52SzJ0vzOemWTHt
         MdP6MvpVApiGUcyAbTbGFobzc46ULdWz7i1OTqsSzcPc3FKDw7EKH2V6dftitMB9MZiM
         ySO8mZ2Oi0cdk0whU3zHxoib9QDYcqOGXoN7O/qc8LG4eaHmPdBsgiRVMRZIBsO99owA
         CBCNfx+vJR9pDoYUOLqo3G0ldURABVxOUIb6s7pC/k0AK04xMBGzA/gB6L5H0h1MIbyP
         tpSW11Rt8Ad2D9HUWMRB3RCN2TY3nG+8qVr+UEpQMnoYYHKoK0qRRjXOacGNPSzNRXXL
         k2eA==
X-Gm-Message-State: AJcUukcWlC6JEP8ruYTqe4QDfYP038puCbHOxtWwgpdAQAIoIerNeWOJ
        xR+B7lwC2sBW/0wCjPIjKTKpZ/SL9p4=
X-Google-Smtp-Source: ALg8bN7Qj3TtmTV1Hh3pg5ZiAoGjslAb4LOqQjx1Punlqg8X3uhor25CthWu2sZAAW3mH1wE8bDmAw==
X-Received: by 2002:a5d:4a45:: with SMTP id v5mr2958530wrs.7.1545406662873;
        Fri, 21 Dec 2018 07:37:42 -0800 (PST)
Received: from [192.168.0.104] ([79.134.172.72])
        by smtp.googlemail.com with ESMTPSA id i186sm14407922wmd.19.2018.12.21.07.37.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 07:37:42 -0800 (PST)
Subject: Re: [PATCH net-next 0/4] bridge: implement Multicast Router Discovery
 (RFC4286)
To:     =?UTF-8?Q?Linus_L=c3=bcssing?= <linus.luessing@c0d3.blue>,
        netdev@vger.kernel.org
Cc:     Roopa Prabhu <roopa@cumulusnetworks.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        "David S . Miller" <davem@davemloft.net>,
        bridge@lists.linux-foundation.org, b.a.t.m.a.n@lists.open-mesh.org,
        linux-kernel@vger.kernel.org
References: <20181221151511.14923-1-linus.luessing@c0d3.blue>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <e930f996-de2c-3d69-ccb9-a512ef846de6@cumulusnetworks.com>
Date:   Fri, 21 Dec 2018 17:37:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181221151511.14923-1-linus.luessing@c0d3.blue>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/18 5:15 PM, Linus Lüssing wrote:
> Hi,
> 
> This patchset adds initial Multicast Router Discovery support to
> the Linux bridge (RFC4286). With MRD it is possible to detect multicast
> routers and mark bridge ports and forward multicast packets to such routers
> accordingly.
> 
> So far, multicast routers are detected via IGMP/MLD queries and PIM
> messages in the Linux bridge. As there is only one active, selected
> querier at a time RFC4541 ("Considerations for Internet Group Management
> Protocol (IGMP) and Multicast Listener Discovery (MLD) Snooping
> Switches") section 2.1.1.a) recommends snooping Multicast Router
> Advertisements as provided by MRD (RFC4286).
> 
> 
> The first two patches are refactoring some existing code which is reused
> for parsing the Multicast Router Advertisements later in the fourth
> patch. The third patch lets the bridge join the all-snoopers multicast
> address to be able to reliably receive the Multicast Router
> Advertisements.
> 
> 
> What is not implemented yet from RFC4286 yet:
> 
> * Sending Multicast Router Solicitations:
>   -> RFC4286: "[...] may be sent when [...] an interface is
>      (re-)initialized [or] MRD is enabled"
> * Snooping Multicast Router Terminations:
>   -> currently this only relies on our own timeouts
> * Adjusting timeouts with the values provided in the announcements
> 
> 
> Regards, Linus
> 
> 
> 

Hi Linus,
Nice work, unfortunately net-next is currenty closed. Anyway I'll
review the patches in detail after the holidays so if there's
anything it can be adjusted for when net-next opens up.

Thanks,
 Nik

