Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F66C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 22:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05F4F208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 22:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UZMluMFw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05F4F208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbeJBF2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 01:28:11 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39835 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbeJBF2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 01:28:11 -0400
Received: by mail-pg1-f193.google.com with SMTP id r9-v6so1952pgv.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 15:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rtfd65uzAckPehqCXpbzUlECxRt5jl4YCAIZQF8KU/g=;
        b=UZMluMFwylnpoQ2tGTBOhc1e6c4behjRJBdlrEfgv2/kmoEBba0t5+KXZ0KhuncPsa
         YmXYiztOAFUhDbSleIr+vlGomTgMwu1HkjpmGQX5uXRMW05p9sEFsRXBExKpzREjcD0N
         rnIrxK7tlWhq39He0mLUQKl7DEqyZHSGPNA5R/PFetBRfW0YDLRqqpEdE8RSWEOUtGeA
         3PlDIy+jr3AnOpJtHOqDBbOHjvNoIqJ5Ay1esWNLdVXvSsU6DAjoqgZ1QeE8k45cvQOK
         WSr7nLpTV17EOPZ7y7wbOYeImz0zrhEbaElPw7qdzOAELhA721Vi0ZPxpG7fR3yTNZ/X
         KuuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rtfd65uzAckPehqCXpbzUlECxRt5jl4YCAIZQF8KU/g=;
        b=r1EzYalCMJRgK/l49R+7Vg/KhdP8t/TjJHrKa113kkiZnoC//LvejcY69Ey5ZshSqE
         eIIYJbL8HCWD3NTv50IoLHk74C+VH+xIWQQKceR5vCppZ/infx6a/b7cOyedZiDQm4rn
         8I4zlCCxQ//WECOACFdFV4lasru/Ay/XtdWLaKApMahd4E2+YWNRKE0gBWBaeupOXIdr
         DsNl7QDJSMosXMMsQtzk1MsEu9EL4wOVCkduHQ3l1eRSG2pcariDuqKQ+1ZwR62BIvj8
         ZxT3ibA+q+xMUYL1A/rebfyzmjJuO7M9loe/2ObZs3llkiOkjoJcujhLlOuuJFN/cC34
         diNw==
X-Gm-Message-State: ABuFfoiaDRoa1OvKwAEv7EaNKwhSKgFcaPrKZXUmTbYN4f2vZwDg6pwj
        KcmMGw3ud8XbVJDxtqDCiYS0qrgQScfuEL1a9KiM3w==
X-Google-Smtp-Source: ACcGV62iWpDIiHHJQhgkCXCc9pW6cHa66KlG04GzRwHi7/+dSLWZIkrXriofp973aHbmnZVjIT7ADVu9HJNLP4BZCno=
X-Received: by 2002:a17:902:bf42:: with SMTP id u2-v6mr11353596pls.13.1538434086689;
 Mon, 01 Oct 2018 15:48:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180930205448.26205-1-natechancellor@gmail.com>
In-Reply-To: <20180930205448.26205-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 1 Oct 2018 15:47:55 -0700
Message-ID: <CAKwvOdmCHEB945Lr26mWt9J7jYXDo89wUt=r0UT7mZ-WcroMLA@mail.gmail.com>
Subject: Re: [PATCH] libosd: Remove ignored __weak attribute
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     ooo@electrozaur.com,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 30, 2018 at 1:55 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns that the __weak attribute is going to be ignored on
> osd_root_object because it's not in the correct location (needs to be
> after the type).
>
> ./include/scsi/osd_types.h:31:21: warning: 'weak' attribute only applies
> to variables, functions, and classes [-Wignored-attributes]
> static const struct __weak osd_obj_id osd_root_object = {0, 0};
>                     ^
>
> Turns out that GCC ignores the attribute too albeit silently because
> moving the attribute after either osd_obj_id or osd_root_object like
> all other uses of __weak on variables in the kernel causes a build
> error on both GCC and Clang because static variables cannot be weak
> since weak definitions rely on not having internal linkage:
>
> ./include/scsi/osd_types.h:31:32: error: weak declaration cannot have
> internal linkage
> static const struct osd_obj_id __weak osd_root_object = {0, 0};
>                                ^
>
> Just remove the attribute because it hasn't been correct since the
> initial addition of this file in commit de258bf5e638 ("[SCSI] libosd:
> OSDv1 Headers").
>
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  include/scsi/osd_types.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/scsi/osd_types.h b/include/scsi/osd_types.h
> index 48e8a165e136..6b6fdcafa6cc 100644
> --- a/include/scsi/osd_types.h
> +++ b/include/scsi/osd_types.h
> @@ -28,7 +28,7 @@ struct osd_obj_id {
>         osd_id id;
>  };
>
> -static const struct __weak osd_obj_id osd_root_object = {0, 0};
> +static const struct osd_obj_id osd_root_object = {0, 0};
>
>  struct osd_attr {
>         u32 attr_page;
> --
> 2.19.0
>

LGTM, thank you for sending, Nathan.
-- 
Thanks,
~Nick Desaulniers
