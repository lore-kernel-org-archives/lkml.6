Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B96C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6903320834
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BEvh9F2M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6903320834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbeLEAFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 19:05:00 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45127 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbeLEAE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 19:04:58 -0500
Received: by mail-lf1-f66.google.com with SMTP id b20so13335274lfa.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 16:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cBIEbzdPwj/PWj1m/TZNCt6/GC5QZUcL3LSR3psjZDk=;
        b=BEvh9F2MHUtRFybiyeXYtFJB2IQhVcBAtds/H+Fp4r66KmRqLglmqHTdnGLHQAIMbQ
         vRM0jPbqEqAEtjBU49n4IeYjfln7e/8Fosq3wF2HtH7uB2B9+xKQrwREZm0FHiqPMuuY
         Ozf495P81G/uNUDEDUI/JEtkVCsWH1yJJJkAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=cBIEbzdPwj/PWj1m/TZNCt6/GC5QZUcL3LSR3psjZDk=;
        b=rbkDn9ACioFwfdtj6VoJdysglEjzR/uPGd7IyAzJvy5OVisc3I32gfQMYtgUMKNKBb
         SHgabT4Bh9T6p5kLdsMMKafRxql4sFW9tmyInw61w4NGkmLcrFmZgtS/iGnd0Cggekai
         qVCtMxxOD903FlRYXihYwVG5HMFY+bqANJeRYG20M1aw0L3bkZ5vaw0gCySCz/qh093J
         xyEFXNKfalQCBvWB1li6caLRocKAwVOJhrpVN1w/8hoFFOq1ZsRTC0EbykywHLCowJm+
         mt6dHGsesHgwGlOdWXwpzQ6jme1ibUuF0BvxvLF6RUyAwu3J87PQPC5pHzeF31Gc4aUD
         OmZQ==
X-Gm-Message-State: AA+aEWblEvFHMJt7ICzbnlCpV++mSnRNyx+yGZxOqI2Q50ITXhW5LIE/
        LauvLHc2iZ/xzrafSIxY/Zd7jA==
X-Google-Smtp-Source: AFSGD/VrMUFWiJKOgsGHSmBEGks+0evedfSzaOI12kXzSlo59uhgte80uFqKdx3PUW69+sfeTpe3qA==
X-Received: by 2002:ac2:4215:: with SMTP id y21mr10197962lfh.6.1543968294310;
        Tue, 04 Dec 2018 16:04:54 -0800 (PST)
Received: from khorivan (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id y131sm3163552lfc.43.2018.12.04.16.04.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 16:04:53 -0800 (PST)
Date:   Wed, 5 Dec 2018 02:04:51 +0200
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     davem@davemloft.net, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiri@mellanox.com, andrew@lunn.ch
Subject: Re: [RFC PATCH net-next 2/5] net: 8021q: vlan_dev: add vid tag for
 uc and mc address lists
Message-ID: <20181205000450.GB3507@khorivan>
Mail-Followup-To: Florian Fainelli <f.fainelli@gmail.com>,
        davem@davemloft.net, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiri@mellanox.com, andrew@lunn.ch
References: <20181203184023.3430-1-ivan.khoronzhuk@linaro.org>
 <20181203184023.3430-3-ivan.khoronzhuk@linaro.org>
 <b2a7baa7-b334-0f6f-c119-a2f30ac68c7b@gmail.com>
 <20181203235119.GF23230@khorivan>
 <35479973-2d2d-d673-f7ab-54d6369ce3d1@gmail.com>
 <20181204185720.GI23230@khorivan>
 <756cbb25-3062-91e8-0613-66bb887f937e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <756cbb25-3062-91e8-0613-66bb887f937e@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 11:49:27AM -0800, Florian Fainelli wrote:

...

>>
>> I was thinking also about pinned list of vlans to the address, but in
>> this case this information also has to be synced by members of device
>> chain,
>> because it can be modified on any device level and it looks not very
>> friendly,
>> and at the end address space has addresses with pinned lists of vlans with
>> their pointers. But keeping this stuff in sync is not simplest decision.
>>
>>
>
>I really think we are not communicating properly, it really seems to me
>that if you had the information about the upper device trying to add an
>address to the lower device filter's either through notification or call
>to ndo_set_rxmode, you could be solving your problems. What are we
>missing here?

Sry, missed this one. The problem in getting  the owner of address.
Just simple case: vlan/macvlan/real_dev or vlan/.../.../real_dev

The real dev hasn't simple way to get vid the address belong to, or it has?



>--
>Florian

-- 
Regards,
Ivan Khoronzhuk
