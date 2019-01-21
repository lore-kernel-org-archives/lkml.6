Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2CDC31681
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE47720989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfAUR20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 12:28:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44866 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbfAUR20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 12:28:26 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 10CAF4E8A8;
        Mon, 21 Jan 2019 17:28:26 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.34.27.18])
        by smtp.corp.redhat.com (Postfix) with SMTP id 36AAD5E1BF;
        Mon, 21 Jan 2019 17:28:24 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 21 Jan 2019 18:28:25 +0100 (CET)
Date:   Mon, 21 Jan 2019 18:28:23 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Elena Reshetova <elena.reshetova@intel.com>
Cc:     mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        keescook@chromium.org, tglx@linutronix.de
Subject: Re: [PATCH 2/5] sched: convert signal_struct.sigcnt to refcount_t
Message-ID: <20190121172822.GB8088@redhat.com>
References: <1547814450-18902-1-git-send-email-elena.reshetova@intel.com>
 <1547814450-18902-3-git-send-email-elena.reshetova@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547814450-18902-3-git-send-email-elena.reshetova@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 21 Jan 2019 17:28:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/18, Elena Reshetova wrote:
>
> For the signal_struct.sigcnt it might make a difference
> in following places:
>  - put_signal_struct(): decrement in refcount_dec_and_test() only
>    provides RELEASE ordering and control dependency on success
>    vs. fully ordered atomic counterpart

this is fine.

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

