Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B40AC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 560F220863
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind-com.20150623.gappssmtp.com header.i=@6wind-com.20150623.gappssmtp.com header.b="F+hh66Xs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbfBHPIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 10:08:46 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34575 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbfBHPIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 10:08:45 -0500
Received: by mail-wm1-f67.google.com with SMTP id y185so7014411wmd.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 07:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind-com.20150623.gappssmtp.com; s=20150623;
        h=reply-to:subject:to:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MdwmXtBvXwxENwVSPhAmdv3MbAQ3fWK3xZrpSPz9OTw=;
        b=F+hh66XsBOVJmvqUjgH+KVTQ3SgEanf1/sUXqYrvSymMIrEW3gRpENXFjJheIHqjb4
         mW8zgKHf5lNNMINzAxCFY/0MBlvzIiVFZngD5Dby72Yho71FZ8lur0AvRFq5wK2phhU1
         uL1v/A5Ow95TY0YcTK7AdY3ERF2va2P1gsh6HFVf+eao6s0UwQjAqCUfw3JmNCqTiS81
         wlxm3qmPMUcxyRte3X4rrvgMMTV7oHpYNQQu2hfP+uI2FJjz19ZQvD3EzeEQkkqB9qd1
         yGthxAAGLel69LceWAy0MuamCtHeEcmkNz68GSBiegvsgHF9/0MyDCKGjWiiLQgFLMVh
         ZNtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=MdwmXtBvXwxENwVSPhAmdv3MbAQ3fWK3xZrpSPz9OTw=;
        b=Y0zLqWiPx2YeYyYx91XGXojFG3snHr1pRgTUxtBwzoj1I4J7uvpJoclrqQK3lU7w2+
         iHrCcNI4/GuCEAv/9rTDXZmaTOj16rFBHFxyg6ONd2iJpQl4rb0l7VxDnTdefXCnyUVJ
         aon2IluNBZTlHoxDA+3Ztb4X3qgOe1nEw8DsHJshLqOFjSREFY7eDm0AkKT3oVRWPLYl
         F6uiNVRGa+l69lwQSTFLLjrvGIJPky/TwMmBqOUH0L1wFE1tXygeLWcNolbL52dFs5Dl
         UYPnM2TqygvOzS3RoMCUWVaZ/oFMB1u59w23CdkQkTJ37kbbsLdaZcn1CGSCK9tVN49b
         2Y5g==
X-Gm-Message-State: AHQUAuYSSxbom2iIcMIAKHd+3NP4lZ1NghZeOtp7J7TDYtoZ0jVQeBeD
        MyzIQZ1Q/45Wqsx6pNeVZcdT4Qwh3AU=
X-Google-Smtp-Source: AHgI3IYy3imBjiRGUASWDfsO6D9ub7jz8ZLrDzhWe92KvkwtqiKDt/3044nCFMF37Xfw7tm4IxvkQw==
X-Received: by 2002:a1c:f218:: with SMTP id s24mr12617777wmc.6.1549638523652;
        Fri, 08 Feb 2019 07:08:43 -0800 (PST)
Received: from ?IPv6:2a01:e35:8b63:dc30:a891:eeb0:d9a7:6bd2? ([2a01:e35:8b63:dc30:a891:eeb0:d9a7:6bd2])
        by smtp.gmail.com with ESMTPSA id t199sm39832132wmt.1.2019.02.08.07.08.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 07:08:42 -0800 (PST)
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next] ipmr: ip6mr: Create new sockopt to clear mfc
 cache or vifs
To:     Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        Callum Sinclair <callum.sinclair@alliedtelesis.co.nz>,
        davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190208041103.31299-1-callum.sinclair@alliedtelesis.co.nz>
 <20190208041103.31299-2-callum.sinclair@alliedtelesis.co.nz>
 <be9e655b-6911-c644-de63-9aabcd131763@6wind.com>
 <5597e8bc-c23e-1f59-0442-260a7b4ca83d@cumulusnetworks.com>
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
Message-ID: <31a5155c-ce6e-4c0f-61c0-35a5472549aa@6wind.com>
Date:   Fri, 8 Feb 2019 16:08:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <5597e8bc-c23e-1f59-0442-260a7b4ca83d@cumulusnetworks.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 08/02/2019 à 15:43, Nikolay Aleksandrov a écrit :
> On 08/02/2019 16:18, Nicolas Dichtel wrote:
>> Le 08/02/2019 à 05:11, Callum Sinclair a écrit :
>>> Currently the only way to clear the mfc cache was to delete the entries
>> mfc stands for 'multicast forwarding cache', so 'mfc cache' is a bit strange.
>>
>>> one by one using the MRT_DEL_MFC socket option or to destroy and
>>> recreate the socket.
>> Note that if entries were added with MRT_ADD_MFC_PROXY, they will survive to the
>> socket destruction. This is not the case with your new cmd. Is it intended?
> 
> I think you're referring to MFC_STATIC entries (sk != mroute_sk). It
> doesn't matter how you add an entry - they all get cleaned up if added
> through the mroute socket.
Yes, right.
MRT_FLUSH_MFC_STATIC ?
