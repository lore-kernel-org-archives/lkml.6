Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751696AbeCOBr1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 21:47:27 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:42012 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751405AbeCOBrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 21:47:25 -0400
X-Google-Smtp-Source: AG47ELtEJC+FNN+xmj5DLjMsdzDiRzWhCwG5PmGNcFzNd7f3AFewgHi3CFV9bZqC0OI3epLBIF5rycVh6hM/QabYLDs=
MIME-Version: 1.0
In-Reply-To: <1520997629-17361-2-git-send-email-okaya@codeaurora.org>
References: <1520997629-17361-1-git-send-email-okaya@codeaurora.org> <1520997629-17361-2-git-send-email-okaya@codeaurora.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 14 Mar 2018 18:47:23 -0700
Message-ID: <CAKgT0Ue=hYC6qRO9Z193JKKvkQtmyaXm3rcy3naxFqTRW0J_8g@mail.gmail.com>
Subject: Re: [PATCH 2/7] ixgbe: eliminate duplicate barriers on weakly-ordered archs
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Netdev <netdev@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>,
        sulrich@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 8:20 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> Code includes wmb() followed by writel() in multiple places. writel()
> already has a barrier on some architectures like arm64.
>
> This ends up CPU observing two barriers back to back before executing the
> register write.
>
> Since code already has an explicit barrier call, changing writel() to
> writel_relaxed().
>
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>

In this patch you missed the writel at the end of ixgbe_tx_map.
