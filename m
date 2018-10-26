Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01AB7ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 20:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5A90207DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 20:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLjZDXmt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5A90207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbeJ0FAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 01:00:17 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39577 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727636AbeJ0FAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 01:00:17 -0400
Received: by mail-wm1-f67.google.com with SMTP id y144-v6so2535373wmd.4;
        Fri, 26 Oct 2018 13:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7GCJWMCBji8YwOd3rDPsOh2yDzMWJQYrZ1d3QdRERU4=;
        b=aLjZDXmtarMtRNWeZuxm52m3YPJ0s7y6SL9L0Fel4ardPZ3NfnSJ3dUcgrmkXwvYQE
         PZwxGtolPjU6iOpwf/0Unb0apGoFbobU3dgl2BJDUH/ICP3ksXAnPN8ZmVFJrISUfpNY
         rn+e23qZSMkUsS24uEbmvEmjUq2xAeNSrGorQUHEHAPZBhs4GsWprsdFpCIeVCQa+/1+
         5AmWXFKd5ZNBxLeDN1QIBAflZ2oe8YRozgNrXVFoOJXKa1+qtVZw7keXMlPq/mBawik7
         UG4nr7ATYnWsmBBbZ1dT9nsZcvyJ/uyScqWSaaQyzwQ3WlbvBFaGJ2UnlQ3JqG2KpXc+
         v+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7GCJWMCBji8YwOd3rDPsOh2yDzMWJQYrZ1d3QdRERU4=;
        b=dQ0pIzFmDfueEdBnvT5GVi7YcQ0VQ+eCuKSZOU3LQBl1sqMbFYwYTT4//KB4biciGH
         vBaPQIrhjZ3H7OwGh1BlOUTXr2IMk0/EMBRAOOdy6xtH7KG3B/SNTNaiWd6bS4q8qJZn
         ynggLYotPOMTMM67TbZmsWPg1GpaUM0xVwaC/h/d/zGYqvKDkvnajZGG47kcvLdTSC5s
         ErhJp5SpoZl3itq0Q4bHCQxtowN4a4103yRQEB50EpKxLXluCj2eKCLZ82svp+qHAQLT
         rppB+gL4xaQjYAasmpFa/RyCk7GcvLszu+RDZ7cXlunNL4gprXSybDWsH4cSX0Vq5fth
         Dstg==
X-Gm-Message-State: AGRZ1gJGiBxRa7wIefeVGl4WNHMtNS+IxeK3nswxTRClgr6BAriD+jll
        9il0FjXCA0G5jA/65jrxasuxWIyK
X-Google-Smtp-Source: AJdET5cQCU0Iw9UAJx9nqj8b0RSG4APg3bDO1p89PtMuw2G6p/8YgFJoG0bFyn7RTYWedvz267I9Cw==
X-Received: by 2002:a1c:bce:: with SMTP id 197-v6mr6307171wml.15.1540585310285;
        Fri, 26 Oct 2018 13:21:50 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:3f00:808d:9bd7:b50:2001? (p200300EA8BD43F00808D9BD70B502001.dip0.t-ipconnect.de. [2003:ea:8bd4:3f00:808d:9bd7:b50:2001])
        by smtp.googlemail.com with ESMTPSA id o13-v6sm8266854wrw.93.2018.10.26.13.21.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 13:21:49 -0700 (PDT)
Subject: Re: CAKE and r8169 cause panic on upload in v4.19
To:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@toke.dk>
Cc:     Dave Taht <dave.taht@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <61d09f0db41f269cc9ee13dd68a5c285@natalenko.name>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <fbd7f0b8-10c8-be17-fce6-327a95d8ea2e@gmail.com>
Date:   Fri, 26 Oct 2018 22:21:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <61d09f0db41f269cc9ee13dd68a5c285@natalenko.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.10.2018 21:26, Oleksandr Natalenko wrote:
> Hello.
> 
> I was excited regarding the fact that v4.19 introduced CAKE, so I've deployed it on my home router.
> 
> I used this script of mine [1]:
> 
> # bufferbloat enp3s0.100 20 20
> 
> to do its job on the VLAN interface, where 20/20 ISP link is switched from the home switch. Basically, it just follows [2] with simple bandwidth restriction and egress mirroring using ifb.
> 
> Then I thought it would be nice to run speedtest-cli on one of the computer in the home LAN, connected to this router. Download stage went fine, but immediately after upload started I've got a panic on the router: [3] (sorry, it is a photo, netconsole didn't work because, I assume, the panic happened in the networking code). I rebooted the router and tried once more, and got the same result, again during upload stage. Then I rebooted again, replaced CAKE script with my former HTB script, and after running speedtest-cli a couple of times there's no panic.
> 
> Before running speedtest-cli I was using CAKE for a couple of days without generating much traffic just fine. It seems it crashes only if lots of traffic is generated with tools like this.
> 
> My sysctl: [4] and ethtool -k: [5]
> 
> So far, I've found something similar only here: [6] [7]. The common thing is r8169 driver in use, so, maybe, it is a driver issue, and CAKE is just happy to reveal it.
> 
> If it is something known, please point me to a possible fix. If it is something new, I'm open to provide more info on your request, try patches etc (as usual).
> 
It seems to be the same problem as described here: https://bugzilla.kernel.org/show_bug.cgi?id=201063
As I commented in bugzilla, the GPF in dev_hard_start_xmit and the values of R12/R15 make me think
that a poisoned list pointer is accessed. It's so deep in the network stack that I can not really
imagine the network driver is to blame. One screenshot attached to the bug report shows that the
GPF also happened with the igb driver. Most likely we find out only once somebody spends effort
on bisecting the issue.
d4546c2509b1 ("net: Convert GRO SKB handling to list_head.") and some subsequent changes deal with
skb list processing, maybe the issue is related to one of these changes.

> Thanks.
> 
