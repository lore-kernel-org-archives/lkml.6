Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JqFpQTJ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E2D9C601A8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933068AbeFFQeX (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 12:34:23 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:42954 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932514AbeFFQeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 12:34:20 -0400
X-Google-Smtp-Source: ADUXVKK0wOyi3d8FvzQhT+F3hCEENEuwICCOPrszgpE7RajXx9LKw4HSolw65uA96E/yo9Ccrz00fvJDR0XGC3xJXRU=
MIME-Version: 1.0
In-Reply-To: <1528293206-24298-1-git-send-email-nmanthey@amazon.de>
References: <1528293127-23825-1-git-send-email-nmanthey@amazon.de> <1528293206-24298-1-git-send-email-nmanthey@amazon.de>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 6 Jun 2018 12:33:39 -0400
Message-ID: <CAF=yD-JCtvVpdxwrncFurc_-OO_VtELjkxBLh=1Gk3jTnOQmug@mail.gmail.com>
Subject: Re: [less-CONFIG_NET 1/7] net: reorder filter code
To: Norbert Manthey <nmanthey@amazon.de>
Cc: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 6, 2018 at 9:53 AM, Norbert Manthey <nmanthey@amazon.de> wrote:
> This commit reorders the definition of functions and struct in the
> file filter.c, such that in the next step we can easily cut the file
> into a commonly used part, as well as a part that is only required in
> case CONFIG_NET is actually set.
>
> This is part of the effort to split CONFIG_SECCOMP_FILTER and
> CONFIG_NET.
>
> Signed-off-by: Norbert Manthey <nmanthey@amazon.de>

Reordering patches like this and the flow-dissector patch in this
series make cherry-picking fixes back to stable branches and
and following code history with git blame harder.
