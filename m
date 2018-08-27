Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B254EC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 22:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EB32208B4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 22:48:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EB32208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbeH1Cg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 22:36:59 -0400
Received: from mga18.intel.com ([134.134.136.126]:40140 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726994AbeH1Cg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 22:36:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2018 15:48:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,296,1531810800"; 
   d="scan'208";a="80679725"
Received: from megha-z97x-ud7-th.sc.intel.com (HELO [143.183.85.162]) ([143.183.85.162])
  by fmsmga002.fm.intel.com with ESMTP; 27 Aug 2018 15:48:19 -0700
Message-ID: <1535411336.3516.2.camel@megha-Z97X-UD7-TH>
Subject: Re: KASAN: use-after-free Read in sha512_ctx_mgr_resubmit
From:   Megha Dey <megha.dey@linux.intel.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        syzbot <syzbot+d5455bac3ba1ee9114e5@syzkaller.appspotmail.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        the arch/x86 maintainers <x86@kernel.org>
Date:   Mon, 27 Aug 2018 16:08:56 -0700
In-Reply-To: <20180822062036.mdq4q5o5zdzuxh7s@gondor.apana.org.au>
References: <00000000000072d64d05737b6b8c@google.com>
         <20180820073119.GA14931@sol.localdomain>
         <CAKv+Gu9Y0TLOuMba43HPihYqy-kk0nttBfPj1_UukiYy1cBcFw@mail.gmail.com>
         <20180822062036.mdq4q5o5zdzuxh7s@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-22 at 14:20 +0800, Herbert Xu wrote:
> On Tue, Aug 21, 2018 at 02:43:56PM +0200, Ard Biesheuvel wrote:
> >
> > I agree. The code is obviously broken in a way that would have been
> > noticed if it were in wide use, and it is too complicated for mere
> > mortals to fix or maintain. I suggest we simply remove it for now, and
> > if anyone wants to reintroduce it, we can review the code *and* the
> > justification for the approach from scratch (in which case we should
> > consider factoring out the algo agnostics plumbing in a way that
> > allows it to be reused by other architectures as well)
> 
> I agree too.  Could one of you guys send me a patch to remove
> them?
> 

Hi,

We are working on a fix to solve these corner cases.

-Megha
> Thanks,


