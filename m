Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF36C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EB8B21F45
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idB66pE6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EB8B21F45
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbeHIU3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 16:29:20 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50885 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbeHIU3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 16:29:20 -0400
Received: by mail-wm0-f65.google.com with SMTP id s12-v6so1106141wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 11:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7G1kve6HpYsuwqYFIPLYl/v8H8pJcnAmR0kPHj3c5h4=;
        b=idB66pE62yFKIwmjsH/hRSpQeiYeyatP+B6ooJ54tDYDwGDAPvlzZjaWHOKZ4Ucrha
         dW28abj7AAQQlDAUoPtUkri6NebofO36CsihzUmXdM58cbrZB0EWWUcelD2mW6l7x5O0
         KGJOHdGfXCLor/snkfCQFbQ26x4+Hxg54Q56bDTLf0hvl4HaSTIf7ds/7tyfkYVdFnOe
         iZI330AAlEog35Uo0VG7XjqL891tBIBpE2VeLzx1XhFtVLtAFdBWp5J6F9TMTSQ9NXa4
         Ik8UKs+Ex+OAkuOcz79o4E5xqFLQfGiMHuiJ2+6LWq1kaLj3VxGBkBLSes+XuQ3smSLA
         leRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7G1kve6HpYsuwqYFIPLYl/v8H8pJcnAmR0kPHj3c5h4=;
        b=gmcaUgk7J8V9KFtgXCBZC6eFPEVUhSi1Kyf42nzFZ8bp7LP3A6zMLQmxsPInVcvaki
         wXI/pACfOBFlUUglZQFXLq5xc4an5OyQzlGpNe/vg6MxHLkok1K2+uj43wj2gw41WlAK
         N/hMosALxKpZtMkVsz/6OSMTG128bL2KgqAddIQFtjLJ7Ey9xVynw0dzOBdHIGizyG9t
         eGBcmZTaUQEIE192B6ZDgQccIY1P+xocJn0dBG1NaZglV1PH3TrW08MRDo6kklnkuWgo
         rGuYXSzx3RO4gm3NnciS1sXlDCO0rBh9qdJR5bhAJJS7ssH3VS9c1vktanEyagVsODah
         kI+A==
X-Gm-Message-State: AOUpUlFyHnn2YZ3gu0+ciSP918E3dcTtuIA/CiU6kMxoqYInsNhB3Yds
        KFYOC0PzRyeB6SHORZThKJg=
X-Google-Smtp-Source: AA+uWPxfMT5ibrSziA9q89+Dxlv+1fwkLAbcOJBzBdK/AAeQ9P37Y0HnDHXXTap99VPj4jidapchWQ==
X-Received: by 2002:a1c:eb03:: with SMTP id j3-v6mr2216171wmh.150.1533837800510;
        Thu, 09 Aug 2018 11:03:20 -0700 (PDT)
Received: from ?IPv6:2a02:8108:85c0:57c8:32db:916d:97a2:c4eb? ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id m2-v6sm9141391wrw.76.2018.08.09.11.03.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 11:03:19 -0700 (PDT)
Subject: Re: [PATCH 3/5] staging: rtl8188eu: use is_multicast_ether_addr in
 rtw_xmit.c
To:     Joe Perches <joe@perches.com>, gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Alexander Duyck <alexander.h.duyck@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
References: <20180809170131.29279-1-straube.linux@gmail.com>
 <20180809170131.29279-3-straube.linux@gmail.com>
 <e1c49e8a5c93b07542899f1e8b238a70ec89801b.camel@perches.com>
 <d1f2ab32-ff10-9575-ad61-0286ee3811ae@gmail.com>
 <cf3e257702a93e4fcfab666e42e49f363eb447f7.camel@perches.com>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <6da72965-8228-46bf-9c5b-981d761836bb@gmail.com>
Date:   Thu, 9 Aug 2018 20:03:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <cf3e257702a93e4fcfab666e42e49f363eb447f7.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/18 7:51 PM, Joe Perches wrote:
> On Thu, 2018-08-09 at 19:42 +0200, Michael Straube wrote:
>> On 8/9/18 7:13 PM, Joe Perches wrote:
>>> On Thu, 2018-08-09 at 19:01 +0200, Michael Straube wrote:
>>>> Use is_multicast_ether_addr instead of custom IS_MCAST in
>>>> core/rtw_xmit.c.
>>>
>>> Have you verified that all accesses are __aligned(2) ?
>>>
>>> If so, please state that in the patch description.
>>>
>>>> diff --git a/drivers/staging/rtl8188eu/core/rtw_xmit.c b/drivers/staging/rtl8188eu/core/rtw_xmit.c
>>>
>>> []
>>>> @@ -460,10 +460,10 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
>>>>    	if ((pattrib->ether_type == ETH_P_ARP) || (pattrib->ether_type == ETH_P_PAE) || (pattrib->dhcp_pkt == 1))
>>>>    		rtw_lps_ctrl_wk_cmd(padapter, LPS_CTRL_SPECIAL_PACKET, 1);
>>>>    
>>>> -	bmcast = IS_MCAST(pattrib->ra);
>>>> +	mcast = is_multicast_ether_addr(pattrib->ra);
>>>
>>> i.e.:  is pattrib->ra __aligned(2) ?
>>>
>>> etc...
>>>
>>
>> Hi Joe,
>>
>> I looked at the function comment for is_multicast_ether_addr in etherdevice.h.
>> There is not mentioned that __aligned(2) is required. If it is, I will check.
>>
>> So, is it required although it's not mentioned for is_multicast_ether_addr?
> 
> Well, it wasn't required initially, but
> 
> commit d54385ce68cd18ab002b46f61246ad197cec92de
> Author: Alexander Duyck <alexander.h.duyck@redhat.com>
> Date:   Thu Apr 30 14:53:54 2015 -0700
> 
>      etherdev: Process is_multicast_ether_addr at same size as other operations
>      
>      This change makes it so that we process the address in
>      is_multicast_ether_addr at the same size as the other calls.  This allows
>      us to avoid duplicate reads when used with other calls such as
>      is_zero_ether_addr or eth_addr_copy.  In addition I have added a 64 bit
>      version of the function so in eth_type_trans we can process the destination
>      address as a 64 bit value throughout.
>      
>      Signed-off-by: Alexander Duyck <alexander.h.duyck@redhat.com>
>      Signed-off-by: David S. Miller <davem@davemloft.net>
> 
> changed it without adding a note in the kernel-doc.
> 
> So this is likely appropriate to avoid unaligned access traps:
> ---
>   include/linux/etherdevice.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
> index 572e11bb8696..0f7086b4836a 100644
> --- a/include/linux/etherdevice.h
> +++ b/include/linux/etherdevice.h
> @@ -115,6 +115,8 @@ static inline bool is_zero_ether_addr(const u8 *addr)
>    *
>    * Return true if the address is a multicast address.
>    * By definition the broadcast address is also a multicast address.
> + *
> + * Please note: addr must be aligned to u16.
>    */
>   static inline bool is_multicast_ether_addr(const u8 *addr)
>   {
> 

Ok, then I will check and resend the series.
Thanks again.
