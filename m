Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751254AbeFDRkl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 13:40:41 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:37361 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751015AbeFDRki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 13:40:38 -0400
X-Google-Smtp-Source: ADUXVKJzFRp6+OMHGP+xxd39YOHjY2rA2uLG0IeyeiBZ/mdXFC96R4CNzYVHx0aiktPOkYqjaUbXNg==
Subject: Re: [PATCH 4/8] serial: 8250: Handle case port doesn't have TEMT
 interrupt using em485.
To: Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Matthias Brugger <mbrugger@suse.com>,
        Allen Pais <allen.lkml@gmail.com>, Sean Young <sean@mess.org>,
        Ed Blake <ed.blake@sondrel.com>,
        Stefan Potyra <Stefan.Potyra@elektrobit.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Joshua Scott <joshua.scott@alliedtelesis.co.nz>,
        Vignesh R <vigneshr@ti.com>,
        Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>,
        Aaron Sierra <asierra@xes-inc.com>,
        Rafael Gago <rafael.gago@gmail.com>, Joel Stanley <joel@jms.id.au>,
        Sean Wang <sean.wang@mediatek.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Newsgroups: gmane.linux.kernel,gmane.linux.serial
References: <20180601124021.102970-1-giulio.benetti@micronovasrl.com>
 <20180601124021.102970-5-giulio.benetti@micronovasrl.com>
From: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matwey.kornilov@gmail.com; keydata=
 xsBNBFqzfRUBCACb5yTIRtEkXBVptbSuDzrxxTo7aN2YrxjQBbCAP3rxJtOYLh0pvx7Q6jdc
 hax0oiDsLIDXRpOonAq3jhdeXogw3PAi82S4srSToSiWY+9/Cj5mxGjAEhkPyXAfCQgI9rT5
 FW5jPXrDsspXxqRv1vtCfxr0lZ47sYT1osy5j24prhNiSyv/NAs9YuV7BN7gvyTO+h6/LQw9
 EzCXA8KlbbETGptTw3oN6pudmXO615FIsbizP74B4Z9CWu5FjhGBANphZSPajxLi4jEOIQ9o
 QS7MOmHnkXpntszp25H8FuEcAAFJ78KtyIWEirTlTNB4HRREn6rkwmRafx2jhkw4lhClABEB
 AAHNLk1hdHdleSBWLiBLb3JuaWxvdiA8bWF0d2V5Lmtvcm5pbG92QGdtYWlsLmNvbT7CwHkE
 EwECACMFAlqzfRUCGwMHCwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRAC/Q9fWLJKf1Kj
 B/9YCEJv2Oz8oMhS/iu7tnnXKk9fcWW5PbQLDUDlT2NNa0pafjBYzj0//ld8xeBHaCD/pIfz
 q+z7D3fkp73bjevwgIIASUtE7ZEi6Sr0Pk+XB6llhQhKfL2Vm8txV+0p88Bo7khomcwddJJF
 mk9UQyu/WVu56fNFm+CDlvCQZmrsJDZ3v6PPhBTFHaOmbNrvGsTSgIX+Nt0TrPb1rtlezaTD
 E1GM9ztayUg3X+f5fiZW70J3RbIP+xMfvKF+51kdVieffqeZYgdH7KdEyNXU6WID6JN3Ti1x
 0JcDV597WCmdSDN0zhIwPZa73yTsI7Zq4BPSG8NTfJnr1Ypdak4PAw4vzsBNBFqzfRUBCACG
 gOhHWz8xxyzhkQp2HbU6BktCnex4LzObNaWONm3ENFPcmZfzL8LXDXf9kGhFL/TzbhEZQZlj
 w1H1+zjujk5Y/N6RWR8+lkQ/d9sOVMaaq+MbvwXSDAKfQEsi0od4H9TR+0V9tIu25OaQhyyF
 CKfSV6HsCyAjVGUAzasM/PfqsDiKDExLUbjAtO2ftdm34N4ScFaTJvzlxC8Wr2y2ZX1KDso5
 S139k1K5UQCQhUPFQ5D6w62hEfa4qJ1B64wRR/vKiiiTdzf50iWkJBeZh9czYY73e49lHCS/
 yBtloH1W82WC1/6bnqLolT6MSBjgM3IdfCwdrRXOg0IXoO4Jkwx9ABEBAAHCwF8EGAECAAkF
 AlqzfRUCGwwACgkQAv0PX1iySn+4fgf9G7TB3GcXENoTytwVB1psKZlkA5mPm1iIs71KfK67
 lrpKXnR/7A87tcTs49N7VUjlNfqvcPaZashiiko1Vh1CVtBEKykv0b9iaZNW66uRrsx1kd7U
 +PLO8FImUblQR5T8oVYDwgTIW40AHzEGUZ1kgksgtgkuKvODzqmeaP+QCzxWBztJizpzI64G
 31rhouGWVDqUB7OJBEXmctUJqtipgxvjHEokfSVo5shXbe8o4ozTQWRJDG+yUCEzXZKDWW6i
 LLVcVbHlLXbt5ulFafMG6oyIzF1RL62UL71rO8DbfFVfuYW9rKU4NFobuwXEkVtKykSZ//Wo
 iVEx2OEW32jH2g==
Message-ID: <b14d4970-f14d-d59f-2072-b7d5704dd842@gmail.com>
Date: Mon, 4 Jun 2018 20:40:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180601124021.102970-5-giulio.benetti@micronovasrl.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

01.06.2018 15:40, Giulio Benetti пишет:
> Some 8250 ports only have TEMT interrupt, so current implementation
> can't work for ports without it. The only chance to make it work is to
> loop-read on LSR register.
> 
> With NO TEMT interrupt check if both TEMT and THRE are set looping on
> LSR register.
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> ---
>  drivers/tty/serial/8250/8250.h      |  2 +-
>  drivers/tty/serial/8250/8250_dw.c   |  2 +-
>  drivers/tty/serial/8250/8250_omap.c |  2 +-
>  drivers/tty/serial/8250/8250_port.c | 26 ++++++++++++++++++--------
>  include/linux/serial_8250.h         |  1 +
>  5 files changed, 22 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
> index ebfb0bd5bef5..5c6ae5f69432 100644
> --- a/drivers/tty/serial/8250/8250.h
> +++ b/drivers/tty/serial/8250/8250.h
> @@ -136,7 +136,7 @@ void serial8250_rpm_put(struct uart_8250_port *p);
>  void serial8250_rpm_get_tx(struct uart_8250_port *p);
>  void serial8250_rpm_put_tx(struct uart_8250_port *p);
>  
> -int serial8250_em485_init(struct uart_8250_port *p);
> +int serial8250_em485_init(struct uart_8250_port *p, bool has_temt_isr);
>  void serial8250_em485_destroy(struct uart_8250_port *p);
>  
>  static inline void serial8250_out_MCR(struct uart_8250_port *up, int value)
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index 0f8b4da03d4e..888280ff5451 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -330,7 +330,7 @@ static int dw8250_rs485_config(struct uart_port *p,
>  	 * are idempotent
>  	 */
>  	if (rs485->flags & SER_RS485_ENABLED) {
> -		int ret = serial8250_em485_init(up);
> +		int ret = serial8250_em485_init(up, false);
>  
>  		if (ret) {
>  			rs485->flags &= ~SER_RS485_ENABLED;
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> index 624b501fd253..ab483c8b30c8 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -725,7 +725,7 @@ static int omap_8250_rs485_config(struct uart_port *port,
>  	 * are idempotent
>  	 */
>  	if (rs485->flags & SER_RS485_ENABLED) {
> -		int ret = serial8250_em485_init(up);
> +		int ret = serial8250_em485_init(up, true);
>  
>  		if (ret) {
>  			rs485->flags &= ~SER_RS485_ENABLED;
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 95833cbc4338..e14badbbf181 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -599,15 +599,16 @@ EXPORT_SYMBOL_GPL(serial8250_rpm_put);
>  /**
>   *	serial8250_em485_init() - put uart_8250_port into rs485 emulating
>   *	@p:	uart_8250_port port instance
> + *	@p:	bool specify if 8250 port has TEMT interrupt or not
>   *
>   *	The function is used to start rs485 software emulating on the
>   *	&struct uart_8250_port* @p. Namely, RTS is switched before/after
>   *	transmission. The function is idempotent, so it is safe to call it
>   *	multiple times.
>   *
> - *	The caller MUST enable interrupt on empty shift register before
> - *	calling serial8250_em485_init(). This interrupt is not a part of
> - *	8250 standard, but implementation defined.
> + *	If has_temt_isr is passed as true, the caller MUST enable interrupt
> + *	on empty shift register before calling serial8250_em485_init().
> + *	This interrupt is not a part of	8250 standard, but implementation defined.
>   *
>   *	The function is supposed to be called from .rs485_config callback
>   *	or from any other callback protected with p->port.lock spinlock.
> @@ -616,7 +617,7 @@ EXPORT_SYMBOL_GPL(serial8250_rpm_put);
>   *
>   *	Return 0 - success, -errno - otherwise
>   */
> -int serial8250_em485_init(struct uart_8250_port *p)
> +int serial8250_em485_init(struct uart_8250_port *p, bool has_temt_isr)
>  {
>  	if (p->em485)
>  		return 0;
> @@ -633,6 +634,7 @@ int serial8250_em485_init(struct uart_8250_port *p)
>  	p->em485->start_tx_timer.function = &serial8250_em485_handle_start_tx;
>  	p->em485->port = p;
>  	p->em485->active_timer = NULL;
> +	p->em485->has_temt_isr = has_temt_isr;
>  	serial8250_em485_rts_after_send(p);
>  
>  	return 0;
> @@ -1517,11 +1519,19 @@ static inline void __stop_tx(struct uart_8250_port *p)
>  		/*
>  		 * To provide required timeing and allow FIFO transfer,
>  		 * __stop_tx_rs485() must be called only when both FIFO and
> -		 * shift register are empty. It is for device driver to enable
> -		 * interrupt on TEMT.
> +		 * shift register are empty. If 8250 port supports it,
> +		 * it is for device driver to enable interrupt on TEMT.
> +		 * Otherwise must loop-read until TEMT and THRE flags are set.
>  		 */
> -		if ((lsr & BOTH_EMPTY) != BOTH_EMPTY)
> -			return;
> +		if (em485->has_temt_isr) {
> +			if ((lsr & BOTH_EMPTY) != BOTH_EMPTY)
> +				return;
> +		} else {
> +			while ((lsr & BOTH_EMPTY) != BOTH_EMPTY) {
> +				lsr = serial_in(p, UART_LSR);
> +				cpu_relax();
> +			}

What happens if TEMP never be empty after interruption occurring?

> +		}
>  
>  		em485->active_timer = NULL;
>  
> diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
> index a27ef5f56431..9b13cf59726b 100644
> --- a/include/linux/serial_8250.h
> +++ b/include/linux/serial_8250.h
> @@ -83,6 +83,7 @@ struct uart_8250_em485 {
>  	struct hrtimer		start_tx_timer; /* "rs485 start tx" timer */
>  	struct hrtimer		stop_tx_timer;  /* "rs485 stop tx" timer */
>  	struct hrtimer		*active_timer;  /* pointer to active timer */
> +	bool			has_temt_isr;	/* say if 8250 has TEMT interrupt or no */
>  	struct uart_8250_port	*port;          /* for hrtimer callbacks */
>  };
>  
> 
