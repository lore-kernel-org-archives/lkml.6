Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965288AbeEIP4n (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 11:56:43 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34931 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964984AbeEIP4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 11:56:41 -0400
Date: Wed, 9 May 2018 17:56:28 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-mtd@lists.infradead.org,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH 16/18] mtd: rawnand.h: use nested union kernel-doc
 markups
Message-ID: <20180509175628.204fdb71@bbrezillon>
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

Applied.

Thanks,

Boris

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
>   * @force_8bit: force 8-bit access
>   *
>   * Please note that "in" and "out" are inverted from the ONFI specification
> @@ -842,9 +844,13 @@ enum nand_op_instr_type {
>  /**
>   * struct nand_op_instr - Instruction object
>   * @type: the instruction type
> - * @cmd/@addr/@data/@waitrdy: extra data associated to the instruction.
> - *                            You'll have to use the appropriate element
> - *                            depending on @type
> + * @ctx:  extra data associated to the instruction. You'll have to use the
> + *        appropriate element depending on @type
> + * @ctx.cmd: use it if @type is %NAND_OP_CMD_INSTR
> + * @ctx.addr: use it if @type is %NAND_OP_ADDR_INSTR
> + * @ctx.data: use it if @type is %NAND_OP_DATA_IN_INSTR
> + *	      or %NAND_OP_DATA_OUT_INSTR
> + * @ctx.waitrdy: use it if @type is %NAND_OP_WAITRDY_INSTR
>   * @delay_ns: delay the controller should apply after the instruction has been
>   *	      issued on the bus. Most modern controllers have internal timings
>   *	      control logic, and in this case, the controller driver can ignore
> @@ -997,7 +1003,9 @@ struct nand_op_parser_data_constraints {
>   * struct nand_op_parser_pattern_elem - One element of a pattern
>   * @type: the instructuction type
>   * @optional: whether this element of the pattern is optional or mandatory
> - * @addr/@data: address or data constraint (number of cycles or data length)
> + * @ctx: address or data constraint
> + * @ctx.addr: address constraint (number of cycles)
> + * @ctx.data: data constraint (data length)
>   */
>  struct nand_op_parser_pattern_elem {
>  	enum nand_op_instr_type type;
> @@ -1224,6 +1232,8 @@ int nand_op_parser_exec_op(struct nand_chip *chip,
>   *			devices.
>   * @priv:		[OPTIONAL] pointer to private chip data
>   * @manufacturer:	[INTERN] Contains manufacturer information
> + * @manufacturer.desc:	[INTERN] Contains manufacturer's description
> + * @manufacturer.priv:	[INTERN] Contains manufacturer private information
>   */
>  
>  struct nand_chip {
