Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757497AbeDKUWA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 16:22:00 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58957 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756709AbeDKUV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 16:21:57 -0400
Date: Wed, 11 Apr 2018 22:21:37 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
cc: peterz@infradead.org, lirongqing@baidu.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
        linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/urgent] x86/apic: Fix signedness bug in APIC ID validity
 checks
In-Reply-To: <e66e1b1d-a8d0-ce74-f3c6-4bdc4432efb7@cn.fujitsu.com>
Message-ID: <alpine.DEB.2.21.1804112221080.1564@nanos.tec.linutronix.de>
References: <1523322966-10296-1-git-send-email-lirongqing@baidu.com> <tip-a774635db5c430cbf21fa5d2f2df3d23aaa8e782@git.kernel.org> <e66e1b1d-a8d0-ce74-f3c6-4bdc4432efb7@cn.fujitsu.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1987243463-1523478097=:1564"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1987243463-1523478097=:1564
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Wed, 11 Apr 2018, Dou Liyang wrote:

> Hi Thomas,
> 
> At 04/10/2018 10:51 PM, tip-bot for Li RongQing wrote:
> [...]
> 
> > x86/apic: Fix signedness bug in APIC ID validity checks
> > 
> > The APIC ID as parsed from ACPI MADT is validity checked with the
> > apic->apic_id_valid() callback, which depends on the selected APIC type.
> > 
> > For non X2APIC types APIC IDs >= 0xFF are invalid, but values > 0x7FFFFFFF
> 
> Today when I am reading "Intel® 64 Architecture x2APIC Specification", I
> find that below in chapter 2.4.1:
> 
>   The APIC ID value of FFFF_FFFFH and the highest value corresponding to
>   the imple-mented bit-width of the local APIC ID register in the system
>   are reserved and cannot be assigned to any logical processor.
> 
> Seems, FFFF_FFFFH is also invalid for X2APIC types, Shall we also do the
> validity check for X2APIC ID?
> 
> acpi_parse_x2apic()
> 	...
> 	/* Ignore invalid ID */
> 	if (apic_id == 0xffffffff)
> 		return 0;

Yes. I noticed that as well and just did not come around to write the
patch.

Thanks,

	tglx
--8323329-1987243463-1523478097=:1564--
