Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8F4C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB23A20881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:28:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB23A20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbeJPTSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 15:18:22 -0400
Received: from mga04.intel.com ([192.55.52.120]:33822 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726595AbeJPTSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 15:18:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2018 04:28:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,388,1534834800"; 
   d="scan'208";a="81835354"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.128])
  by orsmga008.jf.intel.com with ESMTP; 16 Oct 2018 04:28:20 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] usb: gadget: storage: Fix Spectre v1 vulnerability
In-Reply-To: <20181016101645.GA24870@embeddedor.com>
References: <20181016101645.GA24870@embeddedor.com>
Date:   Tue, 16 Oct 2018 14:28:19 +0300
Message-ID: <8736t6p1v0.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Greg,

"Gustavo A. R. Silva" <gustavo@embeddedor.com> writes:

> num can be indirectly controlled by user-space, hence leading to
> a potential exploitation of the Spectre variant 1 vulnerability.
>
> This issue was detected with the help of Smatch:
>
> drivers/usb/gadget/function/f_mass_storage.c:3177 fsg_lun_make() warn:
> potential spectre issue 'fsg_opts->common->luns' [r] (local cap)
>
> Fix this by sanitizing num before using it to index
> fsg_opts->common->luns
>
> Notice that given that speculation windows are large, the policy is
> to kill the speculation on the first load and not worry if it can be
> completed with a dependent load/store [1].
>
> [1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Can you still take this as an urgent fix?

Acked-by: Felipe Balbi <felipe.balbi@intel.com>

-- 
balbi
