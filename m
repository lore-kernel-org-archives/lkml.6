Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-121884-1518785565-2-3866882147472114009
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518785565; b=nwKU6J/2N8XrgGaEeTQnj7XXGPbF6oCVW0PhcpZaVJmecA4
    QN/vYFiPVJFNsyneTdLqedrGYDfhAq7dLrRQWLEgNuHIPoH3MF0gFIXpfyFFqBgX
    VhV2pcRh72Bx8qvOP+3YjCM2MvaEABYIHTedDCSqz2uycLm3NO05dAUFW3uDI0RL
    515CXOb3qVrG3qM/MF8flLIRSqSuwp3fu9IRLipGHeOxpzhvumxN96npyApAaW4K
    5beW2TXmaTLG//2V4M8/dSLJbFBuRqReVXcfJG+PePbNDwc9lfPg8OhGf4FDKImW
    rsgRHbMRU1p8i4oTNANLERamiVX2x+SBq+syhxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1518785565; bh=0a+aAm/q8DS/PPL8rhM3HEluRfo7lMPZwNV/kF
    SHb+Q=; b=edYaigKy6s9eeZ1RNAk2lry7TI8QKDs3gnqakbKe592SEDw0vfBR9g
    jfLkPuPTz2AB5ewkDP3oB6jNTL/8qVDJw6FQd40JV44MrU53plKfaXA83X8d4dYl
    /KppdMSXz/WVXmZo7NJ3nJZy0anPZBr542e7CBmzvNczq0EwxtMNSWVu5EPpiGrZ
    oe19ZNDh7w7bJD+qVOg1R0XQVF5Jm5M1YsSs2wfO4HTAFCcBu04yJXor1ztVf1Qe
    YInZggekGogfhOyjEQwswEynzaaD2YmPmrzwHgxyf86iiMYpBk/z0eUyvYM1OZ4m
    qeex9WEpoI++/YcpcF7ZAKPJpYtVloQQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=csie.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=n4tJBBaY;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=csie.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=csie.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=n4tJBBaY;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=csie.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967718AbeBPMwn (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Feb 2018 07:52:43 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40861 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967661AbeBPMwm (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Feb 2018 07:52:42 -0500
X-Google-Smtp-Source: AH8x22527OXVrEdDW4JFRs2IsqHK/djAhKq0POutP47MYZ2K3hOJFypIPnxmpFkLtK3ANlmyJEZjZw==
MIME-Version: 1.0
In-Reply-To: <a38e269f-abe9-0560-1542-c115c5a64605@ti.com>
References: <20180119092541.7508-1-wens@csie.org> <20180119144512.dqqbywavhwsyma2f@flea.lan>
 <a38e269f-abe9-0560-1542-c115c5a64605@ti.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Fri, 16 Feb 2018 20:52:19 +0800
X-Gmail-Original-Message-ID: <CAGb2v64i43RsN7rrPseRiDBJdFGNZW9gr6BrDCJNg2e=m1F8VQ@mail.gmail.com>
Message-ID: <CAGb2v64i43RsN7rrPseRiDBJdFGNZW9gr6BrDCJNg2e=m1F8VQ@mail.gmail.com>
Subject: Re: [PATCH] phy: allwinner: sun4i-usb: poll vbus changes on A23/A33
 when driving VBUS
To: Maxime Ripard <maxime.ripard@free-electrons.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        stable <stable@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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

Thanks.

After some more experimentation on the A83T/AXP813, it seems this
is pretty standard behavior for the AXP PMICs. If one uses N_VBUSEN
to enable VBUS, the user/system should already know that VBUS is
on or present. The VBUS-related logic in the PMIC, save for the
VBUS status bits, is disconnected in this case.

So it looks like we either enable this workaround for most if not
all of the Allwinner family, or fix this by polling in the power
supply driver itself. This would require polling once every 50ms,
which might be too much work for the system, but is necessary for
VBUS detection to work properly for MUSB. Or we could limit polling
to whenever the drivevbus regulator is enabled. This would involve
creating a reference between the USB power supply and regulator in
the device tree. (There doesn't seem to be a way to fetch a regulator
directly by its device node.) The power supply would then register
a notifier on the regulator for on/off events, and configure polling
accordingly.

Any suggestions?

ChenYu
