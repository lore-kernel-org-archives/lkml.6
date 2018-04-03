Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-461495-1522729264-2-17216158030251754524
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522729264; b=DcuhCuilzhR8CpxYD4qITVvnuilJvIf3HWOcBh0ZDg/P4E/zW4
    PSH87DHQ9d+q0oDcywxBIakIFLAREJHfyRa1VqsZM5lo8gH7OVL8yo+Yegb5RWI2
    AagsiWDWH71kYeRtsgQROkiIs4E1KkvKIOB2cExFmQqexos5n80GYiagIB82xVFE
    GtMuMiW3dIi99DHpU2Px4VLW/60qfbM0/zFmYTiQPLrQntsPZ1ZHL4axUr42S25V
    NHaQMN5+VRFKVQeoCBJAe5CgKTsR26rq4qmcplBdtoK1JTxAZ+8MCDp4b0TceBzT
    fbMY42uceozatJ7//roRaoXmgJ1hvKzO3JXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1522729264; bh=ImRhfoZF608lX9H7Hc8mlmJbDM7HKn
    803IqnnPhmxZ4=; b=sYVfg71fzR69ryggUzGojAtA3aA22OnBxSjwizkApWXrmg
    0wYmBmyktKRnDc/pYYaAnOjPK/9kZwJcQiBBKuO4ruY58CvjZZHuUfeCxkNEJ4fv
    YhXkNFuEjP2Uh0JQaHm4fLeWPpq0AwjD+nlsHgbMFlH0IwSe4Vrevr9hz+TBALbw
    w7Qyn1vAfl7YHXdCuSE02jCobmZdEUBE8E+DzjEhTX86uw+HKmM13BiQE7zEa076
    8C7eyUL4a9ISrvvH7cjGBM8gccm2JO6G+gna7FbAKmEON4RZe2zVT0L/ekHfjBin
    v+i/1mzHPkVZ9MwuLI3PL+JvRh4mU1v7Qb6Yr6hA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=X5NESXPc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Fd0kRH6F;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=X5NESXPc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Fd0kRH6F;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJhZYKQFAqg+FvvqTBxvKAE0LH5oqj3mHiHOPaeUpDwlKxl0XU+YXyI+RVQSkpCzU9JiKU95jQ+9EIS3amebdiOMNLOaK89Fks8W6bfPs1UVy/t7iDAQ
    CQr7um245Sf6coo6diX0qvDh6mPQE3Gjlo7cMjx85xEFrcZbAw9raNBk+MTiBRqZMKWuyT4vTcMxc8EjLs/l95JJ+Xp9O6rJY0zElV9fXHUrrT96gOsrVgaN
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=KKAkSRfTAAAA:8
    a=tameXWM-FVa4SESlYukA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=aeg5Gbbo78KNqacMgKqU:22 a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750842AbeDCEVA (ORCPT <rfc822;greg@kroah.com>);
        Tue, 3 Apr 2018 00:21:00 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38231 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750793AbeDCEU6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 3 Apr 2018 00:20:58 -0400
X-Google-Smtp-Source: AIpwx4/VaL04fP69nARRDCbBp4mnkuLQ+VybVqI2GJ8sMqDJvnHV4KJ+l8pyaPL+ZLFCjBf9zuAr0A==
Date: Tue, 3 Apr 2018 09:50:53 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Suman Anna <s-anna@ti.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dave Gerlach <d-gerlach@ti.com>, Tero Kristo <t-kristo@ti.com>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zumeng Chen <zumeng.chen@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] cpufreq: ti-cpufreq: Fix an incorrect error
 return value
Message-ID: <20180403042053.GG3572@vireshk-i7>
References: <20180402164958.20057-1-s-anna@ti.com>
 <20180402164958.20057-2-s-anna@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180402164958.20057-2-s-anna@ti.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02-04-18, 11:49, Suman Anna wrote:
> Commit 05829d9431df ("cpufreq: ti-cpufreq: kfree opp_data when
> failure") has fixed a memory leak in the failure path, however
> the patch returned a positive value on get_cpu_device() failure
> instead of the previous negative value. Fix this incorrect error
> return value properly.
> 
> Fixes: 05829d9431df ("cpufreq: ti-cpufreq: kfree opp_data when failure")
> Cc: Zumeng Chen <zumeng.chen@gmail.com>
> Cc: stable@vger.kernel.org

You also need to mention which version of the stable kernel this patch
should be applied to, like this:

Cc: 3.15+ <stable@vger.kernel.org> # v3.15+

Rafael would probably fix this while applying, so no need to resend
again for now.

> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
>  drivers/cpufreq/ti-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
> index a099b7bf74cd..46d1ab2dea87 100644
> --- a/drivers/cpufreq/ti-cpufreq.c
> +++ b/drivers/cpufreq/ti-cpufreq.c
> @@ -226,7 +226,7 @@ static int ti_cpufreq_probe(struct platform_device *pdev)
>  	opp_data->cpu_dev = get_cpu_device(0);
>  	if (!opp_data->cpu_dev) {
>  		pr_err("%s: Failed to get device for CPU0\n", __func__);
> -		ret = ENODEV;
> +		ret = -ENODEV;
>  		goto free_opp_data;
>  	}

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
