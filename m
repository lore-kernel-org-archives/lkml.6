Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACEE9C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8473820881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbfA1RpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:45:07 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:53154 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbfA1RpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 12:45:05 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A9E832441;
        Mon, 28 Jan 2019 17:45:04 +0000 (UTC)
Date:   Mon, 28 Jan 2019 09:45:03 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        Brian Behlendorf <behlendorf1@llnl.gov>,
        Siarhei Volkau <lis8215@gmail.com>
Subject: Re: [PATCH] lib/div64: off by one in shift
Message-Id: <20190128094503.19e9f2ae0b286f7b1f743d70@linux-foundation.org>
In-Reply-To: <1548686944-11891-1-git-send-email-sgruszka@redhat.com>
References: <1548686944-11891-1-git-send-email-sgruszka@redhat.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jan 2019 15:49:04 +0100 Stanislaw Gruszka <sgruszka@redhat.com> wrote:

> fls counts bits starting from 1 to 32 (returns 0 for zero argument).
> If we add 1 we shift right one bit more and loose precision from
> divisor, what cause function incorect results with some numbers.
> 
> Corrected code was tested in user-space, see bugzilla:
> https://bugzilla.kernel.org/show_bug.cgi?id=202391

What are the usersoace-visible runtime effects of this change?

Thanks.
