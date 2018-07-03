Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9A5C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63FFB2086B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:40:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63FFB2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754489AbeGCHk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:40:29 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43020 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752839AbeGCHk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:40:28 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7A873E60;
        Tue,  3 Jul 2018 07:40:27 +0000 (UTC)
Date:   Tue, 3 Jul 2018 09:40:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tamir Suliman <tsuliman@linuxvaults.com>
Cc:     w.d.hubbs@gmail.com, speakup@linux-speakup.org,
        dhowells@redhat.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, chris@the-brannons.com
Subject: Re: [PATCH 3/3] drivers/speakup: Fix style and coding warnings
Message-ID: <20180703074025.GA26787@kroah.com>
References: <1530603080-1353-1-git-send-email-tsuliman@linuxvaults.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530603080-1353-1-git-send-email-tsuliman@linuxvaults.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 07:31:20AM +0000, Tamir Suliman wrote:
> Fixed the following style/coding issues:
> *updated ---help to the prefered new help texts which reduces the code/file size and fixes the warning messages
> *Used else if instead of elese as else is not generally useful after a break or return, not sure if this is the acceptable but it resolved the warning messages.
> *kstrtoul is used instead of the abosolete simple_strtoul
> 
> Signed-off-by: Tamir Suliman <tsuliman@linuxvaults.com>
> ---
>  drivers/staging/speakup/Kconfig    | 43 ++++++++++++++------------------------
>  drivers/staging/speakup/keyhelp.c  |  2 +-
>  drivers/staging/speakup/kobjects.c |  4 ++--
>  3 files changed, 19 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/staging/speakup/Kconfig b/drivers/staging/speakup/Kconfig
> index efd6f45..2f282fd 100644
> --- a/drivers/staging/speakup/Kconfig
> +++ b/drivers/staging/speakup/Kconfig
> @@ -3,7 +3,7 @@ menu "Speakup console speech"
>  config SPEAKUP
>  	depends on VT
>  	tristate "Speakup core"
> -	---help---
> +	help
>  		This is the Speakup screen reader.  Think of it as a
>  		video console for blind people.  If built in to the
>  		kernel, it can speak everything on the text console from
> @@ -43,7 +43,7 @@ config SPEAKUP
>  if SPEAKUP
>  config SPEAKUP_SYNTH_ACNTSA
>  	tristate "Accent SA synthesizer support"
> -	---help---
> +	help
>  		This is the Speakup driver for the Accent SA
>  		synthesizer.  You can say y to build it into the kernel,
>  		or m to build it as a module.  See the configuration
> @@ -52,7 +52,7 @@ config SPEAKUP_SYNTH_ACNTSA
>  config SPEAKUP_SYNTH_ACNTPC
>  	tristate "Accent PC synthesizer support"
>  	depends on ISA || COMPILE_TEST
> -	---help---
> +	help
>  		This is the Speakup driver for the accent pc
>  		synthesizer.  You can say y to build it into the kernel,
>  		or m to build it as a module.  See the configuration
> @@ -60,7 +60,7 @@ config SPEAKUP_SYNTH_ACNTPC
>  
>  config SPEAKUP_SYNTH_APOLLO
>  	tristate "Apollo II synthesizer support"
> -	---help---
> +	help
>  		This is the Speakup driver for the Apollo II
>  		synthesizer.  You can say y to build it into the kernel,
>  		or m to build it as a module.  See the configuration
> @@ -68,7 +68,7 @@ config SPEAKUP_SYNTH_APOLLO
>  
>  config SPEAKUP_SYNTH_AUDPTR
>  	tristate "Audapter synthesizer support"
> -	---help---
> +	help
>  		This is the Speakup driver for the Audapter synthesizer.
>  		 You can say y to build it into the kernel, or m to
>  		build it as a module.  See the configuration help on the
> @@ -76,7 +76,7 @@ config SPEAKUP_SYNTH_AUDPTR
>  
>  config SPEAKUP_SYNTH_BNS
>  	tristate "Braille 'n' Speak synthesizer support"
> -	---help---
> +	help
>  		This is the Speakup driver for the Braille 'n' Speak
>  		synthesizer.  You can say y to build it into the kernel,
>  		or m to build it as a module.  See the configuration
> @@ -84,8 +84,7 @@ config SPEAKUP_SYNTH_BNS
>  
>  config SPEAKUP_SYNTH_DECTLK
>  	tristate "DECtalk Express synthesizer support"
> -	---help---
> -
> +	help
>  		This is the Speakup driver for the DecTalk Express
>  		synthesizer.  You can say y to build it into the kernel,
>  		or m to build it as a module.  See the configuration
> @@ -93,8 +92,7 @@ config SPEAKUP_SYNTH_DECTLK
>  
>  config SPEAKUP_SYNTH_DECEXT
>  	tristate "DECtalk External (old) synthesizer support"
> -	---help---
> -
> +	help
>  		This is the Speakup driver for the DecTalk External
>  		(old) synthesizer.  You can say y to build it into the
>  		kernel, or m to build it as a module.  See the
> @@ -105,13 +103,11 @@ config SPEAKUP_SYNTH_DECPC
>  	depends on m
>  	depends on ISA || COMPILE_TEST
>  	tristate "DECtalk PC (big ISA card) synthesizer support"
> -	---help---
> -
> +	help
>  		This is the Speakup driver for the DecTalk PC (full
>  		length ISA) synthesizer.  You can say m to build it as
>  		a module.  See the configuration help on the Speakup
>  		choice above for more info.
> -
>  		In order to use the DecTalk PC driver, you must download
>  		the dec_pc.tgz file from linux-speakup.org.  It is in
>  		the pub/linux/goodies directory.  The dec_pc.tgz file
> @@ -127,8 +123,7 @@ config SPEAKUP_SYNTH_DECPC
>  config SPEAKUP_SYNTH_DTLK
>  	tristate "DoubleTalk PC synthesizer support"
>  	depends on ISA || COMPILE_TEST
> -	---help---
> -
> +	help
>  		This is the Speakup driver for the internal DoubleTalk
>  		PC synthesizer.  You can say y to build it into the
>  		kernel, or m to build it as a module.  See the
> @@ -138,8 +133,7 @@ config SPEAKUP_SYNTH_DTLK
>  config SPEAKUP_SYNTH_KEYPC
>  	tristate "Keynote Gold PC synthesizer support"
>  	depends on ISA || COMPILE_TEST
> -	---help---
> -
> +	help
>  		This is the Speakup driver for the Keynote Gold
>  		PC synthesizer.  You can say y to build it into the
>  		kernel, or m to build it as a module.  See the
> @@ -148,8 +142,7 @@ config SPEAKUP_SYNTH_KEYPC
>  
>  config SPEAKUP_SYNTH_LTLK
>  	tristate "DoubleTalk LT/LiteTalk synthesizer support"
> ----help---
> -
> +	help
>  		This is the Speakup driver for the LiteTalk/DoubleTalk
>  		LT synthesizer.  You can say y to build it into the
>  		kernel, or m to build it as a module.  See the
> @@ -158,8 +151,7 @@ config SPEAKUP_SYNTH_LTLK
>  
>  config SPEAKUP_SYNTH_SOFT
>  	tristate "Userspace software synthesizer support"
> -	---help---
> -
> +	help
>  		This is the software synthesizer device node.  It will
>  		register a device /dev/softsynth which midware programs
>  		and speech daemons may open and read to provide kernel
> @@ -169,8 +161,7 @@ config SPEAKUP_SYNTH_SOFT
>  
>  config SPEAKUP_SYNTH_SPKOUT
>  	tristate "Speak Out synthesizer support"
> -	---help---
> -
> +	help
>  		This is the Speakup driver for the Speakout synthesizer.
>  		 You can say y to build it into the kernel, or m to
>  		build it as a module.  See the configuration help on the
> @@ -178,8 +169,7 @@ config SPEAKUP_SYNTH_SPKOUT
>  
>  config SPEAKUP_SYNTH_TXPRT
>  	tristate "Transport synthesizer support"
> -	---help---
> -
> +	help
>  		This is the Speakup driver for the Transport
>  		synthesizer.  You can say y to build it into the kernel,
>  		or m to build it as a module.  See the configuration
> @@ -187,8 +177,7 @@ config SPEAKUP_SYNTH_TXPRT
>  
>  config SPEAKUP_SYNTH_DUMMY
>  	tristate "Dummy synthesizer driver (for testing)"
> -	---help---
> -
> +	help
>  		This is a dummy Speakup driver for plugging a mere serial
>  		terminal.  This is handy if you want to test speakup but
>  		don't have the hardware.  You can say y to build it into
> diff --git a/drivers/staging/speakup/keyhelp.c b/drivers/staging/speakup/keyhelp.c
> index 5f1bda3..a1bbe8f 100644
> --- a/drivers/staging/speakup/keyhelp.c
> +++ b/drivers/staging/speakup/keyhelp.c
> @@ -167,7 +167,7 @@ int spk_handle_help(struct vc_data *vc, u_char type, u_char ch, u_short key)
>  		synth_printf("%s\n", spk_msg_get(MSG_HELP_INFO));
>  		build_key_data(); /* rebuild each time in case new mapping */
>  		return 1;
> -	} else {
> +	} else if {
>  		name = NULL;
>  		if ((type != KT_SPKUP) && (key > 0) && (key <= num_key_names)) {
>  			synth_printf("%s\n",
> diff --git a/drivers/staging/speakup/kobjects.c b/drivers/staging/speakup/kobjects.c
> index f1f9022..a98a0a4 100644
> --- a/drivers/staging/speakup/kobjects.c
> +++ b/drivers/staging/speakup/kobjects.c
> @@ -154,7 +154,7 @@ static ssize_t chars_chartab_store(struct kobject *kobj,
>  			continue;
>  		}
>  
> -		index = simple_strtoul(cp, &temp, 10);
> +		index = simple_kstrtoul(cp, &temp, 10);
>  		if (index > 255) {
>  			rejected++;
>  			cp = linefeed + 1;
> @@ -787,7 +787,7 @@ static ssize_t message_store_helper(const char *buf, size_t count,
>  			continue;
>  		}
>  
> -		index = simple_strtoul(cp, &temp, 10);
> +		index = simple_ktrtoul(cp, &temp, 10);
>  
>  		while ((temp < linefeed) && (*temp == ' ' || *temp == '\t'))
>  			temp++;
> -- 
> 1.8.3.1

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
