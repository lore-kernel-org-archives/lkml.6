Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3038698-1522677798-2-12386984332370557594
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522677797; b=lhzHNT9DF0j5iDxtmVIJiJYr3RDGCT35xjq+KeHTb2bMyyW42+
    vsD2IQkd7kLlH8opW4lKsG/Kpj78dtFEFOV/FEKT/0jaejmA+HtrWONDrpmK09+S
    yqSJ9Sodr3qUK1x5fujLTpFszcsL8W5sjGBKh0gNpQAyosiETjtH4BZGJzP/SAUa
    cpYfLnUwpoMqPwgkIrjYCSmlbmKDc3JV1rA3Ej4QCC87Iw7KOV11sXkYM4/NVIfR
    phJq1I1SB3ngWPSuWd4r3xemtt/Q2beX22ANoB+wb8WSS3mKm9sN1f9BrUjCtDI2
    m9WFcVahuEmX6T8uElvXglOuvS3mZ/XQVdEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522677797; bh=ZmszqswMGUV9wx2o6wYWXHqKp9AVxF1WZ1sW61I8qn
    Q=; b=F7WY246FCUdP/HIul4aIxw3duyoDHdsKGSE4f2KhfGKyLbdufe1NQhCjLK
    H9c2gic8PfVM4PuSBZck9vlo5eDdyRpueGUF9EM79upGw3bOgIH/EDr+t+YYh6gD
    senTVr9E7AE/Xx6Xqm0tw0s/XiuWxy6YwSYyhfoOlqLln/9kIN2AtNbL5czwRPoM
    jK6dKcTI6j+e5T4OaiDo3QVCx2c1hRgBoWE6OCBM7tGDQpinQ4AgLsyKGPTgFNhC
    hJXooAwLn8knbnJEe6gpfBcbIYJ4UdawoT3ngu63tEFyC5iBA3Jb4NPv8/6jfgWa
    XWgrqsIOAuYUhqpBBbZz74lOlY8g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=iTf9b0WK x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=AhWq67UX;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=iTf9b0WK x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=AhWq67UX;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFZpgM/ns0A4pn8YG94+sOaHf46YFkCcxurYT2wOT1OS8RpTxoIh9kpqnRzjdKApsk19oLDwWg3waEfb806WnoWdC6jMBc9PL0FePrVie/QDlFkIOysf
    YLaeHlpUq8YCia5+EEQeIbhK4Uf/fnYukmD9ZXXeybiEiNgroBvcLimmh3Pwl/UWFsV73FmlqZfuCz4OGjRgV/GZxOSOvVRTF9nvgia9RxDis9S7X0fdt7fS
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=fbV3Th2LUxsA:10 a=Kd1tUaAdevIA:10 a=pGLkceISAAAA:8 a=sozttTNsAAAA:8
    a=VwQbUJbxAAAA:8 a=_3iAN5dmJPxjh_Nw_akA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=aeg5Gbbo78KNqacMgKqU:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751313AbeDBODQ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 2 Apr 2018 10:03:16 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:47001 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751255AbeDBODP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 2 Apr 2018 10:03:15 -0400
X-Google-Smtp-Source: AIpwx4+6nSqv2t3L/ibOssRA+47Jb5jsTrVtebFFSLU7CYQZ1t9VYtntUL1EjdN0YPkXuP3K9omtKh5QAetQIM7K8ZU=
MIME-Version: 1.0
In-Reply-To: <CAHp75VdKxsAb4ect_no0g8N2+DQ_OoitWKM8ZH6ao-sfD5dekw@mail.gmail.com>
References: <20180402122037.2710-1-vigneshr@ti.com> <CAHp75VdKxsAb4ect_no0g8N2+DQ_OoitWKM8ZH6ao-sfD5dekw@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 2 Apr 2018 17:03:13 +0300
Message-ID: <CAHp75VdLNQ8VMWUZMOtP75vSEvxHtOihV-qA1LqB-S6QThmiFA@mail.gmail.com>
Subject: Re: [PATCH v2] serial: 8250: omap: Provide ability to enable/disable
 UART as wakeup source
To: Vignesh R <vigneshr@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Tony Lindgren <tony@atomide.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 2, 2018 at 5:01 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Mon, Apr 2, 2018 at 3:20 PM, Vignesh R <vigneshr@ti.com> wrote:

>> +       if (!device_may_wakeup(dev))
>> +               priv->wer = 0;
>
> Can it be
>
> priv->wer = device_may_wakeup(dev);
>
> ?

Answering to myself, missed that this value is used as actual one for the HW.

-- 
With Best Regards,
Andy Shevchenko
