Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3758820-1522828934-2-150415256239112105
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522828934; b=atlvmmCydeoturiloymidsx9I8YovOPMd889afvdnYm0yy3sga
    s79xVps4/iF6UeASNrmU85nZ8SQrZ71TpCAjQ98Z93CTarX/jbSclHYZghpR1yPf
    iPWlTuupwF6txJT64wIJYobTil9IEvW84a62Ol5VmxUnTabhYFa2igXydk3k0u3a
    cxurJC7/ZdrQWCdApdjvs3eM8BUc7kvUu1dxaJqgkyMq5+jHGQuHiN10QHQfUkEt
    h6sBKldmp27GhUIdPYDQ+/hEydAdqFjJ6at9P9dUBpEKwrsRdJ2Rbvx/rIknpKtf
    VDl7Xt5lkR4ny85smALEW/AUd8tx7uxjcI5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:in-reply-to:references
    :date:message-id:mime-version:content-type:sender:list-id; s=
    fm2; t=1522828934; bh=YWJXtMJphDyMSTAv0LFlHPAI62ZXu31QLOvth37IJu
    g=; b=gRZB9juOaDzUIkJLFW95E5E6R6wBm8zaXOcmWw5MEYvn2/Q36/usgnN4VC
    SLvhcRffa5tQJZxrs+Qlbol2L8mhITXa9u7y2xDWt2qCjtj1nz592qtkbwz1e/SM
    TWOVa3+YVvnb6dB9wMN8jZY9wS1e9soTdlNkgJ8t/LvhmqlRDylOOu0o9WSIxZ1l
    PfTKR/I7/Pv4PAo90s8ucmm1Y5sgkkyK5RWDhRs7kRvUzc2lju/JVMauip9+InHo
    mV3mZjCWAtsl8M/qW0vGT8WKEG8/Hpx5lFKfnMqWQP57o3HTTnbgAQVET+q4XHrg
    jG8sfypfJFeekSNJbL9goz/b3vyg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIWWjzmNrPOyufBKN4FV/YtWutQRbm6UpO1HEHj9MP4zWs5x/Yq0NdQ27lWNfOcy9SbztBJybpz+Gl2IzVaQs8x3YxW0W/IlO14E1mN6e57qskuLqVFp
    FRcpBfYz1VoP6GOu+nIhTYYJfTGtPbZowD4RelOJiUX5Tk9QIj136t3ACT/ZWRwJ5wvT/E9mcUjr22zmNMGsiD78k0Lk6envdzZpZR9z32VHnCeYbVYv24zf
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=c-n4J4-pAAAA:8
    a=VwQbUJbxAAAA:8 a=Ndx7yIVex8M7RJDNeXoA:9 a=x8gzFH9gYPwA:10
    a=L0NDqeB7ZLmQzAogN4cw:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750915AbeDDIBh (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 04:01:37 -0400
Received: from mga06.intel.com ([134.134.136.31]:33542 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750736AbeDDIBg (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 4 Apr 2018 04:01:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,405,1517904000";
   d="scan'208";a="43879302"
From: Felipe Balbi <felipe.balbi@linux.intel.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: Multiple generic PHY instances for DWC3 USB IP
In-Reply-To: <CAK7LNATpFZYK-f4j7sJpur-u43bK1gsz_eS1wurTq7C+n6pHAw@mail.gmail.com>
References: <CAK7LNATkS6pFQ9Gexm1uiG8e-3x6QXh-GYs3ABVEQzBnFK5gqw@mail.gmail.com> <87vad7cz2i.fsf@linux.intel.com> <CAK7LNARBVG54o+fozHk8efXUNk8GSkRcRcdDNrtUhDs5kOA7=Q@mail.gmail.com> <87po3fcxs4.fsf@linux.intel.com> <CAK7LNATpFZYK-f4j7sJpur-u43bK1gsz_eS1wurTq7C+n6pHAw@mail.gmail.com>
Date: Wed, 04 Apr 2018 11:00:54 +0300
Message-ID: <87woxns8nd.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Hi,

Masahiro Yamada <yamada.masahiro@socionext.com> writes:
>>> Each DWC3 instance is connected with
>>> multiple HS PHYs and multiple SS PHYs,
>>> depending on the number of ports.
>>
>> in that case, you shouldn't need dwc3 at all. A Host-only dwc3 is xHCI
>> compliant. If you really don't have the gadget block, there's no need
>> for you to use dwc3. Just use xhci-plat directly.
>
> Sorry, I was misunderstanding.
>
> Some of our SoCs support gadget,
> so we need to use the dwc3 driver.

fair enough. Now we need to figure out how to pass multiply PHYs to a
multi-port dwc3 instance.

Kishon, any ideas? How do you think DT should look like?

-- 
balbi
