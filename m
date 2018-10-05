Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD95C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 09:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 538F920652
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 09:48:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 538F920652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbeJEQqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 12:46:37 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:46271 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbeJEQqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 12:46:37 -0400
Received: from 79.184.253.194.ipv4.supernova.orange.pl (79.184.253.194) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.148)
 id 5e597fb7a2fcd3f3; Fri, 5 Oct 2018 11:48:36 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     sudeep.holla@arm.com, gregkh@linuxfoundation.org,
        linux-acpi@vger.kernel.org, jeremy.linton@arm.com,
        linux-kernel@vger.kernel.org, vkilari@codeaurora.org
Subject: Re: [PATCH v4 0/2] PPTT handle Handle architecturally unknown cache types
Date:   Fri, 05 Oct 2018 11:45:34 +0200
Message-ID: <2264331.PzHIdRIQff@aspire.rjw.lan>
In-Reply-To: <1538666406-7504-1-git-send-email-jhugo@codeaurora.org>
References: <1538666406-7504-1-git-send-email-jhugo@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, October 4, 2018 5:20:04 PM CEST Jeffrey Hugo wrote:
> The ARM Architecture Reference Manual allows for caches to be "invisible" and
> thus not specified in the system registers under some scenarios such as if the
> cache cannot be managed by set/way operations.
> 
> However, such caches may be specified in the ACPI PPTT table for workload
> performance/scheduling optimizations.
> 
> Currently such caches can cause an error in lscpu -
> 
> lscpu: cannot open /sys/devices/system/cpu/cpu0/cache/index3/type: No such
> file or directory
> 
> and result in no output, providing a poor user experience.  lstopo is also
> affected as such caches are not included in the output.
> 
> Address these issues by attempting to be a little more discerning about when
> cache information is provided to userspace, and also utilize all sources for
> cache information when possible.
> 
> [v4]
> -Collected all current tags and ammended to individual patches
> -Removed PPTT_CHECKED_ATTRIBUTES
> 
> [v3]
> -removed valid flag in PPTT
> -Added Jeremy Linton's reviewed-by
> 
> [v2]
> -Updated cacheinfo per Sudeep's suggestion
> -Integrated the PPTT fix into existing PPTT code per Sudeep's suggestion
> 
> Jeffrey Hugo (2):
>   drivers: base: cacheinfo: Do not populate sysfs for unknown cache
>     types
>   ACPI/PPTT: Handle architecturally unknown cache types
> 
>  drivers/acpi/pptt.c      | 15 +++++++++++----
>  drivers/base/cacheinfo.c |  2 ++
>  2 files changed, 13 insertions(+), 4 deletions(-)
> 
> 

Both patches applied, thanks!


