Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8545EC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 02:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AFB8217F5
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 02:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfADC2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 21:28:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59688 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbfADC2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 21:28:31 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4B81258E27;
        Fri,  4 Jan 2019 02:28:31 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-85.pek2.redhat.com [10.72.12.85])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 47D595C223;
        Fri,  4 Jan 2019 02:28:23 +0000 (UTC)
Subject: Re: [PATCH 1/2 v4] kdump: add the vmcoreinfo documentation
To:     Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Cc:     "bhe@redhat.com" <bhe@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "dyoung@redhat.com" <dyoung@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20181220054044.30738-1-lijiang@redhat.com>
 <20181220054044.30738-2-lijiang@redhat.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC035656E1@BPXM09GP.gisp.nec.co.jp>
From:   lijiang <lijiang@redhat.com>
Message-ID: <bf26e868-9dfd-5344-df56-df8ff0442df0@redhat.com>
Date:   Fri, 4 Jan 2019 10:28:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <4AE2DC15AC0B8543882A74EA0D43DBEC035656E1@BPXM09GP.gisp.nec.co.jp>
Content-Type: text/plain; charset=iso-2022-jp
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 04 Jan 2019 02:28:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2019年01月04日 03:28, Kazuhito Hagio 写道:
> Hi Lianbo,
> 
> -----Original Message-----
>> +=======================
>> +What is the VMCOREINFO?
>> +=======================
>> +
>> +VMCOREINFO is a special ELF note section. It contains various
>> +information from the kernel like structure size, page size, symbol
>> +values, field offsets, etc. These data are packed into an ELF note
>> +section and used by user-space tools like crash and makedumpfile to
>> +analyze a kernel's memory layout.
>> +
>> +To dump the VMCOREINFO contents, one can do:
>> +
>> +# makedumpfile -g VMCOREINFO -x vmlinux
> 
> again, this command does not dump the VMCOREINFO in ELF note section.
> It converts the vmlinux's debug infomation into a VMCOREINFO-like data.
> So I don't think this command is suitable to introduce here.
> 

Thank you, Kazu.

As you mentioned, makedumpfile in 'devel' branch can print VMCOREINFO in /proc/kcore,
can i add the following command to this document?

#makedumpfile --mem-usage /proc/kcore -D

>> +PG_lru|PG_private|PG_swapcache|PG_swapbacked|PG_slab|
>> +PG_hwpoision|PG_head_mask
>> +-----------------------------------------------------
>> +
>> +Page attributes. These flags are used to filter free pages.
> 
> Some of these are not used to filter *free* pages, so
> 
> ... used to filter various unnecessary pages.
> 

Great. I will modify it in next post.

And also merge the 'PG_buddy' and 'PG_offline'  into the PG_* flag here.

Many thanks.

Lianbo

>> +PAGE_BUDDY_MAPCOUNT_VALUE or ~PG_buddy
>> +--------------------------------------
> 
> then, this can be merged into the one above?
> 
>> +======
>> +x86_64
>> +======
> ...
>> +PAGE_OFFLINE_MAPCOUNT_VALUE(~PG_offline)
>> +----------------------------------------
> 
> This looks not only for x86_64, and also can be merged into
> the PG_* flags?
> 
> Thank you for your effort!
> Kazu
> 
> 
