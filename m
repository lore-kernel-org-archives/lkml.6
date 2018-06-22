Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C098C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D97712455B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:52:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D97712455B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934134AbeFVPww convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 11:52:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:42586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933962AbeFVPwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 11:52:50 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADA4724556;
        Fri, 22 Jun 2018 15:52:48 +0000 (UTC)
Date:   Fri, 22 Jun 2018 11:52:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Matwey V. Kornilov" <matwey@sai.msu.ru>
Cc:     hverkuil@xs4all.nl, mchehab@kernel.org, mingo@redhat.com,
        isely@pobox.com, bhumirks@gmail.com, colin.king@canonical.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        ezequiel@collabora.com, laurent.pinchart@ideasonboard.com
Subject: Re: [PATCH v2 1/2] media: usb: pwc: Introduce TRACE_EVENTs for
 pwc_isoc_handler()
Message-ID: <20180622115246.684ed07c@gandalf.local.home>
In-Reply-To: <20180622120419.7675-2-matwey@sai.msu.ru>
References: <20180622120419.7675-1-matwey@sai.msu.ru>
        <20180622120419.7675-2-matwey@sai.msu.ru>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jun 2018 15:04:18 +0300
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

From a tracing point of view:

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> ---
>  drivers/media/usb/pwc/pwc-if.c |  7 +++++
>  include/trace/events/pwc.h     | 64 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 71 insertions(+)
>  create mode 100644 include/trace/events/pwc.h
> 
>
