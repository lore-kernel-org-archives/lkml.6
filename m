Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752969AbeCPQaa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 12:30:30 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:52237 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751607AbeCPQa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 12:30:26 -0400
X-Google-Smtp-Source: AG47ELsl5HOpZvTmKULMHI74rFhJZLC7cni/VMD8oblByUBfkM0WJdO64mWK0AxZCkSG7+4VmaAlP0LXNoN98myGrw0=
MIME-Version: 1.0
In-Reply-To: <1521216991-28706-10-git-send-email-okaya@codeaurora.org>
References: <1521216991-28706-1-git-send-email-okaya@codeaurora.org> <1521216991-28706-10-git-send-email-okaya@codeaurora.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 16 Mar 2018 09:30:24 -0700
Message-ID: <CAKgT0UcKdCpzFgX4qn7EdYnedOsJa9as5g24tfb6qFLXTxZ29A@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH v3 09/18] fm10k: Eliminate duplicate
 barriers on weakly-ordered archs
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Netdev <netdev@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>,
        sulrich@codeaurora.org, linux-arm-msm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 9:16 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
> Code includes wmb() followed by writel(). writel() already has a
> barrier on some architectures like arm64.
>
> This ends up CPU observing two barriers back to back before executing
> the register write.
>
> Since code already has an explicit barrier call, changing writel() to
> writel_relaxed().
>
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>

You can update the writel call in fm10k_tx_map as well.

Of the drivers updated in drivers/net/ethernet/intel/* it looks like
this is the only one that still requires any additional changes.

Thanks.

- Alex
