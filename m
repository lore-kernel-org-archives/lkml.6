Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10297C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCC9F20834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind-com.20150623.gappssmtp.com header.i=@6wind-com.20150623.gappssmtp.com header.b="iT3kdGVJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCC9F20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=6wind.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbeH3TwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:52:03 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52820 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727042AbeH3TwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:52:03 -0400
Received: by mail-wm0-f68.google.com with SMTP id y139-v6so2470435wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 08:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind-com.20150623.gappssmtp.com; s=20150623;
        h=reply-to:subject:references:to:cc:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2Ro+YhYCgLdkkVvf8gJKCyfj8mMLYi1pQy4uXORtAYg=;
        b=iT3kdGVJ9qbKPjgJKBKj4KAACGK0WNTtQxjecE36kHmX35lmiswAbq8tuSjtLhT5ae
         zMEMo2brjutkuvU78cQ3bsP70UeIZN13tBxbM+eahaN8hwtdVmDnvoI/jWrzzLqTmXRX
         k6BqzSTIgWANg+a6m9IftdfJKx1+XEFefhEbl5W7wJymthPR/VTaKBeJN5jWBmu9wxpQ
         Bh57igFrl0pKdhXi5TCEYTUOOtYjHy5uYSm063Yh1OMyB+CWI/IFMw/5K5fZHVk6Opls
         1zDvMPuVohgvv0Ja4jFhaG6UIR+qi5rG6yqxL1BvmOuEBTqfNIhfnIrXvffR6YsOHMIZ
         lkSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:references:to:cc:from
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=2Ro+YhYCgLdkkVvf8gJKCyfj8mMLYi1pQy4uXORtAYg=;
        b=F8l4t1Hi/1cK4WU2I08kqIM/aOT1woU/NXC0/X5eW/wDLi27Bsqhfq8R/35yNRqvBz
         uj056/Dd4+Pz4epFUR3vtlvTuNmmYKKcG7ZJb+Ozaj3dU6/89rKKh5V3r9CanF3jUPij
         xJLvXR1EzA2+PyRCYgK68KEgK8Qj/Gz6l+UjNPaj8troHMN5M/NNBUfw60tBtpndrraC
         netWpJ6fSn3dG52gUkr1fX5Qhcz+5eCs7nXodxo6b7T19kLE733fjiIshOKPDKEqW3zw
         8GdtWCY9Otz/CI1AjLSg+g0buYm8/SlpjTt/fmYJPxJGeLuOPGils/ejUIJPeOymPqLV
         LJCw==
X-Gm-Message-State: APzg51Dfp9l3cW9UkH9jXJQt1XHXd6LR+frktaPWhc0l5kngfT05x610
        Yy0rRiFDXPxDYUqjg8p2Cam1m89T1cs=
X-Google-Smtp-Source: ANB0VdY3ap5X13baBkKxmh17NadkZYLxMR2JuJwvZzU1A2c86vsx1AfkaRXW2Bl6mRq4TmZtUTNSBw==
X-Received: by 2002:a1c:b709:: with SMTP id h9-v6mr2089118wmf.130.1535644155297;
        Thu, 30 Aug 2018 08:49:15 -0700 (PDT)
Received: from ?IPv6:2a01:e35:8b63:dc30:b857:a345:7022:7458? ([2a01:e35:8b63:dc30:b857:a345:7022:7458])
        by smtp.gmail.com with ESMTPSA id w10-v6sm5603707wrp.31.2018.08.30.08.49.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 08:49:14 -0700 (PDT)
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next 0/5] rtnetlink: add IFA_IF_NETNSID for
 RTM_GETADDR
References: <20180828231859.29758-1-christian@brauner.io>
 <adc2fae5-e22b-3a74-d531-01570e7970ee@virtuozzo.com>
 <20180829181303.4sacopk7y3p5xyou@gmail.com>
 <81379a4f-7149-10ff-2453-886314d0b0c4@virtuozzo.com>
 <20180830144544.tpross4jd6awou4u@gmail.com>
To:     Christian Brauner <christian.brauner@canonical.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, dsahern@gmail.com, fw@strlen.de,
        lucien.xin@gmail.com, jakub.kicinski@netronome.com,
        jbenc@redhat.com
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
Message-ID: <ba6a1b18-959e-e307-45fa-e0da9d6f0b0f@6wind.com>
Date:   Thu, 30 Aug 2018 17:49:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180830144544.tpross4jd6awou4u@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 30/08/2018 à 16:45, Christian Brauner a écrit :
[snip]
> Introducing the IFA_IF_NETNSID property will not make the netlink
> interface less modular. It is a clean, RTM_*ADDR-request specific
> property using network namespace identifiers which we discussed in prior
> patches are the way to go forward.
> 
> You can already get interfaces via GETLINK from another network
> namespaces than the one you reside in (Which we enabled just a few
> months back.) but you can't do the same for GETADDR. Those two are
> almost always used together. When you want to get the links you usually
> also want to get the addresses associated with it right after.
> In a prior discussion we agreed that network namespace identifiers are
> the way to go forward but that any other propery, i.e. PIDs and fds
> should never be ported into other parts of the codebase and that is
> indeed something I agree with.
Yes, I agree with this and I think this series go to the right direction.

Maybe I would choose a more generic name for the attribute, something that can
be used in other netlink families (xfrm, netfilter, ...) also.
What about IFA_TARGET_NSID?
