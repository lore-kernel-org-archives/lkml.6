Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2318C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F94220844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXaDXuYY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F94220844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731279AbeGYTgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 15:36:02 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:39981 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729187AbeGYTgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 15:36:02 -0400
Received: by mail-it0-f65.google.com with SMTP id h23-v6so9956006ita.5;
        Wed, 25 Jul 2018 11:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UIw9i0w7/bpMofUHMUcJ5iZbklnKmitbL36cVwEDF5o=;
        b=QXaDXuYYYuk86QKqDNWUdWbcQ4VtlUy4Rpn1gejIErkv2dYVRv5Amqs5A/QZ8qaxb2
         smH3O1DqG2vzJVjpcjCHQRcilA7U9q21kFdYzhvVlhpFc+VbSKucAvOpdMWZIedgiTHA
         pRAYhRWSwbQPbecaWONbIYTQZKzl+hyse2VoLHwsVefurm9ELraic8aoG+0Xuw8807UM
         6AVhuwNnM7OSwbtiG4A/gTH9qUh6cwcW45jrlGghB6WQhBfWV42uwNjfsZ/kjHB7SnMc
         83ntKSLQjmzAQQYNJ+z7G1FnbG49Kwuz9mUWIim359Mf5RPGekP3nm9gglzRIIpR0JdA
         GOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UIw9i0w7/bpMofUHMUcJ5iZbklnKmitbL36cVwEDF5o=;
        b=VSXH3wXv7xGh4mQIiS4fDSv7zkGevx/iohwIVaH2JfhzvJ9sIiKl3wYkhlbq/J3q4s
         3q4YVdkqt/it7kaTzDXnf+g9zxaykPU2+MI7HOf5o/bdJrFSfkFTE8Yv2mIPy5OBCxsy
         JtVYCeA5kk8f9+PvANhPc9JbP7SxpG6Mf4K/oTuW560EXqqiH40uzc8pH5z8B3LfV5Wj
         Smxq3O2ZPwgIyHNEFVYrBnaXJRLcnXsi/gQVTQLnRUU7QzUVun6XeixLzcM0qpbuuqHn
         qrxON/TcIckP6I1Chr/PXuoofhTzoeFCWiMvgd9TaCFuPDLhDqrOIL0mCSm1K/dUXxvk
         5U1Q==
X-Gm-Message-State: AOUpUlFqVp3/80U2ge5Y+mm6QRS2H5EN9NShwHbFjdYrUEsyVc+WlSAy
        Z9blWSfdnFl0TzmOFuTlmrSAKyPW
X-Google-Smtp-Source: AAOMgpckoeklR3B1cDikLKjOJTNNTHwMET/hvVnBb9ZAIJJaVDLRTXSD6tX5YPnm2CiqAagTuxbXGA==
X-Received: by 2002:a02:b687:: with SMTP id i7-v6mr20915835jam.55.1532542989926;
        Wed, 25 Jul 2018 11:23:09 -0700 (PDT)
Received: from dsa-mb.local ([2601:282:800:fd80:e4d8:8895:822a:720a])
        by smtp.googlemail.com with ESMTPSA id 203-v6sm3023983itv.32.2018.07.25.11.23.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 11:23:08 -0700 (PDT)
Subject: Re: [PATCH RFC/RFT net-next 00/17] net: Convert neighbor tables to
 per-namespace
To:     David Miller <davem@davemloft.net>
Cc:     xiyou.wangcong@gmail.com, netdev@vger.kernel.org,
        nikita.leshchenko@oracle.com, roopa@cumulusnetworks.com,
        stephen@networkplumber.org, idosch@mellanox.com, jiri@mellanox.com,
        saeedm@mellanox.com, alex.aring@gmail.com,
        linux-wpan@vger.kernel.org, netfilter-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <28c30574-391c-b4bd-c337-51d3040d901a@gmail.com>
 <CAM_iQpW4-JkZY7jXx0Q1b907hQ85UOL1eXv2YHwSukb5L=apUg@mail.gmail.com>
 <5021d874-8e99-6eba-f24b-4257c62d4457@gmail.com>
 <20180724.101405.797730329231867648.davem@davemloft.net>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <36c41b45-ed97-1207-1b5e-32d3423b5567@gmail.com>
Date:   Wed, 25 Jul 2018 12:23:07 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180724.101405.797730329231867648.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/18 11:14 AM, David Miller wrote:
> From: David Ahern <dsahern@gmail.com>
> Date: Tue, 24 Jul 2018 09:14:01 -0600
> 
>> I get the impression there is no longer a strong resistance against
>> moving the tables to per namespace, but deciding what is the right
>> approach to handle backwards compatibility. Correct? Changing the
>> accounting is inevitably going to be noticeable to some use case(s), but
>> with sysctl settings it is a simple runtime update once the user knows
>> to make the change.
>>
>> neighbor entries round up to 512 byte allocations, so with the current
>> gc_thresh defaults (128/512/1024) 512k can be consumed. Using those
>> limits per namespace seems high which is why I suggested a per-namespace
>> default of (16/32/64) which amounts to 32k per namespace limit by
>> default. Open to other suggestions as well.
> 
> No objection from me about going to per-ns neigh tables.
> 
> About the defaults, I wonder if we can scale them to the amount of
> memory given to the ns or something like that?  I bet this will better
> match the intended use of the ns.
> 

Not sure how to do that. I am not aware of memory allocations to a
network namespace. As I understand it containers use cgroups to control
memory use, but I am not aware of any direct ties to namespace.
