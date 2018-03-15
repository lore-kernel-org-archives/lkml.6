Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3733408-1521094698-2-9859163876297398038
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521094698; b=AlebhWA+tMeFK6FwiB6SKBOCitsQyDdFx+tOYHdRjwAGyZq
    2BV68/6T2fddN9HnVgHdoIZJrwWzy0eSaJVtriqfExRfzTTCCvXHb6GAtMJKjSGh
    DV/pC8tYBQSMoqkUkyXrBgc7MqHM0kDMi4jIEzjRulOt5cUjq91H9h+zxpcnE1Ln
    kVl2MscV5C5SJqauvgYjnj6wQZtXP1s5QbnAYavG2Y7Hzrx7zGCE49psB7xXPrJk
    m9ozKsymwBINB61wP0DKfA5QJbdwbwTCbpaEPvAa1PuCn3tRwIMW84PxcVBN+C4G
    9PXP3mDOrvkD7A/lry2xHT0mG4tFAXCElJFUtFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1521094698; bh=OCH20j6SC/XwO6GwkSaEAttLaWLu4rG6kcSVdd
    ERX1U=; b=maCyiIT2GG5NBfMz4Rc0+EKiNO2xBrpWk2LzdEGWTWcf/SG3mvQyUi
    3DBlg8WPw1/9KAiG2hfG2Q3WK43yXd50X2j9HLw1JhOMZrNlTNqRtnPtjr2j9PaJ
    zevH37QBT9lrt+AHZ7qiQKHkHJ5QbQZd5jNLLtE19h+1FuGLD6PpYfpMdn2ugYK6
    LeFpPsiiEcM6XfUzIp2Tsr8YtalYB2PtRavJLHevCEVgJN9paLoxFwdupno6BKp8
    P1dPOoWtFOu5wtDXaphhH7713kNSBjFHjDvIVjaLM5qc5Ek1lmxMl0Ay60LgwRY2
    PKv8S4xQhgLrVdXjaObIZk7rfIsoDh3g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=csie.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ujAv2SMn;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=csie.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=csie.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ujAv2SMn;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=csie.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750745AbeCOGSQ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Mar 2018 02:18:16 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53832 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750720AbeCOGSO (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Mar 2018 02:18:14 -0400
X-Google-Smtp-Source: AG47ELs16oBPQLfqHPUqUOdYoaPneiqBEPGarwQ4Ezhg75AfJLat135WlWwxEUoTKUyVJuGEZ/TM6A==
MIME-Version: 1.0
In-Reply-To: <a38e269f-abe9-0560-1542-c115c5a64605@ti.com>
References: <20180119092541.7508-1-wens@csie.org> <20180119144512.dqqbywavhwsyma2f@flea.lan>
 <a38e269f-abe9-0560-1542-c115c5a64605@ti.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 15 Mar 2018 14:17:51 +0800
X-Gmail-Original-Message-ID: <CAGb2v66e+2wHGyZU+gAxho2-EiLX87VnV0E_xybbAv0FKvzToA@mail.gmail.com>
Message-ID: <CAGb2v66e+2wHGyZU+gAxho2-EiLX87VnV0E_xybbAv0FKvzToA@mail.gmail.com>
Subject: Re: [PATCH] phy: allwinner: sun4i-usb: poll vbus changes on A23/A33
 when driving VBUS
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Kishon,

On Fri, Feb 16, 2018 at 7:20 PM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
>
> On Friday 19 January 2018 08:15 PM, Maxime Ripard wrote:
>> On Fri, Jan 19, 2018 at 05:25:41PM +0800, Chen-Yu Tsai wrote:
>>> The AXP223 PMIC, like the AXP221, does not generate VBUS change
>>> interrupts when N_VBUSEN is used to drive VBUS for the OTG port
>>> on the board.
>>>
>>> This was not noticed until recently, as most A23/A33 boards use
>>> a GPIO pin that does not support interrupts for OTG ID detection.
>>> This forces the driver to use polling. However the A33-OlinuXino
>>> uses a pin that does support interrupts, so the driver uses them.
>>> However the VBUS interrupt never fires, and the driver never gets
>>> to update the VBUS status. This results in musb timing out waiting
>>> for VBUS to rise.
>>>
>>> This was worked around for the AXP221 by resorting to polling
>>> changes in commit 91d96f06a760 ("phy-sun4i-usb: Add workaround for
>>> missing Vbus det interrupts on A31"). This patch adds the A23 and
>>> A33 to the list of SoCs that need the workaround.
>>>
>>> Fixes: fc1f45ed3043 ("phy-sun4i-usb: Add support for the usb-phys on the
>>>                    sun8i-a33 SoC")
>>> Fixes: 123dfdbcfaf5 ("phy-sun4i-usb: Add support for the usb-phys on the
>>>                    sun8i-a23 SoC")
>>> Cc: <stable@vger.kernel.org> # 4.3.x: 68dbc2ce77bb phy-sun4i-usb:
>>>              Use of_match_node to get model specific config data
>>> Cc: <stable@vger.kernel.org> # 4.3.x: 5cf700ac9d50 phy: phy-sun4i-usb:
>>>              Fix optional gpios failing probe
>>> Cc: <stable@vger.kernel.org> # 4.3.x: 04e59a0211ff phy-sun4i-usb:
>>>              Fix irq free conditions to match request conditions
>>> Cc: <stable@vger.kernel.org> # 4.3.x: 91d96f06a760 phy-sun4i-usb:
>>>              Add workaround for missing Vbus det interrupts on A31
>>> Cc: <stable@vger.kernel.org> # 4.3.x
>>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>>> ---
>>>
>>> This list might get longer if the newer AXP8xx PMICs also have this
>>> behavior. We could switch to a boolean in the per-compatible data,
>>> or just always use polling. The yet-merged R40 support will have this
>>> issue as well, as the R40 is paired with the AXP221. But for now,
>>> I'd like to have something that is easier to backport to stable, so
>>> we can at least fix this for the A23 and A33.
>>>
>>> Also, checkpatch.pl doesn't like the stable kernel prerequisite lines.
>>
>> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>
> merged, thanks!

I see you moved this patch from your fixes branch to your -next branch.
Is there any problem with the patch? Merge issues?


Thanks
ChenYu
