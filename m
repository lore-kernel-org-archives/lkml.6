Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751568AbeFCPMm (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 11:12:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:50744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751373AbeFCPMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 11:12:40 -0400
Date: Sun, 3 Jun 2018 16:12:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: Colin King <colin.king@canonical.com>,
        Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] iio: tsl2x7x/tsl2772: avoid potential division by
 zero
Message-ID: <20180603161234.008ac6c5@archlinux>
In-Reply-To: <20180531092801.bsmqujkfnge3xhpo@0dcddc0a723b>
References: <20180530181936.17902-1-colin.king@canonical.com>
        <20180531092801.bsmqujkfnge3xhpo@0dcddc0a723b>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 May 2018 05:28:01 -0400
Brian Masney <masneyb@onstation.org> wrote:

> On Wed, May 30, 2018 at 07:19:36PM +0100, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > It may be possible for tsl2772_get_lux to return a zero lux value
> > and hence a division by zero can occur when lux_val is zero. Check
> > for this case and return -ERANGE to avoid the division by zero.
> > 
> > Detected by CoverityScan, CID#1469484 ("Division or modulo by zero")
> > 
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>  
> 
> Acked-by: Brian Masney <masneyb@onstation.org>

Applied to the fixes-togreg branch of iio.git.

As there was nothing in that branch that is going upstream until after
the merge window closes, I moved it forward to match staging/staging-next.

Jonathan
