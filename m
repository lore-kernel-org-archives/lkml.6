Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC94C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FD0420882
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:10:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FD0420882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbeGYIUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 04:20:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42608 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727460AbeGYIUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 04:20:30 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A36F64075764;
        Wed, 25 Jul 2018 07:10:10 +0000 (UTC)
Received: from localhost (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CB528111DCE6;
        Wed, 25 Jul 2018 07:10:09 +0000 (UTC)
Date:   Wed, 25 Jul 2018 15:10:06 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, mingo@redhat.com, keescook@chromium.org,
        yasu.isimatu@gmail.com, indou.takao@jp.fujitsu.com,
        caoj.fnst@cn.fujitsu.com, douly.fnst@cn.fujitsu.com
Subject: Re: [PATCH v4 1/4] x86/boot: Add acpitb.h to help parse acpi tables
Message-ID: <20180725071006.GJ6480@MiWiFi-R3L-srv>
References: <20180723092908.32656-1-fanc.fnst@cn.fujitsu.com>
 <20180723092908.32656-2-fanc.fnst@cn.fujitsu.com>
 <20180724060257.GE6480@MiWiFi-R3L-srv>
 <20180724083657.GB818@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724083657.GB818@localhost.localdomain>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 25 Jul 2018 07:10:10 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 25 Jul 2018 07:10:10 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/24/18 at 04:36pm, Chao Fan wrote:
> On Tue, Jul 24, 2018 at 02:02:57PM +0800, Baoquan He wrote:
> >Hi chao,
> >
> >On 07/23/18 at 05:29pm, Chao Fan wrote:
> >> In order to parse ACPI tables, reuse the head file linux/acpi.h,
> >> so that the files in 'compressed' directory can read ACPI table
> >> by including this head file.
> >> 
> >> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
> >> ---
> >>  arch/x86/boot/compressed/acpitb.h | 7 +++++++
> >>  1 file changed, 7 insertions(+)
> >>  create mode 100644 arch/x86/boot/compressed/acpitb.h
> >> 
> >> diff --git a/arch/x86/boot/compressed/acpitb.h b/arch/x86/boot/compressed/acpitb.h
> >> new file mode 100644
> >> index 000000000000..f8ab6e5b3e06
> >> --- /dev/null
> >> +++ b/arch/x86/boot/compressed/acpitb.h
> >> @@ -0,0 +1,7 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 */
> >> +#include <linux/acpi.h>
> >> +
> >> +#define ACPI_MAX_TABLES                128
> >> +
> >> +/* Function to get ACPI SRAT table pointer. */
> >> +struct acpi_table_header *get_acpi_srat_table(void);
> >
> >Since acpitb.h includes so few lines of code, not sure if we can move
> >them into .c files directly.
> >
> >By the way, you might need to rebase this patchset on top of
> >tip/x86/boot.
> 
> Sorry Baoquan,
> 
> I tried to add this patcheset to the tip/x86/boot branch using both 'patch'
> command and 'git am'. I found no problem and no offset.
> So is there some problems when you use them?

That's great, just to remind.

