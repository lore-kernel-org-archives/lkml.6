Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF58C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E32902082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ruC6o84A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E32902082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbeLEJcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:32:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:60800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbeLEJcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:32:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3AEA206B7;
        Wed,  5 Dec 2018 09:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002369;
        bh=XvcNcTd5h9EUQAuG9Fb41nfSJj2dbLBNpLwZBFp/0hE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ruC6o84AhT7ezR6J4thMIPSgDYNBvDTdSmwiOfibVp24G8+tTG3N52FgpvkQa/qc9
         GDIUP0NjXDhFf3S/cqI5hQBBZ8CIEPDVcsTjtvI/NBpFANRWT/Na33NoH6QKqo2sWq
         L6BZ0UM2dRrrYxjIEJYkDh0YNppOAr04P8RndZ8w=
Date:   Wed, 5 Dec 2018 10:32:47 +0100
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
Subject: Re: [PATCH v3 2/5] usb: assign ACPI companions for embedded USB
 devices
Message-ID: <20181205093247.GB1817@kroah.com>
References: <20181117010748.24347-1-rajatja@google.com>
 <20181121235020.29461-1-rajatja@google.com>
 <20181121235020.29461-2-rajatja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121235020.29461-2-rajatja@google.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 03:50:17PM -0800, Rajat Jain wrote:
> From: Dmitry Torokhov <dtor@chromium.org>
> 
> USB devices permanently connected to USB ports may be described in ACPI
> tables and share ACPI devices with ports they are connected to. See [1]
> for details.
> 
> This will allow us to describe sideband resources for devices, such as,
> for example, hard reset line for BT USB controllers.
> 
> [1] https://docs.microsoft.com/en-us/windows-hardware/drivers/bringup/other-acpi-namespace-objects#acpi-namespace-hierarchy-and-adr-for-embedded-usb-devices
> 
> Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
> Signed-off-by: Rajat Jain <rajatja@google.com> (changed how we get the usb_port)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
