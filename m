Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7AD9ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9314A208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asRpaNAp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9314A208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729935AbeGMH62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 03:58:28 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:37454 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727582AbeGMH62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 03:58:28 -0400
Received: by mail-pf0-f193.google.com with SMTP id a26-v6so91334pfo.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 00:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+fUhs1UPGwhlu61NEreLBTKrzD+cqQJaqAbjn3fRy0o=;
        b=asRpaNApEPN8bEOz2UEqsyshIIoyjaa1B5+L/zsM1WKnSHbSnxfgyiwAPK/US4T2lh
         B466XNAPNNxbl/rz5RBeinBd4V5T0bGpDERGJTymt56JaQYI51QAdj87t+XkxHkVu+z3
         h9R+qKOC1T9NRmn3zb+MBRNnfzmXnn4unZ6fFv8NCfzdkWsgrHDA4RhIijf7yI35b8Et
         VinYYDl3lM1OJ3bG7UxgnG3VsTVb6y7GWK1NeCRo9M+B1UBpNMOuxXTzWQuG6R2s0eS9
         vIyNLaVh1r9nbFWepmaS2UvcUxGpbOZQNIORI5WA552ahWPH/miad+k9xpNAilQxwOES
         Tm1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+fUhs1UPGwhlu61NEreLBTKrzD+cqQJaqAbjn3fRy0o=;
        b=aVt4gyO87yW7zoDaT92SuEds8fJD7SIvzSNIIU5jPFzuiBpQyJuBX2kZC2ms/RpaP3
         W0GMUBnKAxkJBkoiWTA+uOfO7UKENXmMrl6EljrR5YT7iEesqadAuoW1fKqjtUKaPsgh
         dOtP9osvdNv+aWABE34uLkcLIxqYbqU5WGbq15P/czHBkdpIhkY22tInI4T+ZB3qts+C
         9tmvdnA3jLkyGSvYNKnZJmS7MtsRjJKwTnJRlXFZNro9Knc31EWddq9QKQBKKsGzpmmy
         JxruT37OLL59XcUyR7/irVvWp9FOP0idfz5YgdRuDIa3da4uLsqXeHYbalUIA4deYvT5
         cCIg==
X-Gm-Message-State: AOUpUlGOo7pkgXxpXDcx/9YOxKWRiBqASmqA7JJe3E/36tFxBnMJUTpA
        48sq7SrprEBrPeegkBjfpXo=
X-Google-Smtp-Source: AAOMgpfd3SdyOlk5PZbKn1Jkl+nviXDEfQNBqM8ofsC8LKOZgIOjdoSZPhGA8wZEkhINh04mF/ehsA==
X-Received: by 2002:a63:8648:: with SMTP id x69-v6mr5066834pgd.172.1531467902745;
        Fri, 13 Jul 2018 00:45:02 -0700 (PDT)
Received: from himanshu-Vostro-3559 ([103.233.116.134])
        by smtp.gmail.com with ESMTPSA id 10-v6sm52951460pfs.111.2018.07.13.00.44.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 00:45:02 -0700 (PDT)
Date:   Fri, 13 Jul 2018 13:14:55 +0530
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        linux-kernel@vger.kernel.org, cocci@systeme.lip6.fr,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>
Subject: Re: [Cocci] [PATCH 01/18] coccinelle: change strncpy+truncation to
 strlcpy
Message-ID: <20180713074455.GA6859@himanshu-Vostro-3559>
References: <1531444483-17338-1-git-send-email-asmadeus@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1531444483-17338-1-git-send-email-asmadeus@codewreck.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 03:14:43AM +0200, Dominique Martinet wrote:
> Besides being simpler, using strlcpy instead of strncpy+truncation
> fixes part of the following class of new gcc warnings:
> 
>     drivers/gpu/drm/i915/intel_tv.c: In function ‘intel_tv_get_modes’:
>     drivers/gpu/drm/i915/intel_tv.c:1358:3: error: ‘strncpy’ specified bound 32 equals
>     destination size [-Werror=stringop-truncation]
>        strncpy(mode_ptr->name, input->name, DRM_DISPLAY_MODE_LEN);
>        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     cc1: all warnings being treated as errors
> 
> Note that this is not a proper fix for this warning (and not all of the
> occurences give the warning either - the strings are not always static).
> The warning was intended to have developers check the return code of
> strncpy and act in case of truncation (print a warning, abort the
> function or something similar if the original string was not nul
> terminated); the change to strlcpy only works because gcc does not
> handle the function the same way.
> 
> Suggested-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
> ---
> 
> Running this fixes 30 occurences of the problem in 17 different
> components of the kernel, and while the produced patches are fairly
> straight-forward I'm not sure who I should expect to pick this up as
> it is sent as a series.
> I expect each maintainer will pick their share of the patchs if they
> agree with it and the rest will just be dropped?

Masahiro Yamada <yamada.masahiro@socionext.com> takes coccinelle patches,
so please cc him or your patch would be lost.

>  .../coccinelle/misc/strncpy_truncation.cocci  | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 scripts/coccinelle/misc/strncpy_truncation.cocci
> 
> diff --git a/scripts/coccinelle/misc/strncpy_truncation.cocci b/scripts/coccinelle/misc/strncpy_truncation.cocci
> new file mode 100644
> index 000000000000..28b5c2a290ac
> --- /dev/null
> +++ b/scripts/coccinelle/misc/strncpy_truncation.cocci
> @@ -0,0 +1,41 @@
> +/// Use strlcpy rather than strncpy(dest,..,sz) + dest[sz-1] = '\0'
> +///
> +// Confidence: High
> +// Comments:
> +// Options: --no-includes --include-headers
> +
> +virtual patch
> +virtual context

You might consider adding context rule or remove this line perhaps ?

> +virtual report
> +virtual org
> +
> +@r@
> +expression dest, src, sz;
> +position p;
> +@@
> +
> +strncpy@p(dest, src, sz);
> +dest[sz - 1] = '\0';
> +
> +@script:python depends on org@
> +p << r.p;
> +@@
> +
> +cocci.print_main("strncpy followed by truncation can be strlcpy",p)
> +
> +@script:python depends on report@
> +p << r.p;
> +@@
> +
> +msg = "SUGGESTION: strncpy followed by truncation can be strlcpy"
> +coccilib.report.print_report(p[0],msg)
> +
> +@ok depends on patch@
> +expression r.dest, r.src, r.sz;
> +position r.p;
> +@@
> +
> +-strncpy@p(
> ++strlcpy(
> +  dest, src, sz);
> +-dest[sz - 1] = '\0';

The above rule produces an output that I think is not correct:
--------------------------------------------------------------
diff = 
diff -u -p a//ti/wl1251/acx.c b//ti/wl1251/acx.c
--- a//ti/wl1251/acx.c
+++ b//ti/wl1251/acx.c
@@ -150,14 +150,7 @@ int wl1251_acx_fw_version(struct wl1251
 	}
 
 	/* be careful with the buffer sizes */
-	strncpy(buf, rev->fw_version, min(len, sizeof(rev->fw_version)));
-
-	/*
-	 * if the firmware version string is exactly
-	 * sizeof(rev->fw_version) long or fw_len is less than
-	 * sizeof(rev->fw_version) it won't be null terminated
-	 */
-	buf[min(len, sizeof(rev->fw_version)) - 1] = '\0';
+	strlcpy(buf, rev->fw_version, min(len, sizeof(rev->fw_version)));

-----------------------------------------------------------------

I think the comment is useful and should not be removed. Also, consider
changing Confidence level appropriately.

Thanks.

-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
