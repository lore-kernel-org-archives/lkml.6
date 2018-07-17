Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2217ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 19:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C28D206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 19:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="Xn2ALMpz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C28D206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730341AbeGQUZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 16:25:43 -0400
Received: from forwardcorp1g.cmail.yandex.net ([87.250.241.190]:52260 "EHLO
        forwardcorp1g.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729730AbeGQUZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 16:25:43 -0400
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b6:10])
        by forwardcorp1g.cmail.yandex.net (Yandex) with ESMTP id 125A5217B0;
        Tue, 17 Jul 2018 22:51:30 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (localhost.localdomain [127.0.0.1])
        by smtpcorp1p.mail.yandex.net (Yandex) with ESMTP id 0F8F66E40BD7;
        Tue, 17 Jul 2018 22:51:30 +0300 (MSK)
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:0:3713::1:1f])
        by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id xCPqfrxggV-pTxqIWDA;
        Tue, 17 Jul 2018 22:51:30 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1531857090; bh=YUjBDKMK31K/h7s67jmQATS9N5KOISVnksrgQMsNKtk=;
        h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To;
        b=Xn2ALMpzJoHxOGScx6g9zzWEMO6Zs/ygd6vOlMACgXI1v8VsGPxHHfHGFm7qTEY62
         TYXWpRVJ5aOhBUiGG0S50gzOOaleNGp5KNraaWv2aiZLBM61yVweIzpDXDSMG3flRU
         PwuCPo6254gKBYKaaYfxk0YBIU4RfGsXvLxf7FxM=
Authentication-Results: smtpcorp1p.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Subject: Re: [PATCH 4.4 14/43] tools build: fix # escaping in .cmd files for
 future Make
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
References: <20180716073511.796555857@linuxfoundation.org>
 <20180716073513.350026232@linuxfoundation.org>
 <d1a883c6-1b7c-8bf5-49e6-3e29a60ca117@yandex-team.ru>
 <20180717131542.GC5171@kroah.com>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <6b871e03-f1fa-3546-8125-3639891eb828@yandex-team.ru>
Date:   Tue, 17 Jul 2018 22:51:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180717131542.GC5171@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.07.2018 16:15, Greg Kroah-Hartman wrote:
> On Tue, Jul 17, 2018 at 03:57:21PM +0300, Konstantin Khlebnikov wrote:
>> This commit depends on commit 9564a8cf422d7b58f6e857e3546d346fa970191e
>> "Kbuild: fix # escaping in .cmd files for future Make"
>> which is missing in 4.4.141
>>
>>
>> this breaks compilation of tools/perf for me
>>
>> make -C tools/perf V=1 JOBS=24 WERROR=0 NO_GTK2=1 LDFLAGS=-static all
>> make[1]: Entering directory `/tmp/buildd/linux-yandex-4.4.141/tools/perf'
>>    BUILD:   Doing 'make -j24' parallel build
>>
>> Auto-detecting system features:
>> ...                         dwarf: [ on  ]
>> ...            dwarf_getlocations: [ OFF ]
>> ...                         glibc: [ on  ]
>> ...                          gtk2: [ OFF ]
>> ...                      libaudit: [ on  ]
>> ...                        libbfd: [ on  ]
>> ...                        libelf: [ on  ]
>> ...                       libnuma: [ on  ]
>> ...        numa_num_possible_cpus: [ on  ]
>> ...                       libperl: [ OFF ]
>> ...                     libpython: [ OFF ]
>> ...                      libslang: [ on  ]
>> ...                     libunwind: [ on  ]
>> ...            libdw-dwarf-unwind: [ OFF ]
>> ...                          zlib: [ on  ]
>> ...                          lzma: [ on  ]
>> ...                     get_cpuid: [ on  ]
>> ...                           bpf: [ on  ]
>>
>> config/Makefile:274: No libdw DWARF unwind found, Please install elfutils-devel/libdw-dev >= 0.158 and/or set LIBDW_DIR
>> config/Makefile:282: Old libdw.h, finding variables at given 'perf probe' point will not work, install elfutils-devel/libdw-dev >= 0.157
>> config/Makefile:458: Missing perl devel files. Disabling perl scripting support, please install perl-ExtUtils-Embed/libperl-dev
>> config/Makefile:501: No 'Python.h' (for Python 2.x support) was found: disables Python support - please install python-devel/python-dev
>> $(:)
>> make -C /tmp/buildd/linux-yandex-4.4.141/tools/build fixdep
>> /bin/sh util/PERF-VERSION-GEN
>> make -f /tmp/buildd/linux-yandex-4.4.141/tools/build/Makefile.build dir=. obj=fixdep
>> . util/generate-cmdlist.sh > common-cmds.h+ && mv common-cmds.h+ common-cmds.h
>> .fixdep.o.cmd:1: *** missing separator.  Stop.
>> make[3]: *** [fixdep-in.o] Error 2
>> make[2]: *** [fixdep] Error 2
> 
> Ok, backporting the Makefile fixes resolves this issue.  But perf still
> fails to build for me due to some futex errors, which is odd, do you see
> that too?

Compilation fails only for modern glibc, like in ubuntu 18.04 bionic.
Xenial 16.04 and precise 12.04 are fine.

I've bisected to indirect fix in linux 4.8
commit cec07f53c398f22576df77052c4777dc13f14962
("perf tools: Move syscall number fallbacks from perf-sys.h to tools/arch/x86/include/asm/")

To 4.4.y it applies clearly.

> 
> thanks,
> 
> greg k-h
> 
