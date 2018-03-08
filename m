Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2833181-1520542172-2-5672289151184866123
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='windows-1252'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520542171; b=GOGt/ob4BxFXzzQuGxjo+/5eKal99ox27sbAXYlahbrHkR9
    mglfckh1L4Mwj4TSlOkC3G51uEpcx7byI+OVkY0azVDecFkPlzQ1k6/71JfN+v07
    QeBWAwDwtK1tCLoHSJ/BMZ+eWr5fDGYIMp/7B6f+1ERVHYJD8f5H31JSp1yzKmqS
    qnuBnWpccgiZ7DwsfkuCtcdfOgC84/6l0/QaV+SclQBuH13OzU0UBhl/w5ZEg0SX
    IFDaTElW1B2RgXoD8TMeWxWa18j7zkGy/imUZLVgnIIfcA4KabgRcDkS9d5/zjMf
    DMORpf9DlY6knFEqERAR4Jbo37zUzMkfh4JcSWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:cc:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520542171; bh=qVjmKgqIRw9mSdT8d1XYM28IrXYSHpd3hkvxMV4Udh4=; b=L
    KG0TIdi5hxtIi/BJh1YkXERaq9Ii369IhrVh2hKjNFM41jphblVUeF722ObsRgtS
    s5g/jwewufUYgjM/ii05iT9sheXYdtHpYeWzPofUpD4m3MfSOQyEKZNiSiq4pBxO
    6AmuQDQsA+5tvPuujWrCh9GHcMrEkYEgtnvaTl+rAjsVP1Z6fKqWVYQTa0NTWu7g
    hCf/uAkiQnkjKhzMHrRV1Bl9Bya40AnTRVlpXfDc5/M0uF0hK9LdB4xBnKzz/tzX
    kJLGI7vG45RK66clUiADDgQxU2+anO4R4mqlxTIk7/Qubcr0j96jI4cH/NBr+9Kp
    J1w5VlUhpJsZjmUoC0k3g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=FM8lurL4 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BfHN6/90;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=FM8lurL4 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BfHN6/90;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751293AbeCHUta (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 15:49:30 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:46670 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751194AbeCHUt1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Mar 2018 15:49:27 -0500
X-Google-Smtp-Source: AG47ELuwrQVDn9ilD6va0XIqCi2eAga76oiCiHQ8qTtp6kF+/2DYGjf2wROdZLboR5UX5aiWpDL4Bg==
Subject: Re: [PATCH 4.4 16/34] led: core: Fix brightness setting when setting
 delay_off=0
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20180302084435.842679610@linuxfoundation.org>
 <20180302084437.007951262@linuxfoundation.org>
 <1520436743.23626.33.camel@codethink.co.uk>
 <86d4536e-11d5-40c4-4186-21955f809005@gmail.com>
 <20180308172401.GB22224@kroah.com>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        Matthieu CASTET <matthieu.castet@parrot.com>,
        stable@vger.kernel.org
From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
X-Enigmail-Draft-Status: N1110
Message-ID: <57e2a60a-34c6-cd8d-adaa-dedcd8e5257c@gmail.com>
Date: Thu, 8 Mar 2018 21:48:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20180308172401.GB22224@kroah.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/08/2018 06:24 PM, Greg Kroah-Hartman wrote:
> On Wed, Mar 07, 2018 at 09:39:08PM +0100, Jacek Anaszewski wrote:
>> Hi Ben,
>>
>> On 03/07/2018 04:32 PM, Ben Hutchings wrote:
>>> On Fri, 2018-03-02 at 09:51 +0100, Greg Kroah-Hartman wrote:
>>>> 4.4-stable review patch.  If anyone has any objections, please let me
>>>> know.
>>>>
>>>> ------------------
>>>>
>>>> From: Matthieu CASTET <matthieu.castet@parrot.com>
>>>>
>>>>
>>>> [ Upstream commit 2b83ff96f51d0b039c4561b9f95c824d7bddb85c ]
>>>>
>>>> With the current code, the following sequence won't work :
>>>> echo timer > trigger
>>>>
>>>> echo 0 >  delay_off
>>>> * at this point we call
>>>> ** led_delay_off_store
>>>> ** led_blink_set
>>> [...]
>>>
>>> The commit message got cut truncated here, which resulted in addresses
>>> being omitted when it was sent out for review.  The upstream commit
>>> message refers to a LED_BLINK_SW flag which is not used in 4.4.  So
>>> this fix probably isn't needed, though I can't tell whether it does any
>>> harm.
>>
>> We discussed it in [0]. This patch is not needed for 4.4 and what's
>> more more it is harmful. It introduces a bug, fixed in [1].
>>
>> [0] https://lkml.org/lkml/2018/2/6/726
>> [1[ https://patchwork.kernel.org/patch/10253933/
> 
> So, did I mess something up here?  Am I missing some patch that I need
> to apply, or do I need to revert something?
> 
> confused,

It needs to be reverted in 4.4-stable, and Ben's patch [0] does what's
needed.

[0] https://www.spinics.net/lists/stable/msg223656.html

-- 
Best regards,
Jacek Anaszewski
