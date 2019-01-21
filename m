Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E70AC37122
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 23:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50DD42089F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 23:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAnz5rFD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfAUXh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 18:37:56 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43462 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfAUXh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 18:37:56 -0500
Received: by mail-pl1-f194.google.com with SMTP id gn14so10489478plb.10;
        Mon, 21 Jan 2019 15:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3LWy51croUi92FtI2HdM6nJl8UOb1fKH94Ef5q0Q+bs=;
        b=iAnz5rFDYrSkDK0yEp+6zae9zUPJkCkAzZqCUOTSAyaf9qVjFLxo15rypOOl2Ocant
         G1PoZ7ii8W0PGt9jeZhk2H/4j0SYUVzfg3d6xvgGCjjq6s5MqhDGdDFG3woG5qrphTqq
         FDo6imnq9027pLHjOfvOOUWftglM7TSf7uUXtjuLSYW91TFxYx+eyr0WVs9QRdP0FJiY
         yQ+b+CyBUJReHQm2XmaqIdLTQIo+WLVlUHewKNFf9SOYYwXLM5mShPUiN3Gke2pSnDXW
         7fBrfPuFSK/XOFsCZrwBRIOpr0jFsSwKynyfp6itw4C7uKHWcsYI1XuprfyT+5wKhVoy
         u7Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=3LWy51croUi92FtI2HdM6nJl8UOb1fKH94Ef5q0Q+bs=;
        b=UMHLDZxtLO12w/Nhl3QpW7fpY6FaKAAOaZsRfj3r9dNkRFmSXN6LlXna9ZO8Thys7g
         Sf2zUKEUCLjIGpxJE/jrjEtSjwkCbq2CXLzd7hYATaDCeK9hV18nfqeHhZ8/46MXdyYO
         +E+23KxmXL3jGxiKh+pDnmOChQ6KAyP93xXHimMp7d4XF+rDjmymjz9iIz8huPv7yXjJ
         COSQxOyj6snbtzIhdRDWOpOwZ8XYpc0sCNBpUB6vuGHBMuQD6jqxSMF/fWYQ2X0kVLWG
         QPkcMMHb0/T733aF//LU8mNst6EooD/KGzw13qIbhUlT/W0XgereBotixLS2M32HJCk8
         uqcw==
X-Gm-Message-State: AJcUukeUm68gMosCaFkndqNDKJiyuNY5/2g4hqXDCQ/iU/kKdMPE6bn3
        SNkSJYn4u+imeSoEKI2ilcc=
X-Google-Smtp-Source: ALg8bN46alTZqibxk0OeySVLROUY3s/F5ReVJWJ6Ef243T2m1nbzkthM9uG2OG38gKbp2tGocfgJvg==
X-Received: by 2002:a17:902:7044:: with SMTP id h4mr31723475plt.35.1548113874950;
        Mon, 21 Jan 2019 15:37:54 -0800 (PST)
Received: from [10.67.49.9] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id 84sm32179061pfa.115.2019.01.21.15.37.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 15:37:54 -0800 (PST)
Subject: Re: [RFC PATCH net-next 2/5] net: 8021q: vlan_dev: add vid tag for uc
 and mc address lists
To:     davem@davemloft.net, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiri@mellanox.com, andrew@lunn.ch, ivan.khoronzhuk@linaro.org
References: <20181203184023.3430-1-ivan.khoronzhuk@linaro.org>
 <20181203184023.3430-3-ivan.khoronzhuk@linaro.org>
 <b2a7baa7-b334-0f6f-c119-a2f30ac68c7b@gmail.com>
 <20181203235119.GF23230@khorivan>
 <35479973-2d2d-d673-f7ab-54d6369ce3d1@gmail.com>
 <20181204185720.GI23230@khorivan>
 <756cbb25-3062-91e8-0613-66bb887f937e@gmail.com>
 <20181204234236.GA3507@khorivan>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <4cf42ef9-7136-15ff-1244-1d946acd07ae@gmail.com>
Date:   Mon, 21 Jan 2019 15:37:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181204234236.GA3507@khorivan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/18 3:42 PM, Ivan Khoronzhuk wrote:
> On Tue, Dec 04, 2018 at 11:49:27AM -0800, Florian Fainelli wrote:
>> On 12/4/18 10:57 AM, Ivan Khoronzhuk wrote:
>>> On Mon, Dec 03, 2018 at 03:57:03PM -0800, Florian Fainelli wrote:
>>>> On 12/3/18 3:51 PM, Ivan Khoronzhuk wrote:
>>>>> On Mon, Dec 03, 2018 at 02:17:00PM -0800, Florian Fainelli wrote:
>>>>>> On 12/3/18 10:40 AM, Ivan Khoronzhuk wrote:
>>>>>>> Update vlan mc and uc addresses with VID tag while propagating
>>>>>>> address
>>>>>>> set to lower devices, do this only if address is not synched. It
>>>>>>> allows
>>>>>>> on end driver level to distinguish address belonging to vlans.
>>>>>>
>>>>>> Underlying driver for the real device would be able to properly
>>>>>> identify
>>>>>> that you are attempting to add an address to a virtual device, which
>>>>>> happens to be of VLAN kind so I am really not sure this is the right
>>>>>> approach here.
>>>>>>
>>>>>> From there, it seems to me that we have two situations:
>>>>>>
>>>>>> - each of your network devices expose VLAN devices directly on top of
>>>>>> the real device, in which case your driver should support
>>>>>> ndo_vlan_rx_add_vid and ndo_vlan_rx_kill_vid to know when VLAN
>>>>>> devices
>>>>>> are create and maintain a VLAN device to VID correspondence if it
>>>>>> needs
>>>>>> to when being called while setting the addresses
>>>>>>
>>>>>> - you are setting up a bridge that is VLAN aware on one of your
>>>>>> bridge
>>>>>> ports, and there you can use switchdev to learn about such events and
>>>>>> know about both addresses as well as VIDs that must be programmed
>>>>>> into
>>>>>> your real device
>>>>> No limits to have any "middle" device between real end device and
>>>>> virtual one, not only a bridge, but also other kind. And as it's
>>>>> generic
>>>>> change, it should cover all such cases, the simplest example is:
>>>>> real_dev/macvlan/vlan.
>>>>
>>>> It is not generic if the additional information is a VLAN ID, that
>>>> construct does not apply to all types of virtual devices, that is part
>>>> of my issue with the extra VID that is being added. If this was a
>>>> void *
>>>> priv and any virtual device could pass up/down information that
>>>> might be
>>>> more acceptable.
>>>
>>> You mean to create smth like common struct pinned to "an address" and
>>> pass information not only like vid, but in parallel what ever user
>>> wanted.
>>> Even if pass vlan device pointer it still considered like an address
>>> continuation and same sync method is used w/o modification. And here vid
>>> is considered as part of address, by a big account address+vid it's a
>>> separate address, same happens with the pointer, address+pointer it's
>>> still separate address.
>>
>> That depends on the HW implementation, some switches do individual VLAN
>> learning (IVL) and some do shared VLAN learning (SVL) so whether the VID
>> becomes part of the address resolution logic is HW dependent, obviously
>> the more capable, the better (IVL).
> 
> In my case IVL is only choice, as SVL is rather imitation, as each vlan
> has it's own address table anyway. And I mean not only vlan configuration
> above the bridge but also any simple configuration above real device.
> 
> There is proposition to add smth like additional list of entries pinned
> to the each address as you proposed, but in a little bit different way.
> 
> Pin the context pointers to each address if IVL config is enabled.
> Smth like
> 
> +struct ctx_entry {
> +       void *info;
> +       unsigned type;
> +       int synced;
> +       int sync_cnt;
> +       int refcount;
> +}
> 
> Then in hw_addr struct add a ctx_list:
> 
> struct netdev_hw_addr {
>        struct list_head        list;
> +       struct list_head        ctx_list;
>        unsigned char           addr[MAX_ADDR_LEN];
>        unsigned char           type;
> .....
> }
> 
> Each ctx_entry contains pointer to some structure, in my case it could be
> pointer on vlan net_dev, and it can be marked with type
> VLAN_DEVICE_POINTER or
> else. In some other invisible cases it could be another one. Main
> difference
> between each of them is its pointer and type.
> 
> And once each net dev calls mc/uc_sync these entires, if not synced, are
> synced
> along with addresses. But main difference that these ctx entires are
> pinned to
> the address, when addresses are pinned to the device.
> 
> It can allow to bring information any new abstraction can apply.
> For real device the list can be empty or contain special entry to differ
> it from the vlan device entries, as could happen only some vlan is address
> owner.
> 
> Not sure it can be much simpler but it definitely can introduce more
> capabilities, and potentially cover some other cases including your.
> 
> Probably I need rename the series on smth like:
> "make addressing scheme to be IVL capable"
> 
> and send RFCv2
> 
> Thanks for your comment, it's really valuable.

Ivan, based on the recent submission I copied you on [1], it sounds like
we want to move ahead with your proposal to extend netdev_hw_addr with a
vid member.

On second thought, your approach is good and if we enclose the vid
member within an #if IS_ENABLED(CONFIG_VLAN)8021Q) we should be good for
most foreseeable use cases, if not, we can always introduce a variable
size/defined context in the future.

Can you resubmit this patch series as non-RFC in the next few days so I
can also repost mine [1] and take advantage of these changes for
multicast over VLAN when VLAN filtering is globally enabled on the device.

[1]: https://www.spinics.net/lists/netdev/msg544722.html

Thanks!
-- 
Florian
