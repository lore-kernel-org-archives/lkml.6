Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752106AbeCYUYP (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 16:24:15 -0400
Received: from mail-ot0-f169.google.com ([74.125.82.169]:33226 "EHLO
        mail-ot0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751899AbeCYUYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 16:24:13 -0400
X-Google-Smtp-Source: AIpwx48CaD5fF012IXPJsQTg2KzpUrNCWAKFQORCQ0/oLrlhPlL/SjVGtcq5DKFsBHTK04aHyJBOnYMrGU3+nckKkh0=
MIME-Version: 1.0
In-Reply-To: <1521988761-30344-7-git-send-email-okaya@codeaurora.org>
References: <1521988761-30344-1-git-send-email-okaya@codeaurora.org> <1521988761-30344-7-git-send-email-okaya@codeaurora.org>
From: Michael Chan <michael.chan@broadcom.com>
Date: Sun, 25 Mar 2018 13:24:12 -0700
Message-ID: <CACKFLinfo5xieJB_bgwXQhCCySZcGFpG2daqNcpX3gjgDKMdFA@mail.gmail.com>
Subject: Re: [PATCH v7 6/7] bnxt_en: Eliminate duplicate barriers on
 weakly-ordered archs
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Netdev <netdev@vger.kernel.org>, timur@codeaurora.org,
        sulrich@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 25, 2018 at 7:39 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
> Code includes wmb() followed by writel(). writel() already has a barrier on
> some architectures like arm64.
>
> This ends up CPU observing two barriers back to back before executing the
> register write.
>
> Create a new wrapper function with relaxed write operator. Use the new
> wrapper when a write is following a wmb().
>
> Since code already has an explicit barrier call, changing writel() to
> writel_relaxed().
>
> Also add mmiowb() so that write code doesn't move outside of scope.

This line in the patch description is not needed anymore.  Other than that,

Acked-by: Michael Chan <michael.chan@broadcom.com>

Thanks.
>
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
