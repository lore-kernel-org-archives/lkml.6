Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B52C9C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AD4C20874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSKrQWoK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AD4C20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388454AbeGXQVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 12:21:03 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:32924 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388332AbeGXQVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 12:21:02 -0400
Received: by mail-pl0-f66.google.com with SMTP id 6-v6so1918663plb.0;
        Tue, 24 Jul 2018 08:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Z4hIn9bS5JW1fZRb+R+hTXVJuRA6XOPJOxYPzSkVCC8=;
        b=aSKrQWoKRzLwDW64Ohwe/Lq8KTgew1esQc58HYTLlQ0w4UTwR+4bcnbVY61cW+Xxgm
         hgh03fkNKzh6ecFc6uFokOYuWwnmHNsTGRWdcWhFr1FF05hsnBzAZqpO2cm7f+l8wSjF
         tfkZre0C70N9QIafXFZf7h48u30/6SSJIf87RrBwqrGGDCjCm9uDybyvVDXKAQCwEEJR
         BcsPqHcZXHWfxKpLDRLKH28pllsm8f/HbVZezT0HwCgEU5i8o1tvXZTiuIYaTu76o5fu
         /CEXyAZW4cRRx+Z+48objJXEolY6uvH8VrP8lQXViLfIUMB0UY9YE8QNF5IryWrZHh1V
         CgJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z4hIn9bS5JW1fZRb+R+hTXVJuRA6XOPJOxYPzSkVCC8=;
        b=OQNCW329x3qGjhKbGsddqtgSlbIk+TD+zyTygZyFqFHZJdGBlIWdFf4n7GzCVDMJ7O
         cYwOpUBWXjFDgk2gSPOyh9WiTZ5gKCE1S/eQoRpwe8KdWyjAMgjo06wJLPGuaoWFS6FZ
         t9xOnjfS0qpRv4RGWDfEs5rZWM+YlVKtn1fLVoM3mmk/jkW9atBHCv/xBbvR7V5QaWQw
         QleLN7FLiksweZjEgtPruf8xvBPR5EACrbbaZkTGlCPxtY13s5U7Bkg8man15UyIISzr
         exwP8/U0cnGMuoZhwmBsQzHo3vsn/KDEDjEsupyLIPFDnNMM9rhBuZTIO4gyhuhTuxjG
         HdfA==
X-Gm-Message-State: AOUpUlE/Wms9NVs68WxQ7vQtRMcH36pBC4rW8vmE8amXExC53aQAVGrD
        5nKH+m3qb7fIe9MfX2CSovIVDhfS
X-Google-Smtp-Source: AAOMgpe8zEVXWbbbcgtacB5eQhGnYNgS4uHkVzdVBfRIMKxTOpAFHZih2bfuaImI64vGaZ6WkMHT/Q==
X-Received: by 2002:a17:902:1:: with SMTP id 1-v6mr17523392pla.167.1532445244738;
        Tue, 24 Jul 2018 08:14:04 -0700 (PDT)
Received: from dsa-mb.local ([2601:282:800:fd80:3dc3:5892:8bba:bed4])
        by smtp.googlemail.com with ESMTPSA id g63-v6sm17269919pfc.77.2018.07.24.08.14.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 08:14:03 -0700 (PDT)
Subject: Re: [PATCH RFC/RFT net-next 00/17] net: Convert neighbor tables to
 per-namespace
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        nikita.leshchenko@oracle.com,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Ido Schimmel <idosch@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Alexander Aring <alex.aring@gmail.com>,
        linux-wpan@vger.kernel.org,
        NetFilter <netfilter-devel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1a3f59a9-0ba5-c83f-16a6-f9550a84f693@gmail.com>
 <CAM_iQpWabZorkMNswyfHyS4KT=f_bgMtK8K35=84uah6Kfqxew@mail.gmail.com>
 <1a27e301-3275-b349-a2f8-afdfdc02f04f@gmail.com>
 <20180718.125938.2271502580775162784.davem@davemloft.net>
 <28c30574-391c-b4bd-c337-51d3040d901a@gmail.com>
 <CAM_iQpW4-JkZY7jXx0Q1b907hQ85UOL1eXv2YHwSukb5L=apUg@mail.gmail.com>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <5021d874-8e99-6eba-f24b-4257c62d4457@gmail.com>
Date:   Tue, 24 Jul 2018 09:14:01 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAM_iQpW4-JkZY7jXx0Q1b907hQ85UOL1eXv2YHwSukb5L=apUg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/18 11:12 AM, Cong Wang wrote:
> On Thu, Jul 19, 2018 at 9:16 AM David Ahern <dsahern@gmail.com> wrote:
>>
>> Chatting with Nikolay about this and he brought up a good corollary - ip
>> fragmentation. It really is a similar problem in that memory is consumed
>> as a result of packets received from an external entity. The ipfrag
>> sysctls are per namespace with a limit that non-init_net namespaces can
>> not set high_thresh > the current value of init_net. Potential memory
>> consumed by fragments scales with the number of namespaces which is the
>> primary concern with making neighbor tables per namespace.
> 
> Nothing new, already discussed:
> https://marc.info/?l=linux-netdev&m=140391416215988&w=2
> 
> :)
> 

Neighbor tables, bridge fdbs, vxlan fdbs and ip fragments all consume
local memory resources due to received packets. bridge and vxlan fdb's
are fairly straightforward analogs to neighbor entries; they are per
device with no limits on the number of entries. Fragments have memory
limits per namespace. So neighbor tables are the only ones with this
strict limitation and concern on memory consumption.

I get the impression there is no longer a strong resistance against
moving the tables to per namespace, but deciding what is the right
approach to handle backwards compatibility. Correct? Changing the
accounting is inevitably going to be noticeable to some use case(s), but
with sysctl settings it is a simple runtime update once the user knows
to make the change.

neighbor entries round up to 512 byte allocations, so with the current
gc_thresh defaults (128/512/1024) 512k can be consumed. Using those
limits per namespace seems high which is why I suggested a per-namespace
default of (16/32/64) which amounts to 32k per namespace limit by
default. Open to other suggestions as well.
