Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662A1C46464
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 17:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13C8921934
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 17:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVeemWZH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13C8921934
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbeHLUPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 16:15:54 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:55782 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbeHLUPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 16:15:53 -0400
Received: by mail-it0-f68.google.com with SMTP id d10-v6so9418881itj.5;
        Sun, 12 Aug 2018 10:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MRvQ1/Zgi4HopyUeiuWnRH2ggPV6UgmjHqHwVBdm9a4=;
        b=GVeemWZHsB4okxZjAvMVo1fAihIQbuhlNQ8A77j7pNqjoxW3wYZPndVExKo9gl8S0c
         jgcRDY51BNrHWyWhLx3ccnsPmjxGlSZO3bacjauMq/XtQbGg1lwZgaJ0FuxWZnE3yWi3
         mTcSwFVZOXOKnCUstZgWwvrsbn5i4BEnttzV9oqo0JYiKh5y7g8Emkw7jtu16Na/tn+d
         rqSdqmDZqrAw0KD+EzXBVNz2GQtuxTarTWRaSIdzHKKplJFI3QOkDn0KSkaQcAFYvHTO
         GlFQz9+LxG9UhOkJclKecXp4yV+VBYd7LqspBqTvdzcx1CgIatNs81ytCP3u/IIsIAil
         ARhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MRvQ1/Zgi4HopyUeiuWnRH2ggPV6UgmjHqHwVBdm9a4=;
        b=UvKjEua0yvkOyDKnibyC2tXZdx5NOid+RQKpqaCqaOzVqbwX+x71fxMxFVUrhqxlbN
         2aWU0/Sqj1dVOpBNKdIkpHplVEOsxcXvT9GjXYdY485u5ZrZ1vaQPt8mF09X+V0zlk5j
         LtiInzqugro57nOyaYgHKn5FW+KgA1s45NP19ZmXWOTMa+3QnXqTKW7Rq33WBhTLbDrk
         PFJzduAQBW2kdnV8Tyk1XTB4VNCFLKMt4ib4nWQLGf0wjTYZi2rdog8au8WI+8yUrzud
         0DggmxS/oJHwydjzvSJPemqj1mSR1bIho3JjvKgn8Jpt8vLoFMWDAAXbQua8tFDztmpc
         D/pg==
X-Gm-Message-State: AOUpUlFjAvKY2ncU5Kww4j4pq+XcnoPqw3wmXRymb36sGbUjuCGSQDhX
        ayytv3qtjzmg/AMg7klOEPJ+h2Ut
X-Google-Smtp-Source: AA+uWPwgusBxVJO2JCuh1V3yxYM9SSsTUcMJew4igPmtkLw7+ZhLTdx6Jb/ObY1Es1U86W+Wau6Bgw==
X-Received: by 2002:a02:1a89:: with SMTP id 131-v6mr12486969jai.58.1534095428561;
        Sun, 12 Aug 2018 10:37:08 -0700 (PDT)
Received: from dsa-mb.local ([2601:282:800:fd80:b5f3:68cb:77c2:c077])
        by smtp.googlemail.com with ESMTPSA id e5-v6sm2109112itf.0.2018.08.12.10.37.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Aug 2018 10:37:07 -0700 (PDT)
Subject: Re: [RFC/RFT, net-next, 00/17] net: Convert neighbor tables to
 per-namespace
To:     Vasily Averin <vvs@virtuozzo.com>, dsahern@kernel.org,
        netdev@vger.kernel.org
Cc:     nikita.leshchenko@oracle.com, roopa@cumulusnetworks.com,
        stephen@networkplumber.org, idosch@mellanox.com, jiri@mellanox.com,
        saeedm@mellanox.com, alex.aring@gmail.com,
        linux-wpan@vger.kernel.org, netfilter-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180717120651.15748-1-dsahern@kernel.org>
 <dc9cd93c-61d4-dc8c-9ba1-cd8584908ba2@virtuozzo.com>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <988a697a-984c-8ca8-7846-e62feb4a4aec@gmail.com>
Date:   Sun, 12 Aug 2018 11:37:06 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <dc9cd93c-61d4-dc8c-9ba1-cd8584908ba2@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/12/18 12:46 AM, Vasily Averin wrote:
> On 07/17/2018 03:06 PM, dsahern@kernel.org wrote:
>> From: David Ahern <dsahern@gmail.com>
>>
>> Nikita Leshenko reported that neighbor entries in one namespace can
>> evict neighbor entries in another. The problem is that the neighbor
>> tables have entries across all namespaces without separate accounting
>> and with global limits on when to scan for entries to evict.
>>
>> Resolve by making the neighbor tables for ipv4, ipv6 and decnet per
>> namespace and making the accounting and threshold limits per namespace.
> 
> Dear David,
> I prepared own patch set to fix this problem and found your one.
> It looks perfect for me, and I hope David Miller will merge it soon,
> however I have found a few drawbacks:
> 

Hi:

I just returned from an extended vacation. I will revive this topic in
the next few days.

Thanks for the comments. I will address in the next version.
