Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D6CC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F7432087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eK2EQLqr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F7432087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbeLCU6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 15:58:40 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37076 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbeLCU6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 15:58:39 -0500
Received: by mail-ed1-f66.google.com with SMTP id h15so12016054edb.4;
        Mon, 03 Dec 2018 12:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3TjY3JWxdN3/18b9FENgNpkOG6/DFzbiy3Q1rL9wrR4=;
        b=eK2EQLqrqT3U6tTkIigQ3nYIi9V+OJ9VoHQ72VljO5poz2VGk8+kJ8bmuXe650t1zs
         FAMYs6LUkL1DoBh+OV6D43igmhMAIjASg1eeGp32mJx+lUP4TKfQXlvdu5m3h3SvH5Hf
         gxNSRYKrOFEr8WpFftNNlJOwn5OUhMP3GiMH5UvcTz9Icgef7JfcbYlESseblzAyWdoN
         K5D84KrPmTzUCOY2XNaxUFBowoWUsV4cvRyGBjRrpCoKJ0xv7arXNu+iOR7g9Cvb2X0z
         acbwa8EzzLeilIVT1asrlBv0Ca+Sa+w5WnyFmPrsSkOtyqEhAUPevOa83ooUAkqd5qqe
         WwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=3TjY3JWxdN3/18b9FENgNpkOG6/DFzbiy3Q1rL9wrR4=;
        b=kjLV2G5azHAKxCyODevW1oVOtH/nhk045m67OeULnye6uabKd95CJmPJJRu7TEV0xd
         QbLoLjNi8l5j2pAJRYazFpLG+xDNcQ+vn2SfK5tMf7/aTswBF3vw47hBssXPbUm3Cqqz
         wreiHtV+HS0KWXYp9E06/2h9wF1367XB8sD+vkKKGSgKa3wJXtxMuCu1Q3vFg1urweqv
         hVS1sIUHPmyFLeirce63yHw/Iv3IgmFdYe+AkRwvSmtBj09NQYj76vu8rkp48DXxIfJK
         HN8eo8bc7S8wJRX95zoQ3+WYgsto6z1gIy/wHSMtoKdAn+CvCNN4+rrF8GD3GfiZuzGU
         PiDw==
X-Gm-Message-State: AA+aEWbNp6IU7u7LG3htvGwXhwfeLc2TMOZV+RiZs1k7OFTtmWbgX48J
        D6AYAJnuM4CQtz7WI5kwqyQDCc9IDjk=
X-Google-Smtp-Source: AFSGD/WMWTB2dTi58E5OxTsZF0JX6bmZAQwXQEDEvQe7PJaAaMdeaoN76UoT5tHsUZM+pBBwzOrllw==
X-Received: by 2002:a50:b0e5:: with SMTP id j92mr14813776edd.188.1543870717497;
        Mon, 03 Dec 2018 12:58:37 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id e53sm4158738ede.90.2018.12.03.12.58.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 12:58:36 -0800 (PST)
Date:   Mon, 3 Dec 2018 20:58:36 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-acpi@vger.kernel.org,
        devel@linuxdriverproject.org, xen-devel@lists.xenproject.org,
        x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Banman <andrew.banman@hpe.com>,
        "mike.travis@hpe.com" <mike.travis@hpe.com>,
        Oscar Salvador <osalvador@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Michal Such??nek <msuchanek@suse.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH RFCv2 1/4] mm/memory_hotplug: Introduce memory block types
Message-ID: <20181203205836.7xpab6ljc3kngrqm@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20181130175922.10425-1-david@redhat.com>
 <20181130175922.10425-2-david@redhat.com>
 <20181201012507.lxfscl6ho3gc6gnn@master>
 <af797dbb-0537-19ec-ef31-d72a3f979791@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af797dbb-0537-19ec-ef31-d72a3f979791@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]
>>>
>>> +	if (type == MEMORY_BLOCK_NONE)
>>> +		return -EINVAL;
>> 
>> No one will pass in this value. Can we omit this check for now?
>
>I could move it to patch nr 2 I guess, but as I introduce
>MEMORY_BLOCK_NONE here it made sense to keep it in here.
>

Yes, this make sense to me now.

>(and I think at least for now it makes sense to not squash patch 1 and
>2, to easier discuss the new user interface/concept introduced in this
>patch).
>
>Thanks!
>
>-- 
>
>Thanks,
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me
