Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649E8C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1978620820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:04:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1978620820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ab.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbeKBAIF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 20:08:05 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:58845 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728679AbeKBAIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 20:08:05 -0400
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id wA1F3Xrl005508
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 2 Nov 2018 00:03:33 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id wA1F3Xfq024254;
        Fri, 2 Nov 2018 00:03:33 +0900
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id wA1F3X2v009107;
        Fri, 2 Nov 2018 00:03:33 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.135] [10.38.151.135]) by mail01b.kamome.nec.co.jp with ESMTP id BT-MMP-5119250; Fri, 2 Nov 2018 00:01:03 +0900
Received: from BPXM09GP.gisp.nec.co.jp ([10.38.151.201]) by
 BPXC07GP.gisp.nec.co.jp ([10.38.151.135]) with mapi id 14.03.0319.002; Fri, 2
 Nov 2018 00:01:03 +0900
From:   Kazuhito Hagio <k-hagio@ab.jp.nec.com>
To:     Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>
CC:     lijiang <lijiang@redhat.com>, Baoquan He <bhe@redhat.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kazuhito Hagio <khagio@redhat.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: RE: [PATCH] kdump, vmcoreinfo: Export sme_me_mask value to
 vmcoreinfo
Thread-Topic: [PATCH] kdump, vmcoreinfo: Export sme_me_mask value to
 vmcoreinfo
Thread-Index: AQHUcMEz2vnlJsE740iaHFNjogbP4aU4D9UAgAB7zQCAAVkNUA==
Date:   Thu, 1 Nov 2018 15:01:02 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC0355EDE8@BPXM09GP.gisp.nec.co.jp>
References: <15897206-c1a6-ced6-3a1b-f71da8fc9c83@redhat.com>
 <20181029114414.GA11408@MiWiFi-R3L-srv>
 <90385882-7fd1-a674-ec5a-19bd42471a5e@redhat.com>
 <20181029134918.GB32150@zn.tnic>
 <699ab34e-1373-582d-4e58-e76bd57ec34f@redhat.com>
 <20181030050900.GA25987@dhcp-128-65.nay.redhat.com>
 <20181030091542.GD32102@zn.tnic> <20181030092314.GC14493@MiWiFi-R3L-srv>
 <dcbc925f-6935-6a34-fde1-7aa1ea378891@redhat.com>
 <20181031024748.GA2058@dhcp-128-65.nay.redhat.com>
 <20181031101054.GB15955@zn.tnic>
In-Reply-To: <20181031101054.GB15955@zn.tnic>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [143.101.135.161]
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/2018 6:10 AM, Borislav Petkov wrote:
> On Wed, Oct 31, 2018 at 10:47:48AM +0800, Dave Young wrote:
> > It is a mist only a few kdump people know them, documenting them will help
> > people to understand and review. It will also be clearer instead of
> > digging into code?
> 
> Wholeheartedly agreed. Especially if people start using vmcoreinfo for
> other stuff, like live debugging:
> 
> https://lkml.kernel.org/r/1540593788-28181-1-git-send-email-bhsharma@redhat.com

I also agree. If it can help reviewers and other users to understand
vmcoreinfo and can help itself to become more standard, it would be
better to write it.

One small thing as a vmcoreinfo user (not about the documentation),
I think it might be better to export each information to each variable
separately, not OR-ing them into a variable, because of code simpleness
of both kernel and tools, if there is no limitation in kernel.

Thanks,
Kazu


