Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2790900-1524759766-2-4303172400333882203
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524759765; b=W0jB4ypw07Ku+3vyBoUoLjCI0CjgXgjvvw9X7uSuyNF0A93PYM
    YqcvsTl6CK6+Od4esOhXGF9VM68BblQMRctR+NalM2e5MjCEJE4VBnZqM9zjQVj+
    3n7TsaIkjnWGvg6xIUbCZ10QvCGETZDFZG9THmTtFBwGBDiHGjXXdyfwvVI++xk3
    k3s+y7coct5KbiLZAgU5LUfT74COCAImSg5YRVlAWxznGBd5B13MuaVJftqCmnOI
    FBCgWIqlhk7r7Q+Dy/MWqOa5UudcQk8dMLEMtpYrbab57C9BC+4NIYtJOfnan6xr
    EHwUsqgAG9TXgUTgT7eJ+10MQQU564XYB1yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524759765;
    bh=0P8fsEtyuHR6roMDXm5wn6xqUHOABNZYJ0hyWoI/Gr8=; b=pjfKKfDM+u/E
    cNzIJcydENAkVYGSgnD9d/DWf2w6+MJ6kWieMd4QxCmIIPFiNXzkAsVspwSiQhDx
    w9dV4T3WmAM+x9Z9JeaONglKIFa1qUP836wfZUtTy1PTP9vEQwtZt3wzouESvnJB
    ynnNKM0zt5pPskTkSM2kdFf1rKARXs0aTpN7lOxRX5hOhBlmp6SDLps3k2xJqOE8
    qL8YIdL7r7twiuHlIzTJ2gI7sDHbC5XmBIU51/oulfw0TxmyC9oDpM6DZsN0ovhe
    vblImKayAANxPTvBUj63Iymzy/haUBNMlaGUI3WrbSCoWJKv8bnhZt+M6rCMLf38
    fdS/B0gNrw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=MA1spOHR x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=hmkv8I3w;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=MA1spOHR x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=hmkv8I3w;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfP6Y4uK0FTKK9VTF7PgSa6BooMSUOIgimHSiP+drAlZqPxXGMIIpCvIXKbY5RYzBE4UlzeKJaSCYHtHgpdaoyYo2Fz09srhrQjdJR3YA1IZYEe6GTZ6k
    O0M26rJNRVifGjX1eOF8lCh94EY3WDGGpzW2UZdRrLvjBkx4mzSltCSG7w+QMRc2BVu4Id4iLOFVeKE18D1vzQgKNxCL6E1NyFcDv7tWpnIX89lApr2XnO+i
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=CjaL-clQNZYA:10 a=Kd1tUaAdevIA:10 a=3ByqZZf8FkOYVrwpfR8A:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932229AbeDZQWd (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 12:22:33 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:46533 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756803AbeDZQWb (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 26 Apr 2018 12:22:31 -0400
X-Google-Smtp-Source: AIpwx4/shtbOuzeJLpvsYskqahVdV3EPFRsKV8tdJ6pwHOoVLDFvoNtD1CC3iSRwy6167GSm/2dRXw==
Subject: Re: [PATCH] USB: serial: option: adding support for ublox R410M
To: Johan Hovold <johan@kernel.org>
Cc: =?UTF-8?Q?Bj=c3=b8rn_Mork?= <bjorn@mork.no>,
        =?UTF-8?B?U1ogTGluICjmnpfkuIrmmbop?= <sz.lin@moxa.com>,
        stable <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dan Williams <dcbw@redhat.com>
References: <20180426062831.320-1-sz.lin@moxa.com>
 <20180426070927.GT4615@localhost>
 <72c63853-aa2d-e74c-1112-36d54ef52a85@gmail.com>
 <20180426081403.GA335@localhost> <87r2n25i6i.fsf@miraculix.mork.no>
 <3895ed90-bbb9-e7ce-34c0-a1654646cf83@gmail.com>
 <98b50ae7-b889-6811-476e-9cdc8a62a484@gmail.com>
 <20180426161228.GW4615@localhost>
From: Lars Melin <larsm17@gmail.com>
Message-ID: <09866ede-25cf-3ca1-1be6-e720b4b5dd23@gmail.com>
Date: Thu, 26 Apr 2018 23:22:25 +0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180426161228.GW4615@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 4/26/2018 23:12, Johan Hovold wrote:
> On Thu, Apr 26, 2018 at 06:40:46PM +0700, Lars Melin wrote:
>> On 4/26/2018 18:39, Lars Melin wrote:
>>> On 4/26/2018 18:19, Bjørn Mork wrote:
>>>> Anyway, Qualcomm based designs are definitely handled by both drivers.
>>>> Using qcserial only makes sense if the interface layout matches one of
>>>> the defined shared schemes, which currently are:
>>>>
>>>>      QCSERIAL_G2K = 0,    /* Gobi 2000 */
>>>>      QCSERIAL_G1K = 1,    /* Gobi 1000 */
>>>>      QCSERIAL_SWI = 2,    /* Sierra Wireless */
>>>>      QCSERIAL_HWI = 3,    /* Huawei */
>>>
>>> It seems to me that this Quectel device matches the interface layout for
>>> Gobi1K:
>>>
>>>            * Gobi 1K USB layout:
>>>            * 0: DM/DIAG (use libqcdm from ModemManager for communication)
>>>            * 1: serial port (doesn't respond)
>>>            * 2: AT-capable modem port
>>>            * 3: QMI/net
>>>            */
> 
>> Ublox, not Quectel..
> 
> Yeah, but qcserial appears to select a different altsetting for the DM
> port for Gobi 1000, an altsetting which this particular device does not
> have.
> 
> I didn't re-read the full thread I referred to earlier, but I think in
> it, Dan mentioned Gobi 1000 device requiring firmware to be loaded too.
> 
> So if it's not a G1K device, we probably shouldn't be using qcserial
> even if the interface layout happens to match.
> 
> Thanks,
> Johan

Good point, I forgot about the required firmware loading for Gobi1K.
So this device should be handled by the option driver.

/Lars
