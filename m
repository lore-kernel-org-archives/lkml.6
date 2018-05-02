Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751116AbeEBCeF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 22:34:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:41816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750911AbeEBCeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 22:34:03 -0400
X-Google-Smtp-Source: AB8JxZogcrqDH8XFt+bIjFcDov/+SONACAHjVx3HiMglQri73iJiN+RGqtvaHFF16uCLNNcRFTJl2gqG+nKKCZGRYqU=
MIME-Version: 1.0
In-Reply-To: <20180316213306.20424-1-robh@kernel.org>
References: <20180316213306.20424-1-robh@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Tue, 1 May 2018 21:33:41 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLUJYfFNR08-UdyQcggesOhafd6WG4uavqP9kY3f0YSZg@mail.gmail.com>
Message-ID: <CAL_JsqLUJYfFNR08-UdyQcggesOhafd6WG4uavqP9kY3f0YSZg@mail.gmail.com>
Subject: Re: [PATCH] h8300: switch to NO_BOOTMEM
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: "moderated list:H8/300 ARCHITECTURE"
        <uclinux-h8-devel@lists.sourceforge.jp>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 4:33 PM, Rob Herring <robh@kernel.org> wrote:
> Commit 0fa1c579349f ("of/fdt: use memblock_virt_alloc for early alloc")
> inadvertently switched the DT unflattening allocations from memblock to
> bootmem which doesn't work because the unflattening happens before
> bootmem is initialized. Swapping the order of bootmem init and
> unflattening could also fix this, but removing bootmem is desired. So
> enable NO_BOOTMEM on h8300 like other architectures have done.
>
> Fixes: 0fa1c579349f ("of/fdt: use memblock_virt_alloc for early alloc")
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: uclinux-h8-devel@lists.sourceforge.jp
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> I haven't seen any reports, but 4.16 is likely broken. This is compile
> tested only.
>
> Moving unflattening after bootmem_init should also work if a smaller
> change for 4.16 is desired.

Ping! Someone going to pick this up?

Rob
