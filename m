Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751317AbeEVHQy convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 03:16:54 -0400
Received: from mail.bootlin.com ([62.4.15.54]:44573 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751069AbeEVHQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 03:16:50 -0400
Date: Tue, 22 May 2018 09:16:47 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Abhishek Sahu <absahu@codeaurora.org>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Andy Gross <andy.gross@linaro.org>,
        Archit Taneja <architt@codeaurora.org>
Subject: Re: [PATCH v2 07/14] mtd: rawnand: qcom: fix null pointer access
 for erased page detection
Message-ID: <20180522091647.74884137@xps13>
In-Reply-To: <1525350041-22995-8-git-send-email-absahu@codeaurora.org>
References: <1525350041-22995-1-git-send-email-absahu@codeaurora.org>
        <1525350041-22995-8-git-send-email-absahu@codeaurora.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abhishek,

On Thu,  3 May 2018 17:50:34 +0530, Abhishek Sahu
<absahu@codeaurora.org> wrote:

> parse_read_errors can be called with only oob_buf in which case
> data_buf will be NULL.  If data_buf is NULL, then don’t
> treat this page as completely erased in case of ECC uncorrectable
> error for RS ECC. For BCH ECC, the controller itself tells
> regarding erased page in status register.
> 
> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
> ---
> * Changes from v1:
> 
>   1. Added more detail in commit message
>   2. Added comment before each if/else

Again, thanks for that.

> 
>  drivers/mtd/nand/raw/qcom_nandc.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>



-- 
Miquel Raynal, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
