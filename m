Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FA9C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B49A213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="jL1NoV1j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B49A213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbeJKPug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 11:50:36 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35466 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbeJKPug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 11:50:36 -0400
Received: by mail-wm1-f67.google.com with SMTP id e187-v6so8432027wmf.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 01:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NKlhUW7lccWni3+Ehf5nmz/T1BQJupZvCVQZ/n7zgGM=;
        b=jL1NoV1j+rTx/JhwEl7SSxiCbtXvVfV+tnao6WOVqtW8dfECwWBFuCBsa+H22WCo7j
         KDbq/K2XUk8pKObHA8LPCnxXLVrPz15J/uiclEi/AqIaoEyfOecONxJWHUPZ7BaTYgDp
         HYO9LVQCeWndNVXwZtn2s5yzNUWaSQgeA5GO81FUP9a79/glKv5nRG0t8Q3A97TT7n92
         hRdVvSGWn089cWmgJLIw1ojmlIUrBwA8j0clMdIrAlrUSgwdHXdCHFpO8k5rf9YwRMJh
         +I0fIje880sqHJIbG8pqPqrrk/2NZ0KxdM6WoQ1BbbwxjhVcVEDEbGIPGMTJbE8z2Yas
         tqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NKlhUW7lccWni3+Ehf5nmz/T1BQJupZvCVQZ/n7zgGM=;
        b=WWK/BqMeoKXHrS3Zp79V5tVoYbDCuglKSUbXObwamsIqpefvvCZPu2ShgStyvVNQA2
         9AAYDcuMDWFz+6zOr/o6BTPlCocYUCZvAy+XDrblmV2tbfRcOI8i3aBdvxpsi6jLDOhb
         fqBlqe9kbcGt8Gv8UsFcnCuGqGKs15GfZ8Z2tXG0qMOe0bAc7nBdLccm7eyVHjLQqmcH
         O80r5s8Q5d8ppIV7BEPuffudrjFMSFTVtxJV9ZB2bFOnynEzdlTS5QXpkQPgVdMrrOde
         9dGLhSvpgU4kcIT71p7/cRmVYego4MtiG5D9B4iJzd08F/PcDlt/9WNIfotbBE2G5qs/
         O5Ug==
X-Gm-Message-State: ABuFfoiTQqKM/vpow9eQM3kWUzc/zQ0Zr74mpvoBO7M5+LOSBX5XY6+m
        pmyEgFclJK1uovYKSKRXfXxa886B
X-Google-Smtp-Source: ACcGV61OadVHSBzZ14Usw72JvETiHyqyHaIXCjKhhH1W/HNEEjZB2lQ91mb34ZmBABIbxL9PhPSsnA==
X-Received: by 2002:a1c:a505:: with SMTP id o5-v6mr749413wme.53.1539246262168;
        Thu, 11 Oct 2018 01:24:22 -0700 (PDT)
Received: from [192.168.0.20] ([94.1.125.110])
        by smtp.googlemail.com with ESMTPSA id r16-v6sm32631448wrv.21.2018.10.11.01.24.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 01:24:21 -0700 (PDT)
Subject: Re: R8169: Network lockups in 4.18.{8,9,10} (and 4.19 dev)
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Azat Khuzhin <a3at.mail@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <54d8d7e9-a80d-dc2b-5628-22f9dc14e2ee@maciej.szmigiero.name>
 <535f42c7-6c3b-8e5a-49de-5dc975879b21@googlemail.com>
 <98680351-5123-761f-982a-726098da9716@gmail.com>
 <9980dcc1-f7fe-5de7-75be-99b1592c9206@googlemail.com>
 <6b1685ce-22ac-2c71-e1d4-b05748a7d977@googlemail.com>
 <bed5c327-6a2a-99da-8b86-16f897b32548@maciej.szmigiero.name>
 <7199b1e4-ce40-60ae-2a6a-ef7e95e563ea@googlemail.com>
 <0e206e6b-3d0c-de27-dedb-48c30e02649c@gmail.com>
 <9d99060a-db1d-7177-3041-e407b131548e@maciej.szmigiero.name>
 <0b490a74-c8b3-7206-33ba-d99be73c18fd@googlemail.com>
 <df88dcb6-951d-0568-6104-7346d0c49063@maciej.szmigiero.name>
From:   Chris Clayton <chris2553@googlemail.com>
Message-ID: <d14f04cd-329d-cea9-14e1-d90ad629df74@googlemail.com>
Date:   Thu, 11 Oct 2018 09:24:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <df88dcb6-951d-0568-6104-7346d0c49063@maciej.szmigiero.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/10/2018 01:12, Maciej S. Szmigiero wrote:
> On 11.10.2018 00:49, Chris Clayton wrote:
>>> Now, knowing the "right" value you can experiment with what rtl_init_rxcfg()
>>> writes (under the "default:" label for your NIC model).
>>>
>>
>> This might be more interesting. Through a combination of viewing the output from pr_notice() and the output from
>> "ethtool -d", I can see RxConfig with the following values
>>
>> 	During boot:	0x00028700
>> 	Before suspend:	0x0002870e
>> 	During resume:	0x00024000
>> 	Post resume:	0x0002870e
>>
>> As I did with 4.18.10 early on in the process, I removed the call to rtl_init_rxcfg() from rtl_hw_start() and rebuilt,
>> installed and rebooted. Now I see the following values:
>>
>> 	During boot:	0x00028700
>> 	Before suspend:	0x0002870e
>> 	During resume:	0x00024000
>> 	Post resume:	0x0002400e
>>
> 
> Now we can finally see some difference...
> Besides missing RX128_INT_EN (bit 15 or 0x8000) and RX_DMA_BURST
> (bits 8-10 or 0x700) - that rtl_init_rxcfg() would normally set so this
> is kind of expected - one can see that the working configuration
> post-resume has bit 14 (or 0x4000) set, too.
> 
> This bit is described in the driver as RX_MULTI_EN ("8111c only") and is
> set by rtl_init_rxcfg() for example for RTL_GIGA_MAC_VER_35.
> 
> RTL_GIGA_MAC_VER_35 is described in the driver as being in the same
> family as your RTL_GIGA_MAC_VER_38, so can you please try the following
> change:
> --- r8169.c
> +++ r8169.c
> @@ -4271,6 +4271,7 @@ static void rtl_init_rxcfg(struct rtl816
>  	case RTL_GIGA_MAC_VER_18 ... RTL_GIGA_MAC_VER_24:
>  	case RTL_GIGA_MAC_VER_34:
>  	case RTL_GIGA_MAC_VER_35:
> +	case RTL_GIGA_MAC_VER_38:
>  		RTL_W32(tp, RxConfig, RX128_INT_EN | RX_MULTI_EN | RX_DMA_BURST);
>  		break;
>  	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_51:
> 
> This will add RX_MULTI_EN also for your chip model (you need to add back
> the call to rtl_init_rxcfg() to rtl_hw_start(), naturally).
>

That's done the trick. With the above change applied, my network runs running fine after a suspend/resume cycle and the
ping times are back in the 14-15ms range.

Chris

> If this does not help then I would try another values in the above write:
> 1) RTL_W32(tp, RxConfig, 0x00024000);
> 2) RTL_W32(tp, RxConfig, 0x00004000);
> 3) RTL_W32(tp, RxConfig, RX_DMA_BURST);
> 4) RTL_W32(tp, RxConfig, RX128_INT_EN);
> 
>> Chris
> 
> Maciej
> 
