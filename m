Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E517DC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2B6820652
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:52:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2B6820652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbeJHTDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 15:03:54 -0400
Received: from mga11.intel.com ([192.55.52.93]:44887 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726882AbeJHTDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 15:03:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2018 04:52:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,356,1534834800"; 
   d="scan'208";a="90140910"
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.212])
  by orsmga003.jf.intel.com with ESMTP; 08 Oct 2018 04:52:14 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     "Alharthi\, Mansour A" <mansourah@gatech.edu>,
        "peterz\@infradead.org" <peterz@infradead.org>,
        "acme\@kernel.org" <acme@kernel.org>,
        "mingo\@redhat.com" <mingo@redhat.com>,
        "adrian.hunter\@intel.com" <adrian.hunter@intel.com>
Cc:     "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: tracing child threads with address filtering using intel_pt in perf
In-Reply-To: <5267CD8C-A8B1-416E-BCCD-5DD87DCA4FB1@gatech.edu>
References: <8fc78808-db61-2f41-180a-9713178e22f6@gatech.edu> <5267CD8C-A8B1-416E-BCCD-5DD87DCA4FB1@gatech.edu>
Date:   Mon, 08 Oct 2018 14:52:13 +0300
Message-ID: <87o9c464gi.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Alharthi, Mansour A" <mansourah@gatech.edu> writes:

> Hello all,

Hi,

> Assume this test code:
>
> thread_start(){
> ...
> test();
> ...
> }
>
> test(){
> printf("test");
> }
>
> main(){
> ...
> pthread_create(......, thread_start,....);
> }

Can you include the complete test case code?

> Tracing the above program with the following command:
> perf record -v -m 512,10000 -e intel_pt//u -T --switch-events --filter
> 'filter * @ ./test' -- ./test

Can you run it with -vvv and also include its output?

Thanks,
--
Alex
