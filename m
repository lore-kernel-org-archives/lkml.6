Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE88BC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AD09214FB
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:02:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AD09214FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lxorguk.ukuu.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732301AbeHBLwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 07:52:42 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:45694 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732126AbeHBLwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 07:52:40 -0400
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id w72A2AQD011879;
        Thu, 2 Aug 2018 11:02:10 +0100
Date:   Thu, 2 Aug 2018 11:02:10 +0100
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     rkir@google.com
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] tty: Replace goldfish_tty_line_count with a
 #define
Message-ID: <20180802110210.65392224@alans-desktop>
In-Reply-To: <20180725005133.107823-3-rkir@google.com>
References: <20180725005133.107823-1-rkir@google.com>
        <20180725005133.107823-3-rkir@google.com>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jul 2018 17:51:33 -0700
rkir@google.com wrote:

> From: Roman Kiryanov <rkir@google.com>
> 
> The driver never mutates this variable - no benefits of
> keeping it mutable.
> 
> Signed-off-by: Roman Kiryanov <rkir@google.com>
> ---
> Changes in v2:
>  - Replaced "const u32" with "#define".

v1 was IMHO definitely better. And you are correct that gcc will not
allocate memory for a static const object unless you do things like take
its address. It will (unlike a define) however properly typecheck
everything.

Alan
