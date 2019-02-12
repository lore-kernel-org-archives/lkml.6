Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B8DC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 23:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEF42222C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 23:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YaryCsnH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730659AbfBLXDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 18:03:45 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40138 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730432AbfBLXDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 18:03:44 -0500
Received: by mail-pf1-f195.google.com with SMTP id h1so179346pfo.7;
        Tue, 12 Feb 2019 15:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cXDAG7W8ffK7g7o+JlWzY9UmT0iiG/g+7vsYTo0rVUw=;
        b=YaryCsnHVpbCUcf/BHQU/uR6fVhguhMsSuvMcuDOhNnii2sBrTYIQ9uSR4TQZQEDYR
         sdUBlh3Ak2T4klsiaSHZu/uay3G4q3kEPyrThZvd8D5+uj4ND1EUdPjlzKYbESyOcA36
         U7bj+LJTwDn4YLvWIQ6cxGdoMnVOxu1C7eTD9IuQK8jQtSATVeYKXRQmwi/JFr01BXea
         TfWIKQFz5yfQPh3JqouVYKXDBvDjWrGa74tL5lkOctF8nwkYpZ7yQiGbVchLdtn1u3hx
         t0C3jgxRlFIcAh2PIIYB2dVrG4lgRnKpzDDsQSL/WNfmOm6QStj2yjTY9KirlqW0aVTL
         1y8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cXDAG7W8ffK7g7o+JlWzY9UmT0iiG/g+7vsYTo0rVUw=;
        b=X3eWkBq+KuxdI/oHGMpuOUfp6ja6OzUh26m7hrdnDr2tpHM90T551UNopQ1SPPryV/
         SZ7oZtEOG87OB8a4hHFILjrvxQKEqQi93PFqfvalLUrS+9uAHZD0mR0RJK0/FvMtSqMK
         nnSH+qq9GCdVrp50WJahaIx/UjMhJn+wOta0fy9wuln/xT68O0Pjo1tL1IXAnDbWYS3u
         vxBVk2d7CtKmViA7riTNi1H17DdK6/PEzdYQrkGEJqCCgghRXxlKLsihfWil82IUyvyq
         +WgDYLmxoTj+R7oF6tOT0FdNjf9zF3eVzyWBwMWKtYdbIMEMYJvjMJwYzYRYDBqtPpiE
         AuJg==
X-Gm-Message-State: AHQUAuYeJuVtvVHoOkd3HZ2pGKdmg1IEQ5/tc817q+0REOja0ZD3DoD3
        kuZSD+T7EmfDa1ZRzDppXWJuToCv
X-Google-Smtp-Source: AHgI3IZimo6aKFqEOpEe72PJN17t7f8n0zlBJo3aQ6aUjitglieLWSQbwiPJEyWRGCOZW1IxHNwMHA==
X-Received: by 2002:a62:1346:: with SMTP id b67mr656161pfj.195.1550012623480;
        Tue, 12 Feb 2019 15:03:43 -0800 (PST)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id h8sm16718268pgv.27.2019.02.12.15.03.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 15:03:41 -0800 (PST)
Subject: Re: [PATCH] inet_diag: fix reporting cgroup classid and fallback to
 priority
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Cc:     Sasha Levin <sashal@kernel.org>, linux-sctp@vger.kernel.org
References: <154970855279.305165.13649851988934332761.stgit@buzz>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <85412c23-fe10-a7cd-5907-ae69ab55784e@gmail.com>
Date:   Tue, 12 Feb 2019 15:03:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <154970855279.305165.13649851988934332761.stgit@buzz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/09/2019 02:35 AM, Konstantin Khlebnikov wrote:
> Field idiag_ext in struct inet_diag_req_v2 used as bitmap of requested
> extensions has only 8 bits. Thus extensions starting from DCTCPINFO
> cannot be requested directly. Some of them included into response
> unconditionally or hook into some of lower 8 bits.
> 
> Extension INET_DIAG_CLASS_ID has not way to request from the beginning.
> 
> This patch bundle it with INET_DIAG_TCLASS (ipv6 tos), fixes space
> reservation, and documents behavior for other extensions.
> 
> Also this patch adds fallback to reporting socket priority. This filed
> is more widely used for traffic classification because ipv4 sockets
> automatically maps TOS to priority and default qdisc pfifo_fast knows
> about that. But priority could be changed via setsockopt SO_PRIORITY so
> INET_DIAG_TOS isn't enough for predicting class.
> 
> Also cgroup2 obsoletes net_cls classid (it always zero), but we cannot
> reuse this field for reporting cgroup2 id because it is 64-bit (ino+gen).
> 
> So, after this patch INET_DIAG_CLASS_ID will report socket priority
> for most common setup when net_cls isn't set and/or cgroup2 in use.
>

Nice catch Konstantin

Are you planing sending an iproute2/ss patch to output NET_DIAG_CLASS_ID values then ?

Thanks.
