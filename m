Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58361ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B1E9208E9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:40:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B1E9208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730733AbeGPJGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 05:06:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36760 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727848AbeGPJGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 05:06:41 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 048B0D5E;
        Mon, 16 Jul 2018 08:40:22 +0000 (UTC)
Date:   Mon, 16 Jul 2018 10:40:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     John Whitmore <johnfwhitmore@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        tglx@linutronix.de, kstewart@linuxfoundation.org,
        pombredanne@nexb.com
Subject: Re: staging:rtl8192u: [0/10] Coding style changes.
Message-ID: <20180716084020.GA8260@kroah.com>
References: <20180713201247.21428-1-johnfwhitmore@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180713201247.21428-1-johnfwhitmore@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 09:12:37PM +0100, John Whitmore wrote:
> All coding style changes, but the second [2/10] is a bit more hairy then
> most. The original code combined two typedef declarations into one with both
> the structure and a pointer to the structure defined. I've totally removed the
> pointer to the structure type since it uses Hungarian notation, which the
> coding standard isn't keen on.
> 
> As a result of this there are changes in code from the type:
> PStructType  *ppname;
> to:
> struct StructType **ppname;
> 
> To keep the diff simple I've kept the current nameing of "ppname", which again
> is Hungarian notation. I'll leave that for a future patch.

Nit, your subject should look like:

Subject: [PATCH 00/10] staging:rtl8192u: Coding style changes.

What are you using to generate this email?  git format-patch
--cover-letter should generate it with a correct subject line prefix,
right?

thanks,

greg k-h
