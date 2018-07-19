Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEEFC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 16:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8D2020673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 16:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vZgkReBf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8D2020673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731969AbeGSRAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 13:00:33 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:43868 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeGSRAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 13:00:33 -0400
Received: by mail-pl0-f68.google.com with SMTP id o7-v6so3869853plk.10;
        Thu, 19 Jul 2018 09:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RlcZD3q5eY/o8SO2Atokt+Ioz76TKgEq98TgZrjQpIg=;
        b=vZgkReBflDFl5cw0iZtgNHOtVyj5ByxZbhJ48d5/E22KwXvGenn3kzEZLL6dxdkF/q
         Fzvs8STWrytkutBflgJDAfvjLJhRpcA2tzUZIYd5MzdkWU2OkRuRY8Sp8Y+3TwDwIWqJ
         lXD3CXjdDzeXuwSX48ZnlRefkWGoQDTG/rEGn5ErpDAehp3kSWWtrvoypPJ9QjhodKZt
         koeou36GawBWqrwgpa9uhlYeqjRNo/gZGsWjaDyTIr06AYWuuz0UjsbnJYMQAofD1uXB
         jvHB0cH5gUP38nzJ3TUTDGQ7ZKFlaICI6eZ1pdeZychzIo9KdyC3sONsM57/qHrRCm3P
         az6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RlcZD3q5eY/o8SO2Atokt+Ioz76TKgEq98TgZrjQpIg=;
        b=Obb2RFbmXrvE7piMShodgJoe4fK5sifKmOQxSbHRZ0kSnu5mtxITI9pQ9i7FLr8ICu
         6G6L1Veg8K6GPOvzckaZcJ2kfBlTm4jQgF85vUsbaweFSs2gvMq9Pm9FyKM08HV9Q40i
         7qfBqL1tfFTezQADXGaTl4EXzrNMru7tz8y94CZNLmrUrn47c8J6KcD9HibhBeje0/1J
         N8DOg385FgIajSYEo7YIeSHIHvXLaneYZp7KTTntmI0N81OeK0gti1+JXT343lHuRwPX
         Zxw3pJV13HOW8xLOxn2GSH+3oeezsrA0C1TvgRwyn/yVCXKndrrrQFA6WHQh8iz/f2D8
         b3NA==
X-Gm-Message-State: AOUpUlGwLqh23cd7oi8QPoD1GeIHW/kI7OJGFiMuUxZovj1XZ7CQZ57U
        zqj1kP3B5zZI4lDtnpjjc2DhLf6/
X-Google-Smtp-Source: AAOMgpdlr6q7iH23KRD74OimywlIZAuo5KsIC4ERq0TkjBpG3AYeAcgOHNdu12l7ui9I0z9mMgb/jQ==
X-Received: by 2002:a17:902:301:: with SMTP id 1-v6mr10618464pld.127.1532016999279;
        Thu, 19 Jul 2018 09:16:39 -0700 (PDT)
Received: from dsa-mb.local ([2601:282:800:fd80:41e6:c9c0:c223:a927])
        by smtp.googlemail.com with ESMTPSA id s1-v6sm16342366pfj.53.2018.07.19.09.16.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 09:16:38 -0700 (PDT)
Subject: Re: [PATCH RFC/RFT net-next 00/17] net: Convert neighbor tables to
 per-namespace
To:     David Miller <davem@davemloft.net>
Cc:     xiyou.wangcong@gmail.com, netdev@vger.kernel.org,
        nikita.leshchenko@oracle.com, roopa@cumulusnetworks.com,
        stephen@networkplumber.org, idosch@mellanox.com, jiri@mellanox.com,
        saeedm@mellanox.com, alex.aring@gmail.com,
        linux-wpan@vger.kernel.org, netfilter-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1a3f59a9-0ba5-c83f-16a6-f9550a84f693@gmail.com>
 <CAM_iQpWabZorkMNswyfHyS4KT=f_bgMtK8K35=84uah6Kfqxew@mail.gmail.com>
 <1a27e301-3275-b349-a2f8-afdfdc02f04f@gmail.com>
 <20180718.125938.2271502580775162784.davem@davemloft.net>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <28c30574-391c-b4bd-c337-51d3040d901a@gmail.com>
Date:   Thu, 19 Jul 2018 10:16:36 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180718.125938.2271502580775162784.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/18 9:59 PM, David Miller wrote:
> From: David Ahern <dsahern@gmail.com>
> Date: Tue, 17 Jul 2018 13:02:18 -0600
> 
>> I understand the concern about global resource and limits: as it stands
>> you have to increase the limits in init_net to the max expected and hope
>> for the best. With per namespace limits you can lower the limits of each
>> namespace better control the total impact on the total memory used.
>> Perhaps the defaults for namespaces after init_net could have really low
>> defaults (e.g., 16 / 32 / 64 for gc_thresh 1/2/3) requiring admin
>> intervention.
> 
> How does this work when a namespace creates another namespace?
> 
> Changing the defaults for non-init_net namespaces could work, but that
> could be a surprise to some people.
> 

Patches 14 (ipv4) and 15 (ipv6) currently use the existing hardcoded
values - not based on current init_net or anything else. This could be
changed to:

+	if (net_eq(net, &init_net)) {
+		arp_tbl->gc_thresh1	= 128;
+		arp_tbl->gc_thresh2	= 512;
+		arp_tbl->gc_thresh3	= 1024;
+	} else {
+		arp_tbl->gc_thresh1	= 16;
+		arp_tbl->gc_thresh2	= 32;
+		arp_tbl->gc_thresh3	= 64;
+	}

and update the documentation that any new network namespaces have lower
defaults.

As for any change in behavior: today neighbor entries from one namespace
can be removed due to actions in another so no obvious correlation. With
lower settings then gc could kick in and remove entries that otherwise
would not have been. The big hit would be to a new namespace where an
app inserts a lot of PERMANENT entries.

Chatting with Nikolay about this and he brought up a good corollary - ip
fragmentation. It really is a similar problem in that memory is consumed
as a result of packets received from an external entity. The ipfrag
sysctls are per namespace with a limit that non-init_net namespaces can
not set high_thresh > the current value of init_net. Potential memory
consumed by fragments scales with the number of namespaces which is the
primary concern with making neighbor tables per namespace.

If we kept the current default settings (128/512/1024) per namespace we
still have capped memory use, and the one user visible hit that comes to
mind is the namespace with a lot of PERM entries.
