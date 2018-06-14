Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4D693C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5E42208D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rhOQ9hc2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5E42208D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754561AbeFNHqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 03:46:40 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:39054 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752781AbeFNHqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 03:46:39 -0400
Received: by mail-lf0-f68.google.com with SMTP id t2-v6so1485163lfd.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 00:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=dr6KVSW/cBm6y3jl9rWCZk9xfKiRkS6RsW+p7SinGAQ=;
        b=rhOQ9hc2yayYMEw7lm3CSmbJZh7CGDt7HWJrT+XSFQZHWYHWlNtNKcqL8WlU1XnH+L
         5T3opGPCBtt4jfaQ+K5svJs6LlvFGFTWP0ylv66b8iSj/+x8NrxrMEBg9fpxfGrmGXRG
         bE35VKR97EV0EbqmBYrCqTXUw4kYyMNf9kz2D8rGaO7STL5IORaFIe7pDdARJgqMFVsm
         Jz9XEATn16o1ql/QmbjrIRwdDW917GPtBo4ZD4erPQoT2Ucs7NJW1zaHLx7PZt5L9hvO
         faQZyndzDmS0vMlU6/dOPAOEsXrfFapKG0CmfsSJTd/trW37T2QvBmhAJbE6j6z0CAF4
         9dSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=dr6KVSW/cBm6y3jl9rWCZk9xfKiRkS6RsW+p7SinGAQ=;
        b=QU6yf6E6m/gNToaXh+4Qn2Ah+0zAXz2wMcfmiXr4DTu1Q35PsKkqoJOJxausRAsHpI
         RWyoXJ8zAU0rkqma77F+aO+/IV+Q6Xlgqhk7+ICJ2pDhhmBsDJxIqZTzETTfqh8vew4t
         oPN32Lg6rZ3IkjwiRKXNpVj7o5JFuHcmGmvuzyIDmOcHHXSZT2/IzQr3CJ3wZH8XAcuF
         2FUaJffDu6qWskH6ekR8l/rfc/qA7ihJiKX5oLrB0EU/vkQQwK5ITTqhC1cv8DFRT3jE
         OIlGirMUqYDQdCmcj54YsUmjj9vPeKT/KuPY6RKjWZFBqFJH5Hg1B4gQ32+IUPHPb8BB
         +stg==
X-Gm-Message-State: APt69E1R7v/tyHCAl6+GNyfL93Q+ztE6Tg+Yzd62N5hOvWlDiMLUgURu
        3P8Z8/J7GwED0C/rqXLskAVUrWgh4SUa0cqu+mP/aQ==
X-Google-Smtp-Source: ADUXVKJbroERQ7rtkGYYI3dTLqBY7ZqgiRk0t7mDVQLOs9+Ak+Z9a6w1twmDDs82gQ6E49EBdgidE2q5PUb7pHZKbUQ=
X-Received: by 2002:a19:c203:: with SMTP id l3-v6mr5460613lfc.55.1528962397443;
 Thu, 14 Jun 2018 00:46:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:56c8:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 00:46:36
 -0700 (PDT)
In-Reply-To: <20180614004044.jjz3ws3zyns7x4x6@thebollingers.org>
References: <20180611042515.ml6zbcmz6dlvjmrp@thebollingers.org>
 <CAK8P3a2aPshgrAp6=e62mvEpmmLYCAwRa_HxG_A1YKJ5we5XVQ@mail.gmail.com> <20180614004044.jjz3ws3zyns7x4x6@thebollingers.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 14 Jun 2018 09:46:36 +0200
X-Google-Sender-Auth: dsGBmNAZHnWazRzwhyk27kL7xEc
Message-ID: <CAK8P3a1Ke5OER=UFQfoTLppM-4MNWfCmkdWDz_TyWTzbX3WWvw@mail.gmail.com>
Subject: Re: [PATCH] optoe: driver to read/write SFP/QSFP EEPROMs
To:     Don Bollinger <don@thebollingers.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 2:40 AM, Don Bollinger <don@thebollingers.org> wrote:
> On Mon, Jun 11, 2018 at 03:43:02PM +0200, Arnd Bergmann wrote:
>> On Mon, Jun 11, 2018 at 6:25 AM, Don Bollinger <don@thebollingers.org> wrote:

>>
>> I don't understand this part: I see some older patches introducing an
>> EEPROM_CLASS, but nothing ever seems to have made it into the
>> mainline kernel.
>>
>> If that class isn't there, this code shouldn't be either. You can always
>> add it back in case we decide to introduce that class later, but then
>> I wouldn't make it a compile-time option but just a hard dependency
>> instead.
>
> Thanks for the feedback.
>
> Some background will explain how optoe got here...  My goal is to make
> the EEPROM data and controls in {Q}SFP devices more accessible.  (I'm
> working for Finisar, an optics vendor.)
>
> The ecosystem where optoe operates includes switch vendors, NOS vendors,
> optics vendors and switch ASIC vendors, competing and collaborating to
> build a bunch of different complete white box switch solutions.
>
> The NOS (Network Operating System) vendors start with a Linux distro,
> then add a bunch of their own patches and 'value add'.  Then they
> include platform drivers from the switch vendors.  And they integrate
> the chosen switch ASIC SDK.
>
> Here's the key:  I don't have access to all of those pieces.  I can
> build an environment to build my driver for many of those systems, but I
> can't change other elements of that NOS.
>
> The first NOS I targeted (Cumulus Linux) happens to be the author of the
> EEPROM_CLASS patches you cited.  I began with their driver (the best
> available), and morphed it into optoe.  To fit their environment, I kept
> the EEPROM_CLASS code.  They use their own platform driver (one for each
> switch model) to instantiate their predecessor to the optoe driver.  So,
> since I don't have access to their platform driver, I kept the data
> structure they pass to the probe function, where I get initialization
> data.  That is now struct optoe_platform_data.  The *dummy items in that
> struct maintain compatibility, while making it clear that they aren't
> really needed.
>
> When I targeted the next NOS, it did not have the EEPROM_CLASS code.  I
> figured out I could #ifdef that code, enabling me to create a driver that
> works in both environments.

Ok, I see. For the upstream submission of course, none of the forked
kernel code bases matter at all, what we want is a driver that makes
sense by itself, and none of it should depend on any third party code.

>> > +struct optoe_platform_data {
>> > +       u32             byte_len;               /* size (sum of all addr) */
>> > +       u16             page_size;              /* for writes */
>> > +       u8              flags;
>> > +       void            *dummy1;                /* backward compatibility */
>> > +       void            *dummy2;                /* backward compatibility */
>> > +
>> > +#ifdef EEPROM_CLASS
>> > +       struct eeprom_platform_data *eeprom_data;
>> > +#endif
>> > +       char port_name[MAX_PORT_NAME_LEN];
>> > +};
>>
>> What is the backward-compatibility for? Normally we don't do it
>> like that, we only keep compatibility with things that have already
>> been part of the kernel, especially when you also have an #ifdef
>> that makes it incompatible again ;-)
>
> So it is actually compatible with two different kernel compilations.  If
> EEPROM_CLASS is configured, optoe supports that model.  If not, optoe
> implements a sysfs file to identify which port this device is on.  It
> works.

I mean the 'dummy1' and 'dummy2' variables. They don't seem to make
any sense, and neither does the comment here.

>> > +struct optoe_data {
>> > +       struct optoe_platform_data chip;
>>
>> Maybe merge the two structures into one?
>
> optoe_platform_data is passed in when optoe gets a probe.  It is only
> part of the data I need to maintain internally.  I inherited this
> pattern from at24.c (the predecessor ^2 to optoe).

Passed in from where? The structure is declared locally in this
file, so no other driver has access to the definition.

For traditional devices, we would use a header in
include/linux/platform_data/, but a more modern way of doing this
would be to use named device properties that are either put
in the devicetree file (on embedded machines) or added through
the .properties field when statically declaring an i2c device from
a PCI device parent.

      Arnd
