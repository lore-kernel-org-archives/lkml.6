Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECE5C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8712122BC8
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzvo2WWS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8712122BC8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932650AbeGFVyr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 17:54:47 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:46649 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753631AbeGFVyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 17:54:41 -0400
Received: by mail-pf0-f193.google.com with SMTP id l123-v6so9403462pfl.13;
        Fri, 06 Jul 2018 14:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZubZKwa42cdMZZc4gyk5NXOPI4XXCTQ81VX7+8UJ+Uc=;
        b=dzvo2WWS5CWboTtc/G1ojw+V+csP8H5oV79uEL6ei/80FpcpHR7+19lMQb6Bf3jaFH
         8unjQjrSDLygT3ihRr/DTbotH0EucuBfaWMqUaDcOL72NQ9ZLZqULp2Y1YzRrMTqXfLW
         Udh/SDInHirg48YdArpB/MfzzVOwxzzY2FrzpzxNx2XSjUNZfgBSBlK76pGCGTD51LYh
         EKcbaYxG9VnBQ5Zk0UqhW7wmohwsvnp6AnftmZuVeJy2S06Za7DjnxbT0HCYse05FPld
         bBYftFgczJhHONq9VcWkTYWMHUbPUwhQgaDEWh/7eSreKAK21uDUvWNBcwHdJbTGKUub
         ZztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZubZKwa42cdMZZc4gyk5NXOPI4XXCTQ81VX7+8UJ+Uc=;
        b=p3Fq2ImgD8k6nPUbG2XvuYA2RgXu3sko737/MVEvNvBdAj3AtKutHqt2GYMn4AZ+LS
         L+hdPyzktowx6ttMpmu5DG5V83I/5NYiuV006M87fxmFcNFFNRPPdEqljv4pn8PEz8S4
         OwrcacYq85AV6xd39Q+wCYFiYqojp5Rj48XX6VUe+QZDQoBhvbEPUJrwt/sGkWIexlGM
         awieQz8le4vXpQEPXjfPy/Unmj2FRAV1UJOAWAHeMsg1OyishpqKNLioGTU8jpPhWW6p
         ocniqsrqXEh38tFs9fnoFW3qZ5vi8YuoOjVhXRDVGFBr0Xv7kbYfnFatzJbEHtnNlyV1
         YeEg==
X-Gm-Message-State: APt69E3Wj7dvd/eZHmFIw6IK9xVzdMOHwryHJ38cSIU8xsqB2SQ6a/6T
        n1j9Tpml+kS+fDBv6PWc7qY=
X-Google-Smtp-Source: AAOMgpckBBxGO8qT31VH2cZqVniSdxfNRP2VaRXlNm11dfKIZ3VDUl2E+0I+kXDFZTZF+Xo1WvoBqQ==
X-Received: by 2002:a65:40cd:: with SMTP id u13-v6mr10975197pgp.334.1530914080279;
        Fri, 06 Jul 2018 14:54:40 -0700 (PDT)
Received: from gmail.com ([2620:15c:17:3:dc28:5c82:b905:e8a8])
        by smtp.gmail.com with ESMTPSA id d9-v6sm14214804pge.68.2018.07.06.14.54.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 14:54:39 -0700 (PDT)
Date:   Fri, 6 Jul 2018 14:54:37 -0700
From:   Eric Biggers <ebiggers3@gmail.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Larry Woodman <lwoodman@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Wangkai (Kevin C)" <wangkai86@huawei.com>
Subject: Re: [PATCH v6 7/7] fs/dcache: Allow deconfiguration of negative
 dentry code to reduce kernel size
Message-ID: <20180706215437.GA109361@gmail.com>
References: <1530905572-817-1-git-send-email-longman@redhat.com>
 <1530905572-817-8-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530905572-817-8-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.10+35 (c786a508) (2018-06-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 03:32:52PM -0400, Waiman Long wrote:
> The tracking and limit of negative dentries in a filesystem is a useful
> addition. However, for users who want to reduce the kernel size as much
> as possible, this feature will probably be on the chopping block. To
> suit those users, a default-y config option DCACHE_LIMIT_NEG_ENTRY is
> added so that the negative dentry tracking and limiting code can be
> configured out, if necessary.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  fs/Kconfig             | 10 ++++++++++
>  fs/dcache.c            | 33 ++++++++++++++++++++++++++++++++-
>  include/linux/dcache.h |  2 ++
>  kernel/sysctl.c        |  2 ++
>  4 files changed, 46 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/Kconfig b/fs/Kconfig
> index ac474a6..b521941 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -113,6 +113,16 @@ source "fs/autofs/Kconfig"
>  source "fs/fuse/Kconfig"
>  source "fs/overlayfs/Kconfig"
>  
> +#
> +# Track and limit the number of negative dentries allowed in the system.
> +#
> +config DCACHE_LIMIT_NEG_ENTRY
> +	bool "Track & limit negative dcache entries"
> +	default y
> +	help
> +	  This option enables the tracking and limiting of the total
> +	  number of negative dcache entries allowable in the filesystem.
> +

If there's going to be a config option for this, it should be documented
properly.  I.e., why would someone want to turn this on, or turn it off?  What
are the tradeoffs?  If unsure, should the user say y or n?

I think there are way too many config options that were meaningful to the person
writing the code but aren't meaningful to people configuring the kernel.

- Eric
