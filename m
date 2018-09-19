Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2914C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D4C21521
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="txfmFsY/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89D4C21521
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732998AbeITA0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 20:26:44 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35075 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727676AbeITA0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 20:26:44 -0400
Received: by mail-lj1-f196.google.com with SMTP id p10-v6so6038904ljg.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 11:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ApIGaPDQ9w0yju1KQqotIu/pbBqMxLwdaihRPOvwaII=;
        b=txfmFsY/fft2+Atd8q9GjaHUFtv8c7D6O0ledlXH1EZPigxny2Z+7FHCg7x81bE+VC
         9QP/88DmiUafx/SquguuSPbMHSEModTH6wJG/K1KoKXfCbDM2Ydf+8DWDw3WyKzvrgEN
         /yVmFdn3WKqdRcwoG013Flh1wjk+xdZEVESNE/ocLuGroyYlmNnRWlplTpGD5Rs8s8UW
         cXBT3qE2dLKYlY/rGlu5VPFsvfDLv1SvZ4f6NiXCU38EzVHGNNLqw3mhiau3mceg7IXT
         hTvus4mOsPmFLFGPTI/CWOA6h9TnSgLKzDfLNaXtzCau/0xLM2GwEfHWxnY++jnft4YX
         trww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ApIGaPDQ9w0yju1KQqotIu/pbBqMxLwdaihRPOvwaII=;
        b=sAXAKi7K7o8bkCo48uKC34B64rRbIVR16rkqu84tFkTZw8G2sTNXLquC/ZH3bxVrO4
         llRriziRkthckkj+LN7podhD7CH9vK27pTUUnrsnYMpie+4SNdX5uD8hZ2QdVnwbzE4p
         uUqs7i8D7b4CxowlZjp39ujNegqYoYTQTZmqHG4YK0i38tfgd3v17XMu8JY1wy5MQgkL
         w7Lx8gTKjGUaN+co1+XOpCS1z7S/VD0AlgejL8IpCBU9iL7kiW6AQXqg5zHUHvj0OzXe
         r1lRPPwEKiLjBsqtmOBFAq2jmTy7lolEMhZZYdMV36vYKlL53GMFruicd9Mb1YGl27Q0
         2vjQ==
X-Gm-Message-State: APzg51ArXoBXY1dAZ+eYT/KArK3e5J/2Y0fq1DxAGZ3S1SDtd19NhoO7
        8qdPaSkwgNSpFP2+/IO1EC88uGzZp7iU8VGMys0H
X-Google-Smtp-Source: ANB0VdaT01ea2XIDYMFMINJLCaUILV2dff4C1rBEuzdO2gMaNTyWJ8pzodCPLRk6Zc8g4gNACXXyWQ4zuUeqzt/uIjI=
X-Received: by 2002:a2e:8743:: with SMTP id q3-v6mr23214202ljj.139.1537382849506;
 Wed, 19 Sep 2018 11:47:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180919165248.53090-1-takondra@cisco.com>
In-Reply-To: <20180919165248.53090-1-takondra@cisco.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 19 Sep 2018 14:47:18 -0400
Message-ID: <CAHC9VhRhfdpjTDh8itu=0uNerpmaR7t+t7jdpfWqScaWL_RUJQ@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: add a fallback to defcontext for native labeling
To:     takondra@cisco.com
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
        linux-kernel@vger.kernel.org, xe-linux-external@cisco.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 12:52 PM Taras Kondratiuk <takondra@cisco.com> wrote:
> When files on NFSv4 server are not properly labeled (label doesn't match
> a policy on a client) they will end up with unlabeled_t type which is
> too generic. We would like to be able to set a default context per
> mount. 'defcontext' mount option looks like a nice solution, but it
> doesn't seem to be fully implemented for native labeling. Default
> context is stored, but is never used.
>
> The patch adds a fallback to a default context if a received context is
> invalid. If the inode context is already initialized, then it is left
> untouched to preserve a context set locally on a client.
>
> Signed-off-by: Taras Kondratiuk <takondra@cisco.com>
> ---
>  security/selinux/hooks.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)

The idea seems reasonable to me; if we want to treat labeled NFS like
we treat local filesystems we should also support the defcontext mount
option.

However, I wonder if we are better off generalizing some of the
SECURITY_FS_USE_XATTR based code in inode_doinit_with_dentry() such
that it can be used both in selinux_inode_notifysecctx() and in
inode_doinit_with_dentry().  Or maybe we just need a sbsec->def_sid
variant of selinux_inode_setsecurity().  Regardless, the key is the
call to security_context_to_sid_default(), the
selinux_inode_setsecurity() function only calls
security_context_to_sid().

Just in case anyone is wondering, I'm not sure I want to update
selinux_inode_setsecurity() to call security_context_to_sid_default();
at least not without more investigation.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index ad9a9b8e9979..f7debe798bf5 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6598,7 +6598,30 @@ static void selinux_inode_invalidate_secctx(struct inode *inode)
>   */
>  static int selinux_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
>  {
> -       return selinux_inode_setsecurity(inode, XATTR_SELINUX_SUFFIX, ctx, ctxlen, 0);
> +       struct superblock_security_struct *sbsec;
> +       struct inode_security_struct *isec;
> +       int rc;
> +
> +       rc = selinux_inode_setsecurity(inode, XATTR_SELINUX_SUFFIX, ctx, ctxlen, 0);
> +
> +       /*
> +        * In case of Native labeling with defcontext mount option fall back
> +        * to a default SID if received context is invalid.
> +        */
> +       if (rc == -EINVAL) {
> +               sbsec = inode->i_sb->s_security;
> +               if (sbsec->behavior == SECURITY_FS_USE_NATIVE &&
> +                   sbsec->flags & DEFCONTEXT_MNT) {
> +                       isec = inode->i_security;
> +                       if (!isec->initialized) {
> +                               isec->sclass = inode_mode_to_security_class(inode->i_mode);
> +                               isec->sid = sbsec->def_sid;
> +                               isec->initialized = 1;
> +                       }
> +                       rc = 0;
> +               }
> +       }
> +       return rc;
>  }
>
>  /*
> --
> 2.10.3.dirty
>


-- 
paul moore
www.paul-moore.com
