Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC68C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 165A020866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNEDyMHe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 165A020866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbeIJRQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 13:16:04 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38138 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727727AbeIJRQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 13:16:03 -0400
Received: by mail-lj1-f195.google.com with SMTP id p6-v6so17714740ljc.5;
        Mon, 10 Sep 2018 05:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HmkSRJEJAVNMu/5d0DeLzYStcu5Mn7LtCWdnI0sxacg=;
        b=DNEDyMHe+IGtDK3hj1YdtgYWhOSvaP3l7c5F6Hyy565SeVcncNbSyRLmat0kW2pZMT
         u+wzGB4KD6IIp7K8Vlk8Mu1a+RNAKMtJMCWK0JU17Wgm9gVqneRtRCOr/0T4uyGJ0lZh
         VwLPD8DHkpCwb8bYKqsxEIfArpx+qC99cfoyAc9DgAUPLbC0oPYq1aD6mBlziArD91OJ
         tabL2DGfmXvLs90zf7xlqRJDVrsKkwjvcZBQ3T4/kJzCIbIn6JvPg8sDOvJw+2XEaOFE
         RlUde423ko61FkCSgpnvdncvajWXj/Ggey5/9aJod9ryarhdJDZpDYwYIlA5qAdJT7y3
         OSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HmkSRJEJAVNMu/5d0DeLzYStcu5Mn7LtCWdnI0sxacg=;
        b=Q1QcHWv6WUUmhuoAi6EaWLcOBZVzMPUiQn6HGxiwpDq6xDlLouqR1qzKQn4+tsTAJA
         7+dlawTzckeYl2+zUDr3t5lCz8Xv5f05xurcgbOjJeWDJ2E5jO7O5NklL2FC4eNcKe9H
         KLjzdGDyPRaOGZbx6/3Zy3oOYS658dUQGVP0Zac+eNd0pJkXtjGgWTVsj1JGBOAW4fq6
         fPHyOd2w8yee5DxFikmbd98gxjgrGNsGIkfkcLSXArGRbTDyLwpunE6WYaX767eSdRdp
         IMDzbkKZ6oNJ5hAJvnFvuDTPE9gUj19YQYQO/alwJvFEftLqjeuwd1SD4G/tXyq2shCO
         4HpA==
X-Gm-Message-State: APzg51ANuqFhCdHMg0qjuHZZ29PmM+h6zUqmrM7mgfwoth6KjDd2cjRZ
        pY0z+As5NUdK+XNn3EanbAeABS7LIBY=
X-Google-Smtp-Source: ANB0VdapHzNZ/ZTTl+V2AfZ/g2vy08lcAIF7PXmSqXSpCOpqjxiwiJJRbpkJKbVdam5gz9/jbnpasA==
X-Received: by 2002:a2e:54b:: with SMTP id 72-v6mr13190977ljf.152.1536582132416;
        Mon, 10 Sep 2018 05:22:12 -0700 (PDT)
Received: from ?IPv6:2001:14bb:43:46b3:d135:7d7c:caf7:1c82? (dkqdnjzl1s10p1948tk-4.rev.dnainternet.fi. [2001:14bb:43:46b3:d135:7d7c:caf7:1c82])
        by smtp.gmail.com with ESMTPSA id e41-v6sm2820788lji.37.2018.09.10.05.22.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 05:22:11 -0700 (PDT)
Subject: Re: [PATCH v2] asm-generic: bug: unify hints for BUG_ON()
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     igor.stoppa@huawei.com, linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180908045928.26201-1-igor.stoppa@huawei.com>
 <CAK8P3a02Q0_r4sqzJzA01GEHf0oUyevwwVg+E0_iCEkLFrwOaw@mail.gmail.com>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <a58d4439-bc6c-66b3-0de2-ea92be21e6b8@gmail.com>
Date:   Mon, 10 Sep 2018 15:22:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a02Q0_r4sqzJzA01GEHf0oUyevwwVg+E0_iCEkLFrwOaw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/09/18 15:16, Arnd Bergmann wrote:

> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> I assume this will be included in a longer patch series rather than
> going through
> my asm-generic tree, right?

sadly, no: this patch is just for the asm-generic tree
I tried with the longer patch series, but it didn't work out
I'm now submitting individual patches to their respective mailing lists 
and maintainers.
It requires more churning, but at least some patches are going through.

--
thanks, igor
