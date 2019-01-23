Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3948BC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 083B321848
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="H5zBqLdq";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ddozk3S+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbfAWM5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 07:57:45 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:41756 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfAWM5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 07:57:45 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9769260736; Wed, 23 Jan 2019 12:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548248263;
        bh=Mz+DueOzCHqjZ4WaYFUaDzBjJPzVrxhpr9P0YTWphvU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H5zBqLdql9Dr5PmUYZy7+f552lAhtjCw+B7wCKmhvWXmqZOaVYqUZw+t3918bgVhn
         UtjG4Ywj8GuM+6J0AmYax95LAAx8WFpAFkKxw4qrhHIWlRHM8zZ8ayLixyVxhg5o8g
         YqbfnDj1FAUej60O6ZRo9wON36O7UnTr9m2ejnyE=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id D0A0C6024C;
        Wed, 23 Jan 2019 12:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548248262;
        bh=Mz+DueOzCHqjZ4WaYFUaDzBjJPzVrxhpr9P0YTWphvU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ddozk3S+mXaTq+cf+U0u96VsBktf4zD8r6mxOun444IjsvpB+zplBbd88UXrqEgtb
         zvYkAdMoEeCYE3izRvlAiC+dAjoR2eU5M3ikGvLKS3kfvSfi6e5VChZ0njs5DLVcsL
         eOSrgqrG+6o5+jyuD/ybWmBeUd8ho9CC146JBe+Y=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 23 Jan 2019 18:27:42 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Johan Hovold <johan@kernel.org>, marcel@holtmann.org,
        johan.hedberg@gmail.com, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org, Johan Hovold <jhovold@gmail.com>
Subject: Re: [PATCH v5 2/5] Bluetooth: hci_qca: Deassert RTS while baudrate
 change command
In-Reply-To: <20190122215330.GI261387@google.com>
References: <20190111013707.GD261387@google.com>
 <194b5d18ea86830b6a24939d483a964c@codeaurora.org>
 <20190111235633.GK261387@google.com>
 <a6e083d245baebc019b6e7163fd6f133@codeaurora.org>
 <20190115234628.GQ261387@google.com> <20190117160944.GV3691@localhost>
 <20190117172109.GU261387@google.com> <20190118094416.GB3691@localhost>
 <20190119003109.GD261387@google.com>
 <24831204bab89250099ca56e7562bd16@codeaurora.org>
 <20190122215330.GI261387@google.com>
Message-ID: <f5e3080235572c44fe1e8c0d4b2e5a97@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2019-01-23 03:23, Matthias Kaehlcke wrote:
> On Mon, Jan 21, 2019 at 08:11:39PM +0530, Balakrishna Godavarthi wrote:
>> Hi Matthias,
>> 
>> On 2019-01-19 06:01, Matthias Kaehlcke wrote:
>> > On Fri, Jan 18, 2019 at 10:44:16AM +0100, Johan Hovold wrote:
>> > > On Thu, Jan 17, 2019 at 09:21:09AM -0800, Matthias Kaehlcke wrote:
>> > >
>> > > > I observed that the qcom_geni_serial driver doesn't raise RTS with
>> > > > flow control disabled. It seems we have to investigate why that's the
>> > > > case. I agree that the driver should be platform agnostic.
>> > >
>> > > Sounds like a driver bug, unless the hardware is just "odd". The
>> > > driver implementation of this looks very non-standard judging from a
>> > > quick peek.
>> > >
>> > > In fact, qcom_geni_serial_get_mctrl() is currently a no-op if hardware
>> > > flow control is not enabled:
>> > >
>> > > 	if (uart_console(uport) || !uart_cts_enabled(uport))
>> > > 		return;
>> > >
>> > > Perhaps dropping the !uart_cts_enabled() test is sufficient.
>> >
>> > Thanks for taking a look Johan, that was indeed the problem (also
>> > in set_mctrl()). I posted a fix:
>> > https://lore.kernel.org/patchwork/patch/1033611/
>> >
>> > Balakrishna, the following (applied on top of your patch) works for me
>> > with the UART patch above:
>> >
>> 
>> [Bala]: will test and update BT patch accordingly.
> 
> Note that Johan pointed out that hci_uart_set_flow_control() deasserts
> RTS when flow control is disabled, so the _set_rts() calls can be
> removed. With that only a single action needs to be undone in case of
> an error, you can consider to keep the return instead of using the
> goto introduced by my patch.
> 

[Bala]: ok sure. will note this.

> Please keep/adapt the "Deassert RTS while changing the baudrate ..."
> comment to leave it clear to posterity why flow control is disabled
> during baudrate changes. It's fairly obvious once you understand the
> problem and that disabling flow control deasserts RTS, but it took us
> a while to get there, initially we only had a comment saying
> "disabling flow control is mandatory" (I recall I inquired about this
> multiple times during the initial review of the wcn3990 patches ;-)
> 
> Thanks
> 
> Matthias

-- 
Regards
Balakrishna.
