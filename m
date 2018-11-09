Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FE6C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD3F92133D
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pTQJfb0C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD3F92133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbeKJGAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 01:00:15 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:40647 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725752AbeKJGAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 01:00:15 -0500
Received: by mail-yw1-f66.google.com with SMTP id l66-v6so2115501ywl.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 12:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kzKcUSWp1k7g9ZITJDGZvsPHCVOAMWA8DznOB81h9rY=;
        b=pTQJfb0CioCLz9K5NCJyVj6GKuzVshxUKyY1/H16YkQqw3QqWKwemGO1ywiG1rjh7s
         AgFDI1HSuaDCw4Scqfm72YtsmwVvDFhVfv7CHEaNugak3C1IgkQWJORq4fO35GtnLFAo
         mZWHK4DP9vyLrl7P7PUlMoo6kNKHkdMVSBjBRxO2TzW70hLhDavZqEBDSStU/N4a6A0q
         SXOu+xdzoGWiwYKfOi2/1GljKaW8npfIvRKT0n+l26MGgFmDEYIzzPhQqf94+1aBaHvJ
         4vZy1K8XZDNSOJtBVgR748XgyS0t0hmXRReFFMjwXQ6O3eIN90u8sZ1qqeojHcLn0wk/
         V/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=kzKcUSWp1k7g9ZITJDGZvsPHCVOAMWA8DznOB81h9rY=;
        b=E+wbXYYERqS7r2+hSPAQnWUJBTwHNpd8STqr/XJSsZXnzH1CNb0E6sxc8Ip1uvSS6L
         usD8pzOL8DXL8bHEGRECrt7/Ql8VoSzQ2JDfsCOrkRddhKyG9rKo7AyTri1rRmJ2mb/N
         4FNeq6iE2QEeBW4aRRbI+JXiMjDL49fZ7Xdhrd8byo9MLFZkdyXy1HgG1Iv9Ie757apX
         7QY5+TQjbZ2M5r0kp5Mc2wN6TJFCtqS8hYgvjkk00GsXjErWTgi54RCVSFSX8k6TMBwf
         qcdJF8TwxABNxMFHSt38zGG18Xq8EfP90qjHmTE/WQ+zbqKIb1q2hJHCk1bIh+HgBqIv
         kRJA==
X-Gm-Message-State: AGRZ1gKPlQj1JgcmsdJZpbsJ3mYgMJPP3YfRO9CCSEwv6KlXo6ZT7fJR
        ts7Nm1gJTQakLH49gNSPMbLpwq1U
X-Google-Smtp-Source: AJdET5fdl0eV+nwfaZxABo6ra7J+VK0po22khozJ2fNJC18QTaMaPLl3uAgN5ifWK/L4UvaXQDh2Sw==
X-Received: by 2002:a0d:f1c4:: with SMTP id a187-v6mr9682866ywf.482.1541794685158;
        Fri, 09 Nov 2018 12:18:05 -0800 (PST)
Received: from [10.67.49.62] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id d135-v6sm3193347ywh.43.2018.11.09.12.18.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 12:18:03 -0800 (PST)
Subject: Re: [PATCH] ARM: brcmstb: Add entry for 7255
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Justin Chen <justinpopo6@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Doug Berger <opendmb@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20181107004151.20370-1-f.fainelli@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <ca3ddaea-61fa-b7e6-b080-59b8ba92514f@gmail.com>
Date:   Fri, 9 Nov 2018 12:17:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181107004151.20370-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/18 4:41 PM, Florian Fainelli wrote:
> From: Justin Chen <justinpopo6@gmail.com>
> 
> Add in BCM7255 entry and reorder entries to keep ascending order. Also
> moved 7278 cause it was out of order.
> 
> Signed-off-by: Justin Chen <justinpopo6@gmail.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied to soc/next, thanks!
-- 
Florian
