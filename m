Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4548EC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 096112177F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:57:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 096112177F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbeHURR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 13:17:59 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:59676 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbeHURR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 13:17:59 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fs7AD-00024N-TK; Tue, 21 Aug 2018 15:57:42 +0200
Date:   Tue, 21 Aug 2018 15:57:41 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Mukesh Ojha <mojha@codeaurora.org>
cc:     lkml <linux-kernel@vger.kernel.org>
Subject: Re: Query on skip_onerr field in struct cpuhp_step
In-Reply-To: <c228c495-63fa-5af9-32ff-355410d78cc8@codeaurora.org>
Message-ID: <alpine.DEB.2.21.1808211557180.1535@nanos.tec.linutronix.de>
References: <c228c495-63fa-5af9-32ff-355410d78cc8@codeaurora.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1551648132-1534859861=:1535"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1551648132-1534859861=:1535
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Tue, 21 Aug 2018, Mukesh Ojha wrote:
> Hi All,
> 
> This is about one of field in struct cpuhp_step
> 
> * @skip_onerr: Do not invoke the functions on error rollback
>  *              Will go away once the notifiers are gone
>         bool                    skip_onerr;
> 
> Why this field was introduced, can anyone explain the history behind ? As i
> don't see it being set from anywhere
> 
> If it is specifically was dependent on notifiers, did we missed to remove it
> as the notifiers are gone or the usecase still there?

As the comment says....

--8323329-1551648132-1534859861=:1535--
