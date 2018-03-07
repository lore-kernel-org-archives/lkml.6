Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4156463-1520455251-2-1423700483421115795
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520455251; b=ASpgw3gTo4mer8Q4yIz3IrOps4qyb0iv2Hu+W3VW6a2sVsd
    WmBcVt/gEKQ3mE9/l6zhSdB1MJpvuCJ4VLe4SmxLBs+0Dn9y6nbarnpkMa70anC3
    UOL+Hs6INwb6U7k4/vsejCt9k8Kmkt1rgiy+Ev4I9kwAEoOspWxNvnHbUHHBIH98
    UuSsVUsc0xHcxF4n65ZMZ739u8oRe9wScp6jjs11j7LKmHkcBAJZHxKaPAAisPUi
    8S4Fsrf9/iuSVur2Yg/kOXH0yNeSrU716Dak0kH51L8u09OUhgdrNtgahq+U2kj1
    foS//blBdvsdFXLiVY3hUL/2XYJ6oi6xGCNqSSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:cc:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520455251; bh=UXQIDMOxXXrqPdeoddn4icVbvtN6EkIgotMnq/GxWos=; b=v
    OBNDpCzfGvjYZJAuTLeqAkUIoIfVEWHKNhU3TT2aKJyCewPTdafVr8Ayzi+TJZSA
    5thOuJfCp02/teAp5k3K11rbgklk03EajAxMdZOi6sI9oHc7o0zXsCaY38ZALNw3
    hNRRBLTgC0G4Z6TRloXKZY0SGKooQucSE5zN/FbAh7nMiEg4yxjHqj+qr9YMwxci
    O2ANHjQc52ZsF3zKMauvG6jdQ9HKP+Z8Nnqacu3+swGjwHb32oCtL16dyyYUHe2i
    0VHq5blNdduNj6cXBl7Dbx3R2/gEjfdNzrS59CxSUdOe9lDVOX4/hJ+U/sH+v8S4
    ZWlksKPyl/8nm89DdOTTw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=mFAYTR9t x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=a3DKAD0+;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=mFAYTR9t x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=a3DKAD0+;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934842AbeCGUkf (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 15:40:35 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39399 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934713AbeCGUka (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 15:40:30 -0500
X-Google-Smtp-Source: AG47ELvwU6b3cBy1XUt48aSKsxSKqI2AODax3ZaPfUAXbhAcIohQuflq7gp2lTjSzv+Tc8GRlgFmuA==
Subject: Re: [PATCH 4.4 16/34] led: core: Fix brightness setting when setting
 delay_off=0
To: Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        Matthieu CASTET <matthieu.castet@parrot.com>
References: <20180302084435.842679610@linuxfoundation.org>
 <20180302084437.007951262@linuxfoundation.org>
 <1520436743.23626.33.camel@codethink.co.uk>
Cc: stable@vger.kernel.org
From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
X-Enigmail-Draft-Status: N1110
Message-ID: <86d4536e-11d5-40c4-4186-21955f809005@gmail.com>
Date: Wed, 7 Mar 2018 21:39:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <1520436743.23626.33.camel@codethink.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Ben,

On 03/07/2018 04:32 PM, Ben Hutchings wrote:
> On Fri, 2018-03-02 at 09:51 +0100, Greg Kroah-Hartman wrote:
>> 4.4-stable review patch.  If anyone has any objections, please let me
>> know.
>>
>> ------------------
>>
>> From: Matthieu CASTET <matthieu.castet@parrot.com>
>>
>>
>> [ Upstream commit 2b83ff96f51d0b039c4561b9f95c824d7bddb85c ]
>>
>> With the current code, the following sequence won't work :
>> echo timer > trigger
>>
>> echo 0 >  delay_off
>> * at this point we call
>> ** led_delay_off_store
>> ** led_blink_set
> [...]
> 
> The commit message got cut truncated here, which resulted in addresses
> being omitted when it was sent out for review.  The upstream commit
> message refers to a LED_BLINK_SW flag which is not used in 4.4.  So
> this fix probably isn't needed, though I can't tell whether it does any
> harm.

We discussed it in [0]. This patch is not needed for 4.4 and what's
more more it is harmful. It introduces a bug, fixed in [1].

[0] https://lkml.org/lkml/2018/2/6/726
[1[ https://patchwork.kernel.org/patch/10253933/

-- 
Best regards,
Jacek Anaszewski
