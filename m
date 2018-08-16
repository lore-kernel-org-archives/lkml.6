Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A392AC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 10:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51ED3214AB
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 10:07:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51ED3214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390810AbeHPNEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 09:04:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43300 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbeHPNEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 09:04:39 -0400
Received: from localhost (unknown [37.170.164.166])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1CF7BBA2;
        Thu, 16 Aug 2018 10:07:10 +0000 (UTC)
Date:   Thu, 16 Aug 2018 12:07:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Erick Reyes <erickreyes@google.com>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, kernel-team@android.com,
        Vinod Koul <vkoul@kernel.org>, Joe Perches <joe@perches.com>,
        Al Viro <viro@zeniv.linux.org.uk>, alsa-devel@alsa-project.org,
        Siqi Lin <siqilin@google.com>
Subject: Re: [PATCH] ALSA: info: Check for integer overflow in
 snd_info_entry_write()
Message-ID: <20180816100705.GC9141@kroah.com>
References: <20180816005548.151269-1-erickreyes@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180816005548.151269-1-erickreyes@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 05:55:48PM -0700, Erick Reyes wrote:
> Commit 4adb7bcbcb69 ("ALSA: core: Use seq_file for text proc file
> reads") heavily refactored ALSA procfs and fixed the overflow as
> a side-effect, so this fix only applies to kernels < 4.2 and
> there is no upstream equivalent

Thanks for the patch.  I'll queue this up for 3.18.

greg k-h
