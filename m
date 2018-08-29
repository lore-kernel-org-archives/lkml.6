Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9DAC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 02:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A117A20852
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 02:42:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A117A20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbeH2GhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 02:37:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43962 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbeH2GhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 02:37:01 -0400
Received: from localhost (unknown [208.181.116.45])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 20F2CC77;
        Wed, 29 Aug 2018 02:42:27 +0000 (UTC)
Date:   Tue, 28 Aug 2018 19:42:24 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH resend] uapi/linux/keyctl.h: don't use C++ reserved
 keyword as a struct member name
Message-ID: <20180829024224.GA6083@kroah.com>
References: <0db6c314-1ef4-9bfa-1baa-7214dd2ee061@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0db6c314-1ef4-9bfa-1baa-7214dd2ee061@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 04:34:04PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Since this header is in "include/uapi/linux/", apparently people
> want to use it in userspace programs -- even in C++ ones.
> However, the header uses a C++ reserved keyword ("private"),
> so change that to "dh_private" instead to allow the header file
> to be used in C++ userspace.
> 
> Fixes https://bugzilla.kernel.org/show_bug.cgi?id=191051
> Fixes: ddbb41148724 ("KEYS: Add KEYCTL_DH_COMPUTE command")
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: David Howells <dhowells@redhat.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: keyrings@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
> Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
> Cc: stable@vger.kernel.org
> ---
>  include/uapi/linux/keyctl.h |    2 +-
>  security/keys/dh.c          |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> --- lnx-416.orig/include/uapi/linux/keyctl.h
> +++ lnx-416/include/uapi/linux/keyctl.h
> @@ -65,7 +65,7 @@
>  
>  /* keyctl structures */
>  struct keyctl_dh_params {
> -	__s32 private;
> +	__s32 dh_private;

Ick ick ick, why not just put the C "namespace" on all uapi files if you
are including them from c++ code?  I'm sure this isn't the only problem
that has this problem, right?

This is valid C, no need to start worrying about C++ reserved names.

thanks,

greg "'struct class' is your friend" k-h
