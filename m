Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFAC6C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0956219EB
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:39:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0956219EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbeHFLrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:47:20 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:48263 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbeHFLrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 07:47:20 -0400
Received: from 79.184.254.16.ipv4.supernova.orange.pl (79.184.254.16) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id fbc8bfbe2522fb64; Mon, 6 Aug 2018 11:39:04 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Chris Chiu <chiu@endlessm.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input <linux-input@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Subject: Re: Built in PS2 keyboard in new ASUS/acer laptops can not wake up system after s2idle
Date:   Mon, 06 Aug 2018 11:37:05 +0200
Message-ID: <73029405.6ZXyByzer1@aspire.rjw.lan>
In-Reply-To: <CAB4CAwfQ0mPMqCLp95TVjw4J0r5zKPWkSvvkK4cpZUGE--w8bQ@mail.gmail.com>
References: <CAB4CAwfQ0mPMqCLp95TVjw4J0r5zKPWkSvvkK4cpZUGE--w8bQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, August 3, 2018 10:04:09 AM CEST Chris Chiu wrote:
> Hi guys,
>     We have some new laptops with Intel new Intel WiskyLake CPU come
> in and they all have the same problem. They all have the so-called
> "Modern Standby" feature which is s2idle in Linux.
> 
>     The problem is the built-in keyboard no longer wake up the system
> after it goes to s2idle. Only the power button can wake up. It's
> different from the other laptops with old Intel CPUs (CoffeeLake,
> KaybeLake...etc). We found the difference is that the EC (embedded
> controller) no longer signals SCI event when in s2idle.
> 
>     Confirmed with ASUS EC engineer, he also admits that the EC code
> for signaling SCI event in modern standby has been removed on
> WiskyLake models. Because the built-in PS2 keyboard can still wake up
> the system on WisksyLake+Windows10 RS4 combination without EC
> intervention.
> 
>     Based on this information, we suspect that maybe the built-in
> keyboard wakeup on Windows 10 RS4 in enabled by default (although we
> don't know how to prove that). It's easy to simply do
> 'device_set_wakeup_enable' and 'enable_irq_wake' for the i8042
> keyboard port to wake up the system without EC, but it's nasty.
> 
>     Any suggestion about how to achieve the keyboard wake up function
> on these new laptops in a generic way? Thanks

What about echoing "enabled" to the keyboard's power/wakeup file in sysfs?

