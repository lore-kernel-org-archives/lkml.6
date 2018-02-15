Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1797899-1518708164-2-7282427673610885153
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518708164; b=oJrxAD8AIDzgazeXoDa7Jw6lrYIQUxs6KGTadPNMkH9jUxf
    ViA1nC9oyJh7flMerLfNKkt9IVjM9rtYlwbAu4gP3O2xEAnHB7urXuwO7BIr1plY
    X7QuuKFVj0K1KconeWtYL1VG1RoKAxFlM1LJJQ5xfeoqEuxeTGzbobtoAoP0zA6N
    5ekreb81kkq+VH5vxjP7RfeHW4OZhPteYdusKBiYzCTZBjUZhpuJN9YmytsZn8ld
    JsBiveIX/9yh9rdFZPB+KOzyLHkG0uvxAsRuHGOWzx/ym5w7qOs15VZtvSF+VYL9
    mBUfLePnIciTw3gwK8bTYsssJurpGvt6YfTvt3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:from:message-id:date
    :mime-version:in-reply-to:content-transfer-encoding:content-type
    :references:sender:list-id; s=arctest; t=1518708164; bh=ZkaGSaoD
    bLXHd/jBkbHpqYRbqp2o38DCEHl/fSrhCHY=; b=WBUo05eFBWAg2MYrCsY9MJd/
    oDoe/se52pbWdO8foOko9a+chUn/MxrC5HmNcqeQTjUDl90zPNgHTN+/OG8DmKw7
    tFOHrB4nrIdWmdJFgOMBNEpc5SQ1gWSvjsj+5u9xbEhydpM7JIFiKyRogNnyCZWX
    Z8+wlq6gaV/KHDJhgxyFpoQoZS1z+MPkormn/k+J1DWV3TX7UZJv4zwM/esSL106
    SFPxnl9tPeS25Qw5KEoWyam6pSBIMnbZxL+F5ysL5tSlk9gRNGeKXOqDtkfzlTXj
    T+6rRvH6zN2T70PWikMc33k3rc20jeMIybjL6mMwxHInjG8hPi58XdaAaFVlkQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=EgvmralY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=EgvmralY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162407AbeBOPWi (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:22:38 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:38585 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162423AbeBOPWf (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 15 Feb 2018 10:22:35 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180215152232euoutp025178916072032024bcd733dadf7e806a~TiQTHggmf1693916939euoutp02n
X-AuditID: cbfec7f4-6f9ff700000043e4-e6-5a85a5b7d378
Subject: Re: [RFC PATCH v2 4/6] arm64: dts: exynos: add OF graph between MHL
 and USB connector
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        dri-devel@lists.freedesktop.org, Inki Dae <inki.dae@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-usb@vger.kernel.org
From: Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <a8472ef5-16ea-7a18-3ec4-85ab7bf610a6@samsung.com>
Date: Thu, 15 Feb 2018 16:22:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPdg81LPOFmxtJmL7hMXGgB2USAOhCz2yjU9obX1jWjEWw@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+c5lO1uujsvYS0WXmXQhtSLiC82CCk4RdPsjG1itOqjpzHZm
        ZX/UDAw1XGVGa5laOAsxL/MyExRTcVjYMkO7alKjsrYSNRHT2vEk+d/vfZ734Xsf+BhS3U/P
        Z+KTTLwxSZ+olSmp2rYxd6jTnq5bU9eiwBczvDSutJbTuGf4M40LWp/R+OXIDxnO6btKYbe7
        Qo4zrxXJseNjN4276vNk2OpuJPC94nQSP2x9L8f2nk4Cpze0yrfM4UrzSxHXZckmuNsZt2jO
        UZIp4/ouuwiuqugCZ6kuQdyQY9EeRqeMPM4nxp/mjeFRR5Rx756OEsljmrPu0VzKjNoDspCC
        AXY9dBcNyEVWsw8QXLm+Mwsp/TyM4Mt4LyUNQwg8JXY0nWgqzJBLxn0EdeZsUhq8CD7Yhogs
        xDBz2SPQkKYTA0HsSuiZGKXFHZLto6Bl7C4hGjK/MVH1Wiayio2Cz5nfpnSKDQHfYBMt8jw2
        Gu7e8CBpJxDab32iRFawe8FSWzyVJdnF4PTmkRJr4M2nAkJ8DNg0BvK8Bf/O3gZOewMh8VwY
        cFXLJV4Ifx5NBy4jeNKYSUpDLgL3QNe/RAS0uDppsRrpP7u8PlySN8Fbe86UDOxseOUNlI6Y
        DTm1N0lJVkHGJbW0vRT6OmpIiTVgfz4iu4qCbTOq2WbUsc2oY/v/biGiSpCGTxEMsbywLok/
        EyboDUJKUmzYsZMGB/J/vKeTruE6VP/7aDNiGaQNUFVkp+vUtP60kGpoRsCQ2iDVoM4vqY7r
        U8/xxpOHjSmJvNCMFjCUVqM6tOK8Ts3G6k18As8n88Zpl2AU883ojvCuvcMTaS60+ExrDoY/
        vlaGN/cKW8vav17aELp56Mdqp2Vh3BLu565VuT4n/l5pcITFNI4vhYkTwY/bYM/y6I38+qz+
        pptR+7oSjG35MDHLtP/crzHrMoVs+wszfaobhiOWWOy7U+U7Eid9B6weX0yN1ZVsrgjdHhJz
        MSpeSwlx+rWrSKOg/wuwm3mydAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTURiAO99l+xSXX1PZwR8ag4oip5uXHcPMn8MKivohC9GhH3O5i+zb
        vASRCoNtomn4wy1x4o1ahraJSWGJzcQUl1pKoY5QkFrTTGUIGm2uwH8P5zzPC4f3UDh/l0ik
        VFoDo9cq1EJONDH9Z3I1ZbjXJE+rcwFUbw6Q6EXbAImWdjdI5PDMkujT3hYHPfI1E8jrHeQi
        S0sPF7nWFkm08Kqdg9q8bzDU1WfC0XPPChf1Ls1hyDTq4ebFyvo7+oFsoakRkz0220iZy2nh
        yHwNk5jM3fNA1jTkBLIdV9INSi7K0euMBuZ0mY41XBbeESOJSJyNRJKMbJE4XVp4SZIpTM3N
        KWXUqkpGn5pbLCpbng5iFfuCam+wlagFUzFWEEVBOgOOdZq5VhBN8eleAPdmmriRCwF87Qjg
        EY6DB4tWTkTyA9jlPgBWQFFxdDEcrZOHnXj6PFw6DJJhB6fXCGjyeLBIUI/BiScTR1M5IevQ
        /YUTZh6dCzcsfizMBH0Gbm6PkWFOoAug5amDiDin4JRt/Yij6JuwabjvqMXpc/CgYx6PcDJ8
        GWj/xwL4dd2BNQO+/VhuP5bYjyX2Y0knIJwgnjGyGqWGlYhYhYY1apWiEp3GBUIbH36/PzQC
        rJu3xgFNAWEMb7DRJOeTikq2RjMOIIUL43nb8tARr1RRc4/R64r0RjXDjoPM0ONa8MSEEl3o
        /2gNReJMsRRli6Xp0vQsJBTwvGk1cj6tVBiYcoapYPT/O4yKSqwFM7u+vALPbHrVdWdl8m0t
        VboaI1lZDlwJPrxqSymTm7p+J5nfzVTD4ZOelIFv7tiLZy2qn+UjO7V5v+6CtowTWx9nlT3r
        PrstX9Xl/8F0J98PgtapSeWGtLsq7sNcfkOnSTE/JvUVfi/g+P1vP08t8tXPdNfm+3ZHsqqa
        aUJIsGUK8QVczyr+AnkenQgHAwAA
X-CMS-MailID: 20180215152230eucas1p2f802dfd092e380f22057a3c72d0fd7de
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180215152230eucas1p2f802dfd092e380f22057a3c72d0fd7de
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180215103927eucas1p24785b56277ed6c9fa2fd70058096b944
X-RootMTR: 20180215103927eucas1p24785b56277ed6c9fa2fd70058096b944
References: <CGME20180215103927eucas1p24785b56277ed6c9fa2fd70058096b944@eucas1p2.samsung.com>
        <20180215103920.32017-1-a.hajda@samsung.com>
        <20180215103920.32017-5-a.hajda@samsung.com>
        <CAJKOXPdg81LPOFmxtJmL7hMXGgB2USAOhCz2yjU9obX1jWjEWw@mail.gmail.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 15.02.2018 13:14, Krzysztof Kozlowski wrote:
> On Thu, Feb 15, 2018 at 11:39 AM, Andrzej Hajda <a.hajda@samsung.com> wrote:
>> OF graph describes MHL data lanes between MHL and respective USB
>> connector.
>>
>> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
>> ---
>>  .../boot/dts/exynos/exynos5433-tm2-common.dtsi     | 31 +++++++++++++++++++---
>>  1 file changed, 28 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
>> index 7e49fadee412..ef758f7337e9 100644
>> --- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
>> +++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
>> @@ -779,9 +779,22 @@
>>                 clocks = <&pmu_system_controller 0>;
>>                 clock-names = "xtal";
>>
>> -               port {
>> -                       mhl_to_hdmi: endpoint {
>> -                               remote-endpoint = <&hdmi_to_mhl>;
>> +               ports {
>> +                       #address-cells = <1>;
>> +                       #size-cells = <0>;
>> +
>> +                       port@0 {
>> +                               reg = <0>;
>> +                               mhl_to_hdmi: endpoint {
>> +                                       remote-endpoint = <&hdmi_to_mhl>;
>> +                               };
>> +                       };
>> +
>> +                       port@1 {
>> +                               reg = <1>;
>> +                               mhl_to_musb_con: endpoint {
>> +                                       remote-endpoint = <&musb_con_to_mhl>;
>> +                               };
>>                         };
>>                 };
>>         };
>> @@ -804,6 +817,18 @@
>>                                              "usb-b-connector";
>>                                 label = "micro-USB";
>>                                 type = "micro";
>> +
>> +                               ports {
>> +                                       #address-cells = <1>;
>> +                                       #size-cells = <0>;
>> +
>> +                                       port@3 {
> I think you might need here "reg = <3>". Doesn't it produce a warning now?

You are right, I will fix it. Warning is produced only if compiled with W=1.

Regards
Andrzej

>
> BR,
> Krzysztof
>
>> +                                               musb_con_to_mhl: endpoint {
>> +                                                       remote-endpoint = <&mhl_to_musb_con>;
>> +                                               };
>> +                                       };
>> +                               };
>> +                       };
>>                         };
>>                 };
>>
>> --
>> 2.16.1
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>

