Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15409ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 06:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0E8D214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 06:36:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0E8D214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbeIQMC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 08:02:27 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42866 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727440AbeIQMC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 08:02:27 -0400
Received: by mail-lj1-f195.google.com with SMTP id f1-v6so12115142ljc.9
        for <linux-kernel@vger.kernel.org>; Sun, 16 Sep 2018 23:36:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=vlMgULVP7lNkIh6uRg1HvJib/EusWRY3aEbV8u/6fk0=;
        b=KqkL8b9JzbaXe02mZ6kkR+yYib1Gdvn9qIEFKZR7tB5DaRQT4jhsY79M1sxv+63b+A
         lJRK+cUNsvGOSTRL7Dg52Wlo3NVOhElRWw/iIvUeOh3d3PPbTK1AhHVRzKO/suHSTNly
         A47hPM0SI/vjWhnmPx+3MA4g4F8EK/0c03zwXEX8UATDviw/f4pBt/2EPACRO+7hAW1T
         93tYyHgL+dNuN2h8yuuW6VSSdiKtu1VkTOyHuEmwxhojp2OBRJ4XDHAlaqjkUdH3KrAv
         YGnUZ29dq4Pzw55oIPBR87l5DKihSHwVAn8wSo6AjqH25WC/l3l9QiYmHTYcgE7toY2z
         ocDg==
X-Gm-Message-State: APzg51A0StYQhyIYLaZ+9KdFgSOEaQM3nsZlfAPoPizq7Npgxewe99zK
        5O4FonH+ZVaMsbao0lN0YbzQxDwRukrE3KRexW+V3Oa9
X-Google-Smtp-Source: ANB0VdZVMIUFMfOjHTd2tYzS9eT3TKx1ERWqtlv2ebI2qBC7nguBdQ2IOCFpSItVjagOb1HVfvCIuMU8vfr2MDfbhQU=
X-Received: by 2002:a2e:934d:: with SMTP id m13-v6mr13680049ljh.45.1537166186902;
 Sun, 16 Sep 2018 23:36:26 -0700 (PDT)
MIME-Version: 1.0
References: <20180907081810.21615-1-peter@korsgaard.com>
In-Reply-To: <20180907081810.21615-1-peter@korsgaard.com>
From:   Peter Korsgaard <peter@korsgaard.com>
Date:   Mon, 17 Sep 2018 08:36:15 +0200
Message-ID: <CACXmVia=hiMQA8KoRpgptozsuRqUCR4n3YwWsBeMWV=hr-ewFg@mail.gmail.com>
Subject: Re: [PATCH v2] ttyprintk: make the printk log level configurable
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 7, 2018 at 10:18 AM Peter Korsgaard <peter@korsgaard.com> wrote:
>
> For some use cases it is handy to use a different printk log level than the
> default (info) for the messages written to ttyprintk, so add a Kconfig
> option similar to what we have for default console loglevel.
>
> Signed-off-by: Peter Korsgaard <peter@korsgaard.com>
> ---
> Changes since v1:
> - Leave [U] prefix in printk invocation and drop space before it as
>   suggested by Joe Perces.

Ping? Joe, if you are happy with v2, then it would be great if you could ack it.

Thanks.

>  drivers/char/Kconfig     | 8 ++++++++
>  drivers/char/ttyprintk.c | 4 +++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
> index ce277ee0a28a..14a7f023f20b 100644
> --- a/drivers/char/Kconfig
> +++ b/drivers/char/Kconfig
> @@ -66,6 +66,14 @@ config TTY_PRINTK
>
>           If unsure, say N.
>
> +config TTY_PRINTK_LEVEL
> +       depends on TTY_PRINTK
> +       int "ttyprintk log level (1-7)"
> +       range 1 7
> +       default "6"
> +       help
> +         Printk log level to use for ttyprintk messages.
> +
>  config PRINTER
>         tristate "Parallel printer support"
>         depends on PARPORT
> diff --git a/drivers/char/ttyprintk.c b/drivers/char/ttyprintk.c
> index 67549ce88cc9..88808dbba486 100644
> --- a/drivers/char/ttyprintk.c
> +++ b/drivers/char/ttyprintk.c
> @@ -37,6 +37,8 @@ static struct ttyprintk_port tpk_port;
>   */
>  #define TPK_STR_SIZE 508 /* should be bigger then max expected line length */
>  #define TPK_MAX_ROOM 4096 /* we could assume 4K for instance */
> +#define TPK_PREFIX KERN_SOH __stringify(CONFIG_TTY_PRINTK_LEVEL)
> +
>  static int tpk_curr;
>
>  static char tpk_buffer[TPK_STR_SIZE + 4];
> @@ -45,7 +47,7 @@ static void tpk_flush(void)
>  {
>         if (tpk_curr > 0) {
>                 tpk_buffer[tpk_curr] = '\0';
> -               pr_info("[U] %s\n", tpk_buffer);
> +               printk(TPK_PREFIX "[U] %s\n", tpk_buffer);
>                 tpk_curr = 0;
>         }
>  }
> --
> 2.11.0
>


-- 
Bye, Peter Korsgaard
