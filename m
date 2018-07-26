Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2DBC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 099B92088E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ONc76Jho"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 099B92088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbeGZIX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 04:23:29 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:43920 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbeGZIX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 04:23:29 -0400
Received: by mail-yw0-f196.google.com with SMTP id l189-v6so232089ywb.10
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 00:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FVSJZCiFHzM4XqljDCJrBxMa7hjIavcFbMDnq2EKWp4=;
        b=ONc76Jho84L+Z/58N+DD20i57aW7IHPRcPhS92pMYiFWSHEzeDFoA6D9bdQPlkpfVa
         lP+HY6HH79enGlqxqdsfJDIvXSplfLjwWE+WLQ7rLmnuoTXbzpy4REfrBUns/QpQvk+8
         4aWuzS14EoOq/fdniWC45ToZO6DEVJQbEHfVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FVSJZCiFHzM4XqljDCJrBxMa7hjIavcFbMDnq2EKWp4=;
        b=CKtC6P2kqD7YiV4fqwaJlgztr5Z5IXMI2nmtSJvDkkt0aCpeKzXUjMhUvJ2InCxne7
         9u8gCiwrgLFckePXbjQHBKZ3FpSGwldYBm1Ab+wAVDD3thDH9HDPi3rSxbX0P0Okz8EI
         6+UTE8ByUNs72cP2ZQ5LHBtq91fs+XueRT5kAwO3X7bJvdMsW/bg8XUfIYpgFzo2PTRs
         b63I9dL4umcdLIh9N/9op+py3nKc7capKSXFK3awjLfKrSMwMt7Ic+lqB6fH/LorlGlk
         a/i73Fgv3MgmAftIazXrFYDtvKP+n7XnF1js91VIiL3yfE11Dee0Pf8dsuoVCw7TZSkI
         v2VA==
X-Gm-Message-State: AOUpUlEfeldmce2rJsS1im0uLD6l8HhoGTMYWVMScFC1+jK+E8Z38QjF
        cb8it7kW/MUSFzV1/mEu9aDfUttVyR/Sj5cynWRIWg==
X-Google-Smtp-Source: AAOMgpdVKwtUKD96XqQkKTGd4uPQvvOcpyLyWin1W72MIQEr/xzL8i1M/j4Mckb0nQRbYTOaSFSidvmcp+MSBcQjpJg=
X-Received: by 2002:a0d:f704:: with SMTP id h4-v6mr332724ywf.240.1532588883144;
 Thu, 26 Jul 2018 00:08:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180620225412.7894-1-anders.roxell@linaro.org>
In-Reply-To: <20180620225412.7894-1-anders.roxell@linaro.org>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Thu, 26 Jul 2018 09:07:52 +0200
Message-ID: <CADYN=9L9VutVezvXdXs_6htMvBJtdj2KxaGDc8XN7jV3hdAskg@mail.gmail.com>
Subject: Re: [PATCH] selftests: cgroup: add gitignore file
To:     Shuah Khan <shuah@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jun 2018 at 00:54, Anders Roxell <anders.roxell@linaro.org> wrote:
>
> Add the executable 'test_memcontrol' to a .gitignore file.
>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  tools/testing/selftests/cgroup/.gitignore | 1 +
>  1 file changed, 1 insertion(+)
>  create mode 100644 tools/testing/selftests/cgroup/.gitignore
>
> diff --git a/tools/testing/selftests/cgroup/.gitignore b/tools/testing/selftests/cgroup/.gitignore
> new file mode 100644
> index 000000000000..95eb3a53c381
> --- /dev/null
> +++ b/tools/testing/selftests/cgroup/.gitignore
> @@ -0,0 +1 @@
> +test_memcontrol
> --
> 2.17.1
>

Ping.
