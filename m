Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753239AbeCEU0m (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 15:26:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:44586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752975AbeCEU0j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 15:26:39 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9C6821770
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh+dt@kernel.org
X-Google-Smtp-Source: AG47ELsQrwQ2wVa/fQaK9Vco0QMgOo7qciQVQtYbja1UY3ZQthjpXUW5ssJa4YIQsjHDWYMY+Uhizhz8Eyd3lkhRHR4=
MIME-Version: 1.0
In-Reply-To: <1520208889-3908-4-git-send-email-frowand.list@gmail.com>
References: <1520208889-3908-1-git-send-email-frowand.list@gmail.com> <1520208889-3908-4-git-send-email-frowand.list@gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Mon, 5 Mar 2018 14:26:17 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+sD=Hj+3cYy0injRSZ5Dj2M6c+KbiFrrwsO_9pqq8wKg@mail.gmail.com>
Message-ID: <CAL_Jsq+sD=Hj+3cYy0injRSZ5Dj2M6c+KbiFrrwsO_9pqq8wKg@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] of: add early boot allocation of
 of_find_node_by_phandle() cache
To: Frank Rowand <frowand.list@gmail.com>
Cc: Chintan Pandya <cpandya@codeaurora.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 4, 2018 at 6:14 PM,  <frowand.list@gmail.com> wrote:
> From: Frank Rowand <frank.rowand@sony.com>
>
> The initial implementation of the of_find_node_by_phandle() cache
> allocates the cache using kcalloc().  Add an early boot allocation
> of the cache so it will be usable during early boot.  Switch over
> to the kcalloc() based cache once normal memory allocation
> becomes available.

Do we get a lot of lookups early? It makes sense to me to do early,
but freeing and repopulating seems to add needless complexity.

Rob
