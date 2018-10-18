Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A80C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23CD820658
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:22:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23CD820658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbeJSCY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:24:26 -0400
Received: from ms.lwn.net ([45.79.88.28]:44936 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726424AbeJSCY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:24:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id CFD2597E;
        Thu, 18 Oct 2018 18:22:07 +0000 (UTC)
Date:   Thu, 18 Oct 2018 12:21:55 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH] kernel-doc: fix declaration type determination
Message-ID: <20181018122155.4fe8dc01@lwn.net>
In-Reply-To: <640b26f4-a6fa-ffbc-c866-ea03de4f79a5@infradead.org>
References: <640b26f4-a6fa-ffbc-c866-ea03de4f79a5@infradead.org>
Organization: LWN.net
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Oct 2018 21:07:27 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Make declaration type determination more robust.
> 
> When scripts/kernel-doc is deciding if some kernel-doc notation
> contains an enum, a struct, a union, a typedef, or a function,
> it does a pattern match on the beginning of the string, looking
> for a match with one of "struct", "union", "enum", or "typedef",
> and otherwise defaults to a function declaration type.
> However, if a function or a function-like macro has a name that
> begins with "struct" (e.g., struct_size()), then kernel-doc
> incorrectly decides that this is a struct declaration.
> 
> Fix this by looking for the declaration type keywords having an
> ending word boundary (\b), so that "struct_size" will not match
> a struct declaration.
> 
> I compared lots of html before/after output from core-api, driver-api,
> and networking.  There were no differences in any of the files that
> I checked.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Applied, thanks.

jon
