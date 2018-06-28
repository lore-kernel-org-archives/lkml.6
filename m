Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A5CC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 22:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89CEC27A1E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 22:27:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89CEC27A1E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967389AbeF1W1C (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 18:27:02 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:59772 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966506AbeF1W1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 18:27:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id C9026E1C;
        Fri, 29 Jun 2018 00:26:57 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vwl-wCOGW7wY; Fri, 29 Jun 2018 00:26:56 +0200 (CEST)
Received: from var.youpi.perso.aquilenet.fr (static-176-158-111-12.ftth.abo.bbox.fr [176.158.111.12])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 296637E6;
        Fri, 29 Jun 2018 00:26:56 +0200 (CEST)
Received: from samy by var.youpi.perso.aquilenet.fr with local (Exim 4.91)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1fYfNN-0001sU-SU; Fri, 29 Jun 2018 00:26:53 +0200
Date:   Fri, 29 Jun 2018 00:26:53 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org, Anton Zinoviev <anton@lml.bas.bg>
Subject: Re: [PATCH] kbd: complete dead keys definitions
Message-ID: <20180628222653.uqeh2cqo6izo5j6i@var.youpi.perso.aquilenet.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org, Anton Zinoviev <anton@lml.bas.bg>
References: <20180603181858.dtyhhmb7f43cqg3d@var.youpi.perso.aquilenet.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180603181858.dtyhhmb7f43cqg3d@var.youpi.perso.aquilenet.fr>
Organization: I am not organized
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Ping?

Samuel

Samuel Thibault, le dim. 03 juin 2018 20:18:58 +0200, a ecrit:
> This completes dead keys definitions for internationalization
> completeness on the console.  The representatives have been chosen
> coherently with libx11 compose sequences, which avoid symetry conflicts
> (e.g. there is U with caron, but no c with breve).
> 
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> 
> Index: linux-4.15/drivers/s390/char/keyboard.c
> ===================================================================
> --- linux-4.15.orig/drivers/s390/char/keyboard.c
> +++ linux-4.15/drivers/s390/char/keyboard.c
> @@ -39,8 +39,34 @@ static const int kbd_max_vals[] = {
>  };
>  static const int KBD_NR_TYPES = ARRAY_SIZE(kbd_max_vals);
>  
> -static unsigned char ret_diacr[NR_DEAD] = {
> -	'`', '\'', '^', '~', '"', ','
> +static const unsigned char ret_diacr[NR_DEAD] = {
> +	'`',	/* dead_grave */
> +	'\'',	/* dead_acute */
> +	'^',	/* dead_circumflex */
> +	'~',	/* dead_tilda */
> +	'"',	/* dead_diaeresis */
> +	',',	/* dead_cedilla */
> +	'_',	/* dead_macron */
> +	'U',	/* dead_breve */
> +	'.',	/* dead_abovedot */
> +	'*',	/* dead_abovering */
> +	'=',	/* dead_doubleacute */
> +	'c',	/* dead_caron */
> +	'k',	/* dead_ogonek */
> +	'i',	/* dead_iota */
> +	'#',	/* dead_voiced_sound */
> +	'o',	/* dead_semivoiced_sound */
> +	'!',	/* dead_belowdot */
> +	'?',	/* dead_hook */
> +	'+',	/* dead_horn */
> +	'-',	/* dead_stroke */
> +	')',	/* dead_abovecomma */
> +	'(',	/* dead_abovereversedcomma */
> +	':',	/* dead_doublegrave */
> +	'n',	/* dead_invertedbreve */
> +	';',	/* dead_belowcomma */
> +	'$',	/* dead_currency */
> +	'@',	/* dead_greek */
>  };
>  
>  /*
> Index: linux-4.15/drivers/tty/vt/keyboard.c
> ===================================================================
> --- linux-4.15.orig/drivers/tty/vt/keyboard.c
> +++ linux-4.15/drivers/tty/vt/keyboard.c
> @@ -690,7 +690,35 @@ static void k_dead2(struct vc_data *vc,
>   */
>  static void k_dead(struct vc_data *vc, unsigned char value, char up_flag)
>  {
> -	static const unsigned char ret_diacr[NR_DEAD] = {'`', '\'', '^', '~', '"', ',' };
> +	static const unsigned char ret_diacr[NR_DEAD] = {
> +		'`',	/* dead_grave */
> +		'\'',	/* dead_acute */
> +		'^',	/* dead_circumflex */
> +		'~',	/* dead_tilda */
> +		'"',	/* dead_diaeresis */
> +		',',	/* dead_cedilla */
> +		'_',	/* dead_macron */
> +		'U',	/* dead_breve */
> +		'.',	/* dead_abovedot */
> +		'*',	/* dead_abovering */
> +		'=',	/* dead_doubleacute */
> +		'c',	/* dead_caron */
> +		'k',	/* dead_ogonek */
> +		'i',	/* dead_iota */
> +		'#',	/* dead_voiced_sound */
> +		'o',	/* dead_semivoiced_sound */
> +		'!',	/* dead_belowdot */
> +		'?',	/* dead_hook */
> +		'+',	/* dead_horn */
> +		'-',	/* dead_stroke */
> +		')',	/* dead_abovecomma */
> +		'(',	/* dead_abovereversedcomma */
> +		':',	/* dead_doublegrave */
> +		'n',	/* dead_invertedbreve */
> +		';',	/* dead_belowcomma */
> +		'$',	/* dead_currency */
> +		'@',	/* dead_greek */
> +	};
>  
>  	k_deadunicode(vc, ret_diacr[value], up_flag);
>  }
> Index: linux-4.15/include/uapi/linux/keyboard.h
> ===================================================================
> --- linux-4.15.orig/include/uapi/linux/keyboard.h
> +++ linux-4.15/include/uapi/linux/keyboard.h
> @@ -357,8 +357,29 @@
>  #define K_DTILDE	K(KT_DEAD,3)
>  #define K_DDIERE	K(KT_DEAD,4)
>  #define K_DCEDIL	K(KT_DEAD,5)
> +#define K_DMACRON	K(KT_DEAD,6)
> +#define K_DBREVE	K(KT_DEAD,7)
> +#define K_DABDOT	K(KT_DEAD,8)
> +#define K_DABRING	K(KT_DEAD,9)
> +#define K_DDBACUTE	K(KT_DEAD,10)
> +#define K_DCARON	K(KT_DEAD,11)
> +#define K_DOGONEK	K(KT_DEAD,12)
> +#define K_DIOTA		K(KT_DEAD,13)
> +#define K_DVOICED	K(KT_DEAD,14)
> +#define K_DSEMVOICED	K(KT_DEAD,15)
> +#define K_DBEDOT	K(KT_DEAD,16)
> +#define K_DHOOK		K(KT_DEAD,17)
> +#define K_DHORN		K(KT_DEAD,18)
> +#define K_DSTROKE	K(KT_DEAD,19)
> +#define K_DABCOMMA	K(KT_DEAD,20)
> +#define K_DABREVCOMMA	K(KT_DEAD,21)
> +#define K_DDBGRAVE	K(KT_DEAD,22)
> +#define K_DINVBREVE	K(KT_DEAD,23)
> +#define K_DBECOMMA	K(KT_DEAD,24)
> +#define K_DCURRENCY	K(KT_DEAD,25)
> +#define K_DGREEK	K(KT_DEAD,26)
>  
> -#define NR_DEAD		6
> +#define NR_DEAD		27
>  
>  #define K_DOWN		K(KT_CUR,0)
>  #define K_LEFT		K(KT_CUR,1)

