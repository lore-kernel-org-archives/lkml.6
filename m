Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B85FC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 10:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E0242064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 10:31:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E0242064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lxorguk.ukuu.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbeJOSQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 14:16:02 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:60354 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbeJOSQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 14:16:02 -0400
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id w9FAV47D013626;
        Mon, 15 Oct 2018 11:31:04 +0100
Date:   Mon, 15 Oct 2018 11:31:03 +0100
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] platform/x86: Add Intel AtomISP2 dummy /
 power-management driver
Message-ID: <20181015113103.27dc106c@alans-desktop>
In-Reply-To: <20181014175427.22139-1-hdegoede@redhat.com>
References: <20181014175427.22139-1-hdegoede@redhat.com>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Oct 2018 19:54:27 +0200
Hans de Goede <hdegoede@redhat.com> wrote:

> The Image Signal Processor found on Cherry Trail devices is brought up in
> D0 state on devices which have camera sensors attached to it. The ISP will
> not enter D3 state again without some massaging of its registers beforehand
> and the ISP not being in D3 state blocks the SoC from entering S0ix modes.
> 
> There was a driver for the ISP in drivers/staging but that got removed
> again because it never worked. It does not seem likely that a real
> driver for the ISP will be added to the mainline kernel anytime soon.
> 
> This commit adds a dummy driver which contains the necessary magic from
> the staging driver to powerdown the ISP, so that Cherry Trail devices where
> the ISP is used will properly use S0ix modes when suspended.
> 
> Together with other recent S0ix related fixes this allows S0ix modes to
> be entered on e.g. a Chuwi Hi8 Pro and a HP x2 210.
> 
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=196915
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Reviewed-by: Alan Cox <alan@linux.intel.com>

Thanks
