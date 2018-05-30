Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968641AbeE3CCc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 22:02:32 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:40841 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968600AbeE3CCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 22:02:30 -0400
X-Google-Smtp-Source: ADUXVKJiTwn4+cbUPzVkYOWJCN4tnkZgWdIqjaJxlyGByzgz0rh9Rxax1HolGLrgYhRJnQy8fU6zyAFUAP7+vizRjCs=
MIME-Version: 1.0
In-Reply-To: <20180529081117.GA1416@lst.de>
References: <1527576558-26817-1-git-send-email-nick.desaulniers@gmail.com> <20180529081117.GA1416@lst.de>
From: Nick Desaulniers <nick.desaulniers@gmail.com>
Date: Tue, 29 May 2018 19:02:29 -0700
Message-ID: <CAH7mPvgC7WE-JFUk3aV4_Cex9vm9PO9wRa7gM8-=YdUp5uOv4Q@mail.gmail.com>
Subject: Re: [PATCH] nvme: prefer strlcpy to strncpy
To: Christoph Hellwig <hch@lst.de>
Cc: keith.busch@intel.com, axboe@fb.com, sagi@grimberg.me,
        linux-nvme@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ebiggers@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 1:11 AM, Christoph Hellwig <hch@lst.de> wrote:
> On Mon, May 28, 2018 at 11:49:18PM -0700, Nick Desaulniers wrote:
>> Fixes a stringop-truncation warning from gcc-8.
>
> What would that warning be?  Maybe it actually is genuinly useful,
> and switching to strlcpy just papers over it..

Eric also pointed out to me that strlcpy will not initialize the rest
of dest with zeros if size is less than the length of src.
