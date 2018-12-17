Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361B7C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99712086C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="E22wkjxr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732123AbeLQJvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 04:51:54 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33640 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732038AbeLQJvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 04:51:54 -0500
Received: by mail-wm1-f65.google.com with SMTP id r24so4290829wmh.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 01:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sIl+D+RSCNRzf5F3LiIMtk4dGuasREWKnaEe9ZC4r4o=;
        b=E22wkjxreCEmSbxMUzdHCLNOQ8Guvs1tMBuTAvAG0TjbjGmh+0YHvW+IDRFmCr0tgd
         cjAvrSQaMAUzGiuJ8KuznMIoFgabqrghozdt5BDfgbgLOQ9zS3fNd1J930ELTxM3iNPU
         uxG0HE7VDAD5bgWb0reyevil6KTo1WTWoXUEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sIl+D+RSCNRzf5F3LiIMtk4dGuasREWKnaEe9ZC4r4o=;
        b=ce2iDn9nohKgp6obdn7yXupCHB/gf30VWkyqaWpZmHZ1J2O8QDw0w43y4quL21yc12
         WECThx6gHIYgbvo99/86Od3JY9VMhr66bgZkMpjJm68dJgdLJ7sOhVdHGGgMowEr/ius
         rIqMjdEUnb8NTe8qt2huzvkR7eRQYyyF+fBMk3LjjZxtTE7k9EiGNK0fQLXhCBm0TJ17
         nQ0TfpPyg7P6GdWJFzQRYPrToTYwm5ZruLqiwjaw1tKAJeKwv37AFe3j4LWtw57kVTQ7
         6peLnQ21MYFX3AzUIxq/7OnG2Ol0nz50d7Sp23uMACyYZ6ymyoxUqJaULQHYI5KxrSu8
         Rawg==
X-Gm-Message-State: AA+aEWa/Ulmqzj+mTOYVsy2v5jVW9lmSLI6zzvmCQKJN8NqDbdmW6bbE
        SDRw+RCE9C6So5mrvGb19Z4yQg==
X-Google-Smtp-Source: AFSGD/WCiGrZyo8KuYzrASqWMBK4CRinEzbQCagnDXo90Jg5Cf9go4d+1mzu4Kb3saygeHStyxMpEg==
X-Received: by 2002:a1c:2643:: with SMTP id m64mr10862519wmm.22.1545040312552;
        Mon, 17 Dec 2018 01:51:52 -0800 (PST)
Received: from ?IPv6:2001:470:1f0a:1832::2? (nikaleksandrov-1-pt.tunnel.tserv6.fra1.ipv6.he.net. [2001:470:1f0a:1832::2])
        by smtp.gmail.com with ESMTPSA id e27sm16623159wra.67.2018.12.17.01.51.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 01:51:52 -0800 (PST)
Subject: Re: [PATCH net-next] net: bridge: remove unneeded variable 'err'
To:     YueHaibing <yuehaibing@huawei.com>, davem@davemloft.net,
        roopa@cumulusnetworks.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bridge@lists.linux-foundation.org
References: <20181217094623.32668-1-yuehaibing@huawei.com>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <e9b1e56e-4c37-aff4-b855-2523eae1ef49@cumulusnetworks.com>
Date:   Mon, 17 Dec 2018 11:51:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181217094623.32668-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/12/2018 11:46, YueHaibing wrote:
> function br_multicast_toggle now always return 0,
> so the variable 'err' is unneeded.
> Also cleanup dead branch in br_changelink.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  net/bridge/br_multicast.c | 3 +--
>  net/bridge/br_netlink.c   | 4 +---
>  2 files changed, 2 insertions(+), 5 deletions(-)
> 

That is correct, but in such case just make it void.


