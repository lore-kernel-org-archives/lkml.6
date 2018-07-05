Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089A4C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 09:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD99A2415C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 09:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="yc8QFZGv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD99A2415C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753503AbeGEJ0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 05:26:33 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:45170 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753372AbeGEJ03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 05:26:29 -0400
Received: by mail-io0-f193.google.com with SMTP id l25-v6so7120198ioh.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 02:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iYGC+RgXN5Gc5wQm/QP5qWotMEwC1/WViQXLpQzrUg8=;
        b=yc8QFZGvJHkBp7FpTxft03c1gVE3k4xl6tLZpbYprwqKRPVsEsUNTGL+d5J6M6f9N1
         ScCXUEv4h6Mv9JCyeGylmilIQVtEo5y8LgHdFIXuiLB64HtZSCoUp3wLrx9irSK+IQdo
         BOUjSn/R1IP3hSi5yVhjZxDk1SUCQC5i/WdjCUtXnKJOXIr6ivbhFiBaNKogcAi6HxB2
         REOo7EYKAEwbBkews5TDN7lSDmgdak0XbY29l4o3hPxlRIlkJfZM5NnBA05kg5abh+/d
         qFGTCm6Ck27iLRZgEm5qjVtmb/YCV9Gm4C0kzD3RaKdaxSKoLYDH8GgyJ0dpRqbSi9UN
         ihdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iYGC+RgXN5Gc5wQm/QP5qWotMEwC1/WViQXLpQzrUg8=;
        b=QXaPAjtyaiUzT9tGMFQ/sk/M0+S6HFNQRWNzZGAUAGNTq1Mn5ltVE2rR71MlM+nyLk
         dcWD8S938v2tZxUzLt46eVa1i8J/g7NgRxTjX8kvRNLvVqqKZxN+nZXmwwM8PPrH/aQh
         7p0vOirMHSfyqXCp1hEfOUwfhr/9Y+3RhudZ4q3gVNV1O9kFZ6Ny3V1JdNgUzLROYJHQ
         vlQcNdsbQ5S/+hdxpjv5aErPDQGDmWFU1/J9aEINB3nkuVfJWv7r6wH/RBj3lw/KNCOk
         +6hWEYbNmSZHLcmF07XaebvwaQNqrGdLqkx+T+vG6DqlzA3ryZK/jkqZ6Fc5P/90wwtH
         BQkQ==
X-Gm-Message-State: APt69E20cYDd8ljP85x7MdSX/dda63MLd3sChhd47IljYTQ1KbK3T7Av
        T7nB7TIMa6TdFSbyEsm3HMc6SZXKRdz9uyB4zmLIuw==
X-Google-Smtp-Source: AAOMgpeP4pa7T8YmXsY2pTpuofMPoT6jkrAZ6wEK8tyGLF54+Izqm5tZpy+l6138rnF6NBO+vFucLF6Pl/K9+4Ckk4E=
X-Received: by 2002:a6b:3a89:: with SMTP id h131-v6mr4036890ioa.263.1530782788785;
 Thu, 05 Jul 2018 02:26:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:7391:0:0:0:0:0 with HTTP; Thu, 5 Jul 2018 02:26:28 -0700 (PDT)
In-Reply-To: <1530776154.4156.12.camel@realtek.com>
References: <CAPpJ_ed1oFQW_xmBtetP-ztoL7Z14T6akOSgKJ_8jxogdf3FWg@mail.gmail.com>
 <f3bf0687-76fb-9411-6fa2-e8ef312efb58@lwfinger.net> <20180704140933.3dk2ylbntltz6jqd@mwanda>
 <7e95bd6a-97bc-b030-26ce-83da66e5f279@lwfinger.net> <CAD8Lp44EG73XQ9omQhH6XiHfm2rMypmndSFyffnf_PVMueTvEA@mail.gmail.com>
 <1530776154.4156.12.camel@realtek.com>
From:   Jian-Hong Pan <jian-hong@endlessm.com>
Date:   Thu, 5 Jul 2018 17:26:28 +0800
Message-ID: <CAPpJ_ecCzhxEu8gMBFRsCerpeu_Z8TR=Rw5BiFhzVYP6WK-wAw@mail.gmail.com>
Subject: Re: [BUG] staging: r8822be: RTL8822be can't find any wireless AP
To:     Pkshih <pkshih@realtek.com>
Cc:     "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "drake@endlessm.com" <drake@endlessm.com>,
        Shaofu <shaofu@realtek.com>,
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
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-05 15:36 GMT+08:00 Pkshih <pkshih@realtek.com>:
> On Wed, 2018-07-04 at 10:33 -0500, Daniel Drake wrote:
>> On Wed, Jul 4, 2018 at 10:13 AM, Larry Finger <Larry.Finger@lwfinger.net> wrote:
>> > We will have to agree to disagree.
>> >
>> > I have no idea what the vendors are doing that cause some motherboards to
>> > need a different aspm value. What I do know is that we have had to live with
>> > the idiocy of some vendors saving a few pennies by only including a single
>> > antenna, rather than two, and then making a problem by miscoding the EFUSE
>> > bit that indicates which connector is actually in use. As we have no means
>> > that I know about to detect which boxes have the problem, a module parameter
>> > was created, just as in this case.
>> >
>> > I agree that drivers should work "out of the box", but finite resources and
>> > lack of vendor cooperation make this a goal that may not be attainable.
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

I do not know why I cannot apply this patch directly.  So, I apply
each line manually.

However, here is a good news.  I tested this fix, and it works
correctly on ASUS X530UN.  System can scan and get the access points
list.  Finally, it also connects to the access point.
Maybe, you can have a formal patch for this.

Thanks,
Jian-Hong Pan

>
> diff --git a/drivers/staging/rtlwifi/rtl8822be/hw.c b/drivers/staging/rtlwifi/rtl8822be/hw.c
> index 7947edb239a1..88ba5b2fea6a 100644
> --- a/drivers/staging/rtlwifi/rtl8822be/hw.c
> +++ b/drivers/staging/rtlwifi/rtl8822be/hw.c
> @@ -803,7 +803,7 @@ static void _rtl8822be_enable_aspm_back_door(struct ieee80211_hw *hw)
>                 return;
>
>         pci_read_config_byte(rtlpci->pdev, 0x70f, &tmp);
> -       pci_write_config_byte(rtlpci->pdev, 0x70f, tmp | BIT(7));
> +       pci_write_config_byte(rtlpci->pdev, 0x70f, tmp | ASPM_L1_LATENCY << 3);
>
>         pci_read_config_byte(rtlpci->pdev, 0x719, &tmp);
>         pci_write_config_byte(rtlpci->pdev, 0x719, tmp | BIT(3) | BIT(4));
> diff --git a/drivers/staging/rtlwifi/wifi.h b/drivers/staging/rtlwifi/wifi.h
> index 012fb618840b..a45f0eb69d3f 100644
> --- a/drivers/staging/rtlwifi/wifi.h
> +++ b/drivers/staging/rtlwifi/wifi.h
> @@ -88,6 +88,7 @@
>  #define RTL_USB_MAX_RX_COUNT                   100
>  #define QBSS_LOAD_SIZE                         5
>  #define MAX_WMMELE_LENGTH                      64
> +#define ASPM_L1_LATENCY                                7
>
>  #define TOTAL_CAM_ENTRY                                32
>
>
> ---
> PK
>
