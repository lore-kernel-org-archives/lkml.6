Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E69EC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A9E20882
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:53:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32A9E20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388516AbeGXM71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 08:59:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60722 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388272AbeGXM70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 08:59:26 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A964CC9D;
        Tue, 24 Jul 2018 11:53:19 +0000 (UTC)
Date:   Tue, 24 Jul 2018 13:53:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Aastha Gupta <aastha.gupta4104@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] staging: rtl8188eu/rtl8723bs: fix character encoding
Message-ID: <20180724115317.GA5928@kroah.com>
References: <20180724111600.4158975-1-arnd@arndb.de>
 <20180724111600.4158975-4-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724111600.4158975-4-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 01:13:28PM +0200, Arnd Bergmann wrote:
> drivers/staging/rtl8188eu/include/odm.h uses an incorrect encoding
> for the '...' character in two comments, which makes it one of the
> few non-UTF-8 source files.
> 
> This removes the odd characters and uses the same ASCII representation
> that we have in the regular rtlwifi driver. The second instance
> of drivers/staging/rtl8723bs/hal/odm.h is garbled in a different way,
> so I change it to be the same as well even though it is already
> plain ASCII.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

git does not like this patch:
	error: cannot convert from Binary to UTF-8
	fatal: could not parse patch
Let me see if I can force it by hand...

