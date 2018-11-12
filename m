Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF1E8C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76C7422504
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVlpnkTd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76C7422504
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbeKMBiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 20:38:08 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45785 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729356AbeKMBiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 20:38:07 -0500
Received: by mail-pl1-f193.google.com with SMTP id r3-v6so3790551pls.12;
        Mon, 12 Nov 2018 07:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KWj7ZzFJX6mi6HS0+SSOYC44j85K4Wyg5t+RgwkzpHo=;
        b=dVlpnkTdZNdtWC8raWla3CoJa46uef+ge2Dc9ozhndluW9IWohM1g0czGUijJro8cp
         zr4sjRtc2DqOeHoyurcsCQ1UU7q4JZjZA8ZDl0jO2LhZSQJZrtBKtpbThbHOVlYOWkM2
         PJ3sCZUCP4UV/gLeAEEeY3QlpslGdj72+Ycs6Cs1/A3hoGjuwRUsCRg0NKBWzWrhHNuq
         XdVKvoh+mYpsyUuWAs1bzs+rx3iDRoRtOKJ7QsAnjKPUqZGVW3UM64AN8eW/XXo5dP3o
         KLIbXK8LiWxZvIo1pT4rhTDPzN/yC1xDAivAisp3l4cDBHtvfBQvJduwKoY6JacwtYSo
         pDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KWj7ZzFJX6mi6HS0+SSOYC44j85K4Wyg5t+RgwkzpHo=;
        b=SyWDsGdV0qgeZqhPbjeobDEEMdwH/jBhU2OGmQiC3wiETcYH+ebglEGw/NWxzhiU6o
         JWsaNGDUeEHAvF1jnI/XqmFlWwCHm7jozJN4daNOEIBK2UGb25L9uYi4zHM8ZARpbR8P
         92UQYFXYvpXEkSqJgm5ifs+13TqvHj318PxSDvqJbi8xSkYnY1voREoHAVpEUkBNZAPD
         5IbtGIuZhUT5byA4/nI7hzrMDhtKvIWsH4s7xDov+asUrLoNfXrv4GCdVjjQ35H56Kgu
         idfxHeNzPZac7RgGXRoUkUjjFHCEjtMbLQQRTTZbB10nEd9eouW4Tz5ER3RGyYvxGFO/
         UDSg==
X-Gm-Message-State: AGRZ1gK8LVwKMkh0DYdmbMSVK97iIYsPsN1ITqFBG3imFUr/1I9DkXKh
        Xdt2SLtfbo0jRyIiEphqIr4=
X-Google-Smtp-Source: AJdET5dE0Kde/52fdw5Klwh86HEjpx8kY5WWAiMXu4+jWk7VyIX767pvwXDVnjAK/viKG3zMBG5/Ag==
X-Received: by 2002:a17:902:7281:: with SMTP id d1-v6mr1407093pll.284.1542037460816;
        Mon, 12 Nov 2018 07:44:20 -0800 (PST)
Received: from [192.168.86.235] (c-67-180-167-114.hsd1.ca.comcast.net. [67.180.167.114])
        by smtp.gmail.com with ESMTPSA id z79-v6sm26397488pfl.33.2018.11.12.07.44.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 07:44:19 -0800 (PST)
Subject: Re: [PATCH 1/2] mm/page_alloc: free order-0 pages through PCP in
 page_frag_free()
To:     Alexander Duyck <alexander.duyck@gmail.com>,
        =?UTF-8?Q?Pawe=c5=82_Staszewski?= <pstaszewski@itcare.pl>
Cc:     aaron.lu@intel.com, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        ilias.apalodimas@linaro.org, yoel@kviknet.dk,
        Mel Gorman <mgorman@techsingularity.net>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>, dave.hansen@linux.intel.com
References: <20181105085820.6341-1-aaron.lu@intel.com>
 <CAKgT0UdvYVTA8OjgLhXo9tRUOGikrCi3zJXSrqM0ZmeHb5P2mA@mail.gmail.com>
 <b8b1fbb7-9139-9455-69b8-8c1bed4f7c74@itcare.pl>
 <CAKgT0UdhcXF-ohPHPbg8onRjFabEMnbpXGmLm-27skCNzGKOgw@mail.gmail.com>
 <bd33633b-2f6c-0034-a130-38a8468531db@itcare.pl>
 <CAKgT0UeOBF0yPJLOTBBb3m7nTkmSDxzkCur+iGzJ++Y-jWaw9g@mail.gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <6edcec1a-eefa-7861-1af4-cdf7fa45184c@gmail.com>
Date:   Mon, 12 Nov 2018 07:44:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAKgT0UeOBF0yPJLOTBBb3m7nTkmSDxzkCur+iGzJ++Y-jWaw9g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/12/2018 07:30 AM, Alexander Duyck wrote:

> It sounds to me like XDP would probably be your best bet. With that
> you could probably get away with smaller ring sizes, higher interrupt
> rates, and get the advantage of it batching the Tx without having to
> drop packets.

Add to this that with XDP (or anything lowering per packet processing costs)
you can reduce number of cpus/queues, get better latencies, and bigger TX batches.
