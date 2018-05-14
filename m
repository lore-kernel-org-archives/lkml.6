Return-Path: <s.nawrocki@samsung.com>
X-Google-Smtp-Source: AB8JxZrwTGh6gYwz8jc8r87ywO5LdMYKFi0kVofY6HMiwDq/8yD2+iANpz69tKw/j15tr28v7KSi
ARC-Seal: i=1; a=rsa-sha256; t=1526300577; cv=none;
        d=google.com; s=arc-20160816;
        b=M+7k2hUchKrvrIvzi7q51YNkZPJT9TqX61kiHo7IjOmhspXregyPuT2Efio0XjdEhR
         6TJwvqdc1uqf4grc+wugsxNZXg0j6m0DNduxWD/o5yHWm1kiHj3uMWi5DZHq38VnvKKg
         iE0S7TSQ02KrRicgsUFg27PM/WSMfUbnfpExmuNjvPZVsJq+IavQua7Ay87W4qFru30i
         3ATA+UFq5AvsjnQwPV9PP3nsvlLThawAZIU4siehLTC1mpgJcRrkJm8+1L9xd5mRs6F5
         1ExkVBKsS4bwpB0TqJm5KZacscsweeyxSVEVLZ9iMsajnk6GzrmJckafyL8hF3XZxAp5
         giTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:cms-type:content-transfer-encoding:content-language
         :in-reply-to:mime-version:user-agent:date:message-id:from:cc:to
         :subject:dkim-signature:dkim-filter:arc-authentication-results;
        bh=gvsJPo3gF72I28fB9cWu7/Nhheen46tOGhuj00Fll6M=;
        b=bITyWDlckv9Kv778vmAGzfP76dgcblEeaiVDohRARjx3DmToz29XGEhUBAo/fS+f8s
         Mv4o9QfuyDm3ts+9MocnZuvkSH0y2rlRkjcP2vggURyk1pHsRiGwr3Qqwv6lteSk2oJI
         6YfE5dg54SVd/xYBAIgHWK320ivKniJlOPi3vYJKTL98SFbp7dZ4A+EQ4fs6nCogYqXJ
         i5N+mAFwdDcuP3OWnTK9KELaje2MhQlAl5BIltewxZuCGb67aQzBvPNPxmo+jxuvfKVQ
         XYKGJXbJo/D/geb5RaYN0Jz9hNbQKLd/pryYHKbeafT4MdWv1N8TY59FmbROXKYoO1Ug
         njWA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=LFbaxD0T;
       spf=pass (google.com: domain of s.nawrocki@samsung.com designates 203.254.224.24 as permitted sender) smtp.mailfrom=s.nawrocki@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=LFbaxD0T;
       spf=pass (google.com: domain of s.nawrocki@samsung.com designates 203.254.224.24 as permitted sender) smtp.mailfrom=s.nawrocki@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180514122255epoutp016a5b151e5458093e5fb870c9d7961c98~ugkmCldgQ3153631536epoutp01D
X-AuditID: b6c32a38-70fff7000000105c-bb-5af97f9fa27a
Subject: Re: [FAIL bisect] Sound card probe error
To: Krzysztof Kozlowski <krzk@kernel.org>, Ulf Hansson
	<ulf.hansson@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
	<rafael.j.wysocki@intel.com>, Marek Szyprowski <m.szyprowski@samsung.com>,
	Mark Brown <broonie@kernel.org>, Inki Dae <inki.dae@samsung.com>,
	"linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Andrzej
	Hajda <a.hajda@samsung.com>
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <b193b8a0-ad25-1895-8f8d-ffab97261dc1@samsung.com>
Date: Mon, 14 May 2018 14:22:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.7.0
MIME-version: 1.0
In-reply-to: <CAJKOXPfD8gZR8nZkmAr=Ldt3xESuFocQLnMtrDsNZu=ba55jcw@mail.gmail.com>
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7bCmnu78+p9RBneWilncWneO1WLqwyds
	Fs2L17NZTLo/gcXi/PkN7BabHl9jtbi8aw6bxYzz+5gs1h65y27xeMVbdovja8MduD0W73nJ
	5LFpVSebx51re9g89s9dw+6xeUm9R9+WVYwenzfJBbBHcdmkpOZklqUW6dslcGX8m/uQveAM
	d8WX52uYGhh3cHYxcnJICJhIXFw+m7mLkYtDSGAHo8TnnX8YIZzvjBK7v5xjgama/egtC0Ri
	N6PE8VfP2CGc+4wSc34sAKsSFjCU+P2pAaidg0NEIFDizEJhkBpmgQnMEj3rLzKD1LAB1fQe
	7WMEsXkF7CTuvZzNBmKzCKhKrL6yECwuKhAh0fT8JztEjaDEj8n3wOZzCgRL/O9eDRZnFtCU
	ePFlEguELS5x7P5NRghbXmLzmrfMEFf/ZpM4cdYe5B4JAReJUxdkIcLCEq+Ob2GHCEtLXDpq
	CxGuluhs6wJ7S0KghVHiz7RLbBAJa4nDxy+yQoznk3j3tYcVopdXoqNNCKLEQ6L98iYmiLCj
	xJHjopDQWcIocX31YfYJjHKzkDwzC8kDs5A8MAvJAwsYWVYxiqUWFOempxYbFpjoFSfmFpfm
	pesl5+duYgQnIi2LHYx7zvkcYhTgYFTi4Q1Y/iNKiDWxrLgy9xCjBAezkgjvbqOfUUK8KYmV
	ValF+fFFpTmpxYcYpTlYlMR55yh9jRISSE8sSc1OTS1ILYLJMnFwSjUwVqZIzl23SbC4Tu0l
	bzeblIvnyv07O2zzFP088jdsOD2Lv2a62vKrfgtqqlIvLpmyyqagQO3FyYNRh1w8+bJz7+wy
	39SkqKYQsfL8s8rZngtqtxwsYbO/WTTn3e8bZfmL7lu09NxaFXYs6VGJ10XhB/datNPT+V41
	b0+e76v7be1L9u+elfP4lViKMxINtZiLihMBFaS/jUADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnkeLIzCtJLcpLzFFi42I5/e+xgO68+p9RBm2dQha31p1jtZj68Amb
	RfPi9WwWk+5PYLE4f34Du8Wmx9dYLS7vmsNmMeP8PiaLtUfusls8XvGW3eL42nAHbo/Fe14y
	eWxa1cnmcefaHjaP/XPXsHtsXlLv0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBn/5j5kLzjD
	XfHl+RqmBsYdnF2MnBwSAiYSsx+9ZQGxhQR2Mkr8WhXexcgFZD9klNjy4RQTSEJYwFDi96cG
	RhBbRMBfYuK5biaQImaBScwSn3dOY4boWMYosW72FLAqNqCO3qN9YDavgJ3EvZez2UBsFgFV
	idVXFoLFRQUiJO6d/8QGUSMo8WPyPbAzOAWCJS4d2g40lANog7rElCm5IGFmAXGJY/dvMkLY
	8hKb17xlnsAoMAtJ9yyEjllIOmYh6VjAyLKKUTK1oDg3PbfYqMAwL7Vcrzgxt7g0L10vOT93
	EyMwerYd1urbwXh/SfwhRgEORiUe3hUrf0QJsSaWFVfmHmKU4GBWEuHdbfQzSog3JbGyKrUo
	P76oNCe1+BCjNAeLkjjv7bxjkUIC6YklqdmpqQWpRTBZJg5OqQbGqgrBf7dXKz933K18f13C
	ZtuIn50cEW9qF4aGTNT7zvKQsyJ4kta0tvPzPPKFjQ7Gex6Yb7jbL/Dq87rbhqWHjq8seGOX
	xWy27e0q9vpfG54xTjvBvePH4bg0J92yXSdZ7zB9XCVZt9DBMnPhf2HpW5yR7XOPv2XODohw
	/8xyY5uBYLbjLQ5DJZbijERDLeai4kQAqRlQ/ZoCAAA=
X-CMS-MailID: 20180514122254epcas1p344b9c7c39046efb2db52ed62a0bca661
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180514101728epcas4p3108760546a415b36252df93dfe38e0fb
X-RootMTR: 20180514101728epcas4p3108760546a415b36252df93dfe38e0fb
References: <CGME20180514101728epcas4p3108760546a415b36252df93dfe38e0fb@epcas4p3.samsung.com>
	<CAJKOXPfD8gZR8nZkmAr=Ldt3xESuFocQLnMtrDsNZu=ba55jcw@mail.gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600434255100788752?=
X-GMAIL-MSGID: =?utf-8?q?1600442154417763811?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 05/14/2018 12:17 PM, Krzysztof Kozlowski wrote:

> Bisected to:
> 8c123c14bbba4add148536b6d47a9226deda2f7a is the first bad commit
> commit 8c123c14bbba4add148536b6d47a9226deda2f7a
> Author: Ulf Hansson <ulf.hansson@linaro.org>
> Date:   Thu Apr 26 10:53:06 2018 +0200
> 
>     driver core: Respect all error codes from dev_pm_domain_attach()
> 
>     The limitation of being able to check only for -EPROBE_DEFER from
>     dev_pm_domain_attach() has been removed. Hence let's respect all error
>     codes and bail out accordingly.
> 
>     Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>     Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The DRM driver creates the HDMI codec but its registration fails, due
to some missing clocks. The clock are missing because the exynos5-subcmu
driver probing fails.

[    0.678578] exynos5-subcmu: probe of GSC failed with error -17
[    0.679250] exynos5-subcmu: probe of MFC failed with error -17
[    0.679992] exynos5-subcmu: probe of DISP failed with error -17

The exynos5-subcmu driver before registering platform device makes 
of_genpd_add_device() call, so in platform_drv_probe() dev_pm_domain_attach()
call will fail, as dev->pm_domain is already set. Previously the error
was masked by code removed in the above commit and platform_drv_probe()
was could complete successfully.

-- 
Regards,
Sylwester
