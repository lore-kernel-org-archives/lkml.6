Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573A4C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 108B02084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544614634;
	bh=6FUgvVDCpisbOfkkhZSv0C5+WSRbMvWrDVg+/rvkl+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Wk0eipxmRkkdXcocD7Gql/9g5zf2Jp8wPLJlnqyaugFP7Nnc04ShrWq6YRw+6yLyT
	 z/aSusyneLc+XgYBM+2tK7K629YSF7PQWk07gcen1yVGVej2EENwqF2LsKCzKfwrT9
	 Xwt4vYlyiRZTv0h4C5pEBkon+89G8dzDJW8amCq0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 108B02084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbeLLLhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 06:37:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:51140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726869AbeLLLhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 06:37:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33A2A2086D;
        Wed, 12 Dec 2018 11:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544614631;
        bh=6FUgvVDCpisbOfkkhZSv0C5+WSRbMvWrDVg+/rvkl+E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YDDqDFw0GWa/ZyEkdqSMdmBFNFj+0UYVMWEB9OWFuEh9Pc3sNms+8/biE1oPmarsr
         JPlYMemnNRZmInSHKnsH8ep3QNGKlBZngVwSG0i59Z2IcQ/wvLH83g8nJr+1z7OmJf
         58lhi7NHXY4E5z+23NXlc+qmOL4KUxu6O/FuYzp0=
Date:   Wed, 12 Dec 2018 12:37:09 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kyle Williams <kdgwill@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Jon Flatley <jflat@chromium.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v3 1/2] USB: quirks: Check device interface LPM capability
Message-ID: <20181212113709.GA20058@kroah.com>
References: <20181205093902.GA18633@kroah.com>
 <20181208014724.951-1-kdgwill@google.com>
 <20181208014724.951-2-kdgwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181208014724.951-2-kdgwill@google.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 08:47:21PM -0500, Kyle Williams wrote:
> From: Kyle Williams <kdgwill@chromium.org>
> 
> Description: enable the ability to disable LPM for all devices matched
> by interface information

Why have "Description:" in here?  Of course this is the description :)

And the subject doesn't make much sense, what does this have to do with
quirks?

Also, you need more information here in the description about why you
are doing all of this, as it is, I have no idea why this patch is needed
at all.

thanks,

greg k-h
