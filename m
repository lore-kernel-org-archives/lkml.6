Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932067AbeDZNZ4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 09:25:56 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:38042 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755074AbeDZNZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 09:25:55 -0400
X-Google-Smtp-Source: AIpwx4/iqrph42Oa1sUbcaVF3w36v8Q7j/sdwhggB5gOdF/Vg+4qCUuyy3yFz4nKwY8hjvbQKHhPRdzs0kJAfu7EVpY=
MIME-Version: 1.0
X-Originating-IP: [176.63.54.97]
In-Reply-To: <20180423172135.4050588-2-songliubraving@fb.com>
References: <20180423172135.4050588-1-songliubraving@fb.com> <20180423172135.4050588-2-songliubraving@fb.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 26 Apr 2018 15:25:53 +0200
Message-ID: <CAJfpegvp7dGpwrq0Zj2gQnnxsADfFvvFcrjcB82jT1p+8dqKaw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] tracing: remove igrab() iput() call from uprobes.c
To: Song Liu <songliubraving@fb.com>
Cc: linux-kernel@vger.kernel.org, kernel-team <kernel-team@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        Howard McLauchlan <hmclauchlan@fb.com>, Josef Bacik <jbacik@fb.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 7:21 PM, Song Liu <songliubraving@fb.com> wrote:
> Caller of uprobe_register is required to keep the inode and containing
> mount point referenced.
>
> There was misuse of igrab() in uprobes.c and trace_uprobe.c. This is
> because igrab() will not prevent umount of the containing mount point.
> To fix this, we added path to struct trace_uprobe, which keeps the inode
> and containing mount reference.
>
> For uprobes.c, it is not necessary to call igrab() in uprobe_register(),
> as the caller is required to keep the inode reference. The igrab() is
> removed and comments on this requirement is added to uprobe_register().
>
> Link: http://lkml.kernel.org/r/CAELBmZB2XX=qEOLAdvGG4cPx4GEntcSnWQquJLUK1ongRj35cA@mail.gmail.com
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Howard McLauchlan <hmclauchlan@fb.com>
> Cc: Josef Bacik <jbacik@fb.com>
> Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Signed-off-by: Song Liu <songliubraving@fb.com>

Acked-by: Miklos Szeredi <mszeredi@redhat.com>
