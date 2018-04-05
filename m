Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753058AbeDEUYe convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 16:24:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:39790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752802AbeDEUYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 16:24:32 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7CD020CAA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180404010931.GA30291@embeddedor.com>
Cc: linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
References: <20180404010931.GA30291@embeddedor.com>
Message-ID: <152295987121.91052.16578276622043986934@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: samsung: s3c: Mark expected switch fall-through
Date: Thu, 05 Apr 2018 13:24:31 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Gustavo A. R. Silva (2018-04-03 18:09:31)
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Notice that in this particular case I replaced the comma wiht a dash,

s/wiht/with/

> which is what GCC is expecting to find when there are other comments
> in the same line in which "fall through" appears.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
> This code was compiled with GCC 7.3.0

What's the GCC warning? Please include in the commit text.

Also what's the implicit-fallthrough level you're using? 3? Can you file
a bug so GCC can update their regex to accept a comma in addition to
whitespace characters?

And maybe we can change the level to 2 or 1 in the kernel's makefile so
we don't need to patch comments for this.
