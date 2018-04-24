Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753251AbeDXJEG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 05:04:06 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:39637 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753084AbeDXJED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 05:04:03 -0400
X-Google-Smtp-Source: AIpwx4/CmlDkJLmfHPADS/cco1uyfxxD1YRVw70Az6mkI7BBMsFZR1+KXJ1ZhTvtIC0GSfxhIifKxZBBLz29gonFSNw=
MIME-Version: 1.0
In-Reply-To: <9b8c9c6134cb27ee8ac37224098e382ab9189d62.1524556744.git.arvind.yadav.cs@gmail.com>
References: <9b8c9c6134cb27ee8ac37224098e382ab9189d62.1524556744.git.arvind.yadav.cs@gmail.com>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Tue, 24 Apr 2018 11:04:02 +0200
Message-ID: <CAO-hwJ+cM2nPPiQbHM=u2E0vzvdztR9CFtQD5xztLw8QPOBPbA@mail.gmail.com>
Subject: Re: [PATCH] HID: wacom: Release device resource data obtained by devres_alloc()
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, jkosina@suse.cz,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 10:03 AM, Arvind Yadav
<arvind.yadav.cs@gmail.com> wrote:
> Free device resource data, if __wacom_devm_sysfs_create_group
> is not successful.
>
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---

Looks good to me:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>  drivers/hid/wacom_sys.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index b54ef1f..ee7a37e 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -1213,8 +1213,10 @@ static int __wacom_devm_sysfs_create_group(struct wacom *wacom,
>         devres->root = root;
>
>         error = sysfs_create_group(devres->root, group);
> -       if (error)
> +       if (error) {
> +               devres_free(devres);
>                 return error;
> +       }
>
>         devres_add(&wacom->hdev->dev, devres);
>
> --
> 1.9.1
>
