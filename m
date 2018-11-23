Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE196C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 18:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9273420861
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 18:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hG8bb9h8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9273420861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbeKXFFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 00:05:47 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39674 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725139AbeKXFFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 00:05:47 -0500
Received: by mail-pg1-f193.google.com with SMTP id w6so3364274pgl.6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 10:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wKuEOueeKuKlwNjv+F2Y+FU8AAXIMEHQ3LCBhdlzaBI=;
        b=hG8bb9h8vovduFm5Vwu6fj9pkxAVK1mNcP+CZANGroDTdXVQHojqpAwTyhF9l/bfas
         w0zkWHBnpYp0jEZNucOBZDE4KGUZe5/2dgdUSUQDXH1gA9lM2vbz2/COwG2+UtMHOxJj
         V9cOv3cxtjtKAnqWBui+NeSi1BH9Wz0sDyVDPLDpGJbz0tBmRHYS7/s6ZrJmshTU/93P
         ZEZ0/QJ1gznz36Jd/l2RF2es6Ltm7CILyYbNDO9yHfvXV3LLOSaaYfbD3KMpHy4eaF27
         XUTbcBueBpoY3O0eUqszg/plY7lY38otbaOU/WwhK7QsvdDyU6jE10he4Ro/eE28Am5j
         4Hig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=wKuEOueeKuKlwNjv+F2Y+FU8AAXIMEHQ3LCBhdlzaBI=;
        b=V/XDbJXo1Mab2S2sSBrlZyxh0qOB1uV0DPd1reTU44XkQnNL20Phn6f+tHzD0ue0EL
         X5rxxJXJSZ0ZJJBt5tNdNCI/I2a3AE156nkeOkWDh0IHH4Ul8SLhc40Bn4JTPiptA0lZ
         7Xusb35xDKdr77mptunZBsysIIPLctIf0LreUxS2uCi1dEhz1jqHxqzoqZoVETS8iQpc
         4YnG6mK846FnmK6llflBviccOqdMZSp8P0h5GD5yHaVN84aM6zIhw9glgrlmXnyEFDu6
         9R4E2NQLto0UVPqD4Mk59beN6Wa7o6n4Z5NLPxgVkJORc4FL9SM6lBD5fJgyRdPhDhcd
         51yA==
X-Gm-Message-State: AGRZ1gLZS1jQSJxrs2dui2yOzuVScwJHffk81g6jUi3iFhxJzMy4MVQv
        K9zE9VVXug+lX5JdUIUaVooHhz3f
X-Google-Smtp-Source: AJdET5ecXjhFOhwBizgPnDR33mlQZ3IYiWQlx52xJ4LARxY9E/xqNoJq3z29PHL22yRDX47lQJQg+w==
X-Received: by 2002:a62:2e46:: with SMTP id u67mr16778939pfu.3.1542997224953;
        Fri, 23 Nov 2018 10:20:24 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y26-v6sm15351574pfi.123.2018.11.23.10.20.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 10:20:24 -0800 (PST)
Date:   Fri, 23 Nov 2018 10:20:23 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     arnd@arndb.de, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: 8250: Default SERIAL_OF_PLATFORM to SERIAL_8250
Message-ID: <20181123182023.GA10080@roeck-us.net>
References: <20181115011125.GA32556@roeck-us.net>
 <29E7A6C0-7829-4650-93C6-7220FECAA6EF@gmail.com>
 <20181115053836.GA7606@roeck-us.net>
 <27ed27d3-220e-963f-7d2c-64df10421580@gmail.com>
 <20181115172535.GA26922@roeck-us.net>
 <5937b814-ca5f-5786-93a1-3334df8c92dc@gmail.com>
 <20181116011656.GA21813@roeck-us.net>
 <ffff966c-d6ae-1487-5269-b86df0824d1c@gmail.com>
 <20181119205050.GA1933@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119205050.GA1933@roeck-us.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 12:50:50PM -0800, Guenter Roeck wrote:
> On Mon, Nov 19, 2018 at 10:44:30AM -0800, Florian Fainelli wrote:
> > On 11/15/18 5:16 PM, Guenter Roeck wrote:
> > > On Thu, Nov 15, 2018 at 11:48:20AM -0800, Florian Fainelli wrote:
> > >>
> > >> OK, would you mind testing this below? It seems to me that 8250_of.c is
> > >> incompatible with arch/powerpc/kernel/legacy_serial.c and that is what
> > >> is causing the issue here.
> > >>
> > >> diff --git a/drivers/tty/serial/8250/Kconfig
> > >> b/drivers/tty/serial/8250/Kconfig
> > >> index d7737dca0e48..21cb14cbd34a 100644
> > >> --- a/drivers/tty/serial/8250/Kconfig
> > >> +++ b/drivers/tty/serial/8250/Kconfig
> > >> @@ -483,7 +483,7 @@ config SERIAL_8250_PXA
> > >>
> > >>  config SERIAL_OF_PLATFORM
> > >>         tristate "Devicetree based probing for 8250 ports"
> > >> -       depends on SERIAL_8250 && OF
> > >> +       depends on SERIAL_8250 && OF && !(PPC && PPC_UDBG_16550)
> > >>         default SERIAL_8250
> > >>         help
> > >>           This option is used for all 8250 compatible serial ports that
> > > 
> > > 44x/virtex5_defconfig has both PPC_UDBG_16550 and SERIAL_OF_PLATFORM enabled
> > > and fails to boot (or display anything on the console) with this patch applied.
> > 
> > Thanks for trying, can you either share or provide a link to the mpc85xx
> > and ml507 qemu command lines that you use? I spent a good chunk of my
> > time trying to get a kernel to boot but has failed so far.
> > 
> 

Any update ? I still see the boot failures in next-20181123.

Guenter

> Good to hear that this doesn't just happen to me ;-).
> 
> The scripts are all at https://github.com/groeck/linux-build-test/.
> This includes root file systems. The one used below is at
> https://github.com/groeck/linux-build-test/blob/master/rootfs/ppc/rootfs.cpio.gz
> 
> ml507:
> 
> qemu-system-ppc -kernel vmlinux -M virtex-ml507 -m 256 -no-reboot \
> 	-initrd rootfs.cpio -dtb arch/powerpc/boot/dts/virtex440-ml507.dtb \
> 	--append 'rdinit=/sbin/init panic=-1 mem=256M console=ttyS0' \
> 	-monitor none -nographic
> 
> mpc85xx:
> 
> qemu-system-ppc -kernel arch/powerpc/boot/uImage -M mpc8544ds -m 256 \
> 	-no-reboot -initrd rootfs.cpio \
> 	--append 'rdinit=/sbin/init panic=-1 mem=256M console=ttyS0' \
> 	-monitor none -nographic
> 
> Hope this helps,
> Guenter
