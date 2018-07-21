Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC406ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 07:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C332206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 07:21:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C332206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbeGUIM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 04:12:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48330 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727172AbeGUIM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 04:12:28 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6EE23B13;
        Sat, 21 Jul 2018 07:20:45 +0000 (UTC)
Date:   Sat, 21 Jul 2018 09:20:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nicolas Pitre <nicolas.pitre@linaro.org>
Cc:     Adam Borowski <kilobyte@angband.pl>,
        Kees Cook <keescook@chromium.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dave Mielke <Dave@mielke.cc>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        linux-kernel@vger.kernel.org, linux-console@vger.kernel.org
Subject: Re: [PATCH v2 1/3] vt: avoid a VLA in the unicode screen scroll
 function
Message-ID: <20180721072043.GA26449@kroah.com>
References: <20180718010242.5254-1-nicolas.pitre@linaro.org>
 <20180718010242.5254-2-nicolas.pitre@linaro.org>
 <20180718014813.ygcbgqxk4yo3ydbl@angband.pl>
 <nycvar.YSQ.7.76.1807172155070.11681@knanqh.ubzr>
 <nycvar.YSQ.7.76.1807182353560.2327@knanqh.ubzr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YSQ.7.76.1807182353560.2327@knanqh.ubzr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 12:05:25AM -0400, Nicolas Pitre wrote:
> 
> The nr argument is typically small: most often nr == 1. However this
> could be abused with a very large explicit scroll in a resized screen.
> Make the code scroll lines by performing an array rotation operation to
> avoid the need for a large temporary space.
> 
> Requested-by: Kees Cook <keescook@chromium.org>
> Suggested-by: Adam Borowski <kilobyte@angband.pl>
> Signed-off-by: Nicolas Pitre <nico@linaro.org>

I've now applied this v2 of the patch, thanks for this.

greg k-h
