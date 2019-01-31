Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E702C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 07:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9B0020870
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 07:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="evLMdsFr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfAaHsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 02:48:07 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33473 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfAaHsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 02:48:07 -0500
Received: by mail-lj1-f196.google.com with SMTP id v1-v6so1855239ljd.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 23:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9lIM8ir49OrTSg2y1eKhcO1EgOHEz2IUlbrYvCNzoms=;
        b=evLMdsFrNVG/+UaI/arPOFnbCX7tMk3WokWyAqg5e6s1ZBzyAq4yOLVKPA0U5wnWuy
         NPgllouKXSco40WHTQ6E64LgoTl20r4JAZq2lIRK6Qhluo8V8SrWnYU1+MUxRSLIBx4O
         5HVfu1UhFTusCisFVHRMcBphE8r3Ws4G4RpyIRCZw/7fgF9H1g4IOUlBC2osIan1cqDM
         JUSq7j5NIC8eC+0qP7rbolcxyWCCyd1tEyzudCu6vCi0qFGNs5SjgKNBR+N4rh+KZeH6
         zXuceWmHlHLXj6jgoh2wWZaBLLt24ikVveL2+LPDnGf2TcZQp+1Sj8LlVTaYeIGs6181
         q7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9lIM8ir49OrTSg2y1eKhcO1EgOHEz2IUlbrYvCNzoms=;
        b=cHkXVintUHcufyfWnz5dVnXogGDPL4mJeN3f3BXRoWr+/zJhm5r/sKQykxErxdm5Yz
         OfAJn/reoc/QVDox3KEfEpUHzKQmBzX6aNx0BvEbgOrnvvfNnBx3pqaf/y6tY2X/ijTv
         NkQxDrID8tuK0gHJwludWZOxM7/YLuJZ4YCe6hFwKRGp2xoU3nXqkwUP4xJPvkTgHZKd
         za31iHbeBCKpf7kk5JrRMhYO9nLfFhjxKdNCMIbdLaD0qM85KLOVa1y08SEgSe9BP8P6
         IC1UP7a/y0OVbs0nGnFiTEJE67GmndXBRKp4pcPshOzStArHOoLh/JecJGGsh5Q67F44
         10Zw==
X-Gm-Message-State: AJcUukcpqk/ajkYDDGuOkMNfQclBQ1mKJCiMhotrsTSHGdcGDeBKHDbk
        gz1NxwiDLIpfu9Sl/7+GAvbRpg==
X-Google-Smtp-Source: ALg8bN7UwKjyBO6J2PBVXEhDj7+ItFv9mScK14KPG2Ld/E6FrrUL3kpcLGfBznjXxGWjeo7Lv6UGlw==
X-Received: by 2002:a2e:9556:: with SMTP id t22-v6mr26578360ljh.36.1548920885241;
        Wed, 30 Jan 2019 23:48:05 -0800 (PST)
Received: from [192.168.0.199] ([31.173.86.8])
        by smtp.gmail.com with ESMTPSA id s62sm697116lfg.34.2019.01.30.23.48.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 23:48:04 -0800 (PST)
Subject: Re: [PATCH v2] usb: chipidea: Grab the (legacy) USB PHY by phandle
 first
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Peter Chen <Peter.Chen@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20190130163011.26437-1-paul.kocialkowski@bootlin.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <d8a66e38-ad7d-a919-905f-8bbbff1d7425@cogentembedded.com>
Date:   Thu, 31 Jan 2019 10:47:52 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190130163011.26437-1-paul.kocialkowski@bootlin.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 30.01.2019 19:30, Paul Kocialkowski wrote:

> According to the chipidea driver bindings, the USB PHY is specified via
> the "phys" phandle node. However, this only takes effect for USB PHYs
> that use the common PHY framework. For legacy USB PHYs, a simple lookup
> based on the USB PHY type is done instead.
> 
> This does not play out well when more than USB PHY is registered, since

    More than one?

> the first registered PHY matching the type will always be returned
> regardless of what the driver was bound to.
> 
> Fix this by looking up the PHY based on the "phys" phandle node.
> Although generic PHYS and rather matched by their "phys-name" and not
> the "phys" phandle directly, there is no helper for similar lookup on
> legacy PHYs and it's probably not worth the effort to add it.
> 
> When no legacy USB PHY is found by phandle, fallback to grabbing any
> registered USB2 PHY. This ensures backward compatibility if some users
> were actually relying on this mechanism.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
[...]

MBR, Sergei
