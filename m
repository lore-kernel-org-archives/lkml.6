Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA26C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EE4420811
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549280855;
	bh=0v1MfmKQ+7NcvkxJ32qlNktk6rJhLkb8374+r9yiMKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KbSNL6E2DngK2r4d8E/iSE7SIDUQgAyoHSTxc/SxNTmtLynDZJFHTQf0iBO5nGYhG
	 VELJAMaip7oeN+1ZNtGfxcOU8iDbww4EQ/AUqiT8spfP9PyxEj9c3XvqyuDxOLvXIT
	 ddnjj8piF3cJgacIxZpyeaQUlT+qPbbf61NWKW1E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbfBDLrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 06:47:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:35674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728949AbfBDLr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 06:47:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FC4220811;
        Mon,  4 Feb 2019 11:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549280849;
        bh=0v1MfmKQ+7NcvkxJ32qlNktk6rJhLkb8374+r9yiMKI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jecTTx/cyCRuaiIY9gsYf6BMWtK3onkHYVMZdZ94J0O/7vt3TYewXyqqJulKXzJb+
         GiKH5Dv6dSN3YWJQqAp7Dk3Vu5O2leu+BD0h+Bs2hJN4Cwg9vhuBm2yQhm9K/LXXcQ
         RlZ4z0jAJHJLi8pvKSskzPtgnGGQkSoeHZC1mQFM=
Date:   Mon, 4 Feb 2019 12:47:26 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     devicetree@vger.kernel.org, mark.rutland@arm.com,
        linux-usb@vger.kernel.org, hdegoede@redhat.com,
        heikki.krogerus@linux.intel.com, andy.shevchenko@gmail.com,
        robh+dt@kernel.org, rogerq@ti.com, linux-kernel@vger.kernel.org,
        jbergsagel@ti.com, nsekhar@ti.com, nm@ti.com, sureshp@cadence.com,
        peter.chen@nxp.com, pjez@cadence.com, kurahul@cadence.com
Subject: Re: [PATCH v3 4/6] usb:common Simplify usb_decode_get_set_descriptor
 function.
Message-ID: <20190204114726.GC28608@kroah.com>
References: <1548935553-452-1-git-send-email-pawell@cadence.com>
 <1548935553-452-5-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548935553-452-5-git-send-email-pawell@cadence.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 11:52:31AM +0000, Pawel Laszczak wrote:
> Patch moves switch responsible for decoding descriptor type
> outside snprintf. It's little improves code readability.

Should that last sentence read: "It improves code readability a little"?

thanks,

greg k-h

