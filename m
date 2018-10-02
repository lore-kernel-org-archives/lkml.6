Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4885C64EBC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 23:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B0CD20666
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 23:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sTinkPXj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B0CD20666
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbeJCFwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 01:52:01 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41210 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725724AbeJCFwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 01:52:00 -0400
Received: by mail-pg1-f193.google.com with SMTP id 23-v6so630171pgc.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 16:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+9nNydKuJ2A8+HcTX49LzL4booZ8epovj3h1SW++6g4=;
        b=sTinkPXjpMbTLDMoeeCT8U5fCpVWPBm9Fw0m73SoS6gokEGMa7Cj1IXTJ/9tvlrURC
         0lf/x5XuUqiwgJyosou8EZPqvTzAskn8KQyATgmdu6lUcxVGVNEcPSOplA2ySd1BVGBH
         igbait0bfkmzKrkJrJ1VK7wy1uGQ4dq4lr2ebT+e/5FzRe2F6Dy12BlKKGbWPtLBSowd
         HLSWl9nf4j8Ojy+DQEFVY6BINcmjJ5ENadc4ns7Nfj/9WWzdidzmwYvAPynkV96N8cfd
         bFDKvZjMT+zj1N147Iz1RxiT/AwEfClYY9HjkCr/Hg3bpjZclgDnUghaTYIIOMPNi5j0
         IQTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+9nNydKuJ2A8+HcTX49LzL4booZ8epovj3h1SW++6g4=;
        b=oXuK1f9NMYv+21zlQMTgFFZd4vAC53y452SGQb6yF9apsx2J0XwBAm+j6XHUR/uJdC
         qeQXs8qZQL0FfJCQCkuiAhxf6ds/no04OmvJbM52sLszoluAPqqxWNxeDtY3OBCZhFJ2
         1n2kY6hav4jPy7hez62gFqKHpfpK6LRKatxvQLtv0RbaXMw6PE5m6p2uTn+oEe1xIu6m
         86R8+R9XAX5MoKX8dd7k2CVd8mmhcRWz+0Om1pRfrkUgruyQ34htbXY8uaB3m3UHqnHC
         1FTahMU5S4sKw0IvdY3BTU5WL8co0e6Ur5lzUDu3Vfvd8RzJUlkT68ut2MsgHVvm6J4J
         YurQ==
X-Gm-Message-State: ABuFfohezoLsorJB9iNzMHAo365hxvNoyzwzhZZ6uigjvGOJdcJBRpEy
        qaXVkF6mUfK3WVJmvpYgBbMOw4PEpYrnl9+Yd/BOZg==
X-Google-Smtp-Source: ACcGV61ZEunBF33/9XdIzGEmYdlxvsr4Gy4JbPuRXarmw3HLUKiMs/27JaPTOmqWt09iFpVUXwwAi/HUfZxcvkmiLn0=
X-Received: by 2002:a62:1095:: with SMTP id 21-v6mr15557464pfq.227.1538521575945;
 Tue, 02 Oct 2018 16:06:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180926045435.9213-1-natechancellor@gmail.com> <20180927235651.27151-1-natechancellor@gmail.com>
In-Reply-To: <20180927235651.27151-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 2 Oct 2018 16:06:05 -0700
Message-ID: <CAKwvOdkH++gmtONndVbt2qsOSjUWquwZ9vnQDvNQanF89rHUJQ@mail.gmail.com>
Subject: Re: [PATCH v2] scsi: bfa: Avoid implicit enum conversion in bfad_im_post_vendor_event
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     anil.gurumurthy@qlogic.com, sudarsana.kalluru@qlogic.com,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 4:57 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns when one enumerated type is implicitly converted to another.
>
> drivers/scsi/bfa/bfa_fcs_lport.c:379:26: warning: implicit conversion
> from enumeration type 'enum bfa_lport_aen_event' to different
> enumeration type 'enum bfa_ioc_aen_event' [-Wenum-conversion]
>                                   BFA_AEN_CAT_LPORT, event);
>                                                      ^~~~~
>
> The root cause of these warnings is the bfad_im_post_vendor_event
> function, which expects a value from enum bfa_ioc_aen_event but there
> are multiple instances of values from enums bfa_port_aen_event,
> bfa_audit_aen_event, and bfa_lport_aen_event being used in this
> function.
>
> Given that this doesn't appear to be a problem since cat helps with
> differentiating the events, just change evt's type to int so that no
> conversion needs to happen and Clang won't warn. Update aen_type's type
> in bfa_aen_entry_s as members that hold enumerated types should be int.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/147
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>
> v1 -> v2:
>
> * Update aen_type's type in bfa_aen_entry_s to match evt

Thanks for respinning with this addition.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
>  drivers/scsi/bfa/bfa_defs_svc.h | 2 +-
>  drivers/scsi/bfa/bfad_im.h      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/scsi/bfa/bfa_defs_svc.h b/drivers/scsi/bfa/bfa_defs_svc.h
> index 3d0c96a5c873..c19c26e0e405 100644
> --- a/drivers/scsi/bfa/bfa_defs_svc.h
> +++ b/drivers/scsi/bfa/bfa_defs_svc.h
> @@ -1453,7 +1453,7 @@ union bfa_aen_data_u {
>  struct bfa_aen_entry_s {
>         struct list_head        qe;
>         enum bfa_aen_category   aen_category;
> -       u32                     aen_type;
> +       int                     aen_type;
>         union bfa_aen_data_u    aen_data;
>         u64                     aen_tv_sec;
>         u64                     aen_tv_usec;
> diff --git a/drivers/scsi/bfa/bfad_im.h b/drivers/scsi/bfa/bfad_im.h
> index e61ed8dad0b4..bd4ac187fd8e 100644
> --- a/drivers/scsi/bfa/bfad_im.h
> +++ b/drivers/scsi/bfa/bfad_im.h
> @@ -143,7 +143,7 @@ struct bfad_im_s {
>  static inline void bfad_im_post_vendor_event(struct bfa_aen_entry_s *entry,
>                                              struct bfad_s *drv, int cnt,
>                                              enum bfa_aen_category cat,
> -                                            enum bfa_ioc_aen_event evt)
> +                                            int evt)
>  {
>         struct timespec64 ts;
>
> --
> 2.19.0
>


-- 
Thanks,
~Nick Desaulniers
