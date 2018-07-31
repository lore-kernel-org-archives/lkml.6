Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC3AC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 00:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 386C120894
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 00:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="rpSYbtdh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UEXwPAM+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 386C120894
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732118AbeGaCCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 22:02:37 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:42892 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731768AbeGaCCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 22:02:37 -0400
Received: by mail-yb0-f194.google.com with SMTP id c10-v6so5490461ybf.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 17:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=cVR/6swMNevywYXszFxm8idd4umMpqAM5gn2ot36WFQ=;
        b=rpSYbtdh1WDgNif6ShTNVWsNVWOEgF9lG83KyjVZVrE37HyYAWvGj8VyWBV3DOtBJO
         IEhK04AQ5glWC1/4hJ0AL7YDK386OdtB8S2j06yqi2MppFEeJPRwkme4vhXA67+3WFAb
         As+U8QaJbbkN64bamzH3SOOSYt4KUUYVpYo4YPebctAFljfl6OLR5FRvvy6QlsyT/UXv
         08xG7vryqH+fkYeeF7b9V/T+TVT9+Tai7izagGBTvNk6ylytdfGePsAvAqHWJZnGAAoV
         t+sLjrq57k9PniModNPobeXS1Nw2Pob4Ju05p0rhmx9EFeoXmpFCTPSwx1mAVzCqGmeT
         iN0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=cVR/6swMNevywYXszFxm8idd4umMpqAM5gn2ot36WFQ=;
        b=UEXwPAM+aGMhjFAs0rOQGNT4Bq73pJ6dF5XCaLAxvU3Hs74xtttIjqbOS5wJceyS+3
         2+sYEgbGZuizhU/e68TKBgWfgh+b5aQYq9e7oh24EgQMnfPxnz5zMD9f2za3TEqByo1p
         YI1i9UB5UHGJznNeR0+qtVrBWxkzUOuEITnHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=cVR/6swMNevywYXszFxm8idd4umMpqAM5gn2ot36WFQ=;
        b=SbTsnZBsM1TUKJ+mA9B9ytznu+9XSrIkmDTdyZAdKRPcgZy3KMO3A9I4EvaTxFthz5
         TWz+/t7WJtGop0rSjQFuMkCUOIR49RGzpx7WElroSrBI9ZBw2AJZMnGOrh4XJmRfzu2y
         8dR2eyNQmkVkgmJmfEy2FxCLlgxhfqSITtlyoNMvcqwlJ7FOhfoIIvJsXGklcJOAOz6Y
         tXDyv7j5DxRj9755npELggttGOpwixk2x38ac0yJKxx385bBiSai8fXR6zpdQxDWPscQ
         D/FV/qUZvoFoZrDYYrSgcLOvo+O2WrkwUQE51aXPEzxAhK+EDS7+/+ukyPp5tFHsYGM3
         f4Mg==
X-Gm-Message-State: AOUpUlE0TKRcFdBlQDSk2kfOWfcMv37lylF4cgPOYoYdwlYs+4diejRK
        MBvNb5HsHV1fIfIjmNSCTB4KzjozHEgN3nDeCgMrKCu1
X-Google-Smtp-Source: AAOMgpdJdrH7mu1Fielr4zDHPVIp/ItIOG6bH3/NLgrWmV4S+GiLrjXigER9ULSnj6To0FSFW5dPMixLZ3EmSZVpvMA=
X-Received: by 2002:a25:a302:: with SMTP id d2-v6mr10721227ybi.193.1532996706852;
 Mon, 30 Jul 2018 17:25:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:6602:0:0:0:0:0 with HTTP; Mon, 30 Jul 2018 17:25:06
 -0700 (PDT)
In-Reply-To: <CAGXu5jJhgbDYK4ZQtkZtpNPMMYwz-iH4224eULmLDdrvp-s4BA@mail.gmail.com>
References: <20180725171901.4468-1-zsm@chromium.org> <CAGXu5jJhgbDYK4ZQtkZtpNPMMYwz-iH4224eULmLDdrvp-s4BA@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 30 Jul 2018 17:25:06 -0700
X-Google-Sender-Auth: IJKk2_0LJW2ic64fOD3UhxEBTU4
Message-ID: <CAGXu5j+Zk564SijO=eXxryUTNojO7h-rgf_BuQMKesWb+zPOJg@mail.gmail.com>
Subject: Re: [PATCH v2] tracefs: Annotate tracefs_ops with __ro_after_init
To:     Zubin Mithra <zsm@chromium.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 11:00 AM, Kees Cook <keescook@chromium.org> wrote:
> On Wed, Jul 25, 2018 at 10:19 AM, Zubin Mithra <zsm@chromium.org> wrote:
>> tracefs_ops is initialized inside tracefs_create_instance_dir and not
>> modified after. tracefs_create_instance_dir allows for initialization
>> only once, and is called from create_trace_instances(marked __init),
>> which is called from tracer_init_tracefs(marked __init). Also, mark
>> tracefs_create_instance_dir as __init.
>>
>> Signed-off-by: Zubin Mithra <zsm@chromium.org>
>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Steve, do you have a tree for this or should we rope akpm in? :)

-Kees

-- 
Kees Cook
Pixel Security
