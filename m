Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5DCC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 19:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F78B20684
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 19:59:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F78B20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbeHUXVK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 19:21:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:57058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726861AbeHUXVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 19:21:10 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57FCB21829;
        Tue, 21 Aug 2018 19:49:27 +0000 (UTC)
Date:   Tue, 21 Aug 2018 15:49:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Matwey V. Kornilov" <matwey@sai.msu.ru>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        matwey.kornilov@gmail.com, tfiga@chromium.org,
        laurent.pinchart@ideasonboard.com, stern@rowland.harvard.edu,
        ezequiel@collabora.com, hdegoede@redhat.com, hverkuil@xs4all.nl,
        mchehab@kernel.org, mingo@redhat.com, isely@pobox.com,
        bhumirks@gmail.com, colin.king@canonical.com,
        kieran.bingham@ideasonboard.com, keiichiw@chromium.org
Subject: Re: [PATCH v5 1/2] media: usb: pwc: Introduce TRACE_EVENTs for
 pwc_isoc_handler()
Message-ID: <20180821154925.1951096c@gandalf.local.home>
In-Reply-To: <20180821170629.18408-2-matwey@sai.msu.ru>
References: <20180821170629.18408-1-matwey@sai.msu.ru>
        <20180821170629.18408-2-matwey@sai.msu.ru>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Aug 2018 20:06:28 +0300
"Matwey V. Kornilov" <matwey@sai.msu.ru> wrote:

> There were reports that PWC-based webcams don't work at some
> embedded ARM platforms. [1] Isochronous transfer handler seems to
> work too long leading to the issues in MUSB USB host subsystem.
> Also note, that urb->giveback() handlers are still called with
> disabled interrupts. In order to be able to measure performance of
> PWC driver, traces are introduced in URB handler section.
> 
> [1] https://www.spinics.net/lists/linux-usb/msg165735.html
> 
> Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
> ---
>

From a tracing perspective,

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
