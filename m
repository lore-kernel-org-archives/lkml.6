Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C132CC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 01:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91BDB206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 01:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LI54vBPY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbfAOBOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 20:14:24 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:43581 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbfAOBOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 20:14:24 -0500
Received: by mail-vs1-f66.google.com with SMTP id x1so650230vsc.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 17:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/glRo+PwNhXl+8KxWNMyUyAGwpyFFP18lUKdE16Mes0=;
        b=LI54vBPY8z+4b+2M6Yv5ZrzizDyxQT3xAnbrr/06OCn6g+EBFRBEaiNvM7s5MJf3cB
         oZFwrkTY3NOrVaojuZG28VNOVaaHG6C/ki1gvJqf0ZZb1j7AjBC/40k+KVlNcNhSCjav
         YakX+V9AVY7uWESKgOA1HUjtshTbEjwFfrhVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/glRo+PwNhXl+8KxWNMyUyAGwpyFFP18lUKdE16Mes0=;
        b=S5mtdsNKsk/RNG/ZOeZMElThdEZCpxkSIu0GHi+MC8qkLUzVPyDkmb86J3fjVyf3Zi
         S32puBewcb+74SW8Kgy/HGBOTjTB4XD380QDA7gYax26u4dSgVI41mQE3hP+OmSQv2VG
         OUXmlYAWKrrpWjc6QG2D1zMtHbv+I3sBUMelb9KkAKcKUuh/p/kSTvSIQfctv1MU6Kbd
         +I8Oao6PjLr/uPNaUIq1iuUWlpKtOigvkhrLXhz/C3ga3SSimiJQBo+TOOyaJSzgMGZu
         GTw45+nzBzVFqFEonzDlRgid95POCpMClUblTHXC9vA7eSMk+apDTE2A4F+Se1gG3U5w
         nONA==
X-Gm-Message-State: AJcUukfeL0Ze9cnCgR4n/WRymBVMmoyfsGBkUqDbs9rXTUvpMlYkkbP/
        VRAkT+9kmm5rD6+rBX8NtCq/FOxWsVE=
X-Google-Smtp-Source: ALg8bN6rMQJcR2Wkz04lE71lKyHoJaye5QPjEnFot8wvJSeBAs6gkmDxYruUimkxiZVdsaZ8FDv6lA==
X-Received: by 2002:a67:c104:: with SMTP id d4mr546384vsj.171.1547514862692;
        Mon, 14 Jan 2019 17:14:22 -0800 (PST)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id o1sm1187545uaj.4.2019.01.14.17.14.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 17:14:21 -0800 (PST)
Received: by mail-ua1-f45.google.com with SMTP id d19so359536uaq.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 17:14:21 -0800 (PST)
X-Received: by 2002:ab0:470d:: with SMTP id h13mr577693uac.122.1547514860832;
 Mon, 14 Jan 2019 17:14:20 -0800 (PST)
MIME-Version: 1.0
References: <20190112152844.26550-1-w@1wt.eu> <20190112152844.26550-3-w@1wt.eu>
In-Reply-To: <20190112152844.26550-3-w@1wt.eu>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 14 Jan 2019 17:14:09 -0800
X-Gmail-Original-Message-ID: <CAGXu5jK4VQe75MQuwAx6dxqv3F2nMUxCHGjQpPeuOE3Vq6iVBw@mail.gmail.com>
Message-ID: <CAGXu5jK4VQe75MQuwAx6dxqv3F2nMUxCHGjQpPeuOE3Vq6iVBw@mail.gmail.com>
Subject: Re: [PATCH 3/8] ocfs2: change snprintf to scnprintf for possible overflow
To:     Willy Tarreau <w@1wt.eu>
Cc:     Silvio Cesare <silvio.cesare@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Will Deacon <will.deacon@arm.com>, Greg KH <greg@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2019 at 7:28 AM Willy Tarreau <w@1wt.eu> wrote:
>
> From: Silvio Cesare <silvio.cesare@gmail.com>
>
> Change snprintf to scnprintf. There are generally two cases where using
> snprintf causes problems.
>
> 1) Uses of size += snprintf(buf, SIZE - size, fmt, ...)
> In this case, if snprintf would have written more characters than what the
> buffer size (SIZE) is, then size will end up larger than SIZE. In later
> uses of snprintf, SIZE - size will result in a negative number, leading
> to problems. Note that size might already be too large by using
> size = snprintf before the code reaches a case of size += snprintf.
>
> 2) If size is ultimately used as a length parameter for a copy back to user
> space, then it will potentially allow for a buffer overflow and information
> disclosure when size is greater than SIZE. When the size is used to index
> the buffer directly, we can have memory corruption. This also means when
> size = snprintf... is used, it may also cause problems since size may become
> large.  Copying to userspace is mitigated by the HARDENED_USERCOPY kernel
> configuration.
>
> The solution to these issues is to use scnprintf which returns the number of
> characters actually written to the buffer, so the size variable will never
> exceed SIZE.
>
> Signed-off-by: Silvio Cesare <silvio.cesare@gmail.com>
> Cc: Mark Fasheh <mark@fasheh.com>
> Cc: Joel Becker <jlbec@evilplan.org>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Greg KH <greg@kroah.com>
> Signed-off-by: Willy Tarreau <w@1wt.eu>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

>
> ---
>  fs/ocfs2/cluster/heartbeat.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
> index 9b2ed62dd638..2a0af0887ba0 100644
> --- a/fs/ocfs2/cluster/heartbeat.c
> +++ b/fs/ocfs2/cluster/heartbeat.c
> @@ -1324,7 +1324,7 @@ static int o2hb_debug_open(struct inode *inode, struct file *file)
>
>         case O2HB_DB_TYPE_REGION_NUMBER:
>                 reg = (struct o2hb_region *)db->db_data;
> -               out += snprintf(buf + out, PAGE_SIZE - out, "%d\n",
> +               out += scnprintf(buf + out, PAGE_SIZE - out, "%d\n",
>                                 reg->hr_region_num);
>                 goto done;
>
> @@ -1334,12 +1334,12 @@ static int o2hb_debug_open(struct inode *inode, struct file *file)
>                 /* If 0, it has never been set before */
>                 if (lts)
>                         lts = jiffies_to_msecs(jiffies - lts);
> -               out += snprintf(buf + out, PAGE_SIZE - out, "%lu\n", lts);
> +               out += scnprintf(buf + out, PAGE_SIZE - out, "%lu\n", lts);
>                 goto done;
>
>         case O2HB_DB_TYPE_REGION_PINNED:
>                 reg = (struct o2hb_region *)db->db_data;
> -               out += snprintf(buf + out, PAGE_SIZE - out, "%u\n",
> +               out += scnprintf(buf + out, PAGE_SIZE - out, "%u\n",
>                                 !!reg->hr_item_pinned);
>                 goto done;
>
> @@ -1348,8 +1348,8 @@ static int o2hb_debug_open(struct inode *inode, struct file *file)
>         }
>
>         while ((i = find_next_bit(map, db->db_len, i + 1)) < db->db_len)
> -               out += snprintf(buf + out, PAGE_SIZE - out, "%d ", i);
> -       out += snprintf(buf + out, PAGE_SIZE - out, "\n");
> +               out += scnprintf(buf + out, PAGE_SIZE - out, "%d ", i);
> +       out += scnprintf(buf + out, PAGE_SIZE - out, "\n");
>
>  done:
>         i_size_write(inode, out);
> --
> 2.19.2
>


-- 
Kees Cook
