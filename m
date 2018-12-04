Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E123C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 597A42081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:43:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 597A42081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbeLDJn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 04:43:26 -0500
Received: from mga12.intel.com ([192.55.52.136]:6663 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725764AbeLDJnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 04:43:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2018 01:43:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,313,1539673200"; 
   d="scan'208";a="115807853"
Received: from avandeve-mobl.amr.corp.intel.com (HELO [10.251.82.99]) ([10.251.82.99])
  by orsmga001.jf.intel.com with ESMTP; 04 Dec 2018 01:43:18 -0800
Subject: Re: [patch V2 27/28] x86/speculation: Add seccomp Spectre v2 user
 space protection mode
To:     Jiri Kosina <jikos@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Lutomirski <luto@kernel.org>, thomas.lendacky@amd.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>, dave.hansen@intel.com,
        Casey Schaufler <casey.schaufler@intel.com>,
        "Mallick, Asit K" <asit.k.mallick@intel.com>, jcm@redhat.com,
        longman9394@gmail.com, Greg KH <gregkh@linuxfoundation.org>,
        david.c.stewart@intel.com, Kees Cook <keescook@chromium.org>,
        Jason Brandt <jason.w.brandt@intel.com>
References: <20181125183328.318175777@linutronix.de>
 <20181125185006.051663132@linutronix.de>
 <CAHk-=whtiX45YPjFPMFuktZ3WB23zqBZR-rL6RewrTyvrFj2Fw@mail.gmail.com>
 <f4b903ef-828c-0b05-29c6-6f71677d120d@linux.intel.com>
 <nycvar.YFH.7.76.1812040937440.17216@cbobk.fhfr.pm>
From:   Arjan van de Ven <arjan@linux.intel.com>
Message-ID: <d5a6f813-d5d1-ae79-fc73-9f8fafccf407@linux.intel.com>
Date:   Tue, 4 Dec 2018 10:43:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <nycvar.YFH.7.76.1812040937440.17216@cbobk.fhfr.pm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> On processors with enhanced IBRS support, we recommend setting IBRS to 1
>> and left set.
> 
> Then why doesn't CPU with EIBRS support acutally *default* to '1', with
> opt-out possibility for OS?

the BIOSes could indeed get this set up this way.

do you want to trust the bios to get it right?
