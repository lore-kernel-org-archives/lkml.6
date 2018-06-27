Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80640C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 06:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D29E268AC
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 06:33:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D29E268AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753309AbeF0GdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 02:33:22 -0400
Received: from mga11.intel.com ([192.55.52.93]:19457 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753290AbeF0GdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 02:33:18 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2018 23:33:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,278,1526367600"; 
   d="scan'208";a="66677008"
Received: from yexl-desktop.sh.intel.com (HELO localhost) ([10.239.159.124])
  by fmsmga004.fm.intel.com with ESMTP; 26 Jun 2018 23:33:15 -0700
Date:   Wed, 27 Jun 2018 14:29:38 +0800
From:   Ye Xiaolong <xiaolong.ye@intel.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>,
        lkp <lkp@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Laszlo Ersek <lersek@redhat.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Neri, Ricardo" <ricardo.neri@intel.com>,
        Lee Chun-Yi <jlee@suse.com>, Borislav Petkov <bp@alien8.de>,
        "kbuild-all@01.org" <kbuild-all@01.org>,
        Dave Young <dyoung@redhat.com>
Subject: Re: [kbuild-all] [PATCH] efi: Free existing memory map before
 installing new memory map
Message-ID: <20180627062938.GE18756@yexl-desktop>
References: <1529980892-11833-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <201806261053.B3CmI5Dm%fengguang.wu@intel.com>
 <FFF73D592F13FD46B8700F0A279B802F45FD1614@ORSMSX111.amr.corp.intel.com>
 <20180627060257.GD18756@yexl-desktop>
 <CAKv+Gu8bQKnpHbGS2S3RwTErP_F3o8mogc4bAbtX1r7=Fyp=NA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu8bQKnpHbGS2S3RwTErP_F3o8mogc4bAbtX1r7=Fyp=NA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/27, Ard Biesheuvel wrote:
>On 27 June 2018 at 08:02, Ye Xiaolong <xiaolong.ye@intel.com> wrote:
>> Hi,
>>
>> On 06/26, Prakhya, Sai Praneeth wrote:
>>>>
>>>> Hi Sai,
>>>>
>>>> Thank you for the patch! Yet something to improve:
>>>>
>>>> [auto build test ERROR on linus/master]
>>>> [also build test ERROR on v4.18-rc2 next-20180625] [if your patch is applied to
>>>> the wrong git tree, please drop us a note to help improve the system]
>>>
>>>Since efi_memmap_free() is a recently introduced API [1], please note that the patch
>>>is based on efi tree @https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git
>>
>> I noticed the official efi tree recored in MAINTAINERS is git://git.kernel.org/pub/scm/linux/kernel/git/mfleming/efi.git,
>> are they identical?
>>
>
>Which version of MAINTAINERS did you look at?

Oops, I just checked a old version. I'll add above efi.git tree to 0day's repo
pool.

Thanks,
Xiaolong
>
>> EXTENSIBLE FIRMWARE INTERFACE (EFI)
>> M:      Matt Fleming <matt@codeblueprint.co.uk>
>> L:      linux-efi@vger.kernel.org
>> T:      git git://git.kernel.org/pub/scm/linux/kernel/git/mfleming/efi.git
>> S:      Maintained
>> F:      Documentation/efi-stub.txt
>> F:      arch/ia64/kernel/efi.c
>> F:      arch/x86/boot/compressed/eboot.[ch]
>> F:      arch/x86/include/asm/efi.h
>> F:      arch/x86/platform/efi/*
>> F:      drivers/firmware/efi/*
>> F:      include/linux/efi*.h
>>
>>
>> Thanks,
>> Xiaolong
>>
>>>
>>>[1] https://lkml.org/lkml/2018/6/22/39
>>>
>>>Regards,
>>>Sai
>>>_______________________________________________
>>>kbuild-all mailing list
>>>kbuild-all@lists.01.org
>>>https://lists.01.org/mailman/listinfo/kbuild-all
