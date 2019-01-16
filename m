Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F329FC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C318F20859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389619AbfAPLKn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 06:10:43 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34684 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfAPLKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 06:10:42 -0500
Received: by mail-ot1-f67.google.com with SMTP id t5so1505189otk.1;
        Wed, 16 Jan 2019 03:10:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PEmnyaLC69zPRSlEQNRSGDT94/N3f9H5gAm5I4+eC9Y=;
        b=dHGyCfxTKMRFlkNVW3ZwFX3C9eaDG8f+KFtKjws+gRKhb4LzpcWa+OgEvFMUZUsZ2Q
         eRciEHWQ0Txlg2FsKhN1AnmoCcnds5TE3DTATD31Xmynx+JBUGzMyQvITKBT5mK3WRR/
         Qqt7Xx6VMYvje2odX1itbEO9y59pP8e2APQBL+NCMsccs+k9OIqcBPygB9+OZRr8WH3j
         qw232ZD5srZGj1vu3jf0Xo4LV1NmxnXzDmEopFompwuqYkPcwpMcwRwn1R93fLjfFDqb
         ntAbOhuolEQJFRoHz0gCES/B1szKgngpfaNYBA3kzA5QaTXGV5su33xG4DG4cFBz/pii
         b8OA==
X-Gm-Message-State: AJcUukd/mna2DD/izqGCzhYw+CNU1aBMhCQyxhB0eXBakNtomqlB3SEL
        vRCu8xM1V8U3c0TdODOrJmNsT3xKO58PNgg2Zm7GFg==
X-Google-Smtp-Source: ALg8bN5cpd9IsSAFuf0FN1AjSa+00yEaYfHof/ng9jzFsaak8LqZgSbsS94b3cSdGkqj2OtXzsHpX6o3B76TbnMf2BQ=
X-Received: by 2002:a9d:628:: with SMTP id 37mr5485545otn.58.1547637041736;
 Wed, 16 Jan 2019 03:10:41 -0800 (PST)
MIME-Version: 1.0
References: <20181207204318.1920-1-malat@debian.org>
In-Reply-To: <20181207204318.1920-1-malat@debian.org>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Wed, 16 Jan 2019 12:10:30 +0100
Message-ID: <CA+7wUsx7vL_q6KDy_9ZGiaAJnR1SVQq=sbdTHh0NXdk2v7c8Cw@mail.gmail.com>
Subject: Re: [PATCH] mount: Make function to_mnt_ns static
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping ?

On Fri, Dec 7, 2018 at 9:43 PM Mathieu Malaterre <malat@debian.org> wrote:
>
> In commit 58be28256d98 ("make mntns ->get()/->put()/->install()/->inum()
> work with &mnt_ns->ns"), a new function `to_mnt_ns` was introduced.
> Since this function can be made static, make it so.
>
> Fix warning when compiling with W=1:
>
>   fs/namespace.c:1693:23: warning: no previous prototype for ‘to_mnt_ns’ [-Wmissing-prototypes]
>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>  fs/namespace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/namespace.c b/fs/namespace.c
> index a7f91265ea67..f0cf252d9aa3 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -1690,7 +1690,7 @@ static bool is_mnt_ns_file(struct dentry *dentry)
>                dentry->d_fsdata == &mntns_operations;
>  }
>
> -struct mnt_namespace *to_mnt_ns(struct ns_common *ns)
> +static struct mnt_namespace *to_mnt_ns(struct ns_common *ns)
>  {
>         return container_of(ns, struct mnt_namespace, ns);
>  }
> --
> 2.19.2
>
