Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067E0C282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C67482146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind-com.20150623.gappssmtp.com header.i=@6wind-com.20150623.gappssmtp.com header.b="kkdnPB/l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbfBHOSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 09:18:10 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45396 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbfBHOSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 09:18:09 -0500
Received: by mail-wr1-f65.google.com with SMTP id q15so3696954wro.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 06:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind-com.20150623.gappssmtp.com; s=20150623;
        h=reply-to:subject:to:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8fR3Y0eC1ZrDPYxFDkMSPoK8ffv2z7uaeuB193NBttM=;
        b=kkdnPB/lwRPVORyOlkOrob13DH23fQclm2oZFOgwdnjgOrJon3zdJGRhZRZo40m0eT
         B0F0aYLRRZ8QRX/hicES4UKrX1ScnwsFerZf3uC7XUSQetkcK7GOosH6ne5wYwhM8yGk
         EpDXFHfVcf6SZ8pyJKJfI+b3Om0Gm6EdaLG4/0hrzEmjpoRbeJC5M6hepc73mnyRta8F
         D1Jq2Yrm+Dx5iAM02BFgwwnzEamdaGcpnHO7+pm/ltxwqWov+9Bl4JAFDK+GHxiGi39c
         3clYWJiDONeJ41sLxJBBkRJYwEWa4mT+xw42eZLSmwP1CpJABgNazKsHOvS/1IcobzWi
         JRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=8fR3Y0eC1ZrDPYxFDkMSPoK8ffv2z7uaeuB193NBttM=;
        b=Xkft5If2qslItHB2RWQmup+5ywCgCP1njDP+Y00ZtCMZNCgU7wC2bq+bll+yVo9K2Y
         1S1TV9u2F94nlbFpHwpdUhIE1iiZ0woHjaemzcMqe9vA7/N8EO/DubbNZWoFHXd+W3Cv
         4QazYYM01rAYDOrtg6sjjMl51+NYJ7sn6uhKbwfOxQc1TZbRgGckbcDhHZjsuOWnIovD
         kWpN6ZwrgjW/awx7EAQQqJM531ng9H/2K4VJMJiEOhkKkGR8vjreuciRyPg1rgnrccll
         rHK3rrd1u9aOnlaz/aIWlcmExjBUFXEPqlfIY43DL3cfn6f6+EZoF5nu6Ec0/sK43kk9
         Clug==
X-Gm-Message-State: AHQUAuaYLD0Qs/aiwjJfUQTYleaNRvyq86S789R6Xjd0f2f2ujIilKIU
        lLpTbAotlFObhPSAOc/Zl88qx65c5v4=
X-Google-Smtp-Source: AHgI3IaQRv9SLgEPTZ2N01b64+cOfuWY3PMalWNQ9y5C+lVC1KC9B011kY+ViR3/uS4ZsfEsx3POUw==
X-Received: by 2002:adf:f009:: with SMTP id j9mr16507182wro.170.1549635487572;
        Fri, 08 Feb 2019 06:18:07 -0800 (PST)
Received: from ?IPv6:2a01:e35:8b63:dc30:a891:eeb0:d9a7:6bd2? ([2a01:e35:8b63:dc30:a891:eeb0:d9a7:6bd2])
        by smtp.gmail.com with ESMTPSA id v13sm2844629wra.54.2019.02.08.06.18.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 06:18:06 -0800 (PST)
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next] ipmr: ip6mr: Create new sockopt to clear mfc
 cache or vifs
To:     Callum Sinclair <callum.sinclair@alliedtelesis.co.nz>,
        davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        nikolay@cumulusnetworks.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190208041103.31299-1-callum.sinclair@alliedtelesis.co.nz>
 <20190208041103.31299-2-callum.sinclair@alliedtelesis.co.nz>
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
Message-ID: <be9e655b-6911-c644-de63-9aabcd131763@6wind.com>
Date:   Fri, 8 Feb 2019 15:18:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190208041103.31299-2-callum.sinclair@alliedtelesis.co.nz>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 08/02/2019 à 05:11, Callum Sinclair a écrit :
> Currently the only way to clear the mfc cache was to delete the entries
mfc stands for 'multicast forwarding cache', so 'mfc cache' is a bit strange.

> one by one using the MRT_DEL_MFC socket option or to destroy and
> recreate the socket.
Note that if entries were added with MRT_ADD_MFC_PROXY, they will survive to the
socket destruction. This is not the case with your new cmd. Is it intended?
Maybe a third option (something like MRT_FLUSH_MFC_PROXY) would be useful to
avoid confusion?

> 
> Create a new socket option which will clear the multicast forwarding
> cache on the socket without destroying the socket. The new socket option
> MRT_FLUSH_ENTRIES will clear all multicast entries on the sockets table
> and the MRT_FLUSH_VIFS will delete all multicast vifs on the socket
> table.
> 
> Signed-off-by: Callum Sinclair <callum.sinclair@alliedtelesis.co.nz>
> ---
>  include/uapi/linux/mroute.h  |  7 +++-
>  include/uapi/linux/mroute6.h |  7 +++-
>  net/ipv4/ipmr.c              | 69 ++++++++++++++++++++-------------
>  net/ipv6/ip6mr.c             | 74 ++++++++++++++++++++++--------------
>  4 files changed, 100 insertions(+), 57 deletions(-)
> 
> diff --git a/include/uapi/linux/mroute.h b/include/uapi/linux/mroute.h
> index 5d37a9ccce63..673495ca3495 100644
> --- a/include/uapi/linux/mroute.h
> +++ b/include/uapi/linux/mroute.h
> @@ -28,12 +28,17 @@
>  #define MRT_TABLE	(MRT_BASE+9)	/* Specify mroute table ID		*/
>  #define MRT_ADD_MFC_PROXY	(MRT_BASE+10)	/* Add a (*,*|G) mfc entry	*/
>  #define MRT_DEL_MFC_PROXY	(MRT_BASE+11)	/* Del a (*,*|G) mfc entry	*/
> -#define MRT_MAX		(MRT_BASE+11)
> +#define MRT_FLUSH	(MRT_BASE+12)	/* Flush all multicast entries and vifs	*/
nit: "Flush all mfc entries and/or vifs" ?

> +#define MRT_MAX		(MRT_BASE+12)
>  
>  #define SIOCGETVIFCNT	SIOCPROTOPRIVATE	/* IP protocol privates */
>  #define SIOCGETSGCNT	(SIOCPROTOPRIVATE+1)
>  #define SIOCGETRPF	(SIOCPROTOPRIVATE+2)
>  
> +/* MRT_FLUSH optional flags */
> +#define MRT_FLUSH_ENTRIES	1	/* For flushing all multicast entries */
Maybe MRT_FLUSH_MFC is more consistent with the previous naming (MRT_ADD_MFC, etc.)


Regards,
Nicolas
