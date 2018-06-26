Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2B9C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27AB3255D2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 20:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RD16sgEN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27AB3255D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934034AbeFZUsX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 16:48:23 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51589 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933472AbeFZUsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 16:48:22 -0400
Received: by mail-wm0-f65.google.com with SMTP id w137-v6so3409532wmw.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 13:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XIDmgmHqM1AEaY8GAGiC2LMCjtGRrO6ExRDNP3OWyvg=;
        b=RD16sgENRmiK4Z1fh4KLMk+0M85vY3qmP/n2rb05S5FJ9odlSHLwEiv9drM7JXi1YQ
         EPykqUtnPNvOFKyNyQ14vjyiNYRmO3oorZ1nMTWZ/fkzACWH/xMXktqVJfvzSh/EkJLg
         D7fsF/ercwZPIoB3Jvc8MCyxeH07pBXuFV6WkEt2kHO0vfzv71UnEzIrFDNP/nvkmqon
         mM4Hzztkm1mJh6HMqFxvc2Rc4jRlueWpPBbY8Qmitlndz9SKu8Pb/kWhsRbzs+jEUC3R
         mjbu4yMsnnu+FGgzLJFFoBN/xgA+C1CbSMKvTHGDxeK4FLwk6DWE87tfdpzQRg5k8ufB
         WilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XIDmgmHqM1AEaY8GAGiC2LMCjtGRrO6ExRDNP3OWyvg=;
        b=H1uj36EFHZGiuTgWNuMeRefdWe2cvc+Mj8hM7/0NzMrG9uvW5gdHQirlWv7S3seuhk
         mb7+aKw/oy4IR6BQY752kZVx8xSdNjDSKPznLNU16xhv9f/eKL0zVtcGZSGUXtHJ8AH3
         A5EXm/Dikzvgms8FQFeccQ2gz/5gLIWHH/3mXFl6aMjPk4G4TuGJHIjJxP7veIvhodXD
         63LWBPVwhyxUnJiCO4bLyWQaEQn7pjtR1cnIl2M3N9AX7i3cFe0g0IE5r3fZLNqqzpQy
         iDCUWL7u4I1rKhUwTYNlnAwaKFbXtVPzfIF3Kcok0tCaQXTxLhl0GUPHZU9k5edDzJqd
         YYpQ==
X-Gm-Message-State: APt69E3E7ZwQxYERCwwAp63h6VGqEvjpnhWlfKe5JsO3nIZd37Z3CFXP
        tlrUMElifJ8fEhpLQigB8sE=
X-Google-Smtp-Source: AAOMgpdKFVVkO/lIzdI9ReET36PyxeqsmTEXfm084B6DmtnInya4Kq/t0bbbtyUEVsng1I6HIemZIw==
X-Received: by 2002:a1c:91c4:: with SMTP id t187-v6mr2935058wmd.51.1530046100815;
        Tue, 26 Jun 2018 13:48:20 -0700 (PDT)
Received: from [192.168.1.4] (x590c812a.dyn.telefonica.de. [89.12.129.42])
        by smtp.gmail.com with ESMTPSA id k82-v6sm4846935wmg.10.2018.06.26.13.48.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 13:48:20 -0700 (PDT)
Subject: Re: [PATCH v3 4/4] staging: rtl8723bs: use mac_pton() in
 rtw_macaddr_cfg()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20180626081409.9518-1-straube.linux@gmail.com>
 <20180626081409.9518-4-straube.linux@gmail.com>
 <CAHp75Ve8JTY7KiQcRnD+DV-oEWnqFgA9uu2Ufz22zaOvf_xiGw@mail.gmail.com>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <40882fdb-bac1-9aad-1560-60e59cfa09f5@gmail.com>
Date:   Tue, 26 Jun 2018 22:48:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Ve8JTY7KiQcRnD+DV-oEWnqFgA9uu2Ufz22zaOvf_xiGw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/26/18 19:34, Andy Shevchenko wrote:
> On Tue, Jun 26, 2018 at 11:14 AM, Michael Straube
> <straube.linux@gmail.com> wrote:
>> Use the mac_pton() helper to convert the mac address string.
>>
>> The functions key_char2num() and key_2char2num() are not used
>> anywhere else and can be removed.
>>
>> This also has the benefit of validating the input since mac_pton()
>> returns false if the string is not valid.
>>
> 
> FWIW,
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 

Thanks.

>> Signed-off-by: Michael Straube <straube.linux@gmail.com>
>> ---
>>   .../staging/rtl8723bs/core/rtw_ieee80211.c    | 30 +++----------------
>>   .../staging/rtl8723bs/os_dep/ioctl_linux.c    |  3 --
>>   2 files changed, 4 insertions(+), 29 deletions(-)
>>
>> diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
>> index 8af4a89e632f..8e0025e1ff14 100644
>> --- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
>> +++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
>> @@ -1137,25 +1137,6 @@ ParseRes rtw_ieee802_11_parse_elems(u8 *start, uint len,
>>
>>   }
>>
>> -static u8 key_char2num(u8 ch);
>> -static u8 key_char2num(u8 ch)
>> -{
>> -               if ((ch >= '0') && (ch <= '9'))
>> -                       return ch - '0';
>> -               else if ((ch >= 'a') && (ch <= 'f'))
>> -                       return ch - 'a' + 10;
>> -               else if ((ch >= 'A') && (ch <= 'F'))
>> -                       return ch - 'A' + 10;
>> -               else
>> -                       return 0xff;
>> -}
>> -
>> -u8 key_2char2num(u8 hch, u8 lch);
>> -u8 key_2char2num(u8 hch, u8 lch)
>> -{
>> -               return ((key_char2num(hch) << 4) | key_char2num(lch));
>> -}
>> -
>>   void rtw_macaddr_cfg(struct device *dev, u8 *mac_addr)
>>   {
>>          u8 mac[ETH_ALEN];
>> @@ -1166,14 +1147,11 @@ void rtw_macaddr_cfg(struct device *dev, u8 *mac_addr)
>>          if (!mac_addr)
>>                  return;
>>
>> -       if (rtw_initmac) {      /*      Users specify the mac address */
>> -               int jj, kk;
>> -
>> -               for (jj = 0, kk = 0; jj < ETH_ALEN; jj++, kk += 3) {
>> -                       mac[jj] = key_2char2num(rtw_initmac[kk], rtw_initmac[kk + 1]);
>> -               }
>> +       if (rtw_initmac && mac_pton(rtw_initmac, mac)) {
>> +               /* Users specify the mac address */
>>                  ether_addr_copy(mac_addr, mac);
>> -       } else{ /*      Use the mac address stored in the Efuse */
>> +       } else {
>> +               /* Use the mac address stored in the Efuse */
>>                  ether_addr_copy(mac, mac_addr);
>>          }
>>
>> diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
>> index 39502156f652..4eb51f45b387 100644
>> --- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
>> +++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
>> @@ -32,9 +32,6 @@
>>   #define WEXT_CSCAN_HOME_DWELL_SECTION  'H'
>>   #define WEXT_CSCAN_TYPE_SECTION                'T'
>>
>> -
>> -extern u8 key_2char2num(u8 hch, u8 lch);
>> -
>>   static u32 rtw_rates[] = {1000000, 2000000, 5500000, 11000000,
>>          6000000, 9000000, 12000000, 18000000, 24000000, 36000000, 48000000, 54000000};
>>
>> --
>> 2.18.0
>>
> 
> 
> 
