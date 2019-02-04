Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D931C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15EDF20823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549280733;
	bh=BpOswG/vhfhcw5t6gXLinJayiTtIdHqNSmlPWVFvb9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=02GC+YajiZLZJX2pnAA8hxSLYvyBpXy69QF5gFhmgKtIPNPB82SbFISPD/qiIJD1S
	 Vt9m2E1sSDemBqCCekBVwS1EDrLsBp84WhdDLsAkFhDViIx+JOVfheixO8he4Mb9gZ
	 gEeilYbIwSwzinxFPvtHLLOC0MqrnmXnM+hFfU44=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729349AbfBDLpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 06:45:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:34874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726603AbfBDLpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 06:45:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 657A620811;
        Mon,  4 Feb 2019 11:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549280730;
        bh=BpOswG/vhfhcw5t6gXLinJayiTtIdHqNSmlPWVFvb9E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hia20DSc64W6YwgiHV77Xd67zjL9zgMduSkQv/3CGBANacn909TImyAXfzqgkvoRx
         TKwBR1uj7DElVyCOiBcwK939i1sv3u3RBvJn7/fcNA8sy3WUStE9m5lralIxjF4jEG
         lqHCWRTqRky9d9WNsXQYGMCklkXXQO8QUFpi2GFI=
Date:   Mon, 4 Feb 2019 12:45:28 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     devicetree@vger.kernel.org, mark.rutland@arm.com,
        linux-usb@vger.kernel.org, hdegoede@redhat.com,
        heikki.krogerus@linux.intel.com, andy.shevchenko@gmail.com,
        robh+dt@kernel.org, rogerq@ti.com, linux-kernel@vger.kernel.org,
        jbergsagel@ti.com, nsekhar@ti.com, nm@ti.com, sureshp@cadence.com,
        peter.chen@nxp.com, pjez@cadence.com, kurahul@cadence.com
Subject: Re: [PATCH v3 2/6] usb:common Separated decoding functions from dwc3
 driver.
Message-ID: <20190204114528.GB28608@kroah.com>
References: <1548935553-452-1-git-send-email-pawell@cadence.com>
 <1548935553-452-3-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548935553-452-3-git-send-email-pawell@cadence.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 11:52:29AM +0000, Pawel Laszczak wrote:
> Patch moves some decoding functions from driver/usb/dwc3/debug.h driver
> to driver/usb/common/debug.c file. These moved functions include:
>     dwc3_decode_get_status
>     dwc3_decode_set_clear_feature
>     dwc3_decode_set_address
>     dwc3_decode_get_set_descriptor
>     dwc3_decode_get_configuration
>     dwc3_decode_set_configuration
>     dwc3_decode_get_intf
>     dwc3_decode_set_intf
>     dwc3_decode_synch_frame
>     dwc3_decode_set_sel
>     dwc3_decode_set_isoch_delay
>     dwc3_decode_ctrl
> 
> These functions are used also in inroduced cdns3 driver.

/me hands Pawel a spell checker for the changelogs...
