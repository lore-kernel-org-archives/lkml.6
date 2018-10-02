Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13987C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5D9620652
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:49:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5D9620652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbeJBRcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 13:32:33 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34246 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbeJBRcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 13:32:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B76777A9;
        Tue,  2 Oct 2018 03:49:53 -0700 (PDT)
Received: from e107155-lin (e107155-lin.emea.arm.com [10.4.12.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 55C0B3F5B7;
        Tue,  2 Oct 2018 03:49:52 -0700 (PDT)
Date:   Tue, 2 Oct 2018 11:49:46 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     gregkh@linuxfoundation.org, rjw@rjwysocki.net,
        linux-acpi@vger.kernel.org, jeremy.linton@arm.com,
        linux-kernel@vger.kernel.org, vkilari@codeaurora.org
Subject: Re: [PATCH v3 1/2] drivers: base: cacheinfo: Do not populate sysfs
 for unknown cache types
Message-ID: <20181002104946.GA1086@e107155-lin>
References: <1538103477-15513-1-git-send-email-jhugo@codeaurora.org>
 <1538103477-15513-2-git-send-email-jhugo@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538103477-15513-2-git-send-email-jhugo@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 08:57:56PM -0600, Jeffrey Hugo wrote:
> If a cache has an unknown type because neither the hardware nor the
> firmware told us, an entry in the sysfs tree will be made, but the type
> file will not be present.  lscpu depends on the type file being present
> for every entry, and will error out without printing system information
> if lscpu cannot open the type file.
> 
> Presenting information about a cache without indicating its type is not
> useful, therefore if we hit a cache with an unknown type, stop populating
> sysfs so that userspace has the maximum amount of useful information.
> 
> This addresses the following lscpu error, which prevents any output.
> lscpu: cannot open /sys/devices/system/cpu/cpu0/cache/index3/type: No such
> file or directory
> 
> Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep
