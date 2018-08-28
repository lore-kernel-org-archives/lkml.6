Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFD2C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5936720835
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjjSOOBP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5936720835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbeH1VeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 17:34:18 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:45559 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbeH1VeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 17:34:18 -0400
Received: by mail-yw1-f66.google.com with SMTP id p206-v6so899807ywg.12;
        Tue, 28 Aug 2018 10:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GogHkebH8SfHDxdMiBVjtef2fAiB9yRDSAW8eCFewQ8=;
        b=VjjSOOBPjzbU3yMD0azkhYiq3m3dbUoeLiAzmcV/StQxpKFkm+Z/iBZHZ531QUCo3L
         jbtBFLEjCU8GvRCBNdxjTIRNfkdKDZQECFLfDhhEtGQxeS7nXBrtkDX+Y8qTTyOLCZFl
         CNX2pvIAoUMZ5ji7LLfrMRRtgz9T3f80x0hciRk6Lc1S54RsfdnRD2JsWCW3H8botcxN
         orsREPOO0yTLRgtFs6SqDznUJ0HYG+gcAMf1KcP9cUpylyxBeNvMa0Tq8LLtJX8DOIcQ
         wfaTgMfh/7NCS9cIj87HZznysuDdaLzXPFen8SsI6F8cOVt6ZCn4YF2jTSS/t3gNOPqh
         zE8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GogHkebH8SfHDxdMiBVjtef2fAiB9yRDSAW8eCFewQ8=;
        b=twNWoW/vt5og/0I3QzZCTmEo+aMI25wio3nSl23ewgqIlk6bxWC3x53RsRQGE72+qi
         y9XcMIC1dS2BB/r8aXjUp7B+XhpGgBL2LBibIQXNJesUkeRInxPwLl9HN9eJR7a9avTY
         qNTrWWzf16etOoqSiqw4oNtKQ9FMPO6wwnXKKFTAfo6sK1p6tpLRpllug5hWm6huSLaa
         12GXJj+QqwNkwshLJ422W5E2eZehUlx8QzZX+dHcHHFwACQ5GhIBmXIl8VQHMiU/N1vi
         JVMKX9bexAtnkzIlhoE9JvzIvqv7tYo2ZMS1AT2lKySc0lu5Plagdxh+r6J0GEGScs9Z
         rmuQ==
X-Gm-Message-State: APzg51AoB1hen71KHq/H+aTrepA+W3Pnfp5qcSdgzBryts/gdINPBiYA
        OodRe9dVOB4DTVedWwBjZYHSgw4d2lVYhlMpLWg=
X-Google-Smtp-Source: ANB0Vdad/pV/g1zfWSd4bseIzlNDTW8ASd6zLbJ3UZ8hIwrKQkzr+5LwGR4QmwtyK75T6waa0a6nvhCHUTWCkZWQOls=
X-Received: by 2002:a0d:c903:: with SMTP id l3-v6mr1420735ywd.404.1535478094653;
 Tue, 28 Aug 2018 10:41:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180828165319.211563-1-salyzyn@android.com>
In-Reply-To: <20180828165319.211563-1-salyzyn@android.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 28 Aug 2018 20:43:21 +0300
Message-ID: <CAOQ4uxhRPOC_prhygrjndMMUrtU-S7FrLJ0tb4eJUV94GFj38w@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] overlayfs: check CAP_MKNOD before issuing vfs_whiteout
To:     Mark Salyzyn <salyzyn@android.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 7:53 PM Mark Salyzyn <salyzyn@android.com> wrote:
>
> Assumption never checked, should fail if the mounter creds are not
> sufficient.
>
> Signed-off-by: Mark Salyzyn <salyzyn@android.com>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Stephen Smalley <sds@tycho.nsa.gov>
> Cc: linux-unionfs@vger.kernel.org
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
>
> v5
> - dependency of "overlayfs: override_creds=off option bypass creator_cred"
> ---
>  fs/overlayfs/overlayfs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index 7538b9b56237..bf3a80157d42 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -176,7 +176,7 @@ static inline int ovl_do_rename(struct inode *olddir, struct dentry *olddentry,
>
>  static inline int ovl_do_whiteout(struct inode *dir, struct dentry *dentry)
>  {
> -       int err = vfs_whiteout(dir, dentry);
> +       int err = capable(CAP_MKNOD) ? vfs_whiteout(dir, dentry) : -EPERM;

Should that be ns_capable()? Should the test go into vfs_whiteout()?
I feel there is no convention at all.

Thanks,
Amir.
