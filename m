Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBF8C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E2F1216F2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:21:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E2F1216F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbeHHLj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 07:39:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52028 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbeHHLj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 07:39:59 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 493EECB5;
        Wed,  8 Aug 2018 09:21:09 +0000 (UTC)
Date:   Wed, 8 Aug 2018 11:20:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Todd Poynor <toddpoynor@gmail.com>
Cc:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>, devel@driverdev.osuosl.org,
        Todd Poynor <toddpoynor@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/15] staging: gasket: unwrap pci core and more
Message-ID: <20180808092032.GA32636@kroah.com>
References: <20180805200749.116693-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180805200749.116693-1-toddpoynor@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 05, 2018 at 01:07:34PM -0700, Todd Poynor wrote:
> From: Todd Poynor <toddpoynor@google.com>
> 
> Stop wrapping PCI core calls like probe, enable, remove, etc. in the
> gasket framework, move these calls to the device driver instead.  Have
> gasket drivers call into framework on init, enable, disable,
> etc. sequences, rather than the other way around.  Remove the
> gasket-to-device callbacks associated with these sequences.
> 
> Plus a few other fixes and cleanups.
> 
> Todd Poynor (15):
>   staging: gasket: sysfs: clean up state if ENOMEM removing mapping
>   staging: gasket: core: move core PCI calls to device drivers
>   staging: gasket: apex: move PCI core calls to apex driver
>   staging: gasket: core: convert remaining info logs to debug
>   staging: gasket: core: remove device enable and disable callbacks
>   staging: gasket: apex: remove device enable and disable callbacks
>   staging: gasket: core: let device driver enable/disable gasket device
>   staging: gasket: apex: enable/disable gasket device from apex
>   staging: gasket: core: delete device add and remove callbacks
>   staging: gasket: apex: fold device add/remove logic inline
>   staging: gasket: core: remove sysfs setup and cleanup callbacks
>   staging: gasket: apex: move sysfs setup code to probe function
>   staging: gasket: core: protect against races during unregister
>   staging: gasket: apex: place in low power reset until opened
>   staging: gasket: core: remove incorrect extraneous comment
> 
>  drivers/staging/gasket/apex_driver.c  | 145 +++++++++++++++++---------
>  drivers/staging/gasket/gasket_core.c  | 140 ++++++-------------------
>  drivers/staging/gasket/gasket_core.h  |  82 +++------------
>  drivers/staging/gasket/gasket_sysfs.c |  13 ++-
>  4 files changed, 148 insertions(+), 232 deletions(-)

Nice cleanups!
