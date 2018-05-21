Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932310AbeEUVj7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 17:39:59 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:43563 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754376AbeEUVjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 17:39:55 -0400
X-Google-Smtp-Source: AB8JxZpQo74sHa7BT0zLjtdOPBeKqfzE5HgV7LjqDfXoXHbRRMLeAgycQ3SfxzegKJ8+tJoLfGNDmQiC56OfOONFrxc=
MIME-Version: 1.0
In-Reply-To: <1526903890-35761-6-git-send-email-xieyisheng1@huawei.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com> <1526903890-35761-6-git-send-email-xieyisheng1@huawei.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 22 May 2018 00:39:54 +0300
Message-ID: <CAHp75Vcpfeey_womFqoqp_gyy0=jqMHgW+30WJs-BcVTM-vHQA@mail.gmail.com>
Subject: Re: [PATCH 05/33] cxgb4: use match_string() helper
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ganesh Goudar <ganeshgr@chelsio.com>, netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 2:57 PM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
> match_string() returns the index of an array for a matching string,
> which can be used intead of open coded variant.

> -       for (i = 0; i < ARRAY_SIZE(cudbg_region); i++) {
> -               if (!strcmp(cudbg_region[i], region_name)) {
> -                       found = 1;
> -                       idx = i;
> -                       break;
> -               }
> -       }
> -       if (!found)
> -               return -EINVAL;
> +       rc = match_string(cudbg_region, ARRAY_SIZE(cudbg_region), region_name);
> +       if (rc < 0)
> +               return rc;
>
> -       found = 0;
> +       idx = rc;

Is found still in use after this?
If so, is it initialized properly now?

-- 
With Best Regards,
Andy Shevchenko
