Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2549C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 703E62086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:02:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 703E62086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbeILCDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 22:03:18 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:48138 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727645AbeILCDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 22:03:18 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <johannes@sipsolutions.net>)
        id 1fzpnV-0005L8-Vv; Tue, 11 Sep 2018 23:02:10 +0200
Message-ID: <1536699720.3224.152.camel@sipsolutions.net>
Subject: Re: 4.19-rc[23] iwlwifi: BUG in swiotlb
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linuxwifi@intel.com
Date:   Tue, 11 Sep 2018 23:02:00 +0200
In-Reply-To: <8bea4cfc-4b16-7c7c-3e9a-5b6684b47345@infradead.org>
References: <0c5e53e5-2afa-8d38-0b48-272c670c4bc5@infradead.org>
         <1536651177.3224.106.camel@sipsolutions.net>
         <8bea4cfc-4b16-7c7c-3e9a-5b6684b47345@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-09-11 at 13:57 -0700, Randy Dunlap wrote:

> I can't be sure.  I've been having problems booting this laptop for a few
> weeks now but haven't tracked it down yet.

Ok.

> The wireless NIC is Condor Peak:
> 
> 04:00.0 Network controller: Intel Corporation Centrino Wireless-N 1000 [Condor Peak]

Wow, that's old. I should have one somewhere, but we haven't worked on
this NIC in many years. We've touched the driver, of course, but the
configuration for this wouldn't have changed.

> sigh.  I can reproduce it without the patch:
> 
> > https://p.sipsolutions.net/aa0dccd7a60fe176.txt
> 
> but with that patch, it just hangs after about 25 seconds of booting
> (slow hard drive, not SSD).
> 
> I'll try some other ways.

Hmm. That makes me think you have some corruption going on, rather than
something really being set to 0, because otherwise you should've seen
the warning at least?

johannes
