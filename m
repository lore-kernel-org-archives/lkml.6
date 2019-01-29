Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65A3C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 22:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E03B2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 22:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/CttCD7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbfA2Wxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 17:53:35 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46439 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727980AbfA2Wxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 17:53:34 -0500
Received: by mail-wr1-f65.google.com with SMTP id l9so23892508wrt.13;
        Tue, 29 Jan 2019 14:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gnpjrpJ9SO1uxLSMRCNlay9ff270KZBwxe/ynP0cjWs=;
        b=S/CttCD7oofGIGkxCVt+/zI5zK6G9VXBxlKpcHlMASN/mJks8/bGodOYOlFyIJStXy
         gV6uhk0dZlS7ObSeNVLDFgiExi4xji8ovyWRF7gilbvVXtzseV4uBQYio3hfSru6lXvF
         CZS2kRj/V8hBqC5c54aTBTUjE3iv1DWXncPbabQ/ovETD99qXVFbOCWeki/7PIF+Rggt
         jOuTJmVVfREMOvKe0vTrVfMCdSg2bONhrNtDqeAEn6HpeIxcqpc57sIb6PXh967l+Kgd
         6+JMY+VJtOnowJ3SnKA0t+e6XPfa51fCVKOYuPGR6jS/tB6GcdxD90APyfiA7SiUFXzR
         qBNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gnpjrpJ9SO1uxLSMRCNlay9ff270KZBwxe/ynP0cjWs=;
        b=GJEKP5sdVQr7U1m8vKTgMnkjjmMh6a8nJGUUIn5Pm7aMXd+D9kb1CZ0/q0+i6RVU7/
         ASjgVvhuEkVMZ4gFJRk7+NYQISDXDa0DEb8MOhcdL5GAZeaHJR/t0z4jQOBsZGIgRLz+
         g6v1Q41EKlCNlrCgz55FZ/lvUh3pvj9AwBxXEFznTMibYpLW8bPBSwtunNLCRw7xHuJ2
         0pRTfIloAV3uqqxT7Mb2H1UwOMNMe6TRC4oOrR8m4/bFre3L0gOM0FSlNX0YtZIEAhoS
         i8cEMtY35jlp6KyTLw1j6D6qUujyBrEBTOzRl04tekqzM08cASQUBar2K/qF56s52fyB
         MW/Q==
X-Gm-Message-State: AJcUukcaYJKe4L/HWKXfhYrRhg0CKScP20Pwfn2IUQCDCqgbP8DwqiVp
        rJUMYTKKagVs/ZJaI60mErOkqpUaduDjaYRC4eGxityZ
X-Google-Smtp-Source: ALg8bN745ZuAhONT6/d3Qki6lnZWOn08RE5TcLy2QidehAcssK0jMEcMirxc26PJY+xZ9hMcvuqIL7frZaNyUgALooM=
X-Received: by 2002:adf:ec83:: with SMTP id z3mr28478498wrn.264.1548802412700;
 Tue, 29 Jan 2019 14:53:32 -0800 (PST)
MIME-Version: 1.0
References: <20190130093830.728e9d06@canb.auug.org.au>
In-Reply-To: <20190130093830.728e9d06@canb.auug.org.au>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Tue, 29 Jan 2019 14:53:21 -0800
Message-ID: <CAKi4VA+kGT1WbUHV=Q6PW+PR+Vh+AEE+a2_wLkmMVq88tTSH_Q@mail.gmail.com>
Subject: Re: [Intel-gfx] linux-next: build failure after merge of the
 drm-intel-fixes tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 2:39 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the drm-intel-fixes tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> drivers/gpu/drm/i915/intel_display.c: In function 'has_bogus_dpll_config':
> drivers/gpu/drm/i915/intel_display.c:15432:27: error: macro "IS_GEN" requires 3 arguments, but only 2 given
>   return IS_GEN(dev_priv, 6) &&
>                            ^
>
> Caused by commit
>
>   a49a17226feb ("drm/i915: Try to sanitize bogus DPLL state left over by broken SNB BIOSen")
>
> It seems this was cherry-picked incorrectly :-(

while the cherry-pick was correct, the macro is different on
drm-intel-fixes. IS_GEN(dev_priv, 6) needs to be converted to
IS_GEN6(dev_priv).

Lucas De Marchi

>
> I have reverted that commit for today.
>
> --
> Cheers,
> Stephen Rothwell
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gfx



-- 
Lucas De Marchi
