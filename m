Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F4FC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 22:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D3A120866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 22:09:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D3A120866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbeIKDFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 23:05:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45530 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbeIKDFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 23:05:13 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CD47DD25;
        Mon, 10 Sep 2018 22:09:04 +0000 (UTC)
Date:   Mon, 10 Sep 2018 15:09:03 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Eugene Syromiatnikov <esyr@redhat.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        stable <stable@vger.kernel.org>
Subject: Re: [PATCH resend] uapi/linux/keyctl.h: don't use C++ reserved
 keyword as a struct member name
Message-Id: <20180910150903.249031442dd7fe43e01812cf@linux-foundation.org>
In-Reply-To: <20180909220018.GH13219@asgard.redhat.com>
References: <0db6c314-1ef4-9bfa-1baa-7214dd2ee061@infradead.org>
        <20180909220018.GH13219@asgard.redhat.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Sep 2018 00:00:18 +0200 Eugene Syromiatnikov <esyr@redhat.com> wrote:

> On Tue, Aug 28, 2018 at 04:34:04PM -0700, Randy Dunlap wrote:
> > From: Randy Dunlap <rdunlap@infradead.org>
> > 
> > Since this header is in "include/uapi/linux/", apparently people
> > want to use it in userspace programs -- even in C++ ones.
> > However, the header uses a C++ reserved keyword ("private"),
> > so change that to "dh_private" instead to allow the header file
> > to be used in C++ userspace.
> 
> This change breaks all existing C programs that rely on <linux/keyctl.h>
> uapi header in order to get struct keyctl_dh_params definition, however.

Are there such programs?  Do they reference the `private' field?
