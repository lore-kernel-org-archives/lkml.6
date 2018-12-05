Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBC2C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90C3A206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pAwBncT7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90C3A206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbeLEJcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:32:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:60462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbeLEJca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:32:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EA342082B;
        Wed,  5 Dec 2018 09:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002350;
        bh=AWQJilW1v2LUnMGgKQ7SK8iwjqOrj9MZ86LPr9xVc2U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pAwBncT7gHYgf1y2KW5x7V2fIQsKeIJBx1hfLm24muDDWd0LUj8e9pXmElyIccbMG
         EPf5ydAdrGYQypT9xwWyCPvu4iTcQaadOo54NgKFQ2h4aq0inygB166kDl/x51pfNd
         k+m3NS0oHLFmGjJRcBC7OH8HnDd37sHFpx4Uz6Xs=
Date:   Wed, 5 Dec 2018 10:32:28 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Torokhov <dtor@chromium.org>,
        Alex Hung <alex.hung@canonical.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        rajatxjain@gmail.com, dtor@google.com, raghuram.hegde@intel.com,
        chethan.tumkur.narayan@intel.com, sukumar.ghorai@intel.com
Subject: Re: [PATCH v3 1/5] usb: split code locating ACPI companion into port
 and device
Message-ID: <20181205093228.GA1817@kroah.com>
References: <20181117010748.24347-1-rajatja@google.com>
 <20181121235020.29461-1-rajatja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121235020.29461-1-rajatja@google.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 03:50:16PM -0800, Rajat Jain wrote:
> From: Dmitry Torokhov <dtor@chromium.org>
> 
> In preparation for handling embedded USB devices let's split
> usb_acpi_find_companion() into usb_acpi_find_companion_for_device() and
> usb_acpi_find_companion_for_port().
> 
> Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
> Signed-off-by: Rajat Jain <rajatja@google.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
