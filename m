Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751962AbeEGJqy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 05:46:54 -0400
Received: from mail.bootlin.com ([62.4.15.54]:47651 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751147AbeEGJqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 05:46:53 -0400
Date: Mon, 7 May 2018 11:46:50 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>, linux-mtd@lists.infradead.org
Subject: Re: [PATCH 16/18] mtd: rawnand.h: use nested union kernel-doc
 markups
Message-ID: <20180507114650.171edcc2@bbrezillon>
In-Reply-To: <39d8d4f0e0ff5a06be0303f7f4f2eac5fb45b9ca.1525684985.git.mchehab+samsung@kernel.org>
References: <cover.1525684985.git.mchehab+samsung@kernel.org>
        <39d8d4f0e0ff5a06be0303f7f4f2eac5fb45b9ca.1525684985.git.mchehab+samsung@kernel.org>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

On Mon,  7 May 2018 06:35:52 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:

> Gets rid of those warnings and better document the parameters.
> 
>   ./include/linux/mtd/rawnand.h:752: warning: Function parameter or member 'timings.sdr' not described in 'nand_data_interface'
>   ./include/linux/mtd/rawnand.h:817: warning: Function parameter or member 'buf' not described in 'nand_op_data_instr'
>   ./include/linux/mtd/rawnand.h:817: warning: Function parameter or member 'buf.in' not described in 'nand_op_data_instr'
>   ./include/linux/mtd/rawnand.h:817: warning: Function parameter or member 'buf.out' not described in 'nand_op_data_instr'
>   ./include/linux/mtd/rawnand.h:863: warning: Function parameter or member 'ctx' not described in 'nand_op_instr'
>   ./include/linux/mtd/rawnand.h:863: warning: Function parameter or member 'ctx.cmd' not described in 'nand_op_instr'
>   ./include/linux/mtd/rawnand.h:863: warning: Function parameter or member 'ctx.addr' not described in 'nand_op_instr'
>   ./include/linux/mtd/rawnand.h:863: warning: Function parameter or member 'ctx.data' not described in 'nand_op_instr'
>   ./include/linux/mtd/rawnand.h:863: warning: Function parameter or member 'ctx.waitrdy' not described in 'nand_op_instr'
>   ./include/linux/mtd/rawnand.h:1010: warning: Function parameter or member 'ctx' not described in 'nand_op_parser_pattern_elem'
>   ./include/linux/mtd/rawnand.h:1010: warning: Function parameter or member 'ctx.addr' not described in 'nand_op_parser_pattern_elem'
>   ./include/linux/mtd/rawnand.h:1010: warning: Function parameter or member 'ctx.data' not described in 'nand_op_parser_pattern_elem'
>   ./include/linux/mtd/rawnand.h:1313: warning: Function parameter or member 'manufacturer.desc' not described in 'nand_chip'
>   ./include/linux/mtd/rawnand.h:1313: warning: Function parameter or member 'manufacturer.priv' not described in 'nand_chip'
> 
>   ./include/linux/mtd/rawnand.h:848: WARNING: Unexpected indentation.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  include/linux/mtd/rawnand.h | 26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
> index 5dad59b31244..b986f94906df 100644
> --- a/include/linux/mtd/rawnand.h
> +++ b/include/linux/mtd/rawnand.h
> @@ -740,8 +740,9 @@ enum nand_data_interface_type {
>  
>  /**
>   * struct nand_data_interface - NAND interface timing
> - * @type:	type of the timing
> - * @timings:	The timing, type according to @type
> + * @type:	 type of the timing
> + * @timings:	 The timing, type according to @type
> + * @timings.sdr: Use it when @type is %NAND_SDR_IFACE.

Hm, really feels weird to do that. I mean, either we describe
timings.sdr or timings, but not both. I this case, I agree that
describing timings.sdr would make more sense than generically
describing any possible entries in the timings union. Is there a simple
way we can get rid of the warning we have when not describing timings
but all of its fields?

>   */
>  struct nand_data_interface {
>  	enum nand_data_interface_type type;
> @@ -798,8 +799,9 @@ struct nand_op_addr_instr {
>  /**
>   * struct nand_op_data_instr - Definition of a data instruction
>   * @len: number of data bytes to move
> - * @in: buffer to fill when reading from the NAND chip
> - * @out: buffer to read from when writing to the NAND chip
> + * @buf: buffer to fill
> + * @buf.in: buffer to fill when reading from the NAND chip
> + * @buf.out: buffer to read from when writing to the NAND chip

Same here. What we care about is @buf.in and @buf.out, the @buf
description is useless...

Regards,

Boris
