Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6CFC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 20:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE88223C8
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 20:43:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EE88223C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbeKNGm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 01:42:58 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:41304 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725748AbeKNGm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 01:42:58 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3F3367F6;
        Tue, 13 Nov 2018 20:43:06 +0000 (UTC)
Date:   Tue, 13 Nov 2018 12:43:05 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Ben Woodard <woodard@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] exec: increase BINPRM_BUF_SIZE to 256
Message-Id: <20181113124305.73b8ac9e5a2ef9b18d3444b2@linux-foundation.org>
In-Reply-To: <20181113165557.GG30990@redhat.com>
References: <20181112160931.GA28463@redhat.com>
        <20181112160956.GA28472@redhat.com>
        <20181112155248.4dde2613979f4c176565629e@linux-foundation.org>
        <20181113165557.GG30990@redhat.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Nov 2018 17:55:58 +0100 Oleg Nesterov <oleg@redhat.com> wrote:

> > However it would be basically cost-free to increase
> > BINPRM_BUF_SIZE up to the point where sizeof(struct linux_binprm) ==
> > PAGE_SIZE?
> 
> I don't think we should take sizeof(struct linux_binprm) into account, the
> new members can come at any time and we can never decrease BINPRM_BUF_SIZE.

My main point is..  why not make BINPRM_BUF_SIZE a lot larger than 256?
