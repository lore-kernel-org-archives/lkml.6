Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D7FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 04:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C90021904
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 04:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLyTiz/6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395510AbfBNEtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 23:49:46 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35184 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732575AbfBNEtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 23:49:45 -0500
Received: by mail-ot1-f68.google.com with SMTP id z19so8469573otm.2;
        Wed, 13 Feb 2019 20:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:in-reply-to:references:mime-version:content-transfer-encoding
         :autocrypt:subject:to:from:message-id;
        bh=3MXJRVFCf7olgk+KnKgnTVrU930Tj2aU59kPRI1VLnk=;
        b=kLyTiz/6b0tfbNSUSvoXN70gEwfNnILmZ0puU8rdx6jbrpzijl1Ln5J5bfHXUgFu/B
         0dksccZYwFFE5UYBKv4e5AsNEAfdGucJTCUYUatbxmce8pVwb5Zt1RURx/p7pc5s8PJd
         9xNg5pdtkHZ7DddKs5PfjPNeAOep+QKsYRxEioVUVEGFkriJ35WLqKPwz4m9ax7SWuKr
         3FEmpXtT5lQkv1tkiqhLqZmtoXKcx+Du214udWYAQC7eFIg1esPKD6Srj1hSmg6p08u6
         8pxeGb7dhpnH5iwcGLWOQE9xWxKCCo61SXVEpx6Ck1/1ZrLY5kswSM2hBShVcAJl6yts
         6XrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:references:mime-version
         :content-transfer-encoding:autocrypt:subject:to:from:message-id;
        bh=3MXJRVFCf7olgk+KnKgnTVrU930Tj2aU59kPRI1VLnk=;
        b=LqereGX847XZsEkUIzCYFxppqu8J58v4sgv3S4n0/XohDd3ndWJ/9/5c7jOgKoem+U
         7UvErz3ZpvayKpJ9/GkLmpRKNZ+uUqK2sdatqUGHhAb+gGclWXUKgvoE2OzrbeM7RYr5
         BRCRB+nqZ+CEkfi4rykSxUe/PBeMoFjIVzyUZln1wEw4rnJph/P2BPpCLR08JF0iX2pS
         fMpfPxMEIFxld4JRDyBlT0UIGi5Sk6hhX4N56F/bZAqcVw/wcgRJhMFiObo+GCSMS7eY
         A4zmlTJGFRlM2cX5f7Iop24Ts7MKaH2KoIrtA6yEMe3nzuxe6gAW5/GSrGsu5lwujZxb
         2D0A==
X-Gm-Message-State: AHQUAuZTAALQ+Jka3PTLD/k2EeXxEX6hW+xwEY3DVU1ykuhdEJ0tQX+p
        QmegZBijk9oByGdO4wFm05o=
X-Google-Smtp-Source: AHgI3IYgzSM0Dr/A9+ULPn/PmJ6viPfVV03hXTDA4NFVb08mH/tQsr9WHobg25Rxu/nydvldTEIGOw==
X-Received: by 2002:aca:4341:: with SMTP id q62mr1108180oia.2.1550119783898;
        Wed, 13 Feb 2019 20:49:43 -0800 (PST)
Received: from localhost (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id s66sm722320otb.65.2019.02.13.20.49.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 20:49:42 -0800 (PST)
Date:   Wed, 13 Feb 2019 20:49:39 -0800
In-Reply-To: <20190213161715.GA32249@khorivan>
References: <20181203184023.3430-1-ivan.khoronzhuk@linaro.org> <20181203184023.3430-3-ivan.khoronzhuk@linaro.org> <b2a7baa7-b334-0f6f-c119-a2f30ac68c7b@gmail.com> <20181203235119.GF23230@khorivan> <35479973-2d2d-d673-f7ab-54d6369ce3d1@gmail.com> <20181204185720.GI23230@khorivan> <756cbb25-3062-91e8-0613-66bb887f937e@gmail.com> <20181204234236.GA3507@khorivan> <4cf42ef9-7136-15ff-1244-1d946acd07ae@gmail.com> <20190122131239.GC3125@khorivan> <20190213161715.GA32249@khorivan>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
Subject: Re: [RFC PATCH net-next 2/5] net: 8021q: vlan_dev: add vid tag for uc and mc address lists
To:     Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, davem@davemloft.net,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiri@mellanox.com, andrew@lunn.ch
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <BF485558-C29E-4F25-84B5-4C6C80BDF337@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On February 13, 2019 8:17:16 AM PST, Ivan Khoronzhuk <ivan=2Ekhoronzhuk@li=
naro=2Eorg> wrote:
>On Tue, Jan 22, 2019 at 03:12:41PM +0200, Ivan Khoronzhuk wrote:
>>On Mon, Jan 21, 2019 at 03:37:41PM -0800, Florian Fainelli wrote:
>>>On 12/4/18 3:42 PM, Ivan Khoronzhuk wrote:
>>>>On Tue, Dec 04, 2018 at 11:49:27AM -0800, Florian Fainelli wrote:
>>
>>[=2E=2E=2E]
>>
>>>
>>>Ivan, based on the recent submission I copied you on [1], it sounds
>like
>>>we want to move ahead with your proposal to extend netdev_hw_addr
>with a
>>>vid member=2E
>>>
>>>On second thought, your approach is good and if we enclose the vid
>>>member within an #if IS_ENABLED(CONFIG_VLAN)8021Q) we should be good
>for
>>>most foreseeable use cases, if not, we can always introduce a
>variable
>>>size/defined context in the future=2E
>>>
>>>Can you resubmit this patch series as non-RFC in the next few days so
>I
>>>can also repost mine [1] and take advantage of these changes for
>>>multicast over VLAN when VLAN filtering is globally enabled on the
>device=2E
>>>
>>>[1]: https://www=2Espinics=2Enet/lists/netdev/msg544722=2Ehtml
>>>
>>>Thanks!
>>
>>Yes, sure=2E I can start to do that in several days=2E
>>Just a little busy right now=2E
>>
>>Just before doing this, maybe some comments could be added as it has
>more
>>attention now=2E Meanwhile I can send alternative variant but based on
>>real dev splitting addresses between vlans=2E In this approach it leaves
>address
>>space w/o vid extension but requires more changes to vlan core=2E
>Drawback here
>>that to change one address alg traverses all related vlan addresses,
>it can be
>>cpu/time wasteful, if it's done regularly, but saves memory=2E=2E=2E=2E
>>
>>Basically it's implemented locally in cpsw and requires more changes
>to move
>>it as some vlan core auxiliary functions to be reused=2E But it can work
>only
>>with vlans directly on top of real dev, which is fixable=2E
>>
>>Core function here:
>>__hw_addr_ref_sync_dev
>>it is called only for address the link of which was
>increased/decreased, thus
>>update made only on one address, comparing it for every vlan dev=2E
>>
>>It was added with this patch:
>>[1] net: core: dev_addr_lists: add auxiliary func to handle reference=20
>>address update e7946760de5852f32
>>
>>And used by this patch:
>>[2] net: ethernet: ti: cpsw: fix vlan mcast 15180eca569bfe1d4d
>>
>>So, idea is to move [2] to be vlan core auxiliary function to be
>reused
>>by NIC drivers=2E
>>
>>But potentially it can bring a little more changes I assume:
>>
>>1) add priv_flag |=3D IFF_IV_FLT (independent vlan filtering)=2E It allo=
ws
>to reuse
>>this flag for farther changes, probably for per vlan allmulti or so=2E
>>
>>2) real dev has to have complete list for vlans, not only their vids,
>but also
>>all vlandevs in device chain above it=2E So changes in add_vid can be
>required=2E
>>Vlan core can assign vlan dev pointer to real device only after it's
>completely
>>initialized=2E And for propagation reasons it requires every device in
>>infrastructure to be aware=2E That seems doable, but depends not only on
>me=2E
>>
>>3) Move code from [2] to be auxiliary vlan core API for setting mc and
>uc=2E
>>From this patch only one function is cpsw specific: cpsw_set_mc()=2E The
>rest can
>>be applicable on every NIC supporting IFF_IV_FLT=2E
>>
>>4) Move code from link below to do the same but for uc addresses:
>>https://git=2Elinaro=2Eorg/people/ivan=2Ekhoronzhuk/tsn_kernel=2Egit/com=
mit/?h=3Ducast_vlan_fix&id=3Debc88a7d8758759322d9ff88f25f8bac51ce7219
>>here only one func cpsw specific: cpsw_set_uc()
>>the rest can be generic=2E
>>
>>As third alternative, we can think about how to reduce memory for
>addresses by
>>reusing them or else, but this is as continuation of addr+vid
>approach, and API
>>probably would be the same=2E
>>
>>Then all this can be compared for proper decision=2E
>
>
>Hi Florian,
>
>After several more investigations and tries probably better left this
>idea as is=2E

Thank you for keeping the thread alive, does that mean you are going to re=
submit this patch series as-is (rebased) or are you saying that you are aba=
ndoning the idea and leaving the situation the way it is in cpsw?

>
>Here actually several explanations for this:
>1) If even assume that we can get access to vlan devices in the above
>ndev
>tree (we can) that doesn't guarantee that receive vlan filters are set
>replicating this structure=2E For example bond device can have one active
>slave
>but both of them in the tree having vid set, in this case addresses are
>syched only with active slave, no filters should be applied to not
>active slave=2E
>this can be achieved only each address has vid context=2E
>
>2) According to 1) rx filters device structure can be created while
>mc_sync()
>in each rx_mode(), and then used as orthogonal info=2E I've tried and it
>looks
>not cool and consumes anyway memory and even if it's less it's still
>not very
>scalable=2E (+ no normal signal "in complex structure case" when address
>should
>be undated to avoid redundant cpu cycles)=2E Not sure it can have
>practical
>results and be universal enouph=2E
>
>3) Assuming that every device in the tree (bond, team or else) is legal
>to
>modify its own address space, the real end device cannot be sure the
>vlan device
>address spaces reflects vid addresses that device tree want's from him=2E
>According to this each address in address space must hold its own
>context at
>every device and this context is comparable with address size=2E
>
>>-- Regards,
>>Ivan Khoronzhuk

--=20
Florian
