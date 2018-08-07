Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59445C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 19:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 181862172B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 19:44:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 181862172B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390586AbeHGWAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 18:00:47 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:49524 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390006AbeHGWAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 18:00:46 -0400
Received: from localhost (71-36-117-41.ptld.qwest.net [71.36.117.41])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 69B1B10864B62;
        Tue,  7 Aug 2018 12:44:49 -0700 (PDT)
Date:   Tue, 07 Aug 2018 12:44:48 -0700 (PDT)
Message-Id: <20180807.124448.1502585319140215353.davem@davemloft.net>
To:     mr.nuke.me@gmail.com
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        jakub.kicinski@netronome.com, keith.busch@intel.com,
        alex_gagniuc@dellteam.com, austin_bolen@dell.com,
        shyam_iyer@dell.com, ariel.elior@cavium.com,
        everest-linux-l2@cavium.com, michael.chan@broadcom.com,
        ganeshgr@chelsio.com, jeffrey.t.kirsher@intel.com,
        tariqt@mellanox.com, saeedm@mellanox.com, leon@kernel.org,
        dirk.vandermerwe@netronome.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        linux-rdma@vger.kernel.org, oss-drivers@netronome.com
Subject: Re: [PATCH v6 1/9] PCI: Check for PCIe downtraining conditions
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180806232600.25694-1-mr.nuke.me@gmail.com>
References: <CAErSpo4PK+SQLNfdkLNt9eLc7bpbxbkZCsa8T-tQpid601n0SQ@mail.gmail.com>
        <20180806232600.25694-1-mr.nuke.me@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 07 Aug 2018 12:44:50 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Date: Mon,  6 Aug 2018 18:25:35 -0500

> PCIe downtraining happens when both the device and PCIe port are
> capable of a larger bus width or higher speed than negotiated.
> Downtraining might be indicative of other problems in the system, and
> identifying this from userspace is neither intuitive, nor
> straightforward.
> 
> The easiest way to detect this is with pcie_print_link_status(),
> since the bottleneck is usually the link that is downtrained. It's not
> a perfect solution, but it works extremely well in most cases.
> 
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>

Feel free to merge this entire series via the PCI tree.

For the series:

Acked-by: David S. Miller <davem@davemloft.net>
