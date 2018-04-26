Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2417162-1524742853-2-11176938024635055601
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: to='UTF-8', cc='UTF-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524742853; b=VU+AKmYkRi4zaLoWM7iIyUUGDFpbXzYGD3d+oZDzZybRx2hw5B
    AlwzuGeTynBJmPAh6a+Hzzt0Kor+7LJrsQabngHCn28rQYjKSnkIMclbBXk1rEo8
    rB05u5/8/IdMYhzOpiosBJxCagCIk68jhJwM4xV5UKMYV/cmb4qiHeuHjN3DpJ5s
    njNxQx0h8OrZLxlS9NpBfH269M2hz0N/FnpKodcYMtZaBf7P+XGVlBxMno5cnboh
    O8YeGRGV1QITtzTWD129Oh3HkD5J15Qia2uBcCkKS7tIEs5BUyKL/j78J9aT5seO
    EWgGqquV0fa2cFlITbZBz5vdyThqa71ntziA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:references:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524742853;
    bh=e4n9uwZnODtkQp6/H0MlOEfq77qpfT+CRAGfrJSxrys=; b=CNwEAmQTelt6
    QWyQiyf2vTNutkJifHwVtobYwzc3GJI/mU8kf4xTBjGBhEgHrBtIhZvlHmCLzXw5
    pwpy5jzl2hcVPFKaQgnW7bvg0cxL95Hb+6sQERZdL4baJlfgEPkrGrwvR/LtMtUo
    kKKQfrqNGS8vh+J2qYRpwsP6PM9Rv8PVIA67kk6+rANWgemSrOlXdMCYPrwEGb6g
    c3vNIfCeXgdZbLJt1c7JhmONr2H6fIdGFZEy2tvkDNxgRai0dKQztI18XMVEBs8V
    pp0pJYGgJeuacGkNvc/XolM9u/yNaSrkp6iDWyyKqqaFX8erpmry4SqbLhFP4cp5
    VxfFKSbE6Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Bxjgt2jF x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=NqLxcaAL;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Bxjgt2jF x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=NqLxcaAL;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHDdWkXehLb5ykqkxtBQi3E2eni/iNkQAcOvhh8EyG0zWTIIT8bpvrfO7oKE2qA9o/mS23hblRN4DOffpnOx6tnWn+dIv8FTGRuKeY5IKnDPOgK080L1
    Onx3VNEIzEVgzVYLxiYcm2PBo1vTaFkBln/W6rLnTJnC5gOmGau/vNYz+uVIs1slL917LP6BXz//bGscL1ehe4GQH18cm/VVBRnPa1XBzGhTPU0gtdKqqouB
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=CjaL-clQNZYA:10 a=Kd1tUaAdevIA:10 a=QagmcrQ69xX5Vo3HE7QA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755764AbeDZLkw (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 07:40:52 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33827 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755757AbeDZLku (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 26 Apr 2018 07:40:50 -0400
X-Google-Smtp-Source: AIpwx49FbxmftG8YztyJUhK5qy/I/EXrU0pQ7L/vYF8O7lkIdTj4Cwd/TuFY12Lplu7VQnZM5BXxRQ==
Subject: Re: [PATCH] USB: serial: option: adding support for ublox R410M
From: Lars Melin <larsm17@gmail.com>
To: =?UTF-8?Q?Bj=c3=b8rn_Mork?= <bjorn@mork.no>,
        Johan Hovold <johan@kernel.org>
Cc: =?UTF-8?B?U1ogTGluICjmnpfkuIrmmbop?= <sz.lin@moxa.com>,
        stable <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dan Williams <dcbw@redhat.com>
References: <20180426062831.320-1-sz.lin@moxa.com>
 <20180426070927.GT4615@localhost>
 <72c63853-aa2d-e74c-1112-36d54ef52a85@gmail.com>
 <20180426081403.GA335@localhost> <87r2n25i6i.fsf@miraculix.mork.no>
 <3895ed90-bbb9-e7ce-34c0-a1654646cf83@gmail.com>
Message-ID: <98b50ae7-b889-6811-476e-9cdc8a62a484@gmail.com>
Date: Thu, 26 Apr 2018 18:40:46 +0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <3895ed90-bbb9-e7ce-34c0-a1654646cf83@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 4/26/2018 18:39, Lars Melin wrote:
> On 4/26/2018 18:19, Bjørn Mork wrote:
>> Anyway, Qualcomm based designs are definitely handled by both drivers.
>> Using qcserial only makes sense if the interface layout matches one of
>> the defined shared schemes, which currently are:
>>
>>     QCSERIAL_G2K = 0,    /* Gobi 2000 */
>>     QCSERIAL_G1K = 1,    /* Gobi 1000 */
>>     QCSERIAL_SWI = 2,    /* Sierra Wireless */
>>     QCSERIAL_HWI = 3,    /* Huawei */
> 
> It seems to me that this Quectel device matches the interface layout for 
> Gobi1K:
> 
>           * Gobi 1K USB layout:
>           * 0: DM/DIAG (use libqcdm from ModemManager for communication)
>           * 1: serial port (doesn't respond)
>           * 2: AT-capable modem port
>           * 3: QMI/net
>           */
> 
> /Lars

Ublox, not Quectel..
