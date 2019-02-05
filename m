Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CEA9C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 675CC217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbfBEWVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 17:21:39 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36858 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbfBEWVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 17:21:38 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DBE85A487;
        Tue,  5 Feb 2019 22:21:37 +0000 (UTC)
Date:   Tue, 5 Feb 2019 14:21:36 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     Andy Whitcroft <apw@canonical.com>, Rob Herring <robh@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.org>
Subject: Re: [PATCH] checkpatch: Verify SPDX comment style
Message-Id: <20190205142136.9e7105239919596d0b2b6548@linux-foundation.org>
In-Reply-To: <8b02899853247a2c67669561761f354dd3bd110e.camel@perches.com>
References: <8b02899853247a2c67669561761f354dd3bd110e.camel@perches.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2019 16:05:11 -0800 Joe Perches <joe@perches.com> wrote:

> Using SPDX commenting style // or /* is specified for
> various file types in Documentation/process/license-rules.rst
> so add an appropriate test for .[chsS] files because many
> proposed file additions and patches do not use the correct style.

Dan's
http://lkml.kernel.org/r/154899811738.3165233.12325692939590944259.stgit@dwillia2-desk3.amr.corp.intel.com
is giving me 

WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
#500: FILE: mm/shuffle.h:1:
+// SPDX-License-Identifier: GPL-2.0

and switching it to /* */ doesn't fix.  This happens with or without
this patch applied.  What to do?

