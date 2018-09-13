Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F73C070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 00:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91D182146E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 00:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbRvHcrf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91D182146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbeIMFzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 01:55:47 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:39067 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbeIMFzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 01:55:47 -0400
Received: by mail-vk1-f193.google.com with SMTP id e139-v6so446697vkf.6;
        Wed, 12 Sep 2018 17:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5lFbn7Q1DS1X+ewhy820fogG9oqwDWQ1IE1ITmLuKqQ=;
        b=CbRvHcrf8dGz2c0w7Tq0YQ1+FQZSU7e6NEao+/i+cftzlqFUjYHfe9N09aCBskTepw
         oRrjQBtU0F4Z3UNQMG7l6HNku3OakuWAyLCD17yOr0Jxw+sC1f0S7cTNFgoa81ScsesF
         DJNKLeuuOUAOF/oXRHiriwar+egu22Ew+AHTwOz68JMblmMWYLwPbyo2e9E+at7Pk0bc
         nYIvclI7R5XwbpWZOXgChSjz0V8oXpwK1YwwW0okdVEpQXjgO14knfPGsZHWtSWZYsvO
         MZOYhYfZ3pZq5XvwOOHzj+NePC/4pOUW7Sl2UJdh3zzg7b3c+HZqAqONTyZXzyR/KoBm
         CDnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5lFbn7Q1DS1X+ewhy820fogG9oqwDWQ1IE1ITmLuKqQ=;
        b=COKrhEOgQ2cXcj98cc/kGASnOQLUdpKK/fKzPMiorhWlh4rp9qFzIwmUTcE5F0pz0+
         O6oAIEtVuEU6DP5NcaJzJbRohUt1wdXx1nLK/EPTq/M/FD+PofyKIpI6hpK0DVn3auwH
         HlxZIztOL38fmKeuzm5xXmkPNz6RTxqIeqyrt/el7cZUfxyHn7JcSH3WxlXSKZjcfFLk
         ZAlOydJDmVKzE3yQAO+ZP1iSa4Iz8YhZMCwkNcZGkfnOmN+k0ikeo25xAxDcsZudsqPx
         fNZ6jOR6NEey1pXhtjggFa0p8M6Z6pdAyYwhzIPvm5rIa6y8b+UvEQeAj5j/R46uHBGv
         r6cQ==
X-Gm-Message-State: APzg51AZhkgEGxdpsAGEQLDgFk5yr0S1VA3acLy8Es4Xogl8UTzXDT9z
        LnSNwBEsOpEQYs1WJCxbqKEMQZKNE7CKJFIqA24=
X-Google-Smtp-Source: ANB0Vdb0UKLDPhgw+cXLcnudHe3wTBp//bdCq0sB0fW5wv1gcaRgdPqSHfijjxItJbPh6u2quBMa/ICXQsslei+sPBc=
X-Received: by 2002:a1f:61c5:: with SMTP id v188-v6mr1689312vkb.19.1536799724826;
 Wed, 12 Sep 2018 17:48:44 -0700 (PDT)
MIME-Version: 1.0
References: <20180912150142.157913-1-arnd@arndb.de> <20180912150142.157913-4-arnd@arndb.de>
In-Reply-To: <20180912150142.157913-4-arnd@arndb.de>
From:   "Yan, Zheng" <ukernel@gmail.com>
Date:   Thu, 13 Sep 2018 08:48:33 +0800
Message-ID: <CAAM7YAnmTOMUdB4jVTzXv7C3dh58ekThm=U-GMJ9-_zzWti53w@mail.gmail.com>
Subject: Re: [PATCH v2 04/17] ceph: fix compat_ioctl for ceph_dir_operations
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        stable@vger.kernel.org, Zheng Yan <zyan@redhat.com>,
        Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        Chengguang Xu <cgxu519@gmx.com>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 11:10 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> The ceph_ioctl function is used both for files and directories, but only
> the files support doing that in 32-bit compat mode.
>
> For consistency, add the same compat handler to the dir operations
> as well.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  fs/ceph/dir.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index 82928cea0209..da73f29d7faa 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -1489,6 +1489,7 @@ const struct file_operations ceph_dir_fops = {
>         .open = ceph_open,
>         .release = ceph_release,
>         .unlocked_ioctl = ceph_ioctl,
> +       .compat_ioctl = ceph_ioctl,
>         .fsync = ceph_fsync,
>         .lock = ceph_lock,
>         .flock = ceph_flock,
> --
> 2.18.0
>

Reviewed-by: "Yan, Zheng" <zyan@redhat.com>
