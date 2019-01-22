Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1056FC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB15E20870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q6sN8vzn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbfAVNMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 08:12:47 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42356 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728343AbfAVNMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 08:12:46 -0500
Received: by mail-lj1-f196.google.com with SMTP id l15-v6so20530103lja.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 05:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LJUqJHcsbGiWE7HhG0CtXhAlnDNl7v53BBGEM/ayzlY=;
        b=Q6sN8vzn3bJdcwY/5RQ/YzDUxU+AsC2DiDOvEAO0hLBO11OVgrtXpY6RZgYYB6idAy
         C56mfeensrwPDfNJ3lZBPm+eS6Tf/EDGqfjZzPcCo3Et9vAwuG/8Ps46FqhBA0y+JRoj
         um9XA7eXajelJlazS6Dhss04aC8ZW+mL2kCCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=LJUqJHcsbGiWE7HhG0CtXhAlnDNl7v53BBGEM/ayzlY=;
        b=duAuv/mO2lhnsTGZzdcg/9zHsJSMzJ9d3uD1vmtZrJRVy4pMaR7IqWEf/NF6H4sQ8m
         pTl12XibrqaKI1OQVj8CROrkHeOct5zsk0/Pb0MwqrrHIS+4dR2MqJMZGqb2HhvXPUEN
         0qtJAuW8u570+0vjXXnekJmyWO4amJNQ2RWB2dxBgzs6aSTu8flUwNETRGL3OtWb6IFR
         CqjgXUTuDHGlz55vPJQG0A9DlPwVBdNI8fjAFHAA00QB3mFmXt9eUBmnw9EDJJNS3lvA
         O0eFA6LRG/YUODgqJzaJFAIIziEHS2jt5ZIDTsepwLYzOXLtZg0ffp7Db/o7FKyucLvL
         r83g==
X-Gm-Message-State: AJcUukdPUv4F+CyuHU0lV5Nb9ppRFT+n4k8Un12YTYfynUP0PoaOc8Nl
        ekH+0UAJiBEThlgAUlA+n7Oing==
X-Google-Smtp-Source: ALg8bN57aky61UWRYBSJqXcjbKwMR4ebGc3vWsdJ8kcs4C0qbjjz2mRXu8hn7T519S8jPDfqXgplcQ==
X-Received: by 2002:a2e:1241:: with SMTP id t62-v6mr18396662lje.171.1548162763729;
        Tue, 22 Jan 2019 05:12:43 -0800 (PST)
Received: from khorivan (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id q10-v6sm3023739ljh.72.2019.01.22.05.12.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 05:12:43 -0800 (PST)
Date:   Tue, 22 Jan 2019 15:12:41 +0200
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     davem@davemloft.net, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiri@mellanox.com, andrew@lunn.ch
Subject: Re: [RFC PATCH net-next 2/5] net: 8021q: vlan_dev: add vid tag for
 uc and mc address lists
Message-ID: <20190122131239.GC3125@khorivan>
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
 <20181204234236.GA3507@khorivan>
 <4cf42ef9-7136-15ff-1244-1d946acd07ae@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <4cf42ef9-7136-15ff-1244-1d946acd07ae@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 03:37:41PM -0800, Florian Fainelli wrote:
>On 12/4/18 3:42 PM, Ivan Khoronzhuk wrote:
>> On Tue, Dec 04, 2018 at 11:49:27AM -0800, Florian Fainelli wrote:

[...]

>
>Ivan, based on the recent submission I copied you on [1], it sounds like
>we want to move ahead with your proposal to extend netdev_hw_addr with a
>vid member.
>
>On second thought, your approach is good and if we enclose the vid
>member within an #if IS_ENABLED(CONFIG_VLAN)8021Q) we should be good for
>most foreseeable use cases, if not, we can always introduce a variable
>size/defined context in the future.
>
>Can you resubmit this patch series as non-RFC in the next few days so I
>can also repost mine [1] and take advantage of these changes for
>multicast over VLAN when VLAN filtering is globally enabled on the device.
>
>[1]: https://www.spinics.net/lists/netdev/msg544722.html
>
>Thanks!

Yes, sure. I can start to do that in several days.
Just a little busy right now.

Just before doing this, maybe some comments could be added as it has more
attention now. Meanwhile I can send alternative variant but based on
real dev splitting addresses between vlans. In this approach it leaves address
space w/o vid extension but requires more changes to vlan core. Drawback here
that to change one address alg traverses all related vlan addresses, it can be
cpu/time wasteful, if it's done regularly, but saves memory....

Basically it's implemented locally in cpsw and requires more changes to move
it as some vlan core auxiliary functions to be reused. But it can work only
with vlans directly on top of real dev, which is fixable.

Core function here:
__hw_addr_ref_sync_dev
it is called only for address the link of which was increased/decreased, thus
update made only on one address, comparing it for every vlan dev.

It was added with this patch:
[1] net: core: dev_addr_lists: add auxiliary func to handle reference address 
update e7946760de5852f32

And used by this patch:
[2] net: ethernet: ti: cpsw: fix vlan mcast 15180eca569bfe1d4d

So, idea is to move [2] to be vlan core auxiliary function to be reused
by NIC drivers.

But potentially it can bring a little more changes I assume:

1) add priv_flag |= IFF_IV_FLT (independent vlan filtering). It allows to reuse
this flag for farther changes, probably for per vlan allmulti or so.

2) real dev has to have complete list for vlans, not only their vids, but also
all vlandevs in device chain above it. So changes in add_vid can be required.
Vlan core can assign vlan dev pointer to real device only after it's completely
initialized. And for propagation reasons it requires every device in
infrastructure to be aware. That seems doable, but depends not only on me.

3) Move code from [2] to be auxiliary vlan core API for setting mc and uc.
From this patch only one function is cpsw specific: cpsw_set_mc(). The rest can
be applicable on every NIC supporting IFF_IV_FLT.

4) Move code from link below to do the same but for uc addresses:
https://git.linaro.org/people/ivan.khoronzhuk/tsn_kernel.git/commit/?h=ucast_vlan_fix&id=ebc88a7d8758759322d9ff88f25f8bac51ce7219
here only one func cpsw specific: cpsw_set_uc()
the rest can be generic.

As third alternative, we can think about how to reduce memory for addresses by
reusing them or else, but this is as continuation of addr+vid approach, and API
probably would be the same.

Then all this can be compared for proper decision.

>-- 
>Florian

-- 
Regards,
Ivan Khoronzhuk
