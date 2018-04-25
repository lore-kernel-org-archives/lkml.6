Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751559AbeDYKAC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 06:00:02 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37651 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751412AbeDYJ77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 05:59:59 -0400
X-Google-Smtp-Source: AB8JxZr7YrmUZEqflGX2NN1z36gWv0uTcQJ6mgUzr8/DwaVO4GdTrVUKdKqSHorHxiHOjKDsxcOI3g==
Message-ID: <1524650396.4026.55.camel@baylibre.com>
Subject: Re: [PATCH 1/2] clk: honor CLK_MUX_ROUND_CLOSEST in generic clk mux
From: Jerome Brunet <jbrunet@baylibre.com>
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc: Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
Date: Wed, 25 Apr 2018 11:59:56 +0200
In-Reply-To: <CAAEAJfDgGYu9WR5+qA-trQUTkb--bam=LLbhH+1N2OdrtBGLzA@mail.gmail.com>
References: <20180409135921.5617-1-jbrunet@baylibre.com>
         <20180409135921.5617-2-jbrunet@baylibre.com>
         <CAAEAJfDgGYu9WR5+qA-trQUTkb--bam=LLbhH+1N2OdrtBGLzA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-04-24 at 11:04 -0300, Ezequiel Garcia wrote:
> >   }
> > +EXPORT_SYMBOL_GPL(clk_mux_determine_rate_flags);
> > 
> 
> Why do we need to export this?

Because any driver implementing some type of mux may use this function, and the
driver could be a module. I have one in the pipe right now.

It is the same as __clk_determine_rate(), __clk_mux_determine_rate_closest()
