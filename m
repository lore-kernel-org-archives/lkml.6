Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64621C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 21:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26A21218A6
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 21:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="N+KIcnU6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbfAYVFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 16:05:13 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35548 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfAYVFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 16:05:13 -0500
Received: by mail-lf1-f65.google.com with SMTP id e26so7917704lfc.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 13:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hu/MeQhwAjDC2cBj8mJ130DCkTsDhsy/SLjkjYI8toU=;
        b=N+KIcnU6gUJAw/059IUODzNkSzS5rbo7ClhBCqaspuBBV32TVhQadD+3Lza77DHNhg
         ypTaK1/UgmVP4DTiUqa5aZ8nM1VAaUFrGPofLST35B/0aLdY4k7Qga5XaE88VtU5PHCo
         d3OduJYXCwan/xvDO+t2EsZucQp+f0FtBg3st8aMUna4UHR6fFb4kjTbIVbtgC19aHz6
         lXnqPOZxDhS40XrYDib2dDMtaS+H45DEXLwpwdTDwvMikS3UkoS/3bp1vUIqKuq0wxOd
         a/ES9lp4QLaB9kpQnZlyc5Sfen5BR9B0K4reGfXKOLT3MROYpZCNJ1NJDKkCRr4UIIlH
         Tulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hu/MeQhwAjDC2cBj8mJ130DCkTsDhsy/SLjkjYI8toU=;
        b=fVDABRMvSpl6Ir4e+5KfquK/yc0J4rvVNp6N0vAqxfOGwygpQPLvwnmY7G9QmMbaH4
         4pp+iWqtCNvlyFcmDHqYqBhp4A1lstq4jpxnpLCdD+CoWeibkD555A3dCGPU4QXD3pIR
         dhfsESOTRv730/H1CzGp4/raMwiriyMoWyEflqcJ9/CEAxLLfpWTSuWyxgMq84NqU61N
         Bw35l04jcQq1wyJPVK/zYcl/F/gfPjFx5q/P9GGdjWPS4sALixTMwTUzjudJUT3biu2/
         YN5yFD/Vx6Tl4z8twGl0p7St0EV4NriUSPqM3mKSNjf9RVMgjKcEXcb0CsKsldmYsreL
         T3wg==
X-Gm-Message-State: AJcUukfTYOMB/nRPC4y6TQGHm1IYFLNOqQI3v9OdBPsL7x+zUe3hsoEy
        kahZshP4Tl9poxHvKgx9XopPcXAQTGB18CkxJzEN
X-Google-Smtp-Source: ALg8bN777t/RH0pwcJS+1HDmQSbaDtoLJRzJH+97aG4PC6YhGRyCgvvSADAB7EiY9tTNTyscXhU7RkU9k7igsMbZGkM=
X-Received: by 2002:a19:d619:: with SMTP id n25mr8938148lfg.91.1548450310789;
 Fri, 25 Jan 2019 13:05:10 -0800 (PST)
MIME-Version: 1.0
References: <f8348d1e67d66e8e5d42e3bdfbda7e88139f2d31.1548297089.git.rgb@redhat.com>
In-Reply-To: <f8348d1e67d66e8e5d42e3bdfbda7e88139f2d31.1548297089.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 25 Jan 2019 16:04:59 -0500
Message-ID: <CAHC9VhS7idW3VabOQmjTdTXAtwp5_MwPannwUMLVQ+kunVjeVg@mail.gmail.com>
Subject: Re: [PATCH ghak103 V1] audit: add support for fcaps v3
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>,
        Eric Paris <eparis@redhat.com>, Serge Hallyn <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 9:37 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> V3 namespaced file capabilities were introduced in
> commit 8db6c34f1dbc ("Introduce v3 namespaced file capabilities")
>
> Add support for these by adding the "frootid" field to the existing
> fcaps fields in the NAME and BPRM_FCAPS records.
>
> Please see github issue
> https://github.com/linux-audit/audit-kernel/issues/103
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
> Passes audit-testsuite.
>
>  include/linux/capability.h | 5 +++--
>  kernel/audit.c             | 6 ++++--
>  kernel/audit.h             | 1 +
>  kernel/auditsc.c           | 4 ++++
>  security/commoncap.c       | 2 ++
>  5 files changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/capability.h b/include/linux/capability.h
> index f640dcbc880c..f6bb691547fd 100644
> --- a/include/linux/capability.h
> +++ b/include/linux/capability.h
> @@ -14,7 +14,7 @@
>  #define _LINUX_CAPABILITY_H
>
>  #include <uapi/linux/capability.h>
> -
> +#include <linux/uidgid.h>
>
>  #define _KERNEL_CAPABILITY_VERSION _LINUX_CAPABILITY_VERSION_3
>  #define _KERNEL_CAPABILITY_U32S    _LINUX_CAPABILITY_U32S_3
> @@ -25,11 +25,12 @@
>         __u32 cap[_KERNEL_CAPABILITY_U32S];
>  } kernel_cap_t;
>
> -/* exact same as vfs_cap_data but in cpu endian and always filled completely */
> +/* exact same as vfs_ns_cap_data but in cpu endian and always filled completely */

Removed "exact" from the comment above so it fits an 80 char line
width.  Please watch for this in your patches, I care a lot about line
widths.

Otherwise as long as Serge is happy with the capabilities bits, I'm
happy with the audit bits; merged.

--
paul moore
www.paul-moore.com
