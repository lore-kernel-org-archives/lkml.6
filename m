Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1810880-1520512295-2-4963085514114516971
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520512294; b=tq6nJgp9B/wfi7aZGdLpYJtgSxRWk7QrTO+S851BB+VKjgC
    4/+ZLklZithx/WWqfvry2MHdGF4nuayiCURsGVKEQ1Dgp3texwF+sWSqCuQDF1Fc
    g6doI007vsvkYWuDX41SYSDakciQAG5TUOv9fXlqCeOdWvLfzxc/Md4ZR+EpElFi
    ltQN4rUYwdNvnaz8PQ3xoH9sWgnZCS55PDzZL2VTDhtW60O2zFdC4B293nF6AjoC
    UyPH84g0umUWbb4fgRF7xLE5RaT8XgtqpMdlcIYhOHgv6cRZYpVEUbvX5/Z8mIe0
    ClNz3ykLjIx8pPgWmwwPg6g2h2sr2WtALR9lIpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520512294; bh=pPhWGlboq2spzieaW2EW+TLS51vfnTQhOKRKY13cV7w=; b=Y
    wxbGYbj+lDC1lOpLkwwywNFNaQqRXvKRpIepBZFunkNh+wd9bSdSlzOcyBFcLW8v
    IIbDNoWiNd1pvQebFUOPf2cw3nCnez/AbyisgN9abiVorcm8YmrVIrTg3tRFGYVO
    tEPBvAHey3MQiMR83DOaokNZ5+pC9DMUzaYLPEzxPg4sGY2yF9SIyGuLv51Q6Ej1
    HfROlP4e48+lxptAPXEOa70SogycZKIwSGH/OPBQosAx8ZdkBiFax9C7RSeVsRva
    7oG+8K3oyrV7h7vApns9NETWloCbQMdL3MFDRqbZi4iuFxkpG2BlgqdUG8rnxuBO
    YSRpxEmv2I1BKUiZfA8fA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=XX9ljt7s x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=XX9ljt7s x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754806AbeCHMbU (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 07:31:20 -0500
Received: from fllnx209.ext.ti.com ([198.47.19.16]:57106 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751355AbeCHMbT (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 8 Mar 2018 07:31:19 -0500
Subject: Re: [PATCH v2 2/2] usb: dwc3: add dual role support using OTG block
To: Felipe Balbi <balbi@kernel.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1519730952-2102-1-git-send-email-rogerq@ti.com>
 <1519731019-2220-1-git-send-email-rogerq@ti.com>
 <87lgf2vol2.fsf@linux.intel.com>
From: Roger Quadros <rogerq@ti.com>
Message-ID: <7c9382af-bd99-2599-35b1-863320517a0c@ti.com>
Date: Thu, 8 Mar 2018 14:31:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87lgf2vol2.fsf@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Felipe,

On 08/03/18 12:39, Felipe Balbi wrote:
> Roger Quadros <rogerq@ti.com> writes:
> 
>> This is useful on platforms (e.g. TI AM437x) that don't
>> have ID available on a GPIO but do have the OTG block.
>>
>> We can obtain the ID state via the OTG block and use it
>> for dual-role switching.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
> 
> patch one applied fine to testing/next. But not this one:

That's because you will need this commit from v4.16-rc3

c4a5153e87fd	("usb: dwc3: core: Power-off core/PHYs on system_suspend in host mode")

Could you please apply that and let me know if it works?

> 
> checking file drivers/usb/dwc3/core.c
> Hunk #2 FAILED at 107.
> Hunk #3 succeeded at 122 (offset -5 lines).
> Hunk #4 succeeded at 166 (offset -3 lines).
> Hunk #5 succeeded at 365 (offset 5 lines).
> Hunk #6 succeeded at 382 (offset 5 lines).
> Hunk #7 succeeded at 1193 with fuzz 2 (offset -145 lines).
> Hunk #8 FAILED at 1383.
> 2 out of 8 hunks FAILED
> checking file drivers/usb/dwc3/core.h
> Hunk #2 succeeded at 901 (offset 33 lines).
> Hunk #3 succeeded at 1040 (offset 35 lines).
> Hunk #4 succeeded at 1316 (offset 46 lines).
> Hunk #5 succeeded at 1334 (offset 46 lines).
> Hunk #6 succeeded at 1380 (offset 46 lines).
> checking file drivers/usb/dwc3/drd.c
> 
> care to rebase?
> 

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
