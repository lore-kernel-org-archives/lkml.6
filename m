Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AD5C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 17:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29B2022504
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 17:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3yiOMTC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29B2022504
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729453AbeKMDkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 22:40:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:36426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727185AbeKMDkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 22:40:52 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93DD42243E;
        Mon, 12 Nov 2018 17:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542044796;
        bh=JYiASsp0Xa0mAJ9+8h/1fxDPLl4gq4PMos7jFrzWpJs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P3yiOMTCwNZsNj57DcmOourhVMox7FunuDs1SnlJee/lnNE4BH7JstOCO1o45kiGj
         eDjn2L73HL5yL5ZzHjccydMIDNgQCJ661XoLoXdgnATvCla6kopSgLcsFinZV61viv
         Aqj4C8aA0ms6XOZuejDni/nLlaZvnE4+rMRb78iM=
Date:   Mon, 12 Nov 2018 09:46:36 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Schmauss, Erik" <erik.schmauss@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Jean-Marc Lenoir <archlinux@jihemel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 4.14 009/222] ACPICA: AML interpreter: add region
 addresses in global list during initialization
Message-ID: <20181112174636.GA15484@kroah.com>
References: <20181111221647.665769131@linuxfoundation.org>
 <20181111221648.772697504@linuxfoundation.org>
 <CF6A88132359CE47947DB4C6E1709ED53BB9FAB9@ORSMSX110.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CF6A88132359CE47947DB4C6E1709ED53BB9FAB9@ORSMSX110.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 05:16:19PM +0000, Schmauss, Erik wrote:
> 
> > -----Original Message-----
> > From: Greg Kroah-Hartman [mailto:gregkh@linuxfoundation.org]
> > Sent: Sunday, November 11, 2018 2:22 PM
> > To: linux-kernel@vger.kernel.org
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>;
> > stable@vger.kernel.org; Jean-Marc Lenoir <archlinux@jihemel.com>;
> > Schmauss, Erik <erik.schmauss@intel.com>; Wysocki, Rafael J
> > <rafael.j.wysocki@intel.com>
> > Subject: [PATCH 4.14 009/222] ACPICA: AML interpreter: add region
> > addresses in global list during initialization
> > 
> Hi Greg,
> 
> > 4.14-stable review patch.  If anyone has any objections, please let me know.
> 
> This patch is only meant to be added for kernels that are 4.17 or later.
> 
> Please drop this from kernel 4.16 or older.

Ok, but next time be a bit more careful when you add a line like this to
the patch:

> > Cc: All applicable <stable@vger.kernel.org>

I take this to mean "everything it can apply cleanly to".

I'll go drop it from the 3.18.y, 4.4.y, and 4.9.y stable queues as well.

thanks,

greg k-h
