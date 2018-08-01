Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B50C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F07F0208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="i9ySjM5Y";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="i9ySjM5Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F07F0208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732117AbeHAXFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 19:05:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41572 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbeHAXFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 19:05:52 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D134F6035F; Wed,  1 Aug 2018 21:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533158289;
        bh=BNgs2bDalqAoy3LlvA//EkzUBvpq5eMFUD3teNi4Bl4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=i9ySjM5YQpFY/FbKilCKBkq94foGUJIOcD0UQzpqQmorSTNjRzUuXrefsVfwzFrqc
         KjG985GmwTx+IftaT9HU8fv+nhpy44LB4lQcZAFSyLv8bym1tPy6EM4T/R4psAFV64
         0vKEK+ldqnj09N0HaWmGaFJ+Od9jGsiRkXC+EhDo=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 26E0F60540;
        Wed,  1 Aug 2018 21:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533158289;
        bh=BNgs2bDalqAoy3LlvA//EkzUBvpq5eMFUD3teNi4Bl4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=i9ySjM5YQpFY/FbKilCKBkq94foGUJIOcD0UQzpqQmorSTNjRzUuXrefsVfwzFrqc
         KjG985GmwTx+IftaT9HU8fv+nhpy44LB4lQcZAFSyLv8bym1tPy6EM4T/R4psAFV64
         0vKEK+ldqnj09N0HaWmGaFJ+Od9jGsiRkXC+EhDo=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 01 Aug 2018 14:18:09 -0700
From:   rishabhb@codeaurora.org
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ckadabi@codeaurora.org, tsoni@codeaurora.org,
        Vikram Mulukutla <markivx@codeaurora.org>, rjwysocki@gmail.com
Subject: Re: [PATCH] dd: Invoke one probe retry cycle after every initcall
 level
In-Reply-To: <CAJZ5v0ixuWo9RC21Z8zVhuHfkr1uV4vdqMh4s+qGMR7R8Wycag@mail.gmail.com>
References: <1532035440-7860-1-git-send-email-rishabhb@codeaurora.org>
 <CAJZ5v0gWqx5Op-Bbg7bAYALCyBPsc=-+homAYj2Q1qd3WsqmDw@mail.gmail.com>
 <e4ca8572ed913ab65f63be8a351d4439@codeaurora.org>
 <CAJZ5v0ixuWo9RC21Z8zVhuHfkr1uV4vdqMh4s+qGMR7R8Wycag@mail.gmail.com>
Message-ID: <68b90830d5024ce75a20b017aaf21c05@codeaurora.org>
X-Sender: rishabhb@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-24 01:24, Rafael J. Wysocki wrote:
> On Mon, Jul 23, 2018 at 10:22 PM,  <rishabhb@codeaurora.org> wrote:
>> On 2018-07-23 04:17, Rafael J. Wysocki wrote:
>>> 
>>> On Thu, Jul 19, 2018 at 11:24 PM, Rishabh Bhatnagar
>>> <rishabhb@codeaurora.org> wrote:
>>>> 
>>>> Drivers that are registered at an initcall level may have to
>>>> wait until late_init before the probe deferral mechanism can
>>>> retry their probe functions. It is possible that their
>>>> dependencies were resolved much earlier, in some cases even
>>>> before the next initcall level. Invoke one probe retry cycle
>>>> at every _sync initcall level, allowing these drivers to be
>>>> probed earlier.
>>> 
>>> 
>>> Can you please say something about the actual use case this is
>>> expected to address?
>> 
>> We have a display driver that depends 3 other devices to be
>> probed so that it can bring-up the display. Because of dependencies
>> not being met the deferral mechanism defers the probes for a later 
>> time,
>> even though the dependencies might be met earlier. With this change
>> display can be brought up much earlier.
> 
> OK
> 
> What runlevel brings up the display after the change?
> 
> Thanks,
> Rafael
After the change the display can come up after device_initcall level
itself.
The above mentioned 3 devices are probed at 0.503253, 0.505210 and 
0.523264 secs.
Only the first device is probed successfully. With the current
deferral mechanism the devices get probed again after late_initcall
at 9.19 and 9.35 secs. So display can only come up after 9.35 secs.
With this change the devices are re-probed successfully at 0.60 and
0.613 secs. Therefore display can come just after 0.613 secs.
This change helps in overall android bootup as well.

-Rishabh


