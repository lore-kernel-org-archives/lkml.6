Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3438615-1526234803-2-6549552064649659675
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='fi',
  MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526234802; b=ADh2eENXGmCtjopg0b174hBTw405pZr4wJUrWbVB2vxJHCmUs0
    nDg8FDldxjzCMR+ydV9qEMDE5X3mi9CdJK8hAtf8YCrlQ8NXgGH8HDaC8JHr9GBv
    FBa0Xpba4Skq7v31jNAYHsohIF2NsaPtujsbGCfbVSA/GzVDHnsyPgbHNd2IusaH
    i+rxalHsBDQ4KuOcuEWuK/ulhhp/stNN41CTdp+oeiRZgZOLB+pm5oAIU95SOYGJ
    cqvWSBo/9DtE7vZ5FxzzAfZ5y6u8VpYztER5sioedgC7IBKBvELeCbCK8xliD0hL
    UmSfnUq+NlHdzUR9VwAesGL3tmBfFtYhd/lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526234802;
    bh=lnwl+E/lx+DYcKBxdjX/cYlId0m1DFHET6QiIurSPIU=; b=e5K2H1RDAovn
    v/HLzjumEtd669jKOqMFNDqS7DKz3ok+nBAlJFYYzYuly8lLttSNMpb0SwuFRaQc
    GHhPpLiCpPR7AEYeTpzKW7p6joJhIjwNbDM5OWtGAk+7423xKUsSzJbTZanwx2+D
    n6fiA8XiJ61OD+ihWTKKEXblYA1LeYiE6nIBhxLIp231LwzZL8Byv8t3Hf7zoeZH
    WriV6jiQHG4zzS2z8Kai4EzPQAdaXfqYpo+1anBbAbPGaIFJtEuXBVxoCFzTQzY8
    DJHF2elTiDgYTJdzWeet5ngzwSqsYAividYmSxvNtRv78CYefqYWCCsQlToe7nmb
    KVzqd1OHCQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=kapsi.fi header.i=@kapsi.fi header.b=Ayp0Usg2 x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161220;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kapsi.fi;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kapsi.fi header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=kapsi.fi header.i=@kapsi.fi header.b=Ayp0Usg2 x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161220;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kapsi.fi;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kapsi.fi header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCpTYMm8GOMVdN0InfxQVy3686il9NDlWk0I5TrVcQO1hE6J/cESKm5IKQcHLaXYruv6zc9/emr7Wy8xt3tu80rP8PIj987uYKIcUGrwo3ZYUWQu3Urd
    iQW2oBYsSYCGTnek1WkVunoA1vWu5tEM/DEgRpMHn5o04Dag5FMrqkqXosC6ifmnpJ7xkVJNxBakFqBSQn9EGR0ejkBmJS4NJxfaunKUz2Lg2C+5PJ9rfhCc
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=Ikd4Dj_1AAAA:8 a=VwQbUJbxAAAA:8 a=9bLPFV2sn-Yrdq1Y9-wA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751457AbeEMSGk (ORCPT <rfc822;greg@kroah.com>);
        Sun, 13 May 2018 14:06:40 -0400
Received: from mail.kapsi.fi ([91.232.154.25]:60699 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751295AbeEMSGj (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 13 May 2018 14:06:39 -0400
Subject: Re: [PATCH 6/8] serial: Add Tegra Combined UART driver
To: Jassi Brar <jassisinghbrar@gmail.com>,
        Mikko Perttunen <mperttunen@nvidia.com>
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>, araza@nvidia.com,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org,
        ", linux-arm-kernel"@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        srv_heupstream <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180508114403.14499-1-mperttunen@nvidia.com>
 <20180508114403.14499-7-mperttunen@nvidia.com>
 <CABb+yY3snB9o4e14by4xui+o_Vhqpe2zh6Pp_e0t-DCTKvMHWA@mail.gmail.com>
From: Mikko Perttunen <cyndis@kapsi.fi>
Message-ID: <4d6aab52-9c99-8dd8-556d-86f32d9f6234@kapsi.fi>
Date: Sun, 13 May 2018 21:06:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CABb+yY3snB9o4e14by4xui+o_Vhqpe2zh6Pp_e0t-DCTKvMHWA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 84.250.162.250
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/13/2018 06:36 PM, Jassi Brar wrote:
> On Tue, May 8, 2018 at 5:14 PM, Mikko Perttunen <mperttunen@nvidia.com> wrote:
> 
> ....
>>
>> +config SERIAL_TEGRA_TCU
>> +       tristate "NVIDIA Tegra Combined UART"
>> +       depends on ARCH_TEGRA && MAILBOX
>> +       select SERIAL_CORE
>> +       help
>> +         Support for the mailbox-based TCU (Tegra Combined UART) serial port.
>> +         TCU is a virtual serial port that allows multiplexing multiple data
>> +         streams into a single hardware serial port.
>> +
> Maybe make it depend upon TEGRA_HSP_MBOX ?

Yeah, that probably makes more sense. MAILBOX is enough to build it but 
it won't be of any use without TEGRA_HSP_MBOX.

> 
> ......
> 
>> +
>> +static void tegra_tcu_write(const char *s, unsigned int count)
>> +{
>> +       struct tegra_tcu *tcu = tegra_tcu_uart_port.private_data;
>> +       unsigned int written = 0, i = 0;
>> +       bool insert_nl = false;
>> +       uint32_t value = 0;
>> +
>> +       while (i < count) {
>> +               if (insert_nl) {
>> +                       value |= '\n' << (written++ * 8);
>> +                       insert_nl = false;
>> +                       i++;
>> +               } else if (s[i] == '\n') {
>> +                       value |= '\r' << (written++ * 8);
>> +                       insert_nl = true;
>> +               } else {
>> +                       value |= s[i++] << (written++ * 8);
>> +               }
>> +
>> +               if (written == 3) {
>> +                       value |= 3 << 24;
>> +                       value |= BIT(26);
>> +                       mbox_send_message(tcu->tx, &value);
>>
> How is this supposed to work? tegra_hsp_doorbell_send_data() ignores
> the second argument.

The previous patch in the series adds support for what are called 
"shared mailboxes" to the tegra-hsp driver. For these the second 
argument is used.

Thanks,
Mikko

> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
