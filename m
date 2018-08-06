Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1A0C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 05:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F83C219CB
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 05:07:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F83C219CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbeHFHPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 03:15:00 -0400
Received: from smtprelay0152.hostedemail.com ([216.40.44.152]:42818 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726449AbeHFHPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 03:15:00 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id BAEE018029586;
        Mon,  6 Aug 2018 05:07:40 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: steel19_8b4d93b74f25
X-Filterd-Recvd-Size: 1600
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Mon,  6 Aug 2018 05:07:39 +0000 (UTC)
Message-ID: <c99001394ca5cb13fefc56d5b854be1f4c7e0624.camel@perches.com>
Subject: Re: [RFC PATCH 1/2] checkpatch: Correctly detect git commit
 references that span 3 lines
From:   Joe Perches <joe@perches.com>
To:     Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        linux-kernel@vger.kernel.org, apw@canonical.com
Cc:     fbarrat@linux.vnet.ibm.com
Date:   Sun, 05 Aug 2018 22:07:38 -0700
In-Reply-To: <20180806035809.24752-1-andrew.donnellan@au1.ibm.com>
References: <20180806035809.24752-1-andrew.donnellan@au1.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-08-06 at 13:58 +1000, Andrew Donnellan wrote:
> If a patch contains a commit reference that happens to span 3 lines, e.g.:
> 
> ===
> With the optimizations for TLB invalidation from commit 0cef77c7798a
> ("powerpc/64s/radix: flush remote CPUs out of single-threaded
> mm_cpumask"), the scope of a TLBI (global vs. local) can now be
> influenced by the value of the 'copros' counter of the memory context.
> ===
> 
> checkpatch will return a GIT_COMMIT_ID error even though the reference
> actually follows the correct format.

The multiple line block code can be difficult to read.

My suggestion is to instead write a subroutine to get the
commit description and compare that against the returned
git commit description.

