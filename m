Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3855215-1522831425-2-4656057336908942755
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522831424; b=Emv9bpcMp0SrGI3kkZDF6GihlS2zhOuMagcrsyi5jBVUvgD36d
    csRpAU4yJJB/ZUndFYkfNo5V0Q0bF/+vfDndbXnCABDdjUbWcvilHUfXDdCRxB9F
    rNMJy4AZIKQdxOFsmOp27E68oJ95iFatle/g/DiRZJsEkCEzztdyE4C1mLe8MOZT
    xmT3+yl9jERjM6aXJf9qwM1zrjtfyLY6DJ9SA0w3/84LMsnQ+aNDNeqZcPUlAz7H
    a5G0BG93g67nB0FpTE3Ai8sElN81UuI28C9pOuRTntPexhZWl2BtRsFBvCnZLAhL
    6+pYpHaP00blf2/Y/geAkvyjtN4ZOKthpt3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522831424; bh=t1S9YyBdp8+DZtKHOlC3sbfEuJSkt/jbTP+X1ltk0F
    8=; b=NtngXeRYQStl3RFVti9Edoqj3+At12Pw141Cic7ryVd4KiE6qZLJ8v+03e
    FjtOCMWu1KococxD56gF3+VAzPvTe6L/5b1X6KIzS7RiE0vxffebvgW2qgrkH/rJ
    uXheqHVb2EDhfj9ftpnnVu4ruQ0LDkYRhdLX58lnfLyA+F/vi3PChbk9ULNo2Uz+
    EUWI7qzxAZecOZ+0VcGqcjBi2NGQX16FRgQWFJHn5IPFvPO81LXozIERrGugcqu5
    pmEReJLfNaynGam2wi6ljVKQfUei+ikGQXqpVGMnyeNd04sG/QwwXSXWySkMEVkF
    3azvJ4bm5hn7Glf87YcWK5sxBAkg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=squpVcLa x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=sY0eB+6j;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=squpVcLa x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=sY0eB+6j;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFv7BINTuD35nRjEopJ8IMhBeBnMPKMw122f2q2FpZy3IIXtm9Rovo2Ysjrks2Ex2Z5eLuCyxIac/QbFW0qB3Ss4PKd3B3GNhuZ05M8FbDM4/gbcHBlX
    xthM9J0vyuLULxzGALCp5QGm3uD6D5hVRmxwHfZJS63JhGuYY9Up0tX1Yo2G1rKtDVizAfa5L9wUvJiWAn6MAjRps7IM/jsDhKzUIS95MhBqukKuJFadfqOZ
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=QyXUC8HyAAAA:8 a=c-n4J4-pAAAA:8 a=OLL_FvSJAAAA:8 a=VwQbUJbxAAAA:8
    a=6LxprBTznkn4I3Ws_C4A:9 a=QEXdDO2ut3YA:10 a=UeXTCEmezP8A:10 a=x8gzFH9gYPwA:10
    a=B9tjyiFVUVcA:10 a=L0NDqeB7ZLmQzAogN4cw:22 a=oIrB72frpwYPwTMnlWqB:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751426AbeDDInb (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 04:43:31 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:40018 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbeDDIn2 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 4 Apr 2018 04:43:28 -0400
X-Google-Smtp-Source: AIpwx4/WvgtuubHI76r8dcIN/i33vOibNMlLfwZ7XSV0dhoQOyBnvDkaxwvZpw5k58R4dumxTbNe5JPsZrFR9CTvUO8=
MIME-Version: 1.0
In-Reply-To: <87woxns8nd.fsf@linux.intel.com>
References: <CAK7LNATkS6pFQ9Gexm1uiG8e-3x6QXh-GYs3ABVEQzBnFK5gqw@mail.gmail.com>
 <87vad7cz2i.fsf@linux.intel.com> <CAK7LNARBVG54o+fozHk8efXUNk8GSkRcRcdDNrtUhDs5kOA7=Q@mail.gmail.com>
 <87po3fcxs4.fsf@linux.intel.com> <CAK7LNATpFZYK-f4j7sJpur-u43bK1gsz_eS1wurTq7C+n6pHAw@mail.gmail.com>
 <87woxns8nd.fsf@linux.intel.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 4 Apr 2018 10:43:27 +0200
X-Google-Sender-Auth: SrSGRxXERZVISJQ_I8XR_4hTdk8
Message-ID: <CAK8P3a0t4ooQNJrak_r_Qc2T4UeQB9k3SgStuaBptV2DcA8SBA@mail.gmail.com>
Subject: Re: Multiple generic PHY instances for DWC3 USB IP
To: Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 4, 2018 at 10:00 AM, Felipe Balbi
<felipe.balbi@linux.intel.com> wrote:
>
> Hi,
>
> Masahiro Yamada <yamada.masahiro@socionext.com> writes:
>>>> Each DWC3 instance is connected with
>>>> multiple HS PHYs and multiple SS PHYs,
>>>> depending on the number of ports.
>>>
>>> in that case, you shouldn't need dwc3 at all. A Host-only dwc3 is xHCI
>>> compliant. If you really don't have the gadget block, there's no need
>>> for you to use dwc3. Just use xhci-plat directly.
>>
>> Sorry, I was misunderstanding.
>>
>> Some of our SoCs support gadget,
>> so we need to use the dwc3 driver.
>
> fair enough. Now we need to figure out how to pass multiply PHYs to a
> multi-port dwc3 instance.
>
> Kishon, any ideas? How do you think DT should look like?

See this series from Martin Blumenstingl:

https://www.spinics.net/lists/linux-usb/msg166281.html

      Arnd
