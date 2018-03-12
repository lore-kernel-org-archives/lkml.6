Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752293AbeCLJgD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 05:36:03 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51787 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751320AbeCLJgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 05:36:01 -0400
X-Google-Smtp-Source: AG47ELvBgCbYOmsMpb/Y6+ioobwFupc4h+KHy7o+rxthSiOe0B0XULaTLqy/+dsV3l9qQI5t4VfKJw==
Date: Mon, 12 Mar 2018 10:35:57 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, mingo@redhat.com, bhe@redhat.com,
        keescook@chromium.org, yasu.isimatu@gmail.com,
        indou.takao@jp.fujitsu.com, lcapitulino@redhat.com
Subject: Re: [PATCH v9 0/5] x86/KASLR: Add parameter
 kaslr_boot_mem=nn[KMG]@ss[KMG]
Message-ID: <20180312093557.gxypr66vrbftz3v3@gmail.com>
References: <20180228105105.11487-1-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228105105.11487-1-fanc.fnst@cn.fujitsu.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Chao Fan <fanc.fnst@cn.fujitsu.com> wrote:

> Long time no reply, rebase the patchset, change the parameter name
> from 'kaslr_mem' to 'kaslr_boot_mem'. There's no more code change.
> 
> ***Background:
> People reported that kaslr may randomly chooses some positions
> which are located in movable memory regions. This will break memory
> hotplug feature.

[...]

> ***Solutions:
> Introduce a new kernel parameter 'kaslr_boot_mem=nn@ss' to let users to
> specify the memory regions where kernel can be allowed to randomize
> safely.

Manual solutions like that are pretty suboptimal to users, aren't they?

In what way does memory hotplug feature 'break'? Does it crash or misbehave? Or 
simply does it not allow the movement of the affected memory region, while still 
allowing the rest to be moved?

Thanks,

	Ingo
