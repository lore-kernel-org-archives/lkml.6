Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCCDC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 16:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4F4C2064A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 16:50:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4F4C2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=electrozaur.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbeJBXez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 19:34:55 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43202 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbeJBXez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 19:34:55 -0400
Received: by mail-wr1-f66.google.com with SMTP id n1-v6so3016567wrt.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 09:50:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=hnC/TeBmK/Yl/SPUz/dMPzHbKoi0qdN5wTFk/eNDrcU=;
        b=BI3kjTsWjYjv8FwN0Ld4EAaCdabggL02FvkooRWN5qE8gSWOMHb/Xv7ZQuVr+Fsya0
         e3+kOFbNcQkezyFGxJmasYxuRi8CWFt+kYF5fDw+SU/jmVYf+sjxQ72oaT5hrWtL99W6
         3U9nZWrKLSvAUSeFfIIdIMVOPYQui0v4gWlEmGZOSuZx/2WIQAo1THPAf3Gosx7FQKBH
         T4BcKOpyCfIPYUTgSSGzm5LUwvAM7qY0H/f98kA7A2YMxamGJSzMJT6c1EpZhzutUnm6
         TminuTL+IBQzMw0YrqdrrXxnj7b48J2EMfkQT868EkVgZOxNOAmAuiS94LdQVm0bz0Dp
         IBig==
X-Gm-Message-State: ABuFfohOorU044W/vCtdVSMqTTSYH0/cirdz8eKCoscwHdCd6Y7qze4W
        bYIEkP46Y5KOLGQqhIJmVtk9WIla
X-Google-Smtp-Source: ACcGV60Zj1QlaaB302cuZVQ43qK5VQ8otCmXUxudMeIWvAb589lhYDFC0A7HgVBElI0iGFY6XS3NzQ==
X-Received: by 2002:adf:e348:: with SMTP id n8-v6mr10708472wrj.158.1538499035844;
        Tue, 02 Oct 2018 09:50:35 -0700 (PDT)
Received: from [10.0.0.5] ([207.232.55.62])
        by smtp.gmail.com with ESMTPSA id j66-v6sm18837409wrj.28.2018.10.02.09.50.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 09:50:34 -0700 (PDT)
Subject: Re: [PATCH] fs/exofs: Remove ignored __weak attribute
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20180930205126.25840-1-natechancellor@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
From:   Boaz Harrosh <ooo@electrozaur.com>
Message-ID: <aca03ebc-ff33-1734-5364-5ca1ab897f16@electrozaur.com>
Date:   Tue, 2 Oct 2018 19:50:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20180930205126.25840-1-natechancellor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/09/18 23:51, Nathan Chancellor wrote:
> Clang warns that the __weak attribute is going to be ignored on
> g_attr_inode_data because it's not in the correct location (needs to be
> after the type).
> 
> In file included from fs/exofs/dir.c:35:
> In file included from fs/exofs/exofs.h:41:
> fs/exofs/common.h:186:21: warning: 'weak' attribute only applies to
> variables, functions, and classes [-Wignored-attributes]
> static const struct __weak osd_attr g_attr_inode_data = ATTR_DEF(
>                     ^
> 
> Turns out that GCC ignores the attribute too albeit silently because
> moving the attribute after either osd_attr or g_attr_inode_data like
> all other uses of __weak on variables in the kernel causes a build
> error on both GCC and Clang because static variables cannot be weak
> since weak definitions rely on not having internal linkage:
> 
> In file included from fs/exofs/namei.c:34:
> In file included from fs/exofs/exofs.h:41:
> fs/exofs/common.h:186:30: error: weak declaration cannot have internal
> linkage
> static const struct osd_attr __weak g_attr_inode_data = ATTR_DEF(
>                              ^
> 
> Just remove the attribute because it hasn't been correct since the
> initial addition of this file in commit b14f8ab28449 ("exofs: Kbuild,
> Headers and osd utils").
> 
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

ACK-by: Boaz Harrosh <ooo@electrozaur.com>

Yes! thanks
Boaz

> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  fs/exofs/common.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/exofs/common.h b/fs/exofs/common.h
> index 7d88ef566213..45da96a1528d 100644
> --- a/fs/exofs/common.h
> +++ b/fs/exofs/common.h
> @@ -183,7 +183,7 @@ struct exofs_fcb {
>  #define EXOFS_INO_ATTR_SIZE	sizeof(struct exofs_fcb)
>  
>  /* This is the Attribute the fcb is stored in */
> -static const struct __weak osd_attr g_attr_inode_data = ATTR_DEF(
> +static const struct osd_attr g_attr_inode_data = ATTR_DEF(
>  	EXOFS_APAGE_FS_DATA,
>  	EXOFS_ATTR_INODE_DATA,
>  	EXOFS_INO_ATTR_SIZE);
> 

