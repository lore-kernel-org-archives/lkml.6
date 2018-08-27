Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F04BC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 07:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01001208DA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 07:50:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01001208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbeH0Lf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 07:35:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40152 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727049AbeH0Lf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 07:35:59 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0B6498011059;
        Mon, 27 Aug 2018 07:50:29 +0000 (UTC)
Received: from localhost (unknown [10.43.134.11])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C53F02166B41;
        Mon, 27 Aug 2018 07:50:23 +0000 (UTC)
Date:   Mon, 27 Aug 2018 09:50:20 +0200
From:   Miroslav Lichvar <mlichvar@redhat.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     linux-audit@redhat.com, Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH ghak10 v5 1/2] audit: Add functions to log time
 adjustments
Message-ID: <20180827075020.GL27091@localhost>
References: <20180824120001.20771-1-omosnace@redhat.com>
 <20180824120001.20771-2-omosnace@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180824120001.20771-2-omosnace@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 27 Aug 2018 07:50:29 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 27 Aug 2018 07:50:29 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mlichvar@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 02:00:00PM +0200, Ondrej Mosnacek wrote:
> This patch adds two auxiliary record types that will be used to annotate
> the adjtimex SYSCALL records with the NTP/timekeeping values that have
> been changed.

It seems the "adjust" function intentionally logs also calls/modes
that don't actually change anything. Can you please explain it a bit
in the message?

NTP/PTP daemons typically don't read the adjtimex values in a normal
operation and overwrite them on each update, even if they don't
change. If the audit function checked that oldval != newval, the
number of messages would be reduced and it might be easier to follow.

-- 
Miroslav Lichvar
