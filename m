Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3759944-1521095431-2-6571714933594973721
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521095430; b=BZWMQI6cXPTR+mgiBnF5CSKucp6CfH8OD21BQ30OY4zO3xN
    Zfd64XgTZk3kdv499zPxhdTOG/b26laM1TjF4Gj5CEh2InuJWsVzklZO79JgpvSb
    rkluw3n4Z64tMwvouRWxk7MHHwiDOC5TumNUOWnkuGE95/LmtG36Fn6o948PiJQ1
    oHf6KjwO4KHrGR/5JYJausLVh3vimfXd7ekhM5TTeGZ62e6L56fdRIoYvPCP/Z3+
    Z/JN8Iz9COhu7gaEplwxayGmeHpugpBZHthouGmstbsfLZZnlaOk/oVC5gH5PVZn
    M1IRUsv7NsMwW+wWDtg8zMzZU0Hjas+Yi2k7FDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:cc:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521095430; bh=n9TVtjQiIgc5DF9HghcEgVi4dUhu0St6jtGWjpTFxAo=; b=n
    ee5XO0Y+8cDuIEIjSYMpl2HwgI4VD8ZYv2v0ws5OTnCLgCTU7IkoWf6jxTrDXB9w
    eh1gRBrGT6aQbQ90ET1XuqEMg+L13izUZyb6Gn3wKSARDLa/Y3ylVnYyx+51L9Qn
    NRVdSoEVd5CHsiA4QqlEBK9puLWbhQRcl6Pb0J6TJ95hMSD400TS2cfCxTd9Im79
    XTnH59PjKIXLp+yWbyYdSWkwcMhZlDPf2zEf+aKOoqIWAL9+O2/MqWbEk1LhyiV7
    dcJvWreXpDmTd+8X9Af0BT+QcrR2nOap1a75NNg7TTucR8MbWBeSoKwV52yPcu9z
    xMO3mDrujN++CARdizEIA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=Z9WHy8mu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=Z9WHy8mu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751390AbeCOGa1 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Mar 2018 02:30:27 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:65330 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750731AbeCOGa0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Mar 2018 02:30:26 -0400
Subject: Re: [PATCH] phy: allwinner: sun4i-usb: poll vbus changes on A23/A33
 when driving VBUS
To: Chen-Yu Tsai <wens@csie.org>
References: <20180119092541.7508-1-wens@csie.org>
 <20180119144512.dqqbywavhwsyma2f@flea.lan>
 <a38e269f-abe9-0560-1542-c115c5a64605@ti.com>
 <CAGb2v66e+2wHGyZU+gAxho2-EiLX87VnV0E_xybbAv0FKvzToA@mail.gmail.com>
CC: Maxime Ripard <maxime.ripard@free-electrons.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        stable <stable@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <09638ac4-6a3b-3ece-2e3f-00b8f148ce9e@ti.com>
Date: Thu, 15 Mar 2018 11:59:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <CAGb2v66e+2wHGyZU+gAxho2-EiLX87VnV0E_xybbAv0FKvzToA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On Thursday 15 March 2018 11:47 AM, Chen-Yu Tsai wrote:
> Hi Kishon,
> 
> On Fri, Feb 16, 2018 at 7:20 PM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>
>>
>> On Friday 19 January 2018 08:15 PM, Maxime Ripard wrote:
>>> On Fri, Jan 19, 2018 at 05:25:41PM +0800, Chen-Yu Tsai wrote:
>>>> The AXP223 PMIC, like the AXP221, does not generate VBUS change
>>>> interrupts when N_VBUSEN is used to drive VBUS for the OTG port
>>>> on the board.
>>>>
>>>> This was not noticed until recently, as most A23/A33 boards use
>>>> a GPIO pin that does not support interrupts for OTG ID detection.
>>>> This forces the driver to use polling. However the A33-OlinuXino
>>>> uses a pin that does support interrupts, so the driver uses them.
>>>> However the VBUS interrupt never fires, and the driver never gets
>>>> to update the VBUS status. This results in musb timing out waiting
>>>> for VBUS to rise.
>>>>
>>>> This was worked around for the AXP221 by resorting to polling
>>>> changes in commit 91d96f06a760 ("phy-sun4i-usb: Add workaround for
>>>> missing Vbus det interrupts on A31"). This patch adds the A23 and
>>>> A33 to the list of SoCs that need the workaround.
>>>>
>>>> Fixes: fc1f45ed3043 ("phy-sun4i-usb: Add support for the usb-phys on the
>>>>                    sun8i-a33 SoC")
>>>> Fixes: 123dfdbcfaf5 ("phy-sun4i-usb: Add support for the usb-phys on the
>>>>                    sun8i-a23 SoC")
>>>> Cc: <stable@vger.kernel.org> # 4.3.x: 68dbc2ce77bb phy-sun4i-usb:
>>>>              Use of_match_node to get model specific config data
>>>> Cc: <stable@vger.kernel.org> # 4.3.x: 5cf700ac9d50 phy: phy-sun4i-usb:
>>>>              Fix optional gpios failing probe
>>>> Cc: <stable@vger.kernel.org> # 4.3.x: 04e59a0211ff phy-sun4i-usb:
>>>>              Fix irq free conditions to match request conditions
>>>> Cc: <stable@vger.kernel.org> # 4.3.x: 91d96f06a760 phy-sun4i-usb:
>>>>              Add workaround for missing Vbus det interrupts on A31
>>>> Cc: <stable@vger.kernel.org> # 4.3.x
>>>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>>>> ---
>>>>
>>>> This list might get longer if the newer AXP8xx PMICs also have this
>>>> behavior. We could switch to a boolean in the per-compatible data,
>>>> or just always use polling. The yet-merged R40 support will have this
>>>> issue as well, as the R40 is paired with the AXP221. But for now,
>>>> I'd like to have something that is easier to backport to stable, so
>>>> we can at least fix this for the A23 and A33.
>>>>
>>>> Also, checkpatch.pl doesn't like the stable kernel prerequisite lines.
>>>
>>> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>>
>> merged, thanks!
> 
> I see you moved this patch from your fixes branch to your -next branch.
> Is there any problem with the patch? Merge issues?

Decided to keep in -next since this is not a regression introduced in 4.16
kernel and stable kernels will anyways be updated.

Thanks
Kishon
