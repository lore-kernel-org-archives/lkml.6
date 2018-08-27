Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94955C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 06:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4916720891
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 06:25:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4916720891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbeH0KKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 06:10:38 -0400
Received: from mout.web.de ([212.227.15.4]:57485 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726776AbeH0KKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 06:10:37 -0400
Received: from [192.168.1.10] ([95.157.57.47]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MMWA2-1g1J2P244c-008IWQ; Mon, 27
 Aug 2018 08:25:11 +0200
Subject: Re: [PATCH] serial: mvebu-uart: Fix reporting of effective CSIZE to
 userspace
From:   Jan Kiszka <jan.kiszka@web.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        linux-serial <linux-serial@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Allen Yan <yanwei@marvell.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Marc Zyngier <marc.zyngier@arm.com>
References: <69ad54af-8732-b78a-7e0b-482bfcd6d25f@web.de>
Message-ID: <211be85e-8ec1-541f-0d3a-9846079f068f@web.de>
Date:   Mon, 27 Aug 2018 08:25:07 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <69ad54af-8732-b78a-7e0b-482bfcd6d25f@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:P7DNnD3LSAe4R5WEODPgNgQ7kA0YLP6Xvu/hZG9T0ue+E3x1yE7
 oyXrNGM6jmAAB2Dj4WHNzsbwDKpqNhm/UyPTK953Scfjzww1E7t/p9QLK7LYXPkIMewQ35m
 gk9wTp+kXZdeSQ94TxVijKg+gv/k3/104JaViu3yxFATOvD7e270exh0o7XAwNdbN/72QQM
 mQVbICZyL37NfFPj36ArA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7Bkpil1yr/g=:d7jiAbF8NyiD4yh1M7p1c4
 hBtx9N6lAnHxUBc1OLmUsFcg1+ai/i2BVCs8WL9LxzCE/o3ZNOsUeFDP3a+y89/ZpE98iVun7
 GieBR0TZhA5dY7Kd/SRtyo1DUEUUK1NR/QYtaT4HyrwFRoGBoGe0UpCMt5DV7VekbsQ1drA0F
 dP9ffVx1UILSpHJIulLr5micrLep7RvkD2VbO6Mp7YEW3OwXvqbkoWFgFDZQiAcY1H0u5SWdA
 Fg8HUGu9nBFqdT8uHZC1T2/UAVcDp8LsM33qp5mBcWJm+KJ+AA1dMxyOedQXZzlodlb2UY+Yz
 suGn7Qa7kDIpD5Bnbzn6TgegRw6LS/OUBSAIT3o8/cuOt4qjrSycslccNkKwqcxEFmEfL6s4s
 EuLzKMJwbSLTptVnC/l5vUZ1RdMuA/c698J9YGVCPKTGq7p/AU1gJTcxTuIZkf5hZwVnAT0kz
 8tfyQTvS2dW5T7zooPd53lNqHZheu2yLJIb9iInJxFzGp19VYqxOeZA1pAOoShSKiW4DRczak
 MYfWSYUktMQBh3GThIqytCuqKEnGE7+jWq/NgQe7T9XvQVVKYYi6hvjFRhbA3J2/J5/8LHol8
 WqbbLKTMttEAYHkHuyMqBSNeodrC+h5tEigGbbu0/yMs0yQFWdmXt1rzztA1dull9l6MrAxNO
 TwgnwP8ya0bxM+2qusaXdYNP3cxjSKNVFAQQWhQZU0N+hzJW3bhpGiCHlzRd4RklikUIWWmxN
 TVvfJiPsHvCos9vhMrLhPhPYAYTTvF4WSkp3ylorU+oeOHbHhNL4j5wsqvPbUH5teXQSJjUIV
 GaOxiyU
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-26 19:49, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Apparently, this driver (or the hardware) does not support character
> length settings. It's apparently running in 8-bit mode, but it makes
> userspace believe it's in 5-bit mode. That makes tcsetattr with CS8
> incorrectly fail, breaking e.g. getty from busybox, thus the login shell
> on ttyMVx.
> 
> Fix by hard-wiring CS8 into c_cflag.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> It's a bit of a shame that still maturing drivers can break userspace
> that easily and subtly. I had to debug my way from old but working
> buildroot to busybox, libc (tcsetattr) and then finally this driver.
> This wasn't the first bug of this kind, and maybe it's not the last (I
> didn't check all that termio flags). Could the kernel help in some way
> with sanity checks or sane defaults driver have to make insane
> willingly?
> 
>   drivers/tty/serial/mvebu-uart.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
> index d04b5eeea3c6..170e446a2f62 100644
> --- a/drivers/tty/serial/mvebu-uart.c
> +++ b/drivers/tty/serial/mvebu-uart.c
> @@ -511,6 +511,7 @@ static void mvebu_uart_set_termios(struct uart_port *port,
>   		termios->c_iflag |= old->c_iflag & ~(INPCK | IGNPAR);
>   		termios->c_cflag &= CREAD | CBAUD;
>   		termios->c_cflag |= old->c_cflag & ~(CREAD | CBAUD);
> +		termios->c_cflag |= CS8;
>   	}
>   
>   	spin_unlock_irqrestore(&port->lock, flags);
> 

FWIW, below is the analogous fix for stable trees <= 4.14.

Jan

---8<---

From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] serial: mvebu-uart: Fix reporting of effective CSIZE to userspace

Apparently, this driver (or the hardware) does not support character
length settings. It's apparently running in 8-bit mode, but it makes
userspace believe it's in 5-bit mode. That makes tcsetattr with CS8
incorrectly fail, breaking e.g. getty from busybox, thus the login shell
on ttyMVx.

Fix by hard-wiring CS8 into c_cflag.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/tty/serial/mvebu-uart.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index 45b57c294d13..401c983ec5f3 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -327,8 +327,10 @@ static void mvebu_uart_set_termios(struct uart_port *port,
 	if ((termios->c_cflag & CREAD) == 0)
 		port->ignore_status_mask |= STAT_RX_RDY | STAT_BRK_ERR;
 
-	if (old)
+	if (old) {
 		tty_termios_copy_hw(termios, old);
+		termios->c_cflag |= CS8;
+	}
 
 	baud = uart_get_baud_rate(port, termios, old, 0, 460800);
 	uart_update_timeout(port, termios->c_cflag, baud);
-- 
2.16.4
