Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75869C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 17:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECFFB2086C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 17:49:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECFFB2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lxorguk.ukuu.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390166AbeKQECu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 23:02:50 -0500
Received: from www.llwyncelyn.cymru ([82.70.14.225]:42554 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729140AbeKQECu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 23:02:50 -0500
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id wAGHnCaE003901;
        Fri, 16 Nov 2018 17:49:12 GMT
Date:   Fri, 16 Nov 2018 17:49:11 +0000
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ben Woodard <woodard@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        linux-man@vger.kernel.org
Subject: Re: [PATCH 2/2] exec: increase BINPRM_BUF_SIZE to 256
Message-ID: <20181116174911.6fcff580@alans-desktop>
In-Reply-To: <20181112160956.GA28472@redhat.com>
References: <20181112160931.GA28463@redhat.com>
        <20181112160956.GA28472@redhat.com>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Nov 2018 17:09:56 +0100
Oleg Nesterov <oleg@redhat.com> wrote:

> Large enterprise clients often times run applications out of networked
> file systems where the IT mandated layout of project volumes can end up
> leading to paths that are longer than 128 characters. Bumping this up to
> the next order of two solves this problem in all but the most egregious
> case while still fitting into a 512b slab.

You also need to update the execve manual page as it explicitly documents
the 128 byte limit.

Alan
