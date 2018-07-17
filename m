Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8F8ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E885206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="skyhfKcT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E885206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730429AbeGQSRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 14:17:03 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:43740 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729741AbeGQSRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 14:17:02 -0400
Received: by mail-pf0-f193.google.com with SMTP id j26-v6so852260pfi.10;
        Tue, 17 Jul 2018 10:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7f+uY0RamTrAkUnRuM0l2yTktj526hs7KMnvR/5n1UQ=;
        b=skyhfKcTn9tkbSD2FhNx47p/Tz8IuRr+reF/qfjSS/rBxjFJnoz5SGD+0wOR6IF6Jr
         yVn/N+pPwzPxAAvrxvBXXX2CaX6HVBsgnMzz1MuWgztFE3B+dWA91bRmLRBZys+oiYeL
         SUwJJeuF1OVywOG82EvoXASjoXBknj8Z7mZGO8dBaTv7b213oYWrqI5pOr3FvCEaBopC
         3KnPqUxxnQsgVp2aARRL/wo5Dm2u7W5OuxMJeLUIJHbem1zr83Z0nGQJ95BLSbz+CuX2
         22k8/Joi4tV8ZaCM53QBxXzPzBfply+hgA6e8uKfCHexgImrfXf20X5Cvx4x/mAiKQ4b
         qgTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7f+uY0RamTrAkUnRuM0l2yTktj526hs7KMnvR/5n1UQ=;
        b=NaYAO+dR25oVWu0d1tT5WXvWlEOi2xss+5AIxNYFPef6dAVFo7KCZ30o0SP4quiEss
         YriD3UCzPYkWwZeIyn057z6Pl2v4Z6OY4rhop/bFjkeve2QHY8EkYmHSBPot8BoRwiFd
         AVTq/WKghqm/dGonUqZVnH6zm8p9hxXDgfrtTurnRdVf/F+ytYzEA4XUcAJq1IuJneL1
         1qQ+dYNzAJHysHNAIz15MSgnxyY45R0o4v6EaqgxxuILd9mMZN6pPVJLtrakHjEfZ4AR
         aBymbAeU642GKzloFp+qUYKD1wLk9Oip3lCOhXFakuNP7DcXOJlpvIho74CDUCSJD4cf
         eprw==
X-Gm-Message-State: AOUpUlGxZKkQO1yp2CeFJqQKAPAkIdeac88i5HsJd1pKDWIrfXBNve2f
        LK/u/88xSvqb+AbXr5B07PwY9PX3
X-Google-Smtp-Source: AAOMgpcGoCrDDM42spMyEn8IMtrZ4N0a6p8Fvu0VlLuAa25hm0qNymIpOX3+roC7MP8nGM9uc+kLdw==
X-Received: by 2002:a62:ccd0:: with SMTP id j77-v6mr1650028pfk.22.1531849399316;
        Tue, 17 Jul 2018 10:43:19 -0700 (PDT)
Received: from dsa-mb.local ([2601:282:800:fd80:442b:d01f:635c:39ec])
        by smtp.googlemail.com with ESMTPSA id n9-v6sm3824806pfg.21.2018.07.17.10.43.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 10:43:17 -0700 (PDT)
Subject: Re: [PATCH RFC/RFT net-next 00/17] net: Convert neighbor tables to
 per-namespace
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Linux Kernel Network Developers <netdev@vger.kernel.org>,
        nikita.leshchenko@oracle.com,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Ido Schimmel <idosch@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>, alex.aring@gmail.com,
        linux-wpan@vger.kernel.org,
        NetFilter <netfilter-devel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20180717120651.15748-1-dsahern@kernel.org>
 <CAM_iQpW4g2v6xk49Gz+WBasKaO9VUk3Q-umX7iBRK-mAhn21Fw@mail.gmail.com>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <1a3f59a9-0ba5-c83f-16a6-f9550a84f693@gmail.com>
Date:   Tue, 17 Jul 2018 11:43:16 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAM_iQpW4g2v6xk49Gz+WBasKaO9VUk3Q-umX7iBRK-mAhn21Fw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/18 11:40 AM, Cong Wang wrote:
> On Tue, Jul 17, 2018 at 5:11 AM <dsahern@kernel.org> wrote:
>>
>> From: David Ahern <dsahern@gmail.com>
>>
>> Nikita Leshenko reported that neighbor entries in one namespace can
>> evict neighbor entries in another. The problem is that the neighbor
>> tables have entries across all namespaces without separate accounting
>> and with global limits on when to scan for entries to evict.
> 
> It is nothing new, people including me already noticed this before.
> 
> 
>>
>> Resolve by making the neighbor tables for ipv4, ipv6 and decnet per
>> namespace and making the accounting and threshold limits per namespace.
> 
> 
> The last discussion about this a long time ago concluded that neigh
> table entries are controllable by remote, so after moving it to per netns,
> it would be easier to DOS the host.
> 

There are still limits on the total number of entries and with
per-namespace limits an admin has better control.
