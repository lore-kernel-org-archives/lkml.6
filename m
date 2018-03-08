Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934381AbeCHRtY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 12:49:24 -0500
Received: from merlin.infradead.org ([205.233.59.134]:33400 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751642AbeCHRtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 12:49:22 -0500
Subject: Re: Hang while booting 4.15.7
To: Brian Rak <brak@gameservers.com>, linux-kernel@vger.kernel.org
References: <5fcd1a79-02c0-313a-5689-06cfa2c0219d@gameservers.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <18aa7774-4915-3aa1-c9fb-e1ebde09c908@infradead.org>
Date: Thu, 8 Mar 2018 09:49:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <5fcd1a79-02c0-313a-5689-06cfa2c0219d@gameservers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/2018 08:21 AM, Brian Rak wrote:
> We have some Dell servers running Intel Gold 6126 processors. Some of them hang on boot under 4.15.7,  but work fine on 4.14.14.  When they hang, we see the following on console:
> 
> Error parsing PCC subspaces from PCCT
> watchdog: BUG: soft lockup - CPU #16 stuck for 23s! [swapper/0:1]
> 
> We see that PCC subspaces error under 4.14 as well, but it doesn't cause the machine to hang.
> 
> So far we haven't been able to correlate these hangs with anything in particular.  Some machines will hang, some machines will boot.  They're otherwise identical as far as hardware and firmware goes.
> 
> I've tried pcie_aspm=off, since that seems to be the next bit of code that's being executed.  This resulted in the machine booting a little further, but then oopsing somewhere in acpi_os_purge_cache. I'm not able to get a full trace there, as I don't have serial access easily available.
> 
> Any suggestions?
> 

Hi,

The first thing that I would do is boot with:
  ignore_loglevel initcall_debug
on the kernel boot command line.

That will add lots of messages and maybe give us a stronger hint about where
the hang is actually happening.

And then worst case (without a boot log via serial console or netconsole) is
to take a photo of the screen with the oops messages.

And if you are fairly certain that it's an ACPI issue, also write to the
linux-acpi@vger.kernel.org mailing list.

-- 
~Randy
