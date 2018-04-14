Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1698365-1523694947-5-9258988122080197520
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES encaro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523694946; b=GDtccIx5QrhacSgtam8LRSXgJJGlr0hKCixC5eLWKvwmfvd7rE
    0rQNdKyD6pxDQrGbYYGCWK8gBA7MnuAwdifZDbkS3JVVGGuUcG6g1f533JHoDr/I
    fxlmeEVB3HZMXQw1sYv5pxDHVXhib5o7KK7rcfwRSHA52Gy6IIqyHhNHOSf1mA/l
    nUOCQcHprze0G6lGkw6K1vim4bGYqtkjsU7SzUA5ZpNvpd+kNHW2nWoUbbtP8qek
    MRvSWbzE1h8xYGNm+mj1Tq/l1wuaxNxnzOa9SSBa+U4DeEn2Aw1wHyiBb6e+RrSz
    VLty0gTerJkLaLjcQwxw9x7trmBkj1VL3vbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523694946;
    bh=1LtiqvdbvlwrKwPwN8eRBn22dCODCvjpohQRmeYC/Pg=; b=LBORF6Bw7I54
    5n4bC66BFuukZbSIXNNkUEICY2vT2+Tzmvk8OMqzRxCwtzPdnof8vyP2lhPqQRxT
    hUwFh3B+z8NC+jD//01fApLbFYtipcKVwTpTWhSRxThQLZWKpBjDN7RxPxSMUloS
    4Pt8XNmutjx1VAIKe9pxtCLUrrgM4Ol5KzoFWPcDkINn27F0GHh6iO2mc5UewiZz
    qitztxbdbDk7KVaqprD4zjJUWmjP37Sa29vTUAlmf8bkeJZLMlDh73ePVqBwPXNQ
    mNOWzBMcOE4td0bSFPzjG/b7BB9ZgRftYs/7fPiuDQQC5qi37Dc1W7afzQNAOalm
    5UNIVlJRVQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b=YDNknM97 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=cogentembedded.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=hOvsOUyB;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=cogentembedded.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b=YDNknM97 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=cogentembedded.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=hOvsOUyB;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=cogentembedded.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJ+mlHZgVZDJJs6S5ssbGKmHHnuhg3qAHzL1/p4n1SIIx6iVLJNXrrA0PmPLeu5KfaRfffnQaw+dDZYzmqnIZ2nFpKIEbjRf5DS+zIp+w9Ll5tq+0qwe
    wbCrV7yDSfZiQKEv314BF0hpqUic6YKFmBKkjXT8/a1YwNUimoQi/Skni7/nsIQ0/KAiuyBjvd9ZKB3Zdl4zsM7qxoNmklkf/vRP0qw2WX574e3YVIHGCuLv
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=SkrdgQeYLficxMQpslcA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750912AbeDNIfk (ORCPT <rfc822;greg@kroah.com>);
        Sat, 14 Apr 2018 04:35:40 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:37668 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750849AbeDNIfi (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Sat, 14 Apr 2018 04:35:38 -0400
X-Google-Smtp-Source: AIpwx4858wyv5es/B9yep3IOWjeyraJl3y7CtB23pGybSEUpJ8fvj9r5xIckca58dELS52l5SJMzYQ==
Subject: Re: [PATCH v1 1/1] usb: core: Add quirk for HP v222w 16GB Mini
To: sathyanarayanan.kuppuswamy@linux.intel.com,
        gregkh@linuxfoundation.org, mathias.nyman@linux.intel.com,
        heikki.krogerus@intel.com, felipe.balbi@linux.intel.com
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        sathyaosid@gmail.com, Kamil Lulko <kamilx.lulko@intel.com>
References: <9bc2d73d74474258be14ec6a3fe243354e247679.1523640999.git.sathyanarayanan.kuppuswamy@linux.intel.com>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <c6569b4d-052f-bb9b-4e05-35dd29a067ee@cogentembedded.com>
Date: Sat, 14 Apr 2018 11:35:34 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <9bc2d73d74474258be14ec6a3fe243354e247679.1523640999.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello!

On 4/13/2018 8:40 PM, sathyanarayanan.kuppuswamy@linux.intel.com wrote:

> From: Kamil Lulko <kamilx.lulko@intel.com>
> 
> Add DELAY_INIT quirk to fix the following problem with HP
> v222w 16GB Mini:
> 
> usb 1-3: unable to read config index 0 descriptor/start: -110
> usb 1-3: can't read configurations, error -110
> usb 1-3: can't set config #1, error -110
> 
> Signed-off-by: Kamil Lulko <kamilx.lulko@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>   drivers/usb/core/quirks.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
> index 54b019e..f2ef913 100644
> --- a/drivers/usb/core/quirks.c
> +++ b/drivers/usb/core/quirks.c
> @@ -40,6 +40,9 @@ static const struct usb_device_id usb_quirk_list[] = {
>   	{ USB_DEVICE(0x03f0, 0x0701), .driver_info =
>   			USB_QUIRK_STRING_FETCH_255 },
>   
> +        /* HP v222w 16GB Mini USB Drive */
> +        { USB_DEVICE(0x03f0, 0x3f40), .driver_info = USB_QUIRK_DELAY_INIT },
> +

    Please indent with tabs (as above and below), not spaces.

>   	/* Creative SB Audigy 2 NX */
>   	{ USB_DEVICE(0x041e, 0x3020), .driver_info = USB_QUIRK_RESET_RESUME },
>   

MBR, Sergei
