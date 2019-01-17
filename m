Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF43C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9248220868
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BJTktPTw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbfAQVs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 16:48:57 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43999 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbfAQVs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 16:48:57 -0500
Received: by mail-pf1-f196.google.com with SMTP id w73so5457599pfk.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 13:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pd2EzrbE8UNkN+1l0qonyvOjX1yyRlmFOi4YNJHhoqo=;
        b=BJTktPTwqO1/8Xzn77cNQ2I4p61LxviC1OwwRpkA5TfHB7A73HKbMNH1k73g72+ik/
         A90tegIBDQLR6fuCZtV4xrcI5gT86wPXbhLo8uvJFmmksITOtCw7s2j2ApUiPZDUMX2w
         liM2Xj/aviR3LWV2oVxX1IYrrBH16dfbAv563f2lP3CqXz/SjV353WDySogR8+5csriH
         qYOTu9uPJnbq1xIeb4wDXLgqRC1ofZyK2Wj2Gp5BAQx0ty8oKKthHkY7zy64KllHmCfa
         df4nVGnwWH2b7h9z5UzXO4HB7jnlIWRPxN1+p+8f08gn5O0Bd4/bzGKRb1ajX2BKw+gV
         iYvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pd2EzrbE8UNkN+1l0qonyvOjX1yyRlmFOi4YNJHhoqo=;
        b=niuNBECv9qllScXHYfrVqpo5Q5nau9NaaFht+b/qegSCLpqscT+iBs0ZsJn0YskzRD
         6AWMF8ZYU+xv9jzwbJR+Uj2bFvc//TjYu19Ms5ka4zEWnxcAZ0AARCQYE2rqSJ3+Entk
         i/yLV21w8z0AHojups+Q0LTBW6uSdFZCv7HpTd3IOahgI2DAdZXm0wMAPwhQIy9v/94a
         0Ai2Y5kkSg7CVMIXMXaDd1JUKG8n5mPPipYVBlCgTMJn1rS/Jj53Z3WTPvqDcJPRGBez
         LftHgrHv1Xi/OGUqLadIqzIzK89iBwDdpZAGRHQngQkPvaAUVOQLkzIcpY28G7+tAqMg
         IOcQ==
X-Gm-Message-State: AJcUuke+owK8uenD0frxtpp65Hbpmjl03rALfMn8oj1jDYDsFPjDmFs3
        +xVVfTiGNaRMRINGbspsNQjWhZ4VUz3YbK7LVToLMw==
X-Google-Smtp-Source: ALg8bN4o9nmThOimuIs9AcX4Cl7HrzzedgN7zkXOWnbBaVmEu/SCdsG/ruFeKGwEmdssCSdqFQNxgOvVTohSfLNEyso=
X-Received: by 2002:a62:13c3:: with SMTP id 64mr16646998pft.93.1547761736189;
 Thu, 17 Jan 2019 13:48:56 -0800 (PST)
MIME-Version: 1.0
References: <20190115183643.120619-1-trong@google.com> <20190115183643.120619-5-trong@google.com>
 <CAKwvOdkUMpqu3_2bC1DJ47JKg-YVDZDbUOwu63uGkH+wvxA=cg@mail.gmail.com> <CAK7LNAQXY-hU+dvgRM15zRKu-noK=esQu+85uASYFPC5UwfnhA@mail.gmail.com>
In-Reply-To: <CAK7LNAQXY-hU+dvgRM15zRKu-noK=esQu+85uASYFPC5UwfnhA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 17 Jan 2019 13:48:44 -0800
Message-ID: <CAKwvOdmji0RC6Whrr5y2mcsEQhw_VA619607xAhK+XTZ5JSWVA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] gcov: clang: pick GCC vs Clang format depending on compiler
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Tri Vo <trong@android.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Greg Hackmann <ghackmann@android.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 2:19 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> > I think this was the suggestion from Masahiro from v1?
>
> Yes.
>
>
> What is strange is, 2/4 added GCOV_FORMAT_CLANG,
> then 4/4 deletes it.
>
>
> Probably, changing the patch order,
> or squashing 4/4 into 2/4 would be cleaner.

Sure; Tri, I think it's ok for you to become author of 2/4 and put a
"Co-authored-by:" tag for Greg.

-- 
Thanks,
~Nick Desaulniers
