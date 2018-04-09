Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753071AbeDIPRf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 11:17:35 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39918 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753028AbeDIPRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 11:17:33 -0400
X-Google-Smtp-Source: AIpwx4/VKeUwLGxpaNrntRHe2seTetcAw/n1Ya0ncyBDiBGuuf9T4BbO78mxnQhC4Lebh2vDAX3Bpw==
Date: Mon, 9 Apr 2018 17:17:28 +0200
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Finn Thain <fthain@telegraphics.com.au>,
        Laurent Vivier <lvivier@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-m68k <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/12] m68k/mac: Don't remap SWIM MMIO region
Message-ID: <20180409151727.pcvgbfymbr65amy2@ltop.local>
References: <cover.1522546571.git.fthain@telegraphics.com.au>
 <cdba869f704b457bc617007738870b9e1bdef9d3.1522546571.git.fthain@telegraphics.com.au>
 <CAMuHMdUy6C4OoGF44e_34+XjsQHe6RwfoesfBzcM8baEHUwzXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUy6C4OoGF44e_34+XjsQHe6RwfoesfBzcM8baEHUwzXw@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 09, 2018 at 02:54:30PM +0200, Geert Uytterhoeven wrote:
> >
> > -       swim_base = ioremap(res->start, resource_size(res));
> > +       swim_base = (struct swim __iomem *)res->start;
> 
> I guess you need a __force to please sparse?

Hi,

Only pointer-to-pointer conversions may need __force.
The logic being if you use an integer type to hold an address
this address is typeless anyway and has no address-space, so
extra checking is not done in this case and the cast in itself
is enough.

Cheers,
-- Luc
