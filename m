Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BB8C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 00:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D781D20874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 00:02:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D781D20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932802AbeFUACK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 20:02:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40598 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932307AbeFUACJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 20:02:09 -0400
Received: from localhost (113x41x139x141.ap113.ftth.ucom.ne.jp [113.41.139.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 15EFDD5E;
        Thu, 21 Jun 2018 00:02:08 +0000 (UTC)
Date:   Thu, 21 Jun 2018 09:02:07 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dmitry Vyukov <dvyukov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH] include/asm-generic/bug.h: clarify valid uses of WARN()
Message-ID: <20180621000207.GB21936@kroah.com>
References: <20180620103716.61636-1-dvyukov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620103716.61636-1-dvyukov@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 12:37:16PM +0200, Dmitry Vyukov wrote:
> From: Dmitry Vyukov <dvyukov@google.com>
> 
> Explicitly state that WARN*() should be used only for recoverable
> kernel issues/bugs and that it should not be used for any kind of
> invalid external inputs or transient conditions.
> 
> Motivation: it's a very useful capability to be able to understand
> if a particular kernel splat means a kernel bug or simply an invalid
> user-space program. For the former one wants to notify kernel developers,
> while notifying kernel developers for the latter is annoying.
> Even a kernel developer may not know what to do with a WARNING
> in an unfamiliar subsystem. This is especially critical for any automated
> testing systems that may use panic_on_warn and mail kernel developers.
> 
> The clear separation also serves as an additional documentation:
> is it a condition that must never occur because of additional
> checks/logic elsewhere? or is it simply a check for invalid inputs
> or unfortunate conditions?
> 
> Use of pr_err() for user messages also leads to better error messages.
> "Something is wrong in file foo on line X" is not particularly useful
> message for end user. pr_err() forces developers to write more meaningful
> error messages for user.
> 
> As of now we are almost there. We are doing systematic kernel testing
> with panic_on_warn and are not seeing massive amounts of false positives.
> But every now and then another WARN on ENOMEM or invalid inputs pops up
> and leads to a lengthy argument each time. The goal of this change
> is to officially document the rules.
> 
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> ---
>  include/asm-generic/bug.h | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)

Nice!

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
