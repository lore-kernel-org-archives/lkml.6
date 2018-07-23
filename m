Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6EAECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EAD320685
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u+2D78X8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EAD320685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388566AbeGWNpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:45:33 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:54562 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388102AbeGWNpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:45:32 -0400
Received: by mail-it0-f67.google.com with SMTP id s7-v6so1239938itb.4;
        Mon, 23 Jul 2018 05:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UfindXUFk/1E82R9Y9cAhgsZnwh38465tW8YwtHVSc8=;
        b=u+2D78X88OA6oKxZ4GhA4tmS/vQTxnaw6Aik/Dac0khskFbEuV1+H1LwSNhmHGXDhZ
         bbMfUbBy0SD/Bk5q+2l3pX9S9RXhz4Dum3iVNyZeOZVnDF79WfFsauUxon5HjFycz+bn
         bkgrKZPbWtNYxDGjA/aC+L+7HC8d9wnG1K7nH1EiAjUSjR9DOry+LeRjc6Jz8M/Oraqx
         RHicAQ1YdcjCc/MSYU7eHqjVqgxC/0CX0Bi+Zne+zkvysKiX/oFiOr4PdYyFtOXgP4li
         +tq2jMrwKQEGK8UPpO3xiAHKSXMbOoHF+l0LMbfI1M/pIXRJElXKj+0u49LwNgDk1FxK
         DITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UfindXUFk/1E82R9Y9cAhgsZnwh38465tW8YwtHVSc8=;
        b=QopoOA15q4IDkht0ajgwYmmxe0JP4q/9kDo6R1MW2RwdV/JVk1+kCBIxg7o5ByZagr
         BL3aQrRYncAa4bhs51CZ7PsX3j6vSTEImkOtiIVIEIjdfrrtyIQV72d6zqc2aZ2ZdXU+
         KAw1u2srJnrEh4btVH7Hl363areBDRwuR5eH3RaIRFnApOb8tLO/CcAOgZSpY9Sfm0zY
         1WeAEdCcjnIgucDGp90iKrb+k9nfgg3R2YNBTXCuU8KvNBDBQPzJu23xCx3x6RchLW1P
         cFh8eQp+nOvKs3IV2IwO72gVnUgZ+4eHBdl7gSSXSKA1gbK3jdXvol4e/pDI7/D229Ob
         rCBQ==
X-Gm-Message-State: AOUpUlHH5741A25FIVwDO0TmPUod6m8OgveuenHwsoNbrRnbG01mus3V
        q1cFLHYWfI0STvDUU5fNelo32rnDhjHBTdOq4bE=
X-Google-Smtp-Source: AAOMgpeznpuxXz1fgPRdKGJkdwP885bprNm+2g0ENA3cwPRolL1PqHFbtlk+myRoVrej510nrauwWJ4qDOAmxXkthuQ=
X-Received: by 2002:a24:83c6:: with SMTP id d189-v6mr10778353ite.75.1532349869227;
 Mon, 23 Jul 2018 05:44:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180723123429.20040-1-yuehaibing@huawei.com>
In-Reply-To: <20180723123429.20040-1-yuehaibing@huawei.com>
From:   Ilia Lin <ilia.lin@gmail.com>
Date:   Mon, 23 Jul 2018 15:44:17 +0300
Message-ID: <CA+5LGR0VAN-RQvEBNNJ08YEQVgW=NZ-pgBq=DByAfTwXonfiRQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: qcom-kryo: add NULL entry to the end
 of_device_id array
To:     yuehaibing@huawei.com
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 3:38 PM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Make sure of_device_id tables are NULL terminated
> Found by coccinelle spatch "misc/of_table.cocci"
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/cpufreq/qcom-cpufreq-kryo.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-kryo.c
> index 29389ac..efc9a7a 100644
> --- a/drivers/cpufreq/qcom-cpufreq-kryo.c
> +++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
> @@ -183,6 +183,7 @@ static struct platform_driver qcom_cpufreq_kryo_driver = {
>  static const struct of_device_id qcom_cpufreq_kryo_match_list[] __initconst = {
>         { .compatible = "qcom,apq8096", },
>         { .compatible = "qcom,msm8996", },
> +       {}
>  };
>
>  /*
> --
> 2.7.0
>
>

Acked-by: Ilia Lin <ilia.lin@kernel.org>
