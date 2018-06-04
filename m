Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751473AbeFDQa4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 12:30:56 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34224 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751093AbeFDQaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 12:30:55 -0400
X-Google-Smtp-Source: ADUXVKLnlzPSRd7ZGKWEP2hXGzSLx2SyFBdz/XzCDFS0LtF2WylgRk7TXRWSYUtE5YnvpDCi1ygNUGMCIX7D3YHkuCw=
MIME-Version: 1.0
In-Reply-To: <CAJX1YtZNdwiwPmj5gGTqURjvLqa5g7Ly_h+TEZfNJSW=mrqRiQ@mail.gmail.com>
References: <20180601183144.17374-1-xiyou.wangcong@gmail.com> <CAJX1YtZNdwiwPmj5gGTqURjvLqa5g7Ly_h+TEZfNJSW=mrqRiQ@mail.gmail.com>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Mon, 4 Jun 2018 09:30:34 -0700
Message-ID: <CAM_iQpV2PJZUQEcXh=TpHRZzLEqGLDAQ1j1_ibPY_kNfbWoAEQ@mail.gmail.com>
Subject: Re: [PATCH] infiniband: fix a possible use-after-free bug
To: Gi-Oh Kim <gi-oh.kim@profitbricks.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Noam Rathaus <noamr@beyondsecurity.com>,
        Sean Hefty <sean.hefty@intel.com>, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 4, 2018 at 9:23 AM, Gi-Oh Kim <gi-oh.kim@profitbricks.com> wrote:
> Hi,
>
> Your patch is reasonable to me.
> Can I ask a question for that?
> Could it be solved by asymmetric locking as following?

Maybe, if you are sure taking file->mut is safe in that place.

Can you double check atomic_inc_not_zero(&mc->ctx->ref)?
I am too far away from familiar with infiniband. ;)
