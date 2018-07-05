Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLACK,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E491C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 17:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ABC224053
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 17:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFVJ1sSK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ABC224053
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754157AbeGERGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 13:06:49 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34233 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753621AbeGERGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 13:06:47 -0400
Received: by mail-oi0-f66.google.com with SMTP id 13-v6so18269551ois.1;
        Thu, 05 Jul 2018 10:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WqvAADWRRJrHEL/IahGc3K15twMFcMGPoc4pQzpmu2c=;
        b=AFVJ1sSKdAeZrcp2mKGFCcUyZ1iv+HRYouHUGsBw1Wb+4gY2dF+EyrUNiiFl5qCLbZ
         bAyJR1RcLBp35i2nLDAnKPwAZuqrcMk6b3QHryTYIdYniAA8XNcQKdu7b4IJYReOiSVM
         Dv0uOBKOZ6GQUm3HlKrlNcbCQahyMTwK4G5/1U3HRXrA8GjMlzTZzE637/jPwL+VcuJw
         NiyMXnLYe/KyXzn1Dg8AoCNOOBo5OGmPHNzHMfefwy2+AXVLfno8YaxCuh5EKUFt+e8j
         DSC2TMA3iTn+BDxEmlaC1w6blxCooirijV4z/07EgKcnFmUAG2lm/PRoMtWcAGt+39Dk
         k7bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WqvAADWRRJrHEL/IahGc3K15twMFcMGPoc4pQzpmu2c=;
        b=oLlioWL5VPDYBrm/alBB/TtHxUAxR8iAuf3T+UIb6jIuEX6Zg1yXGiQDKLxDh1Fhvk
         BRv05GKT1yDd8f1erbZAAGz2c4PV5xcm5PLTfeaOXCUa+SfbWaj0C3x0jYyoONRgOlZ3
         udSOQqUR9JeK5WPXVSWjqMIKj2poL6qXHRNK+HLEI4tlnKrIbjBrkuonBD0NJc2O1jmS
         f6nsg3X+jo4yG2jfbPuJ4Qml6SuUAJfXwKNEYQYaoeAHyS0fU9R9M7P5wQ+trCUKVGXK
         uR6OsTC1RFm8PDXOUmJPTya8JdFDqpwOlT9yVFlzSq7f4vaQII+YhlU2exF9ucmQogY+
         paJw==
X-Gm-Message-State: APt69E1DVlMzjQtiQzj/DEdmhZrpgKj4j1aQOsM3PcAv4G7G+b9Da6bu
        iN/U3JAfpCmjY6xYmNix3Adl8g==
X-Google-Smtp-Source: AAOMgpet5MuiDmnAKaR1RfYsLjcRL7HTqL01U+LyDDw3w86qAlpcdr1oECa3qTORaZwQBMTlp2/V+A==
X-Received: by 2002:aca:c585:: with SMTP id v127-v6mr8388800oif.348.1530810406574;
        Thu, 05 Jul 2018 10:06:46 -0700 (PDT)
Received: from [192.168.1.107] (cpe-24-31-253-228.kc.res.rr.com. [24.31.253.228])
        by smtp.gmail.com with ESMTPSA id t204-v6sm3695333oig.24.2018.07.05.10.06.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 10:06:45 -0700 (PDT)
Subject: Re: [BUG] staging: r8822be: RTL8822be can't find any wireless AP
To:     Pkshih <pkshih@realtek.com>,
        "drake@endlessm.com" <drake@endlessm.com>
Cc:     Shaofu <shaofu@realtek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Birming Chiu <birming@realtek.com>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "frank@generalsoftwareinc.com" <frank@generalsoftwareinc.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux@endlessm.com" <linux@endlessm.com>,
        Steven Ting <steventing@realtek.com>,
        Tony Chuang <yhchuang@realtek.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "sgruszka@redhat.com" <sgruszka@redhat.com>,
        "jian-hong@endlessm.com" <jian-hong@endlessm.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <CAPpJ_ed1oFQW_xmBtetP-ztoL7Z14T6akOSgKJ_8jxogdf3FWg@mail.gmail.com>
 <f3bf0687-76fb-9411-6fa2-e8ef312efb58@lwfinger.net>
 <20180704140933.3dk2ylbntltz6jqd@mwanda>
 <7e95bd6a-97bc-b030-26ce-83da66e5f279@lwfinger.net>
 <CAD8Lp44EG73XQ9omQhH6XiHfm2rMypmndSFyffnf_PVMueTvEA@mail.gmail.com>
 <1530776154.4156.12.camel@realtek.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <a54fe914-9402-a959-9ae5-540bfec64a14@lwfinger.net>
Date:   Thu, 5 Jul 2018 12:06:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1530776154.4156.12.camel@realtek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05/2018 02:36 AM, Pkshih wrote:
> On Wed, 2018-07-04 at 10:33 -0500, Daniel Drake wrote:
>> On Wed, Jul 4, 2018 at 10:13 AM, Larry Finger <Larry.Finger@lwfinger.net> wrote:
>>> We will have to agree to disagree.
>>>
>>> I have no idea what the vendors are doing that cause some motherboards to
>>> need a different aspm value. What I do know is that we have had to live with
>>> the idiocy of some vendors saving a few pennies by only including a single
>>> antenna, rather than two, and then making a problem by miscoding the EFUSE
>>> bit that indicates which connector is actually in use. As we have no means
>>> that I know about to detect which boxes have the problem, a module parameter
>>> was created, just as in this case.
>>>
>>> I agree that drivers should work "out of the box", but finite resources and
>>> lack of vendor cooperation make this a goal that may not be attainable.
>>
>> As you touched on, the ideal situation is that Realtek solve the
>> issue. Ping-Ke Shih is on CC and I am adding a few more contacts from
>> the commit log. The context is that the r8822 driver fails on several
>> platforms unless setting aspm=0 (the default is 1).
> 
> It's hard to have all laptop or motherboards and all rtl8822be modules in my side,
> so what I can do is to analyze the issue when user encountered.
> 
>>
>> https://gist.github.com/dsd/20c05f0c6d66ee2ef9bfbb17f93f18ba
>> https://bugzilla.kernel.org/show_bug.cgi?id=199651
>>
>>
>> If we don't get a timely fix from Realtek though, I think there is a
>> key difference between the antenna selection headache and this one. In
>> the antenna case, there isn't a good value that you can set that will
>> work on all systems. If you change the default behaviour you will
>> solve the issue for some users while simultanously introducing the
>> problem on other systems that were previously fine.
>>
>> However in this case, it's highly likely that setting aspm=0 (off) by
>> default would work for everyone. It has the disadvantage of using a
>> bit more power, but especially with the indications that this issue
>> affects a significant number of systems, I think that having the
>> driver working out of the box everywhere is more important. The module
>> parameter can be left in place so that unaffected users that want to
>> save power can set aspm=1.
>>
> 
> I think this issue may be due to L1 latency, so below patch would be
> helpful but not sure because I don't have the same laptop.
> Is there anyone can help to test?
> 
> 
> diff --git a/drivers/staging/rtlwifi/rtl8822be/hw.c b/drivers/staging/rtlwifi/rtl8822be/hw.c
> index 7947edb239a1..88ba5b2fea6a 100644
> --- a/drivers/staging/rtlwifi/rtl8822be/hw.c
> +++ b/drivers/staging/rtlwifi/rtl8822be/hw.c
> @@ -803,7 +803,7 @@ static void _rtl8822be_enable_aspm_back_door(struct ieee80211_hw *hw)
>   		return;
>   
>   	pci_read_config_byte(rtlpci->pdev, 0x70f, &tmp);
> -	pci_write_config_byte(rtlpci->pdev, 0x70f, tmp | BIT(7));
> +	pci_write_config_byte(rtlpci->pdev, 0x70f, tmp | ASPM_L1_LATENCY << 3);

This patch loses the BIT(7). Did you really mean to do that?

I now agree that this is a bug. A similar problem had been found in a few boxes 
with RTL8723BE or RTL8821AE cards, but that it might apply here completely 
slipped through the ever larger cracks in my mind.

Larry
