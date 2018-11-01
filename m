Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46A3C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 21:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E8B22082E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 21:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XC4/Q65y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E8B22082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbeKBGmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 02:42:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:41974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbeKBGmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 02:42:39 -0400
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E41CA20833
        for <linux-kernel@vger.kernel.org>; Thu,  1 Nov 2018 21:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541108275;
        bh=ZeMq+xRiWwUT+2ZVCyRlPSj5zWtRBpQpeZ2coZ01PJ8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XC4/Q65y8lgOPk0kGRqg8Q5OxqdYAxGWxriuXXEeM9HrsPTzSAq9czcrcxeLyJAji
         AfNDCjipSCzq4N6H3R2AquPWJiZOmT8pr1+2Si5+Kp+P3nJuDkLpV+x0hPOu7I+F3M
         4Z+eGyqVK8pQJHwXaAllhqbHt8YWQrKqb8VFXN5o=
Received: by mail-qk1-f181.google.com with SMTP id 189so12371779qkj.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 14:37:54 -0700 (PDT)
X-Gm-Message-State: AGRZ1gKFFcFsALPZBD7MSM4AbjH8dUbPIMKLF4T2vfn/ZPIzF6n7oNow
        CCKlv0kSRQWF/RiRKQA39XLhCslGLM1KtRY9IA==
X-Google-Smtp-Source: AJdET5cTlA6nic3JSIDqfqRJGgn2eq6HtpfM/RTzcHi29C0Y3iLUyGPfiNlc4Ss/B3jno+SthhzMqxAcwkMCEiqpD3M=
X-Received: by 2002:aed:29a5:: with SMTP id o34mr1565163qtd.257.1541108274106;
 Thu, 01 Nov 2018 14:37:54 -0700 (PDT)
MIME-Version: 1.0
References: <201811011054.ZGhrqvwa%fengguang.wu@intel.com>
In-Reply-To: <201811011054.ZGhrqvwa%fengguang.wu@intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 1 Nov 2018 16:37:42 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJG9AjQVLSLZg_H4-Msq5h8xhtSQqbBikfKXMfD7pwjqA@mail.gmail.com>
Message-ID: <CAL_JsqJG9AjQVLSLZg_H4-Msq5h8xhtSQqbBikfKXMfD7pwjqA@mail.gmail.com>
Subject: Re: make[3]: *** No rule to make target 'arch/mips/boot/dts/brcm/bcm93384wvg.dtb',
 needed by '__build'.
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 9:18 PM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Rob,
>
> FYI, the error/warning still remains.

I replied on another one of these reports that these failures need to
be fixed by using "CONFIG_OF_ALL_DTBS=y CONFIG_DTC=y" instead of just
"CONFIG_OF_ALL_DTBS=y" as specifying kconfig options on the command
line ignores any select or depends AFAICT.

I partially fixed these in some cases by making 'all' only include
'dtbs' target when CONFIG_OF_EARLY_FLATTREE is enabled. I'm not
exactly sure why mips and xtensa still fail.

Rob
