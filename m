Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,GUARANTEED_100_PERCENT,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD3EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4637B214E0
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtqwvxBu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4637B214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388412AbeKVGcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 01:32:51 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33810 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730802AbeKVGct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 01:32:49 -0500
Received: by mail-wm1-f66.google.com with SMTP id y185so3997299wmd.1;
        Wed, 21 Nov 2018 11:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RQu/3IDncq5ppy9Y0GhWjh+ss5iJZUJwyqWllxzZi0o=;
        b=EtqwvxBuLasXJNtbRkj0TZlUN4oWiJ9d9wdIHAikycEWphFTLnwlrMtVuT2wB4CIRO
         NkaWxi1Md4AmzIAOqQ3pY6hn02JxUMMmyhQQW7nPUt41rSQ/PozQpe0eBtuWB4Pup6MI
         wf+VjeIU3xXCwbTSpvuqKFgTOHYKOi8cxkdwHUElggOebsvY+5IjXPGiWewglaYuusnV
         l6YXMlQ8a2+NN72ouA25Nmntl1v1nvdCygzbp+USldF2tEFWhYSiUC8rapAi4jp2mGYk
         D3MrN1U4rjeefbJ303o1zadcMx3zG77Vs4AdedBa+Rmxm1JefC8zdoENxJraO+52afRY
         KhoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RQu/3IDncq5ppy9Y0GhWjh+ss5iJZUJwyqWllxzZi0o=;
        b=D2mwbHkwl1lDskTtVDETFGDPaXww2CEhJzOZU/AsuKILw7LN9FrObMthqPO5G7lUGr
         tZQHrdFtDKDVMjNYKrLpF5C10ceg6wKa4Eqtk9qiqv++XtgSawxlngNtXKzFeraVpbFd
         up2W9Rg8DhTv7l6CfIIuVS88whDAOxxZpZRLWolf5Oec85FkTvJUcyAuALbqJCdFaucx
         a4MXNf5SOtASV7lG61pRd9uL5p5+21CQoxzDQOLF6awqelyP24GNQxHV8JvDp7WZYmBu
         g11t3Mvtc49G9jR3zj8z+sYs0x6Zu6Oku4Lk3Hw6p0tt8RfbucI/1uS0crw1ymmHJi/S
         gvKw==
X-Gm-Message-State: AA+aEWbJ6FLdjtIG1oVJStUd2khRDWYS1k6ejMHm49ms/N5tkUc1jsxJ
        UmgcA7ANogK27kqzlZqTCQw=
X-Google-Smtp-Source: AFSGD/VF/c6ccbLff5SnTziEGarHp21LGnovMnb4yVCBLBM5R9KwF86R8BN5I84BEbF4NMstl+bFEA==
X-Received: by 2002:a1c:8b42:: with SMTP id n63mr6604385wmd.38.1542830225977;
        Wed, 21 Nov 2018 11:57:05 -0800 (PST)
Received: from ?IPv6:2003:ea:8bcf:e300:14d:188e:adb0:9ba6? (p200300EA8BCFE300014D188EADB09BA6.dip0.t-ipconnect.de. [2003:ea:8bcf:e300:14d:188e:adb0:9ba6])
        by smtp.googlemail.com with ESMTPSA id z8sm29498342wrr.52.2018.11.21.11.57.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 11:57:05 -0800 (PST)
Subject: Re: Issue with RTL8111 NIC after upgrade to kernel 4.19
To:     Norbert Jurkeit <norbert.jurkeit@web.de>, nic_swsd@realtek.com,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael.wiktowy@gmail.com,
        jcline@redhat.com, marc.c.dionne@gmail.com
References: <d0a53002-bf14-6cd9-ab0f-5d3f9aa395ce@web.de>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <38dad61b-bc7f-7038-6d1b-f5c4afe3841c@gmail.com>
Date:   Wed, 21 Nov 2018 20:57:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <d0a53002-bf14-6cd9-ab0f-5d3f9aa395ce@web.de>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.11.2018 11:51, Norbert Jurkeit wrote:
> Dear Linux developers,
> 
> after upgrade from distro kernel 4.18.18 to 4.19.2 some Fedora users (including me) encounter issues with RTL8111 based Ethernet interfaces. The interface is not started correctly after boot with kernel 4.19.2 (i.e. is reported by ifconfig as up, but not running, the LEDs besides the connector stay off and no data is transferred).
> 
> At least for me the issue seems to occur only after reboot from a previous session with kernel 4.18.18, but not after power-on, which means the hardware is not fully initialized by the new r8169 driver. Marc Dionne, another affected Fedora user, thinks that module "realtek" needs to be loaded, which does not happen automatically. Please see https://bugzilla.redhat.com/show_bug.cgi?id=1650984 for more details.
> 

Thanks for reporting the issue. I can't reproduce the error on my
system and obviously it affects only some users, so it seems to be
chip-version- or system-dependent. Having to load the realtek PHY
driver module manually is weird as this should be done by
request_module() in phy_device_create().

request_module() is supposed to be synchronous, however after some
reading this may not be 100% guaranteed. Maybe the module init
function on some systems isn't finished yet when request_module()
returns. As a result the genphy driver may be used instead of
the PHY version-specific driver.

That the issue occurs after the switch to 4.19 isn't a big surprise
because with this version the r8169 driver switched to phylib.

First I'd like to get an overview of the affected systems. I'll
comment in the linked bug ticket to address the affected users.


> As Fedora kernel maintainers usually don't apply many changes to the upstream kernel, users of other distros will likely be affected as well. We therefore kindly ask you to investigate the issue and fix it in future upstream kernels.
> 
> Many thanks and best regards,
> 
> Norbert Jurkeit
> 
> 
Heiner
