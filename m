Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CDBC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4633D208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:57:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4633D208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=angband.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbeLMJ51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 04:57:27 -0500
Received: from tartarus.angband.pl ([54.37.238.230]:47844 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbeLMJ50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 04:57:26 -0500
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.89)
        (envelope-from <kilobyte@angband.pl>)
        id 1gXNkD-0002RV-0E; Thu, 13 Dec 2018 10:57:25 +0100
Date:   Thu, 13 Dec 2018 10:57:24 +0100
From:   Adam Borowski <kilobyte@angband.pl>
To:     Sven Hartrumpf <hartrumpf@gmx.net>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Can we drop upstream Linux x32 support?
Message-ID: <20181213095724.f4ziawroveksd35t@angband.pl>
References: <70bb54b2-8ed3-b5ee-c02d-6ef66c4f27eb@physik.fu-berlin.de>
 <20181213050313.GA21201@ip-172-31-15-78>
 <CAFLxGvy2sMW1nyMpxGN7xHPdUea713g89MdE3EcUNHJDCvZ3jA@mail.gmail.com>
 <20181213.103731.734229932284065893.hartrumpf@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181213.103731.734229932284065893.hartrumpf@gmx.net>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 10:37:31AM +0100, Sven Hartrumpf wrote:
> Will the proposed patch ("only") remove the possibility to build x32 kernels
> or will it make impossible to compile and run any x32 binaries?

There's no such thing as x32 kernels.  It's an ABI atop amd64 kernels; the
kernel is always 64-bit -- short pointers apply only to userspace and
syscalls.

It could be interesting to block regular amd64 syscalls and leave x32 only
-- for "security through rarity", but the kernel itself would still look the
same.


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀ 
⣾⠁⢠⠒⠀⣿⡁ Ivan was a worldly man: born in St. Petersburg, raised in
⢿⡄⠘⠷⠚⠋⠀ Petrograd, lived most of his life in Leningrad, then returned
⠈⠳⣄⠀⠀⠀⠀ to the city of his birth to die.
