Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9289C46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 19:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 925692085B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 19:36:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 925692085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbeJ1ESJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 00:18:09 -0400
Received: from smtprelay0185.hostedemail.com ([216.40.44.185]:56589 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725833AbeJ1ESJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 00:18:09 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id CB14952C2;
        Sat, 27 Oct 2018 19:36:07 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: legs94_8cad8675f7535
X-Filterd-Recvd-Size: 2997
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Sat, 27 Oct 2018 19:36:06 +0000 (UTC)
Message-ID: <c6b7e5b26883c53db35454e9b0ffb44898517228.camel@perches.com>
Subject: Re: Another HID problem this merge window..
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Sat, 27 Oct 2018 12:36:05 -0700
In-Reply-To: <CAHk-=wiZ24JuVehJ5sEC0UG1Gk2nvB363wO02RRsR1oEht6R9Q@mail.gmail.com>
References: <CAHk-=wiZ24JuVehJ5sEC0UG1Gk2nvB363wO02RRsR1oEht6R9Q@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-10-27 at 11:13 -0700, Linus Torvalds wrote:
> Ok, so this is a much smaller issue than the i2c one that cause boot
> problems, but it's annoying.
> 
> We do *not* enable new random drivers by default. And we most
> *definitely* don't do it when they are odd-ball ones that most people
> have never heard of.
> 
> Yet the new "BigBen Interactive" driver that was added this merge
> window did exactly that.

In fairness, it seems many of the HID drivers do exactly that
and this could have been a "copy from example" addition.

$ git grep -P -i -B2 'default\s+\!EXPERT' -- drivers/hid/Kconfig
drivers/hid/Kconfig-    tristate "A4 tech mice"
drivers/hid/Kconfig-    depends on HID
drivers/hid/Kconfig:    default !EXPERT
--
drivers/hid/Kconfig-    tristate "Apple {i,Power,Mac}Books"
drivers/hid/Kconfig-    depends on HID
drivers/hid/Kconfig:    default !EXPERT
--
drivers/hid/Kconfig-    tristate "Belkin Flip KVM and Wireless keyboard"
drivers/hid/Kconfig-    depends on HID
drivers/hid/Kconfig:    default !EXPERT
--
drivers/hid/Kconfig-    tristate "Cherry Cymotion keyboard"
drivers/hid/Kconfig-    depends on HID
drivers/hid/Kconfig:    default !EXPERT
--
drivers/hid/Kconfig-    tristate "Chicony devices"
drivers/hid/Kconfig-    depends on HID
drivers/hid/Kconfig:    default !EXPERT
--
drivers/hid/Kconfig-    tristate "Cypress mouse and barcode readers"
drivers/hid/Kconfig-    depends on HID
drivers/hid/Kconfig:    default !EXPERT
--
drivers/hid/Kconfig-    tristate "Ezkey BTC 8193 keyboard"
drivers/hid/Kconfig-    depends on HID
drivers/hid/Kconfig:    default !EXPERT
--
drivers/hid/Kconfig-    tristate "ITE devices"
drivers/hid/Kconfig-    depends on HID
drivers/hid/Kconfig:    default !EXPERT
--
drivers/hid/Kconfig-    tristate "Kensington Slimblade Trackball"
drivers/hid/Kconfig-    depends on HID
drivers/hid/Kconfig:    default !EXPERT
--
drivers/hid/Kconfig-    tristate "Logitech devices"
drivers/hid/Kconfig-    depends on HID
drivers/hid/Kconfig:    default !EXPERT

