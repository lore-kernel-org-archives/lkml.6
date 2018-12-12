Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F466C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63C0020849
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vyH/41ES"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63C0020849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbeLLJIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 04:08:24 -0500
Received: from merlin.infradead.org ([205.233.59.134]:55946 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeLLJIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 04:08:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=az6nWIJzub1fG/XLd9mMD/gUtKdjaDzbqD9w/4S8LlQ=; b=vyH/41ESX872uRVptejDH6ffo
        JcZgKMA97Sm09uVJZ5ku/hS3tQdzgSZnwBn1AkwbCf1nXn0B6tMLnqw64fzrHnDdAYzV1EoB2KqwL
        NQnOLK6ZgBO6ezh2Bz4ggFcF+OJ6hYMfNFwJpblgoyChZryFrANL4vedCRtFIcjB6daaoH/ZGfB4m
        lg/8bmOd2AXJPvgSAgVTu+uN4zP+5wvY4Svy29LEM2rLAOXbVq4UqQuz6/XV2qc8DdO8dAwXYiyGV
        rjkkNORrK4Asq17bJ+DzN2LqqAtTex2QuR31wpcd10j0gM26ImIRRG1pOe4SOBf17jfsaGWTR0IU7
        mA8QHPdIg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gX0Ui-0006U2-Cy; Wed, 12 Dec 2018 09:07:58 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 311242075BF39; Wed, 12 Dec 2018 10:07:51 +0100 (CET)
Date:   Wed, 12 Dec 2018 10:07:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Dmitry Safonov <dima@arista.com>, Jiri Slaby <jslaby@suse.cz>,
        kernel test robot <rong.a.chen@intel.com>, lkp@01.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Waiman Long <longman@redhat.com>
Subject: Re: [LKP] [tty] c96cf923a9:
 WARNING:possible_circular_locking_dependency_detected
Message-ID: <20181212090751.GU5289@hirez.programming.kicks-ass.net>
References: <20181211091154.GL23332@shao2-debian>
 <b8a5b151-9eaa-b098-f24f-b17c1886f456@suse.cz>
 <2780774e-b397-dcc2-6950-cccb527d5014@arista.com>
 <20181212034252.GD431@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212034252.GD431@jagdpanzerIV>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 12:42:52PM +0900, Sergey Senozhatsky wrote:
> Something like this (not tested):
> 
> ---
> 
>  drivers/tty/serial/serial_core.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index c439a5a1e6c0..64050f506348 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -268,6 +268,7 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
>  	struct uart_port *uport = uart_port_check(state);
>  	struct tty_port *port = &state->port;
>  	unsigned long flags = 0;
> +	char *xmit_buf = NULL;
>  
>  	/*
>  	 * Set the TTY IO error marker
> @@ -297,15 +298,16 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
>  	 */
>  	tty_port_set_suspended(port, 0);
>  
> +	uart_port_lock(state, flags);
> +	xmit_buf = state->xmit.buf;
> +	state->xmit.buf = NULL;
> +	uart_port_unlock(uport, flags);
> +
>  	/*
>  	 * Free the transmit buffer page.
>  	 */
> -	uart_port_lock(state, flags);
> -	if (state->xmit.buf) {
> -		free_page((unsigned long)state->xmit.buf);
> -		state->xmit.buf = NULL;
> -	}
> -	uart_port_unlock(uport, flags);
> +	if (xmit_buf)
> +		free_page((unsigned long)xmit_buf);
>  }

That looks sensible anyhow. One should strive to not do alloc or free
under locks as much as possible anyway.
