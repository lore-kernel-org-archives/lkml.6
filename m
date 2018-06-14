Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6B75CC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 12:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21174208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 12:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DK6l+OWU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21174208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755215AbeFNMJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 08:09:36 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:36657 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754967AbeFNMJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 08:09:31 -0400
Received: by mail-qk0-f194.google.com with SMTP id a195-v6so3437807qkg.3;
        Thu, 14 Jun 2018 05:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3ix25G6zICD9aN0ZFxu8TpDHkhOHsCVZwo28mLSNxfo=;
        b=DK6l+OWUf8VSuhkGhx/SCoKiRJ3+PyPR6mKr/UjDHAjDblgeZaNhVA40AzuHLmRkcK
         nM9QQz3hZ0B+m1JOx0Qh5SHCn4NLWpJ1nxTfga1nSU77znPJe/9MyQuySnBFelCZN4D2
         xzsLbfnPa8RXa+mXiMQ8uRuuRXzY/X9koMuT+zys1mjcrCOv5zVM7vGbhtO/pIpnzqut
         qzyrCZ1MJtbtSoI42yuCKGyzdWtYK40lGIbleCYJZ9YZqQOYLMptbhP7AY2jYHkU/Qlp
         Jq5JxCxzaDVdCyAPQA1dV+YkQk2ogw2VsWsI77gCUB2S3q/nooUDwdx4MxSmaf9ZAjGs
         4ewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3ix25G6zICD9aN0ZFxu8TpDHkhOHsCVZwo28mLSNxfo=;
        b=AE0vlbd4HuHD3CReOKIgEKXY8xCQl3jigfy7IZBno/DQbVX1ZY1MmaUtU3SgbhjhYS
         4rWRzzbLqkJAfPc121i1i9bVplcVOCKPq0xufcrSInxgAwxademNRKcxBg8gcRSmpBAq
         /fMa0vSbNrDR7IuEMKDSaI8g3frVAdkgreTm5GfIhHbJXK97X/lX1XWkE5CNn1zcGWf1
         2kJ5nICG3Zqmf1jE3BrTox9VPX6vzs/igmXqMxbjofSg2clc5P1A4mojDyb3z3HS3iZT
         I+b1WfSkTmmjm4WltsA3BpwG2KQ+GS78eVG/k/g3JVRBsX7lEtbuAh91vUF4Zx2jb4Ex
         NC9g==
X-Gm-Message-State: APt69E1j4hjYxTrvIqIBnZB9lfJd5anFJt3r6bLwLawSpyFWd61cAy9Q
        lJnihdt4p3OxPZPiUxABsPcGHfEzKIVhFcYXw3dl2w==
X-Google-Smtp-Source: ADUXVKKPSgex2Tq8CtYabfnlwFvC3MBlY5qbb/oFFRNtqqEdDBq1vqddvf2BM7woGfeJCld2kHMkks1ODS4FP/9i+TE=
X-Received: by 2002:a37:a441:: with SMTP id n62-v6mr1750044qke.125.1528978170941;
 Thu, 14 Jun 2018 05:09:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:22b2:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 05:08:50
 -0700 (PDT)
In-Reply-To: <CADYN=9+3V4fpqbjh-X4VUVWd_X38XSYhEbZoRBffcx=-nMtF8g@mail.gmail.com>
References: <20180612110510.11731-1-anders.roxell@linaro.org>
 <d6851756-ae3b-09ec-f487-1eeece6bd4c6@iogearbox.net> <CALDO+SY3qNYAOSiYC3645C7YY9LSx7ggg0GjY76m4TbBfF_t3A@mail.gmail.com>
 <CADYN=9+3V4fpqbjh-X4VUVWd_X38XSYhEbZoRBffcx=-nMtF8g@mail.gmail.com>
From:   William Tu <u9012063@gmail.com>
Date:   Thu, 14 Jun 2018 05:08:50 -0700
Message-ID: <CALDO+SZXvnUU7VKd_UwnBCU0NiTHjqei4xEUCdcktkKCD3MnEg@mail.gmail.com>
Subject: Re: [PATCH] selftests: bpf: config: add config fragments
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 4:42 AM, Anders Roxell <anders.roxell@linaro.org> wrote:
> On 14 June 2018 at 13:06, William Tu <u9012063@gmail.com> wrote:
>> On Tue, Jun 12, 2018 at 5:08 PM, Daniel Borkmann <daniel@iogearbox.net> wrote:
>>> On 06/12/2018 01:05 PM, Anders Roxell wrote:
>>>> Tests test_tunnel.sh fails due to config fragments ins't enabled.
>>>>
>>>> Fixes: 933a741e3b82 ("selftests/bpf: bpf tunnel test.")
>>>> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
>>>> ---
>>>>
>>>> All tests passes except ip6gretap that still fails. I'm unsure why.
>>>> Ideas?
>>
>> Hi Anders,
>>
>> ip6erspan is based on ip6gretap, does ip6erspan pass?
>
> it did pass  when I was sending the email.
> However, I retested this on next-20180613 and now it fails.
>
Does 'ip -s link show' show any errors/dropped on ip6gretap device?

Thanks
William
