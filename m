Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E2DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE3DB21479
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="ASSy4op0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730952AbfBRMbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 07:31:18 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44122 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730255AbfBRMbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 07:31:18 -0500
Received: by mail-wr1-f66.google.com with SMTP id w2so3547064wrt.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 04:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yokvTrHnj/HmbGRfRA+U/XZMZ+ruQZCfibLEs6M4bis=;
        b=ASSy4op0TpnyjA0h4MRteZrJzqWl52tyN31lQLtZRbuepJlP8OBV9nOdvyQduPGMk8
         E7rmS6//nv9F4VUakExZKOK+MD9cpTZD4WMxCN/OvF8HqbkhazCO2hoS/moPLwPMFMQb
         uOtB6a2OZRd9yQqzRr6qlvFnwwdRYIR1fMBGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yokvTrHnj/HmbGRfRA+U/XZMZ+ruQZCfibLEs6M4bis=;
        b=n6j+F3lzG8WZ7cZJcgZ2rYdxljMgyKR5EZaJE5jII0nbI84UbCLwYCxa8snLSDcLwn
         Eflot59emvelbWsLCBjiC5aVAwa6jEtjW7CHZSTBLcU7eWFvAcozbi3EOxZuZ7p5yDTd
         /g+LQbizK29a/KaT6BN4iOwc3xL9g3b5HrhEaXjPdNIuCTBP3duy5wt+v1d+Ib+m9zvE
         STXv2P+CltzOXnv61xeKcayI9flsjP9W0CWO6tpzqR8k85LWQV5XQMhrTP1+4ABzcuCN
         IDqzZs9iD/5So866ihVxR9h1K/MGSPyZzelUzuj9IV3Pr7TG1lbXltkyXLFzonR/lCIH
         JA5g==
X-Gm-Message-State: AHQUAuaWyCWcBY1P0qHVK/IXSy/dmUUeM+H1oJxAhStKgerq3ULppkro
        FBZ8ZDzPJrjI0Pyr1Q5RbzNNyw==
X-Google-Smtp-Source: AHgI3IYdGYQNlJZlvTd3mkX5bEe9AHcVkTsoSVKVQvWd++Iiq9HqYSLyKiH4h46DExADCaSqtQQskQ==
X-Received: by 2002:adf:e304:: with SMTP id b4mr5763088wrj.123.1550493076203;
        Mon, 18 Feb 2019 04:31:16 -0800 (PST)
Received: from [192.168.0.107] (79-100-158-105.ip.btc-net.bg. [79.100.158.105])
        by smtp.gmail.com with ESMTPSA id o7sm11529883wmc.44.2019.02.18.04.31.14
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 04:31:15 -0800 (PST)
Subject: Re: [PATCH net-next v6] ipmr: ip6mr: Create new sockopt to clear mfc
 cache or vifs
To:     Callum Sinclair <callum.sinclair@alliedtelesis.co.nz>,
        davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     nicolas.dichtel@6wind.com
References: <20190217210752.20914-1-callum.sinclair@alliedtelesis.co.nz>
 <20190217210752.20914-2-callum.sinclair@alliedtelesis.co.nz>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <58aad8ff-4e85-495e-e4bc-75c16bddfbfb@cumulusnetworks.com>
Date:   Mon, 18 Feb 2019 14:31:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190217210752.20914-2-callum.sinclair@alliedtelesis.co.nz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/02/2019 23:07, Callum Sinclair wrote:
> Currently the only way to clear the forwarding cache was to delete the
> entries one by one using the MRT_DEL_MFC socket option or to destroy and
> recreate the socket.
> 
> Create a new socket option which with the use of optional flags can
> clear any combination of multicast entries (static or not static) and
> multicast vifs (static or not static).
> 
> Calling the new socket option MRT_FLUSH with the flags MRT_FLUSH_MFC and
> MRT_FLUSH_VIFS will clear all entries and vifs on the socket except for
> static entries.
> 
> Signed-off-by: Callum Sinclair <callum.sinclair@alliedtelesis.co.nz>
> ---
> v1 -> v2:
>   Implemented additional flags for static entries
> v2 -> v3:
>   Cleaned up flag logic so any combination of routes can be cleared.
>   Fixed style errors
>   Fixed incorrect flag values
> v3 -> v4:
>   Fixed style errors
>   Fixed incorrect flag (MRT_FLUSH was used instead of MRT_FLUSH_VIFS)
> v4 -> v5:
>   Only clear the unresolved queue when MRT_FLUSH_MFC flag is set.
> v5 -> v6:
>   Renamed MRT6_FLUSH_VIFS to MRT6_FLUSH_MIFS
> 
>  include/uapi/linux/mroute.h  |  9 ++++-
>  include/uapi/linux/mroute6.h |  9 ++++-
>  net/ipv4/ipmr.c              | 75 +++++++++++++++++++++-------------
>  net/ipv6/ip6mr.c             | 78 +++++++++++++++++++++++-------------
>  4 files changed, 115 insertions(+), 56 deletions(-)
> 

Looks good to me,
Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>


