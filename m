Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8C6C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 072E120855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:49:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 072E120855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbeKJDa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 22:30:56 -0500
Received: from mga07.intel.com ([134.134.136.100]:36952 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727995AbeKJDa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 22:30:56 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Nov 2018 09:49:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,484,1534834800"; 
   d="scan'208";a="248456401"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.154])
  by orsmga004.jf.intel.com with ESMTP; 09 Nov 2018 09:49:18 -0800
Date:   Fri, 9 Nov 2018 09:49:18 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Rian Quinn <rianquinn@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: x86_64 INIT/SIPI Bug
Message-ID: <20181109174918.GA3594@linux.intel.com>
References: <CANmpu8XY10CgYsnGn9hVDzGJQyWdwNihpYu3So62KtNwrkwGXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANmpu8XY10CgYsnGn9hVDzGJQyWdwNihpYu3So62KtNwrkwGXw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 03:23:59PM -0700, Rian Quinn wrote:
> I apologize upfront if this is the wrong place to post this, pretty new to this.
> 
> We are working on the Bareflank Hypervisor (www.bareflank.org), and we
> are passing through the INIT/SIPI process (similar to how a VMX
> rootkit from EFI might boot the OS) and we noticed that on Arch Linux,
> the INIT/SIPI process stalls, something we are not seeing on Ubuntu.

I'm confused, INIT is blocked post-VMXON, what are you passing through?
