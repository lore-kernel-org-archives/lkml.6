Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE1EC43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 06:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A1A24DF0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 06:05:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69A1A24DF0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751582AbeFXGFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 02:05:44 -0400
Received: from mout.gmx.net ([212.227.17.21]:40897 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751323AbeFXGFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 02:05:42 -0400
Received: from localhost ([60.45.8.172]) by mail.gmx.com (mrgmx102
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0MKbZD-1fV2k63zsN-001yyZ; Sun, 24
 Jun 2018 08:05:34 +0200
Date:   Sun, 24 Jun 2018 15:04:45 +0900 (JST)
Message-Id: <20180624.150445.1006140718276550233.teika@gmx.com>
To:     Rosen Penev <rosenp@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        jan.steffens@gmail.com, Pablo Cholaky <waltercool@slash.cl>
Subject: Re: [PATCH] synaptics: Enable RMI4 for Clevo P870DM laptops
From:   Teika Kazura <teika@gmx.com>
In-Reply-To: <20180617014216.4043-1-rosenp@gmail.com>
References: <20180617014216.4043-1-rosenp@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:HAJ4dbbv6t9TWjkcv05Zwb4d3h57GEAVQ5L/pj2fv9T+7+8iuqB
 MxN5kioWMqEI/pnQxJpATI+xh7FrVPTeH/0XNVTL8MXRlWgE5SjekjFNLNaU4QG6qVz2pwX
 JeqmO/yiIup8HmDWfGb5PXpstcrb+3VhJhhMfk27DJemDo1JAyULXs8EznaNdU38K+wdgwK
 gOOi/0N9mbpHId2rIQe0Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BECBpQa02+8=:awFW0PJerx6oWctOud+Geu
 WIp5ZpXDhAKvvp/9P2AJivw1l+W9RP7GqVmIP4Hk9otQpZ0wvBfYVJRjc2z4JLuUxiyG5ckbr
 RJSVSdLaKortLySufzHUyShKE1kDfjLD4M/SpUeCyA0eK8XNeGHYWr0K9S8DSNrmA+tPDqGNI
 cpE7mC6J2gMTtrcD0KErPKjoQBO7sBMNxpPrNR9SK/YMS/VtMYqOGUJrm2kBOlp9bRlMh96Kw
 hnQ3FkobwHv8OvJffDObSIK9CMrH7SifD/28oFeJpC9daqendoivoGXbaFNDCnAQCpj+Vb22s
 GTIghGyEPA5nPEyPrNNkADlqRp6LI8lQaXKmsyANF6bv/Ke+igeUlSOYK76dEhP6SKWUFdmcM
 L7Y3H15HAF3TNUGZ6qE8NuO179fI2jb++cU9+qH0N6wx/izFv+PA0FbPOCrPM8Di+wlStIDos
 5rTKqgxBV7cAJziBPNME/2Im0Pr2IGTif0ySSBs11ak5A7UXhS8bAWgEkCNP80fYyg+m3GM5i
 AYHU2wMfZWSlUgDWjKdvl2vym10rkErN37bmz/gmXx3bXTi9jZY2fnS7f5R2V0OkcKgVhCKLH
 K/ykzyyvgyp2KhoVyp5XPDECZZyihxkjgmdjUK5AdnA5tE1pQ/Dh/XUx3IO5Jw8lb4jyuf/i7
 BivGDch9bUqBzlgfkEk/I7XtWY9RkuksRAiVNcq7h2I5YTyZ0uJvsev7GgW0aai+RjrGs3KQK
 v9tRg+x0CVOHsnzF2breISTcv8lmWTPUamxt+9fSBCsUSy3zJBZuMmD7l6NHKxdJM+f9WKgk/
 gY5fkn8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Rosen. Thank you for your patch. (@Jan Steffens and @Pablo Cholaky: Thanks for your reports.) But I'm afraid some more work is necessary. Let me propose some points.

I'm not a kernel developer, but have been working on this issue to help them. (See https://www.spinics.net/lists/linux-input/msg55950.html )

0.
Could you resend it, cc-ing to the relevant developers. (Use the one of my reply here. You can use <kernel src tree>/scripts/get_maintainer.pl next time.) Otherwise, it is unlikely to be noticed by them.

1.
You added your device to forcepad_pnp_ids[], but I guess it should be smbus_pnp_ids[].

When making the patch again, please use the kernel 4.17 or newer, because smbus_pnp_ids was changed recently.

If it works by using smbus_pnp_ids, please test it for a week or so, especially making sure that suspend/resume works without any problem.

2.
Though it's my personal impression, the change description looked somewhat personal. At the same time, it's important, guaranteeing the stability of the patch.- I know you originally reported it last August [1]. Furthermore, there have been two other users [2] who reported SMBus worked for the same device, namely SYN1219. (They two are cc-ed to in this reply.)

You can use "$ git format-patch --cover-letter"; it will generate a "cover-letter", the introductory part of the patch, explaining the acceptability of the patch to kernel developers. (For an example, see https://www.spinics.net/lists/linux-input/msg57041.html)

So the full description can be given in the cover letter, and the real patch description can be something like "This enables SMBus for xxx", being almost identical to the email subject.

3. This is not essential, but the style of the email subject that the device maintainer prefers might be:
------------------------------------------------------------------------
[PATCH v2] Input: synaptics - Enable RMI4 for Clevo P870DM laptops
------------------------------------------------------------------------
after looking at this tree [3]. ("v2" meaning version 2, due to the above change.) You can feed "--subject-prefix='PATCH v2'" to "$ git format-patch".

4. If you want to give the credit for my reply, you can add
------------------------------------------------------------------------
Suggested-by: Teika Kazura <teika@gmx.com>
------------------------------------------------------------------------
after Signed-off-by. It's completely ok without it. :-)

[1] https://marc.info/?l=linux-input&m=150284057602358&w=2
[2] https://marc.info/?l=linux-input&m=150049625613055&w=2
    https://marc.info/?l=linux-input&m=150094561111026&w=2
[3] https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git/log/

Best regards,
Teika (Teika kazura)


From: Rosen Penev <rosenp@gmail.com>
Subject: [PATCH] synaptics: Enable RMI4 for Clevo P870DM laptops
Date: Sat, 16 Jun 2018 18:42:16 -0700

> I have been testing this for half a year with no issues to report.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/input/mouse/synaptics.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> index 55d33500d55e..23f5bb2cf9da 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -183,6 +183,7 @@ static const char * const smbus_pnp_ids[] = {
>  };
>  
>  static const char * const forcepad_pnp_ids[] = {
> +	"SYN1219",
>  	"SYN300D",
>  	"SYN3014",
>  	NULL
> -- 
> 2.17.1
> 
