Return-Path: <krzk@kernel.org>
X-Google-Smtp-Source: AB8JxZoayY9RTMA7YQQh4l81IkWTcU1OjF6g3g/cznIHk8bTTbGrk7uKcRu/DRF+OcQabjKa5ueW
ARC-Seal: i=1; a=rsa-sha256; t=1526300995; cv=none;
        d=google.com; s=arc-20160816;
        b=oJ/NIGU62UNz229hVcTItb14X/L3dmJb/e4FkZlF1GivBf0bX2adBnTQnfwOT1Wf5u
         fxiP9cAljj7gX4/NGDXnnPv6b7uUogGrIHvPLWgqUL1JqMqGbmYGCBuNhS7NoD1NOAUJ
         f9optIkjqu4W0Rm5Yd3zn+AOnHANf2gDMgc/XR0csqwmNYQQcSOvVXu4M1WoRsqLo8wu
         iFmFo359yUkau6p+RBwf1MsCUxZz/riUT0y8LfDK/xihIFYSqzJHJtzp+k3TYWrY1ueB
         u0p8v18PtGSWwXxxwQw2C8SBUwUF3I66ZYQAqptwNp82JfwrcyaPPSmMTYJ0WXBcBBqo
         OJzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=1X5J5gtTgYlP7kme2yn3naKoZ+w2TI7LH8LevjEWPFs=;
        b=fBhjvxz7S+lZDjmOwnyLZdXM4kly7Ykxn3z+yFUGHPlI3jW1/Ueij9DR3M7hwsxe14
         kWJ4k119NSjODNsB+oGCnYvPsr8+LEl9pMXd6yPQLsbdxcFpJ3RkayHNz0ZgtszTbYLO
         jXxBpDfmTqZe+bo8dKHdKHAWfhNqKSOb36LSJLZGU2ES3BzgDJHSgllEETvDgJAUtAlm
         WatAv0p2iOBeXYjc++e5g+j/K2EgxgNJaAVUr+HK/MxDir1weU0B1ZMHfJvno8oPONyD
         yJHvtigVD8y3LXKLqdu1qUAeYHYrOLSJPEMLrwdlu7qWHaVZIFcY5BcAogcvAiYGuogt
         Kg1Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=onFRoqTJ;
       spf=pass (google.com: domain of krzk@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=krzk@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=onFRoqTJ;
       spf=pass (google.com: domain of krzk@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=krzk@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
MIME-Version: 1.0
In-Reply-To: <b193b8a0-ad25-1895-8f8d-ffab97261dc1@samsung.com>
References: <CGME20180514101728epcas4p3108760546a415b36252df93dfe38e0fb@epcas4p3.samsung.com>
 <CAJKOXPfD8gZR8nZkmAr=Ldt3xESuFocQLnMtrDsNZu=ba55jcw@mail.gmail.com> <b193b8a0-ad25-1895-8f8d-ffab97261dc1@samsung.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 14 May 2018 14:29:52 +0200
X-Gmail-Original-Message-ID: <CAJKOXPc+kLA+BPBmaP14zMLbbxxCmWF1eZnKoa_PcO2z9jG9JQ@mail.gmail.com>
Message-ID: <CAJKOXPc+kLA+BPBmaP14zMLbbxxCmWF1eZnKoa_PcO2z9jG9JQ@mail.gmail.com>
Subject: Re: [FAIL bisect] Sound card probe error
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Marek Szyprowski <m.szyprowski@samsung.com>,
	Mark Brown <broonie@kernel.org>, Inki Dae <inki.dae@samsung.com>,
	"linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, Andrzej Hajda <a.hajda@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600434255100788752?=
X-GMAIL-MSGID: =?utf-8?q?1600442592341088889?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 14, 2018 at 2:22 PM, Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
> Hi,
>
> On 05/14/2018 12:17 PM, Krzysztof Kozlowski wrote:
>
>> Bisected to:
>> 8c123c14bbba4add148536b6d47a9226deda2f7a is the first bad commit
>> commit 8c123c14bbba4add148536b6d47a9226deda2f7a
>> Author: Ulf Hansson <ulf.hansson@linaro.org>
>> Date:   Thu Apr 26 10:53:06 2018 +0200
>>
>>     driver core: Respect all error codes from dev_pm_domain_attach()
>>
>>     The limitation of being able to check only for -EPROBE_DEFER from
>>     dev_pm_domain_attach() has been removed. Hence let's respect all error
>>     codes and bail out accordingly.
>>
>>     Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>     Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The DRM driver creates the HDMI codec but its registration fails, due
> to some missing clocks. The clock are missing because the exynos5-subcmu
> driver probing fails.
>
> [    0.678578] exynos5-subcmu: probe of GSC failed with error -17
> [    0.679250] exynos5-subcmu: probe of MFC failed with error -17
> [    0.679992] exynos5-subcmu: probe of DISP failed with error -17
>
> The exynos5-subcmu driver before registering platform device makes
> of_genpd_add_device() call, so in platform_drv_probe() dev_pm_domain_attach()
> call will fail, as dev->pm_domain is already set. Previously the error
> was masked by code removed in the above commit and platform_drv_probe()
> was could complete successfully.

Thanks Sylwester!

Ah, I missed these messages because I was looking at err dmesg level
(and for some reason these are warn). Anyway do you have any thoughts
how is it connected with missing Odroid XU3 sound card and max98090
codec?

Best regards,
Krzysztof
