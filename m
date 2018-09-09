Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C944C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 02:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D502206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 02:45:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D502206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbeIJHhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 03:37:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37334 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725960AbeIJHhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 03:37:09 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3F3C840201BC;
        Sun,  9 Sep 2018 21:59:43 +0000 (UTC)
Received: from asgard.redhat.com (ovpn-200-27.brq.redhat.com [10.40.200.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 95AA2111AF2A;
        Sun,  9 Sep 2018 21:59:40 +0000 (UTC)
Date:   Mon, 10 Sep 2018 00:00:18 +0200
From:   Eugene Syromiatnikov <esyr@redhat.com>
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
Message-ID: <20180909220018.GH13219@asgard.redhat.com>
References: <0db6c314-1ef4-9bfa-1baa-7214dd2ee061@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0db6c314-1ef4-9bfa-1baa-7214dd2ee061@infradead.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Sun, 09 Sep 2018 21:59:43 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Sun, 09 Sep 2018 21:59:43 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'esyr@redhat.com' RCPT:''
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

This change breaks all existing C programs that rely on <linux/keyctl.h>
uapi header in order to get struct keyctl_dh_params definition, however.

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

>  	__s32 prime;
>  	__s32 base;
>  };
> --- lnx-416.orig/security/keys/dh.c
> +++ lnx-416/security/keys/dh.c
> @@ -307,7 +307,7 @@ long __keyctl_dh_compute(struct keyctl_d
>  	}
>  	dh_inputs.g_size = dlen;
>  
> -	dlen = dh_data_from_key(pcopy.private, &dh_inputs.key);
> +	dlen = dh_data_from_key(pcopy.dh_private, &dh_inputs.key);
>  	if (dlen < 0) {
>  		ret = dlen;
>  		goto out2;
> 
> 
