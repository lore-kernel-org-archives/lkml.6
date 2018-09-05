Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F00C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 18:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EEBE20658
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 18:42:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EEBE20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbeIEXOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 19:14:01 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:41367 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbeIEXOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 19:14:01 -0400
Received: from null ([172.19.246.7]) by mrelayeu.kundenserver.de (mreue103
 [212.227.15.183]) with ESMTPSA (Nemesis) id 0LkjTw-1fPfRy02Uu-00aVNa; Wed, 05
 Sep 2018 20:42:30 +0200
Date:   Wed, 5 Sep 2018 20:42:29 +0200 (CEST)
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Doug Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Message-ID: <470783016.30183.1536172949193@email.1und1.de>
In-Reply-To: <410670D7E743164D87FA6160E7907A56013A761B2B@am04wembxa.internal.synopsys.com>
References: <1535795683-3788-1-git-send-email-stefan.wahren@i2se.com>
 <410670D7E743164D87FA6160E7907A56013A761B2B@am04wembxa.internal.synopsys.com>
Subject: Re: [PATCH RFC] usb: dwc2: power off during shutdown
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev36
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:LNia2k7FQx9Tvj8Ma47lybjhviMGO9f6jlI/QxEsblW09p+qcUF
 1PRymSq7pEK4kERaCyTD0e1Pwbhx0G5YXnQP62WK/1/F1M8CR+gvSWd3sjbKV+iIeHdFvT8
 nJl5mk2Od/TjedeaAe7TEdProwrG2hVHyDWJZluT33COUIWx3mZ2+rtl4OZi8SyW69fpz9l
 zGQhZrccnYBjDx9KPkSwA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8q0D6VAXMPw=:HBA7hA4hgTmlyyqCzDTSuR
 r13z1cAQ72yAmOORkcgDgNoHQaWrxEGaiGtHpfQrs04jT8xAzQSbi2pJDIsFTXsFVV7USNVs8
 mZigIeZH6c8XbARutMYAJw35mqumH/fQcXxkGUy7ogdrZGcSWPyVm/32nUj2jQfTv7PtiAop3
 UqtBInTBKkvDF5OT3bmj6lOc5Orr2CoYl/Qz1JX1tP2CTICgxpigCJgP5ZUFXBsQ0Szaa1Pme
 oeZ+cCYWumJjQYKlmYt6a7uXaqnZIydcOkxlky2V8Ggs93flvvWkg0WnH1D7K9OzRCKtBZxyU
 d+wpimcrCvPkVkwBOqq2bSzO59+q0sJUWjEUuzzpOwpw/PSyiXeJP3DMCwhMarsV8KWug7i8b
 xOe2sit1Ly/gMGqb1+/jgDmoizk8t7zy+3nvC3XLffC9k1ZP8P4MQD3RVOElmVk2zDxGfH1BX
 udUGS04/C7uJUDUDnQdc5VSvPKt0vnbpEKg8/HVCxVcPlcV4hsgkKXJEKOEZ4bBLXSFS0wY+l
 swABfCnt3voc0GFlTWiqlB2oVCK8nRi38tkXw7eY3OfW1177HGlDnFZXIU/lO/1465JlfJJZz
 Di2TYwY+GbdMg+yYsZVIYb/x4YiUgxvEqNIwoINTKwHsNh1hgjNXjByxoo8lkP0srAqOcu/r/
 Da3egZtmPrvIa07OGxtWof0fMtStO9u/t3uhye3sCy0iPLfUqi8N3UJ9dj1iHmfQElr/RrO3J
 PAfM13QibiX1ZjPX
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Minas,

> Minas Harutyunyan <Minas.Harutyunyan@synopsys.com> hat am 5. September 2018 um 10:37 geschrieben:
> 
> 
> Hi Stefan,
> 
> On 9/1/2018 1:55 PM, Stefan Wahren wrote:
> > Currently USB consumes a lot of power after shutting down a Raspberry Pi 3
> > (example setup with Ethernet and a keyboard connected). So power off
> > USB on shutdown.
> > 
> > Measured on Raspberry Pi 3B with 4.19rc1/multi_v7_defconfig (HDMI, Ethernet
> > and a keyboard connected)
> > 
> > Before patch: 2.450 W
> > After patch:  2.090 W
> > 
> 
> Could you please elaborate. Power measurements done after shutdown?

I did the following:

sudo halt
wait until "System halted" appears on the screen
"measured" the current value displayed on my PSU

You are right that not the same as poweroff. But in even in poweroff the board consumes 0.6 W, but in this case USB is powered down.

> Why 
> your setup continue consume power after shutdown?

The BCM2835 SoC has a GPU and a ARM core. Linux is running only on the ARM core. The GPU is usually running a close source firmware, which is started at first during boot und runs all the time.

> Maybe its 
> sleep/hibernation mode?

There isn't much implementation of power management for BCM2835 yet. So i wanted to start with USB.
Even for sleep/hibernation the consumption is much too high. Because the system consumes in idle 1.6 W.

> 
> dwc2 core in your platform which type of power optimization supports: 
> partial power down, hibernation or extended hibernation? Please provide 
> me GHWCFG4 register value of your core.

AFAIK all RPis use the same USB IP core:

GHWCFG4 = 0x1ff00020

Stefan
