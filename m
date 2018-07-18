Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693BBECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 04:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE3D22075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 04:28:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE3D22075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbeGRFEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 01:04:33 -0400
Received: from namei.org ([65.99.196.166]:39506 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbeGRFEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 01:04:32 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id w6I4SR1c020679;
        Wed, 18 Jul 2018 04:28:27 GMT
Date:   Wed, 18 Jul 2018 14:28:27 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Arnd Bergmann <arnd@arndb.de>
cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        David Howells <dhowells@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] security: export security_kernel_load_data function
In-Reply-To: <20180717202355.2119407-1-arnd@arndb.de>
Message-ID: <alpine.LRH.2.21.1807181428110.20653@namei.org>
References: <20180717202355.2119407-1-arnd@arndb.de>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jul 2018, Arnd Bergmann wrote:

> The firmware_loader can be built as a loadable module, which now
> fails when CONFIG_SECURITY is enabled, because a call to the
> security_kernel_load_data() function got added, and this is
> not exported to modules:
> 
> ERROR: "security_kernel_load_data" [drivers/base/firmware_loader/firmware_class.ko] undefined!
> 
> Add an EXPORT_SYMBOL_GPL() to make it available here.
> 
> Fixes: 6e852651f28e ("firmware: add call to LSM hook before firmware sysfs fallback")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks!

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general


-- 
James Morris
<jmorris@namei.org>

