Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023EBC4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 19:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A852A217BB
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 19:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxYMlO62"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A852A217BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729620AbeHDVVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 17:21:39 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34400 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728067AbeHDVVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 17:21:39 -0400
Received: by mail-oi0-f67.google.com with SMTP id 13-v6so15663131ois.1;
        Sat, 04 Aug 2018 12:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1aiR7cguf8Q7y7ZfqZ7kf3F4jEw9eaLvgwRL9fKIBpI=;
        b=kxYMlO62SEy+ej2JlnaWUUxjwsfXcS8rhIOW9ikn5ivOaxcXmyUUXxXm5oSiGDlNkw
         8xrouYv0qIueMnLBWQ3BbZAniSVTrozGv/DrymV85GzdkuXVuTA2Xwz03+giHRXZs9J+
         mI13HQg2N545lETOJwv8zrR+/5n8OJaT/SxNLX3WJsCB7lJIOggkEO5qUBIIMxEOPwns
         /xjD+mmCdguiKoaK+1cWx55pTVBCmXEhayQUyAj5QIHJ4VfYi90E4KXFHaAc5e7z1kcD
         /REs08zsDw6OekgcaATpcU+rx9VlP8Jwv+5sqjGeHgmEdHU0O/plco/bPz+DzNpcnkY7
         +UfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=1aiR7cguf8Q7y7ZfqZ7kf3F4jEw9eaLvgwRL9fKIBpI=;
        b=ktmLO5JFsK7o/QwzKupcYeLl1Au4QEIlhxT2irmhyQLaS5j5Npv9HPUfqC2fT6z957
         XazTee7ha8gKu6WFhm+ZE6jJaFjH4UjBpZc9WAPlTOJuamkUhMKD6yD1wLIkYFhXPJTd
         bNB0Fd+l4ln+2jmf3fVz2qY3GDA1/m7fL/WrvV0qRA+VIYRj92nQrKYxQRcBQh2X7H2h
         tzGbA2bFcY6BkkD3kh/SvNQFHec0D3Br8uOn99Rt0EH+0M70BENIp6lKhF0+sxB2pbhz
         KFMIlaE02Acg76hQHPUslB+XZhkWO0vadhSca8+Bqb3CvqdTsWSeyjPDHYk3C+kCLJ2D
         VZow==
X-Gm-Message-State: AOUpUlEfQfO2LA/0twqh/Nv6b0T5/bu5fXj0hNoxhEceTjUrfWnWaXT5
        GpgG8magGYVavhCkG7FtN5hkFsfj
X-Google-Smtp-Source: AAOMgpfzn5NfZXuweevWB0RLl6nDo42Ycp+Wci44/ICiKzB2BeZG3Bgy7IVelXixB0aUw5XTO+X6tg==
X-Received: by 2002:aca:ec51:: with SMTP id k78-v6mr7983206oih.236.1533410399313;
        Sat, 04 Aug 2018 12:19:59 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id v202-v6sm6272434oie.47.2018.08.04.12.19.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Aug 2018 12:19:58 -0700 (PDT)
Date:   Sat, 4 Aug 2018 12:19:56 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: OHCI: ohci-sm501: complete URBs in BH context
Message-ID: <20180804191956.GA5639@roeck-us.net>
References: <1533355279-26725-1-git-send-email-linux@roeck-us.net>
 <Pine.LNX.4.44L0.1808041047220.25853-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1808041047220.25853-100000@netrider.rowland.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 04, 2018 at 10:50:15AM -0400, Alan Stern wrote:
> On Fri, 3 Aug 2018, Guenter Roeck wrote:
> 
> > Testing an USB drive connected to ohci-sm501 results in a large number
> > of runtime warnings.
> > 
> > WARNING: CPU: 0 PID: 0 at ./include/linux/dma-mapping.h:541
> > hcd_buffer_free+0x148/0x178
> > Modules linked in:
> > 
> > CPU: 0 PID: 0 Comm: swapper Not tainted 4.18.0-rc7-00014-g7ec386e4c991-dirty
> > PC is at hcd_buffer_free+0x148/0x178
> > PR is at hcd_buffer_free+0x66/0x178
> > PC  : 8c26cbb0 SP  : 8c481da8 SR  : 400080f1
> > TEA : c00c8fe0
> > R0  : 000000f0 R1  : 000000f0 R2  : 8f9bb890 R3  : 00000000
> > R4  : 8f9c8800 R5  : 00001004 R6  : b07c6000 R7  : 007c6000
> > R8  : 00001004 R9  : 8f9bb814 R10 : 8c388104 R11 : 007c6000
> > R12 : b07c6000 R13 : 8f875680 R14 : 00000000
> > MACH: 000002fe MACL: 0000017c GBR : 00000000 PR  : 8c26cace
> > 
> > Call trace:
> >  [<(ptrval)>] usb_hcd_unmap_urb_for_dma+0xf4/0x13c
> >  [<(ptrval)>] arch_local_save_flags+0x0/0x8
> >  [<(ptrval)>] __usb_hcd_giveback_urb+0x2e/0xdc
> >  [<(ptrval)>] arch_local_save_flags+0x0/0x8
> >  [<(ptrval)>] finish_urb+0x8a/0x164
> >  [<(ptrval)>] arch_local_save_flags+0x0/0x8
> >  [<(ptrval)>] printk+0x0/0x48
> >  [<(ptrval)>] ohci_work.part.11+0x150/0x41c
> >  [<(ptrval)>] td_done.isra.4+0x0/0x11c
> >  [<(ptrval)>] vprintk_default+0x14/0x20
> >  [<(ptrval)>] arch_local_save_flags+0x0/0x8
> >  [<(ptrval)>] ohci_irq+0x20c/0x314
> >  [<(ptrval)>] usb_hcd_irq+0x16/0x28
> > 
> > Code analysis shows that interrupts are indeed disabled in ohci_irq().
> > Handle the situation by setting the HCD_BH flag in the ohci-sm501 driver.
> > With this flag set, urbs are released in a tasklet and not by the
> > interrupt handler.
> > 
> > Fixes: f54aab6ebcecd ("usb: ohci-sm501 driver")
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> 
> Unfortunately, one must not simply turn on this flag.  Doing so will
> violate some of the documented requirements for scheduling of periodic
> transfers.  Significantly deeper changes to the OHCI driver are
> necessary before the flag is set.
> 

Well, it was worth a try. Note that I did try to figure out if there are
any pitfalls when setting HCD_BH, but I didn't find anything. Reminds me
of Hitchhiker through the Galaxy for some reason.

Cheers,
Guenter
