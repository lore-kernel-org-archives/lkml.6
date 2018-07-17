Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836A8ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43DCA206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:48:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43DCA206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730614AbeGQSWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 14:22:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48064 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729737AbeGQSWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 14:22:33 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E030415553;
        Tue, 17 Jul 2018 17:48:49 +0000 (UTC)
Received: from t450s.home (ovpn-116-29.phx2.redhat.com [10.3.116.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9412819483;
        Tue, 17 Jul 2018 17:48:47 +0000 (UTC)
Date:   Tue, 17 Jul 2018 11:48:47 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v7 3/4] PCI: Introduce disable_acs_redir quirk
Message-ID: <20180717114847.5c407c59@t450s.home>
In-Reply-To: <20180717170204.30470-4-logang@deltatee.com>
References: <20180717170204.30470-1-logang@deltatee.com>
        <20180717170204.30470-4-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 17 Jul 2018 17:48:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jul 2018 11:02:03 -0600
Logan Gunthorpe <logang@deltatee.com> wrote:

> Intel SPT PCH hardware has an implementation of the ACS bits that
> does not comply with the PCI express standard. To deal with this
> the existing code has an enable_acs() quirk for the hardware.
> 
> In order to be able to correctly disable the ACS redirect bits for
> all hardware we need an analagous quirk to disable those bits.
> 
> This adds the function pci_dev_specific_disable_acs_redir() which
> behaves similarly to pci_dev_specific_enable_acs() but uses a new
> function pointer for quirks which disables the ACS redirect bits.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/pci/quirks.c | 78 ++++++++++++++++++++++++++++++++++++++++++++--------
>  include/linux/pci.h  |  5 ++++
>  2 files changed, 71 insertions(+), 12 deletions(-)

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
