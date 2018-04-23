Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754643AbeDWK2t (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 06:28:49 -0400
Received: from mail-ot0-f180.google.com ([74.125.82.180]:38194 "EHLO
        mail-ot0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754393AbeDWK2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 06:28:44 -0400
X-Google-Smtp-Source: AB8JxZqTsZcAr1KhbCYhE9Fu8Br+bAx3QYyVgOamx924M6AeCSfPvLMRbaKhi4wFoJc58nRB3wijTWIMWJegT/QKBwo=
MIME-Version: 1.0
X-Originating-IP: [176.63.54.97]
In-Reply-To: <CAJfpegt_i78O_sswFucHf8ZhD8BPkLVXAWFdxE6YkvU6v=SyTw@mail.gmail.com>
References: <20180412150826.20988-1-mszeredi@redhat.com> <20180412150826.20988-17-mszeredi@redhat.com>
 <CAOQ4uxhw+B_BqMjojSSrvnCYOLgc7J1TR_eOvPkfo=Gb0vcW8Q@mail.gmail.com>
 <CAOQ4uxhzsV=9PaJF3uPpMMrkKAmysFuOqmPzjhRCzmWjNC8S+w@mail.gmail.com> <CAJfpegt_i78O_sswFucHf8ZhD8BPkLVXAWFdxE6YkvU6v=SyTw@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 23 Apr 2018 12:28:43 +0200
Message-ID: <CAJfpegsBD8xt2-rPGJpsMJ3joFfUzcQerhneLSKAFk7Tfbe+3A@mail.gmail.com>
Subject: Re: [RFC PATCH 16/35] ovl: readd lsattr/chattr support
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 12:21 PM, Miklos Szeredi <miklos@szeredi.hu> wrote:

> We could fix it to use file_inode()->i_sb instead of
> f_path.dentry->d_sb after reverting the overlay specific hack, and
> that would fix the freeze bypass bug and would be correct for all
> filesystems.   But I wonder how many such issues we have where
> discrepancy between f_path.dentry and file_inode() matters.

OTOH, any such issues should already have surfaced.  Just need to be
careful when reverting VFS patches that they don't regress in the face
of f_path containing the overlay path.

So we are probably better to keep using overlay path in real file
universally, just to keep the code simpler.

Thanks,
Miklos
