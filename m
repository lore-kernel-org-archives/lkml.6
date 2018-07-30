Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3977FFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5F40205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:42:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5F40205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732031AbeG3SSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 14:18:10 -0400
Received: from ale.deltatee.com ([207.54.116.67]:54966 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729331AbeG3SSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 14:18:10 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1fkBEy-0005mn-3t; Mon, 30 Jul 2018 10:41:48 -0600
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Stephen Bates <sbates@raithlin.com>,
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
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20180730161840.13733-1-logang@deltatee.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <1b911d4b-d8e4-d44d-af1b-8ec1a39983e6@deltatee.com>
Date:   Mon, 30 Jul 2018 10:41:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180730161840.13733-1-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: willy@infradead.org, christian.koenig@amd.com, alex.williamson@redhat.com, benh@kernel.crashing.org, jglisse@redhat.com, dan.j.williams@intel.com, frederic@kernel.org, kai.heng.feng@canonical.com, marc.zyngier@arm.com, paulmck@linux.vnet.ibm.com, tglx@linutronix.de, mingo@kernel.org, corbet@lwn.net, bhelgaas@google.com, hch@lst.de, sbates@raithlin.com, linux-doc@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v8 0/4] Add parameter for disabling ACS redirection for
 P2P
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

Oops, I missed finishing this up before sending it sorry:

This is mostly a resend with Alex's tags collected. Bjorn, can you
please consider merging this? All patches have been reviewed and
accepted by Alex.

Thanks,

Logan

--

Changes since v7:
* Collected Alex's Reviewed-by Tags
* Rebased onto v4.18-rc7 (no conflicts)


On 30/07/18 10:18 AM, Logan Gunthorpe wrote:
> Changes since v6:
> * Fixed order of operations for device specific disable function as
>   noticed by Alex
> * Rebased onto v4.18-rc5 (no conflicts)
> 
> Changes since v5:
> * Add a quirk to handle the Intel SPT PCH case (as pointed out by Alex)
> * Warn in the case that we try to disable ACS redirect on a device
>   that doesn't have the ACS capability (also suggested by Alex)
> * Collect reviewed-by tag from Alex
> * Rebased onto v4.18-rc4 (no conflicts)
> 
> Changes since v4:
> * Fixed a couple documentation mistakes spotted by Randy
> 
> Changes since v3:
> * Removed some of the cruft that was copied from the resource_alignment
>   paramater (per Alex)
> * A number of docuemntation fixes as noticed by Alex and Willy
> 
> Changes since v2:
> * Rebased onto v4.18-rc1 (no conflicts)
> * Minor tweaks to the documentation per Andy
> * Removed the "path:" prefix and use the path parsing code
>   for simple devices (as it works the same). Per a suggestion from Alex
> 
> Changes since v1:
> * Reworked pci_dev_str_match_path using strrchr as suggested by Alex
> * Collected Christian's Acks
> 
> 
> Logan Gunthorpe (4):
>   PCI: Make specifying PCI devices in kernel parameters reusable
>   PCI: Allow specifying devices using a base bus and path of devfns
>   PCI: Introduce disable_acs_redir quirk
>   PCI: Introduce the disable_acs_redir parameter
> 
>  Documentation/admin-guide/kernel-parameters.txt |  41 +++-
>  drivers/pci/pci.c                               | 310 +++++++++++++++++++-----
>  drivers/pci/quirks.c                            |  78 +++++-
>  include/linux/pci.h                             |   5 +
>  4 files changed, 361 insertions(+), 73 deletions(-)
> 
> --
> 2.11.0
> 
