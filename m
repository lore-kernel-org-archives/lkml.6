Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 468ADC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 22:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFE02208D8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 22:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="noilcsp4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFE02208D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=networkplumber.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935852AbeFMWS6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 18:18:58 -0400
Received: from mail-pl0-f48.google.com ([209.85.160.48]:45253 "EHLO
        mail-pl0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935540AbeFMWS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 18:18:57 -0400
Received: by mail-pl0-f48.google.com with SMTP id c23-v6so2301475plz.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 15:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dbBAlyl7HymmQXmivzm0k0oIGAe92pXWMFhcA5vCMS0=;
        b=noilcsp42BEmwL54GFMcoVcGKmUOuAX1DGG7iPqwewOqlxQ4uMobhjIMJE07nUVT38
         q3c+EzkDpQBVarifD79Y/S9XovS5QHhrN0HCvHsIuVdIxSdIQaiYb8u3+5jJ2MlUCoE5
         PrpJCq3UL5ZN9z97GQU3rxAGXpMeKM0kPd2ncTpnOzrXNfjXVC1mlzMQ9qsg9RjJmtwg
         /debyBpleaVcI3thmHH0iTKnZY+xGuqQdnHAIzm611tixnSn522HrBAIBiPjvWLtqRwY
         sBktioGS1esV66pM+YvZQVBpmb44FNvcWToJT9vJ1klL5YeVp3OunuQZDl6cd1tYHIaD
         6YLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dbBAlyl7HymmQXmivzm0k0oIGAe92pXWMFhcA5vCMS0=;
        b=JiaZq3zkFjLzqffSFIkykoPUaF8D8MGLp1e4UAN3Yizkp4koS+4u+DznJKXV/9SA0v
         +VgSkHHPqbsmB2Izu/3FzgZd1pLdVd0fxw7n+NGxvysegNtUg32n89obvqMM8OuYPn4p
         FjB6Jy/zYLrdGAZHD9EqxlL1qv3qX/zFjhO6vPzlR5Nb1mvsCrVN/dc+ovo1O6Bnh/gM
         cHAXO8tuyCCP/SnvI9sJO4sa7uh7jhnwzB35ENm6zeIaz+04GKfcgkCztEkviRD7Hzv+
         B0Qnx+KOCD9SG6IMEeJRd8ig37V8jnnzz3R3apVBy1blOiEdb8hmdZrmynQf4zISyhsI
         AX+A==
X-Gm-Message-State: APt69E25fHoVMopG2WZgaK3o9kSz+sdrIKCJKk8yXlTYSHoSQgdpVITK
        CRDefU6oZnCX4/W2u+xZvQTzGg==
X-Google-Smtp-Source: ADUXVKIxa1hST2jgbQ5H/RqXsivcd7gpE6PVOaisv/raVovsxf4DR/WkK8f18BAHJmbJQ1JGw8WkVw==
X-Received: by 2002:a17:902:1121:: with SMTP id d30-v6mr7165138pla.247.1528928336442;
        Wed, 13 Jun 2018 15:18:56 -0700 (PDT)
Received: from xeon-e3 (204-195-35-107.wavecable.com. [204.195.35.107])
        by smtp.gmail.com with ESMTPSA id a81-v6sm7319316pfl.167.2018.06.13.15.18.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 15:18:56 -0700 (PDT)
Date:   Wed, 13 Jun 2018 15:18:54 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Yidong Ren <Yidong.Ren@microsoft.com>
Cc:     Yidong Ren <yidren@linuxonhyperv.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v2] hv_netvsc: Add per-cpu ethtool stats for netvsc
Message-ID: <20180613151854.25be8b33@xeon-e3>
In-Reply-To: <SN6PR2101MB11353820325BBF4712076573847E0@SN6PR2101MB1135.namprd21.prod.outlook.com>
References: <20180613193608.444-1-yidren@linuxonhyperv.com>
        <20180613144813.708f26bf@xeon-e3>
        <SN6PR2101MB11353820325BBF4712076573847E0@SN6PR2101MB1135.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jun 2018 22:03:34 +0000
Yidong Ren <Yidong.Ren@microsoft.com> wrote:

> > From: devel <driverdev-devel-bounces@linuxdriverproject.org> On Behalf
> > Of Stephen Hemminger  
> > > +/* statistics per queue (rx/tx packets/bytes) */ #define
> > > +NETVSC_PCPU_STATS_LEN (num_present_cpus() *  
> > ARRAY_SIZE(pcpu_stats))
> > 
> > Even though Hyper-V/Azure does not support hot plug cpu's it might be
> > better to num_cpu_possible to avoid any possible future surprises.  
> 
> That will create a very long output (num_cpu_possible = 128 on my machine) for ethtool,
> While doesn't provide additional info.
> num_present_cpus() would cause problem only if someone removed cpu 
> between netvsc_get_sset_count() and netvsc_get_strings() and netvsc_get_ethtool_stats(). 
> 
> An alternative way could be: Check all stats, and only output if not zero. 
> This need to be done in two pass. First pass to get the correct count, second pass to print the number.
> Is there an elegant way to do this? 

Ok, but there is a race between getting names and getting statistics.
If a cpu was added/removed then statistics would not match.
