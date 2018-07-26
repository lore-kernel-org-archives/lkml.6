Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BF7C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B86D020685
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:02:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B86D020685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730335AbeGZOS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 10:18:59 -0400
Received: from mout.gmx.net ([212.227.15.18]:53575 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729510AbeGZOS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 10:18:59 -0400
Received: from ls3530 ([155.56.40.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MTTKZ-1fbDCy051L-00SQbY; Thu, 26
 Jul 2018 14:59:51 +0200
Date:   Thu, 26 Jul 2018 14:59:40 +0200
From:   Helge Deller <deller@gmx.de>
To:     Alex Ghiti <alex@ghiti.fr>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@kernel.org>, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com, tony.luck@intel.com,
        fenghua.yu@intel.com, ralf@linux-mips.org, paul.burton@mips.com,
        jhogan@kernel.org, jejb@parisc-linux.org, deller@gmx.de,
        benh@kernel.crashing.org, paulus@samba.org,
        ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v4 00/11] hugetlb: Factorize hugetlb architecture
 primitives
Message-ID: <20180726125940.GA15033@ls3530>
References: <20180705110716.3919-1-alex@ghiti.fr>
 <20180709141621.GD22297@dhcp22.suse.cz>
 <2173685f-7f85-7acb-4685-2383210c5fa2@ghiti.fr>
 <87d0vehx16.fsf@concordia.ellerman.id.au>
 <67aba0f0-c0d4-b06f-5fbc-f4d113ce5033@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67aba0f0-c0d4-b06f-5fbc-f4d113ce5033@ghiti.fr>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Provags-ID: V03:K1:LJW7STv0ttsGWNRGMntZtI8g9h5WdEk1zchAg4XmzjhCReDadlR
 KG+cYi35nReER/0L3a4C+m2kngX4xI03Labu+btPyA68jH3f+GC+B4qcZQauRRzrEc80ERE
 aHGns9dZ853xNeeLFJnjGRUYdQsbCokyKXfbOydvSxnYlIPh6n3wWXsfKwCi920Up+MZU84
 4FSFjVIiKuyHgJ1Qk6Gqg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zkWr1oFCSxI=:2ucBH/SBIgeCNQ0BKUKeje
 F+9jymR6qNiTUTKtDh89IYd0+6+Bsc5f/Syop13rLKmBEhnPFN+a41RacteZnwIBnLF9+ETjJ
 3DlfTAUQSeuGdnHBeADJFltjUCSTvD2vsM58+aeCkxMNMpajnlaqA3E/deNmLotmpKsrqKmrT
 xKlckvHALi8pkKIKyDt5rE4pekx9GLBQHrEB1NEyQsX83D0pk7Fa15jDIyPGlYAUMVCVuoT17
 DJeVFQ5oHMqQh4fvuIix9e6XmiP1i+/MxLVEOA++ocfAgfIXxZeQXNYsUss7wqZLlZ95KbpB4
 nd1/9LjVBmgjK5zN4wTz2onTOFwgtJc09QXPUK1MLL2IOfESmDkYBPc0kTy3WMG7EITGFYPNq
 HixBpBdcYX9LbmNXK17ispo3ECpjyd5I/z1NjyQd8knCR5tSlGgpWo5QqwfeE9aDbbXriwJ2t
 /wsnmcXaL6hle00w1eZUquG+XYKrKxQ6+QU6lgXufdZW3cmVVZx0KiO+TJqk6T+10Ttt7D51L
 ujer+8dhR2WIpubn1MFUSxKLz1do/E1GCp6bqM8TA5hUW2sPPdTl0fBs2i/8FGaAHsQc2Puzf
 1WyUDN0KnN7FwyxWaM99MUxbH1kX70dfXAa6+p3GiEzjwd/dTVZ0boShlQ9esqyhagkmjVRiz
 z92FKnMmMwTkiykoE6mXlzBujDqmwCJ79GxbpgbZDTJVWBDagHK9DfPcW+VFFx/JUDs6tZHJa
 7LWB3ZcIw/5wqxV9V2OErrXZ/ChLYXLIWUiYsWrkJVlmrNajjZivfGblY84=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Alex Ghiti <alex@ghiti.fr>:
> This is the result of the build for all arches tackled in this series
> rebased on 4.18-rc6:
> ...
> parisc:
>         generic-64bit_defconfig: with huge page does not link
>         generic-64bit_defconfig: without huge page does not link
>         BUT not because of this series, any feedback welcome.
Strange, but I will check that later....

Anyway, I applied your v4-patch to my parisc64 tree, built the kernel,
started it and ran some hugetlb LTP testcases sucessfully.
So, please add:

Tested-by: Helge Deller <deller@gmx.de> # parisc

Helge
