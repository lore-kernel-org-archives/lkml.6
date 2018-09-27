Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312F0C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C765B2170E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ofrZcKyN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C765B2170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbeI1Com (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 22:44:42 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43813 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbeI1Com (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 22:44:42 -0400
Received: by mail-pf1-f194.google.com with SMTP id j26-v6so2665291pfi.10;
        Thu, 27 Sep 2018 13:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=B3bDeDNKzVxTCKQGNppPCovq7b0cQR6+LkSPmbYjLZ4=;
        b=ofrZcKyNg5orioZvDwZBiPnvvcDNplUEUlitM7xyDEhqQzFfrqORfb1osazJEvgAtd
         fImSxIf/uJKq7caWrjjBT/PKDIL1Ck7nU9FblGYjwDIMU7wbIncuesF3TRjg0CrcJvGv
         8+4XOhYPkV+h3QH35Lmn4zfX/aWJ1wydflK6zYFk3UmRZSh1pWe2vaKOIlUp2SjGtqjs
         x6Tr4v5dJffV7yyrDtwYdjOwgsXJBO0ZFgRvZ1y6NmjYRi3bFLH0TmFROMCnGyAENOu+
         rAB2WbdBB9kqrg9YtFWVJwA+2NR+uO6tAmHyiW+K0K2NUGoCMQWIVoYBMLxrWQYZo16M
         QgAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B3bDeDNKzVxTCKQGNppPCovq7b0cQR6+LkSPmbYjLZ4=;
        b=Da+b3NEH4TpFirRr2tWCTZF3T0DblQlobfRHtmSGcg6xXVEimNyfD0MO5W/385JLmT
         gPzTqHr58ZmwymaS1zcEaE6mQpW+TVMWvqr9KI6VCfuYaHaDeh85NheVCD6WKZWWblTn
         qHbPUf5Sef4wg8U+anoIt1UJ6/bGofCe2avHWa2ZerA5xp1Irzy8w861hpwZuLHxkcNS
         tjyrSRl0aVTMkYga3KMA1VMV7nQ1hbu8pph9wwWl4MkZ2Gba9jrHerUVZUWNSRv2sI+P
         3f1hlQ9ntYSBywfd1T5JFnM9KP0rZDqzaQB82+h6XyPQAcxj8LnFzWCQfWf/b/NWH0TY
         Ucug==
X-Gm-Message-State: ABuFfogkytgGlsdDGuy43RAzPQdpNDcRHdd8hr2/xNTzd5FgnTv/DWY4
        AK6wnAjzKKS7azHnRimeUD/x4bH3
X-Google-Smtp-Source: ACcGV60oxFTlMZwRS7RYxgvnzbcmuhCjyftkiIKywAh9KQd4fSJFkPwf5i4/+N9AidV+BvAqRqIYJQ==
X-Received: by 2002:a63:fc46:: with SMTP id r6-v6mr11828733pgk.345.1538079879646;
        Thu, 27 Sep 2018 13:24:39 -0700 (PDT)
Received: from ?IPv6:2601:282:800:fd80:302b:f28f:ad79:3398? ([2601:282:800:fd80:302b:f28f:ad79:3398])
        by smtp.googlemail.com with ESMTPSA id e7-v6sm5819856pfk.3.2018.09.27.13.24.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 13:24:38 -0700 (PDT)
Subject: Re: [PATCH net-next 0/7] rtnetlink: add RTM_GETADDR2
To:     Christian Brauner <christian@brauner.io>, jbenc@redhat.com,
        davem@davemloft.net, stephen@networkplumber.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180927175857.3511-1-christian@brauner.io>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <e7ec6202-7d4b-8dc1-1b25-76325129ba6f@gmail.com>
Date:   Thu, 27 Sep 2018 14:24:36 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180927175857.3511-1-christian@brauner.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/18 11:58 AM, Christian Brauner wrote:
> Various userspace programs (e.g. iproute2) have sent RTM_GETADDR
> requests with struct ifinfomsg. This is wrong and should have been
> struct ifaddrmsg all along as mandated by the manpages. However, dump
> requests so far didn't parse the netlink message that was sent and
> succeeded even when a wrong struct was passed along.

...

> The correct solution at this point seems to me to introduce a new
> RTM_GETADDR2 request. This way we can parse the message and fail hard if
> the struct is not struct ifaddrmsg and can safely extend it in the
> future. Userspace tools that rely on the buggy RTM_GETADDR API will
> still keep working without even having to see any log messages and new
> userspace tools that want to make user of new features can make use of
> the new RTM_GETADDR2 requests.

First, I think this is the wrong precedent when all we need is a single
bit flag that userspace can use to tell the kernel "I have a clue and I
am passing in the proper header for this dump request".

Second, you are not addressing the problems of the past by requiring the
proper header and checking values passed in it.

I have another idea. I'll send an RFC patch soon.
