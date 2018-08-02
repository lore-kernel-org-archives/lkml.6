Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B87C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CF87214F1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:27:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CF87214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732119AbeHBNSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 09:18:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:58284 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728767AbeHBNSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 09:18:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3FD2EAD1B;
        Thu,  2 Aug 2018 11:27:34 +0000 (UTC)
Date:   Thu, 2 Aug 2018 13:27:33 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] HID: intel-ish-hid: Prevent loading of driver on
 Mehlow
In-Reply-To: <20180718193200.17944-1-srinivas.pandruvada@linux.intel.com>
Message-ID: <nycvar.YFH.7.76.1808021327240.25787@cbobk.fhfr.pm>
References: <20180718193200.17944-1-srinivas.pandruvada@linux.intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jul 2018, Srinivas Pandruvada wrote:

> On Mehlow Xeon-E workstation, ISH PCI device is enabled but without ISH
> firmware. Here the ISH device PCI device id was reused for some non Linux
> storage drivers. So this was not done for enabling ISH. But this has a
> undesirable side effect for Linux.
> 
> Here the ISH driver will be loaded via PCI enumeration and will try to do
> reset sequence. But reset sequence will wait till timeout as there is no
> real ISH firmware is present to take action. This delay will add to boot
> time of Linux (This platform will still continue to boot after this
> timeout).
> 
> To avoid this boot delay we need to prevent loading of ISH drivers on
> this platform. So we need to have hack to avoid treating this device as
> ISH on this platform. To identify this workstation, we need some runtime
> method. Luckily there are special PCI id on this workstation to
> distinguish from the client version of this platform. On client version,
> the ISH is supported using same PCI device id. So this change look for
> the presence of PCI device IDs A309 and A30A and exit.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> v2
>  Replaced pci_get_device with pci_dev_present to check in a loop as
> suggested by Benjamin.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

