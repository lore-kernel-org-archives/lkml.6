Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25400C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E65AF20673
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:45:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E65AF20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387881AbeK3BvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:51:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:54870 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729915AbeK3BvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:51:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B5A02AFEE;
        Thu, 29 Nov 2018 14:45:28 +0000 (UTC)
Message-ID: <1543502726.10991.13.camel@suse.de>
Subject: Re: [PATCH 4.14 044/100] ACPICA: AML interpreter: add region
 addresses in global list during initialization
From:   Jean Delvare <jdelvare@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, Jean-Marc Lenoir <archlinux@jihemel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Date:   Thu, 29 Nov 2018 15:45:26 +0100
In-Reply-To: <20181129140102.870510957@linuxfoundation.org>
References: <20181129140058.768942700@linuxfoundation.org>
         <20181129140102.870510957@linuxfoundation.org>
Organization: Suse Linux
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Thu, 2018-11-29 at 15:12 +0100, Greg Kroah-Hartman wrote:
> 4.14-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Erik Schmauss <erik.schmauss@intel.com>
> 
> commit 4abb951b73ff0a8a979113ef185651aa3c8da19b upstream.
> 
> The table load process omitted adding the operation region address
> range to the global list. This omission is problematic because the OS
> queries the global list to check for address range conflicts before
> deciding which drivers to load. This commit may result in warning
> messages that look like the following:
> 
> [    7.871761] ACPI Warning: system_IO range 0x00000428-0x0000042F conflicts with op_region 0x00000400-0x0000047F (\PMIO) (20180531/utaddress-213)
> [    7.871769] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
> 
> However, these messages do not signify regressions. It is a result of
> properly adding address ranges within the global address list.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=200011
> Tested-by: Jean-Marc Lenoir <archlinux@jihemel.com>
> Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
> Cc: All applicable <stable@vger.kernel.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Jean Delvare <jdelvare@suse.de>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

I'm confused. While we were discussing the regression, Erik said that
this is fixing commit 5a8361f7ecceaed64b4064000d16cb703462be49, which
went upstream in v4.17. So how can the fix be needed in any kernel
older than v4.17? Erik, did I understand you incorrectly?

-- 
Jean Delvare
SUSE L3 Support
