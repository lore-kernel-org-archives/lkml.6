Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235A0ECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 07:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD8A120849
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 07:46:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD8A120849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727759AbeGUIiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 04:38:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48660 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727140AbeGUIiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 04:38:01 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 893A4AEF;
        Sat, 21 Jul 2018 07:46:13 +0000 (UTC)
Date:   Sat, 21 Jul 2018 09:46:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     rkir@google.com
Cc:     linux-kernel@vger.kernel.org, tkjos@google.com
Subject: Re: [PATCH 3/3] tty: Mark goldfish_tty_line_count as const
Message-ID: <20180721074611.GC6484@kroah.com>
References: <20180718001455.140575-1-rkir@google.com>
 <20180718001455.140575-3-rkir@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718001455.140575-3-rkir@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 05:14:55PM -0700, rkir@google.com wrote:
> From: Roman Kiryanov <rkir@google.com>
> 
> The driver never mutates this variable - no benefits of
> keeping it mutable.

Then why not just make it a #define?  No need to waste the memory of a
variable, right?

thanks,

greg k-h
