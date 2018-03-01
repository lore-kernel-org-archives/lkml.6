Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2558661-1519896795-2-13575195480312056087
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519896795; b=dneDEDt8sXaX7Dkd4SRQ4JxLCEMSMSdoXX6hu7QJ7QSzOde
    E/6dDcvs2VDQsSEn4E4F5eC86dNssrBc8isrG09Ej33AImAlHBzxelRRpfbaTIEi
    ZAqzB5G4xvkrN2kbtOtF9SiGHlWJrDb+t3iuGjUKosKiESsNspajGzHUNKOeqbM6
    UQHvYlEzN4WEUxTSp4SO/hZZ49xOsSRkCR2CWwdm2nBHf7MyF5dcMtRmiKR95gDW
    yZv+91dJcdeOai9sSKCZbMbYXGcWdQs9tal2Md3HTw0m8vFpoOkly/LZxfjtSbR2
    YUu6MlIZjSXuaVvHvCAgG7kYC1crMGFTzAqDMmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1519896795; bh=AW5uCmUdaUu156Hhcg/GpKj734R/dUkI2GTy8E
    ew07M=; b=vTCQ9w8BrdJSYbP7nyqFix4MKHcGF4y36uKjnncJ39yHYTH3VYSD8s
    6lrKkfgcajlCRppRy4KeBvL9Jv62uNUz+DwrgDwDRcO5cssB3GIgSgwO3dqJKgxk
    SeW/YSHzjKeI7YHl1mPqQUo7R0L4A6HVv48OO/ifrVmKL1z/zkDVbox5C1TnwJMA
    r2qbDcE1EZAEVOwq4eMwrW5iZRIjZyZO1+QfsVo7CH5TrLk6BngRvN6QTykv+OJG
    2F1U07W+fttzUfFw+z1XLoblHOf+6HdMf1Syhqg0Dkn13MAWaWD3tzDlCuO0SMLG
    h5Yt5t1Oh9SX5DahdMLOjHR8QsJcINjQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=kO/vNGRf x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=kIKSltoI;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=kO/vNGRf x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=kIKSltoI;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966919AbeCAJcv (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 04:32:51 -0500
Received: from mail-qt0-f172.google.com ([209.85.216.172]:45646 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966675AbeCAJct (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 1 Mar 2018 04:32:49 -0500
X-Google-Smtp-Source: AG47ELs/M8MQqPMPlllfSek4GTXpHprrDgzZBalSRDj24pzW3cRaBou6W5KSj78UnP7NX22g1fDeaq9mcASCZ/CA/o0=
MIME-Version: 1.0
In-Reply-To: <20180301072825.GC5335@kuha.fi.intel.com>
References: <20180228150749.26831-1-hdegoede@redhat.com> <20180228150749.26831-2-hdegoede@redhat.com>
 <VI1PR0402MB3917DD93F114873CC736117389C60@VI1PR0402MB3917.eurprd04.prod.outlook.com>
 <20180301072825.GC5335@kuha.fi.intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 1 Mar 2018 11:32:47 +0200
Message-ID: <CAHp75Vc4CF_Vn90FdFKwBf7egPNHvEWa=mja8w4SarKaW2KZRw@mail.gmail.com>
Subject: Re: [PATCH v5 01/12] drivers: base: Unified device connection lookup
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Jun Li <jun.li@nxp.com>, Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "platform-driver-x86@vger.kernel.org"
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 1, 2018 at 9:28 AM, Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
> Hi,
>
> On Thu, Mar 01, 2018 at 12:56:57AM +0000, Jun Li wrote:
>> > +struct device *device_find_connection(struct device *dev, const char
>> > +*con_id) {
>> > +   return __device_find_connection(dev, con_id, generic_match, NULL); }
>>
>> -       return __device_find_connection(dev, con_id, generic_match, NULL);
>> +       return __device_find_connection(dev, con_id, NULL, generic_match);
>
> Good catch!

It seems I proposed to put function first parameter followed by opaque
data pointer for it.
In that case it would be exactly like now.

Though, I didn't check if the parameter ordering was changed in the prototype.

-- 
With Best Regards,
Andy Shevchenko
