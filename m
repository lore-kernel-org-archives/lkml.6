Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94689C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 20:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E9D20844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 20:03:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41E9D20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbeIHAqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 20:46:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39450 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbeIHAqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 20:46:12 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CF7BCD09;
        Fri,  7 Sep 2018 20:03:41 +0000 (UTC)
Date:   Fri, 7 Sep 2018 22:03:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        David Airlie <airlied@linux.ie>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 4.4 31/43] mm: fix cache mode tracking in
 vm_insert_mixed()
Message-ID: <20180907200338.GB25756@kroah.com>
References: <20180814171517.014285600@linuxfoundation.org>
 <20180814171519.142204859@linuxfoundation.org>
 <1536339923.3024.112.camel@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1536339923.3024.112.camel@codethink.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 06:05:23PM +0100, Ben Hutchings wrote:
> On Tue, 2018-08-14 at 19:18 +0200, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Dan Williams <dan.j.williams@intel.com>
> > 
> > commit 87744ab3832b83ba71b931f86f9cfdb000d07da5 upstream
> > 
> > vm_insert_mixed() unlike vm_insert_pfn_prot() and vmf_insert_pfn_pmd(),
> > fails to check the pgprot_t it uses for the mapping against the one
> > recorded in the memtype tracking tree.  Add the missing call to
> > track_pfn_insert() to preclude cases where incompatible aliased mappings
> > are established for a given physical address range.
> [...]
> 
> This apparently breaks a number of DRM drivers.  The upstream fixes
> are:
> 
> 8ef4227615e1 x86/io: add interface to reserve io memtype for a resource range. (v1.1)
> 7cf321d118a8 drm/drivers: add support for using the arch wc mapping API.
> 
> They appear to apply cleanly to 4.4-stable.  They are included in 4.9
> so no other stable branch needs them.

Thanks, now queued up.

greg k-h
