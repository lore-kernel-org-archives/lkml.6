Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D633FC3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 10:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CAC7258E2
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 10:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B4vjf5lG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CAC7258E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936850AbeF3K1e (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 06:27:34 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:46952 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934131AbeF3K1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 06:27:31 -0400
Received: by mail-pl0-f65.google.com with SMTP id 30-v6so5649604pld.13
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jun 2018 03:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Zp6B+rs0jPzP43oajvF/2kO6Lt1LxgMMaFn0DlTkBkg=;
        b=B4vjf5lGJlMMdWj0dyCdCu8xbcnOx4ajvxqxb2loLd/J7L8Lcq2IOdNKKLDEmSvwUX
         0SfWLoWl6ipaFm5YTJo+3U1aj3wv+8Z3LLvGmq5AOaryKLpXu3W/xoT0Tt7PGfkfCqwx
         vqWzWm5lYLd3UUrlwDOHPqGIZ6gLYPushW64JkYQQs4HWg6e82iU6w/guLs1RShYuRXU
         o5LIVximuguySK3pkFxHqoG8TozCXR9zDfp4UNgAN89spyZOzbWaJaVsfoa0Vka1J/z0
         f+r+cOmSBWl1+D8I4VRz11k4N1+IGKdbeglh5I+t0pGGDIvZ/o2ildinhyKVsbeI+fpp
         reOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Zp6B+rs0jPzP43oajvF/2kO6Lt1LxgMMaFn0DlTkBkg=;
        b=W4P1PGyAoApGmY0KllX1HwQT4XKQ7m7L0iCBoXbIUdbyXvgBzB0jLeVZrAw/CskEwf
         yntdjH3T3KoMWmDm5Ipr1E0CRt/zUD+7JsKqoACPw6P/uaM3+3gjJI/nvyuRRLsPoi7B
         N1mG1lWH/FMEcBWsGT7iLD+kEd3fk4GWNFsCSzz52wPjAH2ALiioZCXHihKAhmyyoVZB
         r0ffjipFEvqyEPPDldRrP6AK1jxJCIfjT28/zBHBSm+X+g4O9hp4Eh59/Q+MufiEDFpb
         NKDlEdxllB9kXy4ioGEoZNkTMouLC1xGuUvwbNX9PViRJMiZ+BQ8+ZHNUMeY/IfNE5Ks
         t7uA==
X-Gm-Message-State: APt69E0TFeU3p0XGutvNJ1pGWqRbKtBnpLdSulWm0ZkayAZVdI+IZL6A
        hUH8FwbiTe9sISwKYOPIERPh3V8n8/r7B7DgBQ+eeTMVNCY=
X-Google-Smtp-Source: AAOMgpfc2R3PQdtVEGkapRpyS6fOHwDj1t3yzgG2GG0tHlhg3Yf2lfh59ektGHUwg7KldP+F//Clg6omAChwt/lvGW4=
X-Received: by 2002:a17:902:7407:: with SMTP id g7-v6mr10967576pll.85.1530354450485;
 Sat, 30 Jun 2018 03:27:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Sat, 30 Jun 2018 03:27:09
 -0700 (PDT)
In-Reply-To: <201806301538.bewm1wka%fengguang.wu@intel.com>
References: <201806301538.bewm1wka%fengguang.wu@intel.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 30 Jun 2018 12:27:09 +0200
Message-ID: <CACT4Y+b+7T3M=5EbHSpJmMAkRQnXih2+JZqeAvxht2zzKyjD2A@mail.gmail.com>
Subject: Re: /tmp/cctnQ1CM.s:35: Error: .err encountered
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 30, 2018 at 9:15 AM, kbuild test robot <lkp@intel.com> wrote:
> Hi Dmitry,
>
> FYI, the error/warning still remains.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   1904148a361a07fb2d7cba1261d1d2c2f33c8d2e
> commit: 758517202bd2e427664857c9f2aa59da36848aca arm: port KCOV to arm
> date:   2 weeks ago
> config: arm-allmodconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 758517202bd2e427664857c9f2aa59da36848aca
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.2.0 make.cross ARCH=arm
>
> All errors (new ones prefixed by >>):
>
>    /tmp/cctnQ1CM.s: Assembler messages:
>>> /tmp/cctnQ1CM.s:35: Error: .err encountered
>    /tmp/cctnQ1CM.s:36: Error: .err encountered
>    /tmp/cctnQ1CM.s:37: Error: .err encountered

Hi kbuild test robot,

The fix was mailed more than a month ago, but still not merged into
the tree. That's linux...
