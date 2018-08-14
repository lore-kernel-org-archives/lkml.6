Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF0BC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 10:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40EEC2170F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 10:13:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40EEC2170F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732139AbeHNNA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 09:00:26 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:51767 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732070AbeHNNAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 09:00:25 -0400
Received: from 79.184.254.66.ipv4.supernova.orange.pl (79.184.254.66) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id 8008b5d4cf829f7b; Tue, 14 Aug 2018 12:13:53 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Pu Wen <puwen@hygon.cn>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        thomas.lendacky@amd.com, Borislav Petkov <bp@alien8.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v3 15/17] driver/cpufreq: enable Hygon support to cpufreq driver
Date:   Tue, 14 Aug 2018 12:11:44 +0200
Message-ID: <2048121.dGp66DhuPz@aspire.rjw.lan>
In-Reply-To: <04744a9f-5865-bbc8-7735-e92c6cf6472d@hygon.cn>
References: <cover.1533989492.git.puwen@hygon.cn> <CAJZ5v0izyq2SoUspLPDRM9U7W+-bZPCcQ4C5Zu1hVFDoUj=w1g@mail.gmail.com> <04744a9f-5865-bbc8-7735-e92c6cf6472d@hygon.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, August 13, 2018 6:22:16 PM CEST Pu Wen wrote:
> On 2018/8/12 17:55, Rafael J. Wysocki wrote:
> > On Sat, Aug 11, 2018 at 3:36 PM Pu Wen <puwen@hygon.cn> wrote:
> >>
> >> Enable ACPI cpufreq driver support for Hygon by adding family ID check
> >> along with AMD.
> >>
> >> As Hygon platforms have SMBus device(PCI device ID 0x790b), enable Hygon
> >> support to function amd_freq_sensitivity_init().
> >>
> >> Signed-off-by: Pu Wen <puwen@hygon.cn>
> > 
> > Is there any technical difference between HYGON and AMD?
> 
> For ACPI cpufreq patch, you are right. But for the whole point of view,
> there has some technical difference between Hygon Dhyana and AMD Family
> 17h.
> For cpufreq if not added X86_VENDOR_HYGON codes, this driver will not
> work functionally on Hygon platforms.
> 
> > 
> > You seem to be mechanically adding X86_VENDOR_HYGON wherever
> > X86_VENDOR_AMD is used.
> 
> X86_VENDOR_HYGON is not mechanically added wherever X86_VENDOR_AMD is
> used, we have reviewed and tested the features wherever X86_VENDOR_HYGON
> is needed.
> 
> As Hygon Dhyana can share code path with AMD family 17h, to minimize the
> code duplication, we choose to reuse the AMD's codes here.

OK

The cpufreq changes are fine by me.

Thanks!

