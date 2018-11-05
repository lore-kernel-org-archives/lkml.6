Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E242ECDE44
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 05:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0077920685
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 05:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="D5gKzrCC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0077920685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbeKEO2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 09:28:13 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45523 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728918AbeKEO2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 09:28:13 -0500
Received: by mail-ot1-f68.google.com with SMTP id g10so6816893otl.12;
        Sun, 04 Nov 2018 21:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OwePt3wgB2qqcmwt9IwlwwBhSLsCCpbxijgljI9iwlk=;
        b=D5gKzrCCebKOJD6qoWpWKpRmGVh4d4Ummzx7BZapE3ABDWQeBGRT+qRixRXpW3ec63
         4nlYYutCBYRuoeo+xEnjtOAUNWlx6NQljY+HUzwkiR/lRU0cf4PmQZVWYqOWq2MGw3VE
         aqfP5L/htUPCis50ur6cRbqAb060M7ln4UddY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OwePt3wgB2qqcmwt9IwlwwBhSLsCCpbxijgljI9iwlk=;
        b=cPDmRsmJAQY5rCml+TcB/uAK68DnYt2KSQRRYKIdIUBbTK/iOnh5k1jhGWYhiHF3f4
         Oe4uEmbDWO5ET8nHoi9gUvRygRtCikSvQNP9X7CjVskpLj67AE/Bb8DuDNt9h9SDtV2Y
         7dU/FdD1frGsily/SbiY/OpZQ18f1wy3J3ACEv2lzYeplAIL5bUqnxmPKnDhFP/OztEK
         KCH8N2pTH1UVDzwNTBojZfM8OGZS9zNArebNFE2R1n81TY5UokBDZQJexFuYP997IrLW
         ZVlyRe1ruDCNM9Et9l6fAC3eSJ8auMFyRkuzrwh8N8AjchPn7rmRhlKI3FBy6W6COxZF
         2Qhw==
X-Gm-Message-State: AGRZ1gIH8JewiWLcQtl13PGfZi8pBBCQe1+U9+qlCBsUkr2Idcoertbr
        9O8VnwATYqExrsFL1dk2B4tXOd0LLrNTlPPeBdo=
X-Google-Smtp-Source: AJdET5dhy2QHpYACskikjDPEq9blkMjL2qcc0yxNRXY4cKxp6fB+iDWf3Qk0cIgM6FthBCrh0Qqso3o8uK4tdDNlsBs=
X-Received: by 2002:a9d:2817:: with SMTP id m23mr13011032otb.168.1541394624158;
 Sun, 04 Nov 2018 21:10:24 -0800 (PST)
MIME-Version: 1.0
References: <20181101013257.659-1-zhaoweiliew@gmail.com>
In-Reply-To: <20181101013257.659-1-zhaoweiliew@gmail.com>
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Mon, 5 Nov 2018 10:40:12 +0530
Message-ID: <CAOh2x=nSWwN90GsyRokUoCZo5OLHN-LyVS3t3rpcAMn0v6+yVA@mail.gmail.com>
Subject: Re: [PATCH] Documentation: cpufreq: Correct a typo
To:     zhaoweiliew@gmail.com, "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Documentation <linux-doc@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Rafael

On Thu, Nov 1, 2018 at 7:06 AM Zhao Wei Liew <zhaoweiliew@gmail.com> wrote:
>
> Fix a typo in the admin-guide documentation for cpufreq.
>
> Signed-off-by: Zhao Wei Liew <zhaoweiliew@gmail.com>
> ---
>  Documentation/admin-guide/pm/cpufreq.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/pm/cpufreq.rst b/Documentation/admin-guide/pm/cpufreq.rst
> index 47153e64dfb5..7eca9026a9ed 100644
> --- a/Documentation/admin-guide/pm/cpufreq.rst
> +++ b/Documentation/admin-guide/pm/cpufreq.rst
> @@ -150,7 +150,7 @@ data structures necessary to handle the given policy and, possibly, to add
>  a governor ``sysfs`` interface to it.  Next, the governor is started by
>  invoking its ``->start()`` callback.
>
> -That callback it expected to register per-CPU utilization update callbacks for
> +That callback is expected to register per-CPU utilization update callbacks for
>  all of the online CPUs belonging to the given policy with the CPU scheduler.
>  The utilization update callbacks will be invoked by the CPU scheduler on
>  important events, like task enqueue and dequeue, on every iteration of the

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
