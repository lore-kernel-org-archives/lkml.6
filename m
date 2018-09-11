Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3721C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87B2A20839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:52:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87B2A20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbeIKMuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 08:50:44 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:9661 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726398AbeIKMuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 08:50:44 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="44767963"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 11 Sep 2018 15:52:37 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id B77884B6EC99;
        Tue, 11 Sep 2018 15:52:38 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 11 Sep 2018 15:52:42 +0800
Date:   Tue, 11 Sep 2018 15:52:16 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>, <bhe@redhat.com>,
        <indou.takao@jp.fujitsu.com>, Cao jin <caoj.fnst@cn.fujitsu.com>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        <linux-efi@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v6 1/3] x86/boot: Add acpitb.c to parse acpi tables
Message-ID: <20180911075215.GD8519@localhost.localdomain>
References: <20180910124015.18073-1-fanc.fnst@cn.fujitsu.com>
 <20180910124015.18073-2-fanc.fnst@cn.fujitsu.com>
 <CAJZ5v0gep7Q4w+yOvgfOUG8rU12tYEw3qtDKCoZN2=b8-=-fjw@mail.gmail.com>
 <20180911012754.GC8519@localhost.localdomain>
 <CAJZ5v0i5UcV3mngTNdGyefobDOKVOGcSG3Tuz=7-PhQWjyyhmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i5UcV3mngTNdGyefobDOKVOGcSG3Tuz=7-PhQWjyyhmA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: B77884B6EC99.AD437
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 09:41:36AM +0200, Rafael J. Wysocki wrote:
>On Tue, Sep 11, 2018 at 3:28 AM Chao Fan <fanc.fnst@cn.fujitsu.com> wrote:
>>
>> On Mon, Sep 10, 2018 at 10:13:49PM +0200, Rafael J. Wysocki wrote:
>> >On Mon, Sep 10, 2018 at 2:41 PM Chao Fan <fanc.fnst@cn.fujitsu.com> wrote:
>> >>
>> >> Imitate the ACPI code of parsing ACPI tables to dig and read ACPI
>> >> tables.
>> >
>> >Why?
>>
>> Sorry for that, I have sent the cover letter to you.
>
>Thanks, but please add the explanation here too.

OK, I will add more.

>
>> >
>> >> Since some operations are not needed here,
>> >
>> >What operations?
>>
>> Such as some operations related to the map between physical address
>> and virtual address. Here in compressed period, use physical address
>> directely.
>
>This information also needs to go into the changelog of the patch.

Sorry for that.

>
>> >
>> >> functions are simplified. Functions will be used to dig SRAT tables to get
>> >> information of memory, so that KASLR can the memory in immovable node.
>> >
>> >So do you want to parse SRAT only or do something in addition to that?
>>
>> Only read and get memory information, won't change SRAT.
>> So ACPI code will not be changed.
>
>I meant whether or not SRAT is the only table you need to look into.
>If so, that also needs to be said in the patch changelog.

Yes, you are right, here only SRAT table is needed.

Thanks,
Chao Fan

>
>Thanks,
>Rafael
>
>


