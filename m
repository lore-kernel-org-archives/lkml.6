Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1BEC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EB9120652
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:41:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EB9120652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbeJBWZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 18:25:52 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:60452 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbeJBWZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 18:25:52 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g7Mns-0007Xq-Aq; Tue, 02 Oct 2018 17:41:40 +0200
Date:   Tue, 2 Oct 2018 17:41:39 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Feng Tang <feng.tang@intel.com>
cc:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        H Peter Anvin <hpa@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Stuart R . Anderson" <stuart.r.anderson@intel.com>,
        alan@linux.intel.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/earlyprintk: Add a force option for pciserial
 device
In-Reply-To: <20181002153110.qyttitbdzhtatlev@shbuild888>
Message-ID: <alpine.DEB.2.21.1810021741181.12704@nanos.tec.linutronix.de>
References: <20180929163458.GA25608@zn.tnic> <20180930131619.jecqh4umrkmifavb@shbuild888> <20181001123916.GC7269@zn.tnic> <20181001141810.fbo3amfqnr5243mc@shbuild888> <20181001203004.GG7269@zn.tnic> <20181002091627.3vm6ow4y7me2uju3@shbuild888>
 <alpine.DEB.2.21.1810021112100.32062@nanos.tec.linutronix.de> <20181002094852.3bw2loje4zjriqe7@shbuild888> <alpine.DEB.2.21.1810021241000.32062@nanos.tec.linutronix.de> <20181002121046.lsqqnqfu42bazbfx@shbuild888>
 <20181002153110.qyttitbdzhtatlev@shbuild888>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Oct 2018, Feng Tang wrote:
> One idea is to change the new format to
> 	earlyprintk=pciserial[,force],bus:device.function[,baudrate]
> Then we can use what Boris has suggested:
> 	!strncmp(s, "force,", 6)

Works for me.
