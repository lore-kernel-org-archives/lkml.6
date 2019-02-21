Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76572C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 19:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FE142081B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 19:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550778146;
	bh=42OHwxo/Z0vC55ri0hh2saipSgXYfDWz1fo/2II09dw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kIZJEMEX5oJXkAO6WTwJN9DXpu3RgpGA5VWX+HPZcePQTfHZxem0Hn+yezx2u6pTc
	 ixKu7TG5bylik0QQNqaQfB4UNl0qEOKmauel4eb/Rf4X07XRMx8ra/q6gW0p2TRvjp
	 NcpVMacUhWPDTyrGec01kdwHYfGA7xT4SmYcCVRQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbfBUTmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 14:42:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:40066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726220AbfBUTmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 14:42:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4E832081B;
        Thu, 21 Feb 2019 19:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550778143;
        bh=42OHwxo/Z0vC55ri0hh2saipSgXYfDWz1fo/2II09dw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eJwhFqlbWned0/ioEkqRtZUnLlT1V/u1+T/lNM4Z8G3jJCA7UNbBB7KUhDKeGOf/w
         NaJUaZno0SpB/+8QEjqnJxsHoH0XSQvzf80mC+hg3PLJFIXWHrdIZk1WePa84PUUj0
         AzuvL21uCByZPoZ/+HS9LXvQnp8bPrw7IlyQA43U=
Date:   Thu, 21 Feb 2019 20:42:19 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Vishnu DASA <vdasa@vmware.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Pv-drivers <Pv-drivers@vmware.com>
Subject: Re: [PATCH] VMCI: Support upto 64-bit PPNs
Message-ID: <20190221194219.GA2347@kroah.com>
References: <20190215162738.21334-1-vdasa@vmware.com>
 <20190216195253.GB11061@kroah.com>
 <8C694A7E-488C-42A9-83F8-AA4FB4E57A5A@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8C694A7E-488C-42A9-83F8-AA4FB4E57A5A@vmware.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Thu, Feb 21, 2019 at 07:26:29PM +0000, Vishnu DASA wrote:
> Hi Greg,
> Sounds like a good idea to use the BIT() macro but can I do that in a
> separate change to cover the entire file (and perhaps other vmci files
> too)?

Yes, that would be fine.

thanks,

greg k-h
