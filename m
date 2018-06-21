Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FBAC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86EBF208B3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Djf+HQt8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86EBF208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754537AbeFUBYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 21:24:40 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33458 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754101AbeFUBYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 21:24:34 -0400
Received: by mail-pl0-f67.google.com with SMTP id 6-v6so728022plb.0;
        Wed, 20 Jun 2018 18:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=124nx/Bf6urjW7NWwZUHKIblzUEVgqs8s6fX/vjUI10=;
        b=Djf+HQt8FKQKNeAh4/aKUefUqjuuus6pbqRr5+gns/Kp5JDkh/jqxvBn6QJx1t/vbD
         8pxNxmGPgWH6wZf1LKkKa3YPJ37YGkpM0Gjg0B8aG+oCgdYVnjKEY9gaI89ufaEN6Aun
         5Bj5/p53PkDXza7a5rAh9qvYHLos48HgkwnSH4fswKwKfi+mI4D2IoIuTrCoBeF0/8rE
         TA+qDo8u4Pj8pjScGG9lOD5zQgb9XlN+jxtVMNocDod4KnEEG5CQAUa9NPtrWRKyKcBc
         hvJryjrqC9Hg3jxZvANHGQJQWQawI/94ucuWj6Shs+ncmAjtgga/x5kgvncYDJjLNgos
         zF2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=124nx/Bf6urjW7NWwZUHKIblzUEVgqs8s6fX/vjUI10=;
        b=HlSV8tkroAucbvvuiWMsilQkBZzrw10YBpeqZXt7DNsOE4SFhWTWnd2k7Ptg+ZC5se
         RWIvcV0as+5rI7YO9zguDOeF5TZ+fuvYQXH2NiIo6JeAOxJLpaWTgSS6hyWXkaYoBklJ
         SbUxUHkyFt3APRxHFkszEd2ng+vpmgOy7wJwdNTBHmyNxc8NVFJxIckHDViZ8o2Rgvjb
         FXrp54fOllHTSNeJEGO6pGjl6ygwFk2LSCfd1/usr35b/rN8Mj3Bv4zhMeLjERgjVJj7
         fKFE2nwZ5t250HuJXbHs08zcInkq+PjMGZkxVzDexPN/2LLyHR3vS5GDjDat+PSdXYRy
         p4tQ==
X-Gm-Message-State: APt69E0Aay4fCNXjTYcearY5mBmzHcVqgLWHcuAoRz0hTqPOAypOt8/B
        hbXjkuqd3+Ud6cDFWp6uqCU=
X-Google-Smtp-Source: ADUXVKKy1ZXzkP3c+N50H0Q6/JNxuZ7u+24bZ11peNORDobi8ySvT0fT/r46BrY/EqJ9WEuO+QKY+A==
X-Received: by 2002:a17:902:7e08:: with SMTP id b8-v6mr374202plm.230.1529544273714;
        Wed, 20 Jun 2018 18:24:33 -0700 (PDT)
Received: from [192.168.1.5] (c-73-157-163-165.hsd1.or.comcast.net. [73.157.163.165])
        by smtp.gmail.com with ESMTPSA id x24-v6sm6683537pfj.104.2018.06.20.18.24.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 18:24:32 -0700 (PDT)
Subject: Re: [PATCH v3 0/2] tpm: add support for nonblocking operation
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, philip.b.tricca@intel.com,
        "Dock, Deneen T" <deneen.t.dock@intel.com>
References: <152882630662.30206.8805136953394285180.stgit@tstruk-mobl1.jf.intel.com>
 <20180619131046.GC5609@linux.intel.com>
 <e402d3d0-d9de-35a9-d434-d472d8f68e62@intel.com>
 <1529539176.4163.2.camel@HansenPartnership.com>
From:   Tadeusz Struk <tstruk@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=tstruk@gmail.com; prefer-encrypt=mutual; keydata=
 xsDiBEiLICMRBADteQacQxypsuFvAw6IwYzbD8pgQi+kLYBcqfGgVAUN/cO+sLl6u1lVdaDB
 fhAArdbV9lpoqcWnmhQFTb4A+W569EpydBr6nuatWkEB+fmmx8YoUtuZfXt7v+1l1rc09kaW
 LY+TkwQkvFCeuvdasgmBLnmRWymEGWi1E12hUgTw/wCgtK24geC7XkiuANMv0gpr+raOgQMD
 /2yJZ0SeXQApWyTRaeIYN8GgYHZTWuBp/ofN+viEkhrDxahcaGPP5B/Nv6VS1+M0e5m8OzHj
 qPUbgfyOeJcslC5aoZdqqqzVWVLaA/+Jy+O+6T3k3R/IryVVATldBlwnGFDhET0mKQsd15zt
 cIdQBBbfSFR5VlugZuWV5q442IpPA/4g7nen9FFPxh45Te8D54hAsOCywjm6xUE0UJGYHeJ/
 MXCPtuXfVCbYcOxZVH7kUS2Vtk5d3bF40IE2WnVq1ZScNANF4ZjikxYhYGfNWX3HXak1gSoj
 UrY87rMSjPIAry4L0BoIx2qgL/k4iV/3QcXL4t5wosU0iw++suf1zGGcKM0gVGFkZXVzeiBT
 dHJ1ayA8dHN0cnVrQGdtYWlsLmNvbT7CYwQTEQIAIwIbAwYLCQgHAwIEFQIIAwQWAgMBAh4B
 AheABQJQTjJTAhkBAAoJEDFswfskq9xyqvcAoI2nsaUCX8ZGbu+Jhq+++qlBFJ2rAJ983RoO
 R2ofHhn3g3Qi4K34tw0l087BTQRauzUlARAAqkWRL/InEPnoGMg/gw/CRaDBaIBgMsvIcghI
 7xevIzpleXt6jKHghSBooH+zaT7qi4u2gkgPn4odsER3Rm94XgrZJgoqls6EpKMWpJNGP4HT
 eYgykhfsZOLX8ijUbjTM/Sm/dZVo6aYoBL2+ciJwyl+Zt3Mp6un3/GWu6cA9005V50pRqO7j
 PTlVCHi2bedcEEf5DDsYJv/3Oz8/4LpSf6BL6BltjeZVa2y03dTMmD031JTH+OuyJm1yh72Z
 HWxhlYNXOv6uFJJVr+paQjrAsBVIYKhK24bD+uGJxLm8AN9i7/Si+2YeSsXvKUhk9mIoFBnU
 VFo63cziRTcpRu/kXgDAbujwN88qytEcvhEZHS6B9vdws+lhTpolEjkLCkz0Y59z4Fs9srKy
 QkRN+wtdiLgrwyDW3ryAKxcDmOumGWebDxpaOI/pBhrlS93HmDlvj7JmgTUU4a/NhwI3dXh5
 pn8FZzZyVXe3Kc3bu5T3UAC7uztinsAvCJQS6jGZWrXmXkqYkaLXQOw61eInWjr01zE/zDbE
 mdJPM0+va/gtZx9TtGxr4PpjbqswqCiubLDZXZHh5uqArPv/i+E8aXIsNSTN6Rrqs1j9YgDN
 ALksibv6+tXH3sOlCUgjuZgJH3+s/mnaAtiV2rZ/WlH15d6nd0uiDSZrKhlR+g4NHMh1ztEA
 EQEAAcJPBBgRAgAPBQJauzUlAhsMBQkJZgGAAAoJEDFswfskq9xyfv8An1osDQI/sA5cqrgj
 cvV2+TsxcukjAKCGFEQxLUxHDJs2KpQW2mJa5DGeCw==
Message-ID: <0e46c2e9-af2b-550f-2b3d-98cbc1840bc1@gmail.com>
Date:   Wed, 20 Jun 2018 18:24:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1529539176.4163.2.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/20/2018 04:59 PM, James Bottomley wrote:
> I'm slightly surprised by this statement.  I thought IoT Node.js
> runtimes (of which there are far too many, so I haven't looked at all
> of them) use libuv or one of the forks:
> 
> http://libuv.org/
> 
> As the basis for their I/O handling?  While libuv can do polling for
> event driven interfaces it also support the worker thread model just as
> easily:
> 
> http://docs.libuv.org/en/v1.x/threadpool.html

Yes, it does polling:
http://docs.libuv.org/en/v1.x/design.html#the-i-o-loop

> 
>> Similarly embedded applications, which are basically just a single
>> threaded event loop, quite often don't use threads because of
>> resources constrains.
> It's hard for me, as a kernel developer, to imagine any embedded
> scenario using the Linux kernel that would not allow threads unless the
> writers simply didn't bother with synchronization: The kernel schedules
> at the threads level and can't be configured not to use them plus
> threads are inherently more lightweight than processes so they're a
> natural fit for resource constrained scenarios.
> 
> That's still not to say we shouldn't do this, but I've got to say I
> think the only consumers would be old fashioned C code: the code we
> used to write before we had thread libraries that did use signals and
> poll() for a single threaded event driven monolith (think green
> threads), because all the new webby languages use threading either
> explicitly or at the core of their operation.

Regardless of how it actually might be used, I'm happy that we agree on
that this *is* the right thing to do.
Thanks,
Tadeusz
