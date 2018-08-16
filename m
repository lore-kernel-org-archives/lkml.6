Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE27C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D34C220C0D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:37:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D34C220C0D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbeHPVhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 17:37:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55902 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727513AbeHPVhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 17:37:48 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CB24FCB7;
        Thu, 16 Aug 2018 18:37:41 +0000 (UTC)
Date:   Thu, 16 Aug 2018 20:37:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nick Bowler <nbowler@draconx.ca>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
        Jiri Slaby <jslaby@suse.cz>
Subject: Re: Linux 4.14.63
Message-ID: <20180816183738.GA2904@kroah.com>
References: <20180816101524.GA10828@kroah.com>
 <CADyTPEw7C=Yu+4fnP05EhjtfDc7JUvbm3sV-yMpY=ao99xLsTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADyTPEw7C=Yu+4fnP05EhjtfDc7JUvbm3sV-yMpY=ao99xLsTQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 01:31:51PM -0400, Nick Bowler wrote:
> Hi Greg,
> 
> On 2018-08-16, Greg KH <gregkh@linuxfoundation.org> wrote:
> > I'm announcing the release of the 4.14.63 kernel.
> >
> > All users of the 4.14 kernel series must upgrade.
> 
> This fails to build:
> 
>     CC      drivers/rtc/rtc-cmos.o
>   In file included from /scratch_space/linux/drivers/rtc/rtc-cmos.c:45:0:
>   /scratch_space/linux/arch/x86/include/asm/i8259.h: In function ‘inb_pic’:
>   /scratch_space/linux/arch/x86/include/asm/i8259.h:33:24: error:
> implicit declaration of function ‘inb’
> [-Werror=implicit-function-declaration]
>     unsigned char value = inb(port);
>                           ^~~
>   /scratch_space/linux/arch/x86/include/asm/i8259.h: In function ‘outb_pic’:
>   /scratch_space/linux/arch/x86/include/asm/i8259.h:46:2: error:
> implicit declaration of function ‘outb’
> [-Werror=implicit-function-declaration]
>     outb(value, port);
>     ^~~~
> 
> 4.14.62 builds OK.
> 
> #including <asm/io.h> in i8259.h fixes it.

This is fixed in my tree now, thanks,

greg k-h
