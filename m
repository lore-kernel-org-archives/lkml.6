Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C231C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF6F22082A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:46:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF6F22082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbeJBS3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 14:29:25 -0400
Received: from foss.arm.com ([217.140.101.70]:35514 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727528AbeJBS3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 14:29:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B4007A9;
        Tue,  2 Oct 2018 04:46:31 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D12E83F5B7;
        Tue,  2 Oct 2018 04:46:29 -0700 (PDT)
Date:   Tue, 2 Oct 2018 12:46:27 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Hoan Tran <hoan.tran@amperecomputing.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Tai Nguyen <ttnguyen@amperecomputing.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Open Source Submission <patches@amperecomputing.com>
Subject: Re: [PATCH v2] perf: xgene: Add CPU hotplug support
Message-ID: <20181002114627.omsungd77lfmbqfj@lakrids.cambridge.arm.com>
References: <1537382649-17266-1-git-send-email-hoan.tran@amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537382649-17266-1-git-send-email-hoan.tran@amperecomputing.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hoan,

On Wed, Sep 19, 2018 at 06:44:30PM +0000, Hoan Tran wrote:
> This patch adds CPU hotplug support where the PMU migrates the context to
> another online CPU when its CPU is offline.
> 
> It fixes the below issue where the user does offline the CPU which is assigned
> to this PMU.
> 
> Assuming, CPU0 is assigned for this PMU. When the user does offline CPU0
> [root@(none) ~]# echo 0 > /sys/devices/system/cpu/cpu0/online
> This PMU does not work anymore and shows the below error.
> [root@(none) ~]# perf stat -a -e l3c0/cycle-count/,l3c0/write/ sleep 1
> Error:
> The sys_perf_event_open() syscall returned with 19 (No such device) for event (l3c0/cycle-count/).
> /bin/dmesg may provide additional information.
> No CONFIG_PERF_EVENTS=y kernel support configured?
> 
> With this patch, when CPU0 is offline, PMU migrates to another online CPU and
> works on that CPU.
> 
> Signed-off-by: Hoan Tran <hoan.tran@amperecomputing.com>
> ---
> v2:
>  * Remove the cpuhp instance when unregistering the PMU

Unfortunately, this has come through whitespae-damaged, with a
disclaimer in the footer.

Could you please resend with those two details fixed?

Thanks,
Mark.
