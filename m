Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7511FC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 007F220881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mbsQX7y5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 007F220881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbeJPTTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 15:19:54 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:44321 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbeJPTTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 15:19:54 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181016112952euoutp02a741a32c24f09add28a1ec5aae629a65~eE1gsGKaI2128821288euoutp02X
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 11:29:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181016112952euoutp02a741a32c24f09add28a1ec5aae629a65~eE1gsGKaI2128821288euoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539689392;
        bh=NdHPdm903Q9ZUXzQzTAuwBJKyToZ48XV+3MquRdpFLU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=mbsQX7y5ug8G5ETu6qv1K+UsXQ6bHbdhvdther30CPZ+ym0lzPO5JABTFIyerJbb3
         RMXiaR9PWJVt88GPC7stjKdCiAKY+zYR2UWdFmwZvgcNXRj4/IYk+B7mivzFV+fNex
         /jyvRWAC4ThE8iSSs1NkQuSQuw+lRWupcgGOIIT4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181016112951eucas1p19c1a4a9cb8094b3f4327679556414fed~eE1f7ABzl0931409314eucas1p1X;
        Tue, 16 Oct 2018 11:29:51 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 60.30.04294.EABC5CB5; Tue, 16
        Oct 2018 12:29:50 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181016112950eucas1p1a1d804f56c40ac01e5ef84c067c29d1a~eE1fNuopO0937209372eucas1p1O;
        Tue, 16 Oct 2018 11:29:50 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181016112950eusmtrp22bb43eca59535f98914034fdede60d19~eE1e_0tyD1038510385eusmtrp2G;
        Tue, 16 Oct 2018 11:29:50 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-2c-5bc5cbae7027
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 4C.EB.04128.EABC5CB5; Tue, 16
        Oct 2018 12:29:50 +0100 (BST)
Received: from [106.120.43.17] (unknown [106.120.43.17]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181016112949eusmtip20ed88d3027e5d420e6d79a18244f004d~eE1em74js0540005400eusmtip2a;
        Tue, 16 Oct 2018 11:29:49 +0000 (GMT)
Subject: Re: [PATCH 1/3] driver core: add probe_err log helper
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>
From:   Andrzej Hajda <a.hajda@samsung.com>
Date:   Tue, 16 Oct 2018 13:29:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VfVxEkTzc=1hBrvc4K7r=L28vXipb=j9jSRJbTJE4GtLQ@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDKsWRmVeSWpSXmKPExsWy7djPc7rrTh+NNrh+19Li5YTDjBYbZ6xn
        tZj68AmbRfPi9WwWC6ctZ7TY9Pgaq8XlXXPYLNYeuctuMffLVGYHTo+ds+6ye2xa1cnmsX/u
        GnaPzUvqPd7vu8rm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBmHV7xnLrgpWzF/wlP2Bsbf
        ol2MnBwSAiYS679PZO5i5OIQEljBKLH8xERGCOcLo8SzaS9YIJzPjBJz9k9gg2npntoI1bKc
        UWJl52wo5y2jxOGNF9hBqoQF7CQ+bzgK1M7OISKgL7G/DKSEWWASs8TeC/fABrEJaEr83XwT
        zGYRUJVY8Ww2C4gtKhAhceTBQkYQm1dAUOLkzCdgcU6BQIlJJ76C2cwC8hLNW0H2gtjiEree
        zGeCOO4Uu8SDSSYQvWUSs58uYoaIu0jsfHAayhaWeHV8CzuELSPxfydMb71E08wrYL9ICHQw
        SpxYvBzqY2uJw8cvsnYxcgAt05RYv0sfIuwosW/9XmaQsIQAn8SNt4IQ5/BJTNo2HSrMK9HR
        JgRRrShx/+xWqAvEJZZe+Mo2gVFpFpInZyF5bBaSx2Yh7F3AyLKKUTy1tDg3PbXYKC+1XK84
        Mbe4NC9dLzk/dxMjME2d/nf8yw7GXX+SDjEKcDAq8fD+uH4kWog1say4MvcQowQHs5IIL/PB
        o9FCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeZfN2xgtJJCeWJKanZpakFoEk2Xi4JRqYNRo0n0r
        1v3G4vPZtRvOmniYHCy4oDJRe372wUOqr9h3quYXzOm/4vx4stvzvtjEs4uvnfY3VI/7n3Hj
        kNMye8W27ee3RKiua9H5YP4nLzhD+Om2GcwnTOtOLb5gIZ/jEmj85u0XzntKe95KPL9oLcNe
        tyVsUV11Qj5/9C/jaVKTtn1X+q+feFqJpTgj0VCLuag4EQDyi+1yTwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsVy+t/xe7rrTh+NNvh9lMvi5YTDjBYbZ6xn
        tZj68AmbRfPi9WwWC6ctZ7TY9Pgaq8XlXXPYLNYeuctuMffLVGYHTo+ds+6ye2xa1cnmsX/u
        GnaPzUvqPd7vu8rm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbm
        sVZGpkr6djYpqTmZZalF+nYJehmHV7xnLrgpWzF/wlP2Bsbfol2MnBwSAiYS3VMbmbsYuTiE
        BJYySkz594YFIiEusXv+W2YIW1jiz7UuNoii14wSH65/BysSFrCT+LzhKJDNziEioC+xvwwk
        yiwwjVni/GxdiPIGJolFqy6BlbMJaEr83XyTDcTmBWndegpsPouAqsSKZ7PBakQFIiRWL3/B
        ClEjKHFy5hOwOKdAoMSkE19ZIBaoS/yZd4kZwpaXaN46G8oWl7j1ZD7TBEahWUjaZyFpmYWk
        ZRaSlgWMLKsYRVJLi3PTc4uN9IoTc4tL89L1kvNzNzECI3PbsZ9bdjB2vQs+xCjAwajEw/vj
        +pFoIdbEsuLK3EOMEhzMSiK8zAePRgvxpiRWVqUW5ccXleakFh9iNAV6biKzlGhyPjBp5JXE
        G5oamltYGpobmxubWSiJ8543qIwSEkhPLEnNTk0tSC2C6WPi4JRqYDR6cPKhroCxoe2nTL8D
        9mbCMbvWzp56uH5z0LaSG935tbskG7n/vdxez19QELtr9zPTPgGhB/+/VZ6OOnxZa9PWuBUH
        F1doti6aay6Tq7ijoEoqTcssWkvrqOGypXnyC8RmrVCZkfTi8yOXwzlb++9If+r6HKFyfLN9
        z80lb2KuX5QWC5uovkaJpTgj0VCLuag4EQANYsaW4gIAAA==
Message-Id: <20181016112950eucas1p1a1d804f56c40ac01e5ef84c067c29d1a~eE1fNuopO0937209372eucas1p1O@eucas1p1.samsung.com>
X-CMS-MailID: 20181016112950eucas1p1a1d804f56c40ac01e5ef84c067c29d1a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181016072249eucas1p2303b8c06a9f7c839a971fe065b0c752e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181016072249eucas1p2303b8c06a9f7c839a971fe065b0c752e
References: <CGME20181016072249eucas1p2303b8c06a9f7c839a971fe065b0c752e@eucas1p2.samsung.com>
        <20181016072244.1216-1-a.hajda@samsung.com>
        <20181016072244.1216-2-a.hajda@samsung.com>
        <CAHp75VfVxEkTzc=1hBrvc4K7r=L28vXipb=j9jSRJbTJE4GtLQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.10.2018 13:01, Andy Shevchenko wrote:
> On Tue, Oct 16, 2018 at 10:22 AM Andrzej Hajda <a.hajda@samsung.com> wrote:
>> During probe every time driver gets resource it should usually check for error
>> printk some message if it is not -EPROBE_DEFER and return the error. This
>> pattern is simple but requires adding few lines after any resource acquisition
>> code, as a result it is often omited or implemented only partially.
>> probe_err helps to replace such code seqences with simple call, so code:
>>         if (err != -EPROBE_DEFER)
>>                 dev_err(dev, ...);
>>         return err;
>> becomes:
>>         return probe_err(dev, err, ...);
>>
>> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
>> ---
>>  drivers/base/core.c    | 37 +++++++++++++++++++++++++++++++++++++
>>  include/linux/device.h |  2 ++
>>  2 files changed, 39 insertions(+)
>>
>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>> index 04bbcd779e11..23fabefb217a 100644
>> --- a/drivers/base/core.c
>> +++ b/drivers/base/core.c
>> @@ -3067,6 +3067,43 @@ define_dev_printk_level(_dev_info, KERN_INFO);
>>
>>  #endif
>>
>> +/**
>> + * probe_err - probe error check and log helper
>> + * @dev: the pointer to the struct device
>> + * @err: error value to test
>> + * @fmt: printf-style format string
>> + * @...: arguments as specified in the format string
>> + *
>> + * This helper implements common pattern present in probe functions for error
>> + * checking: print message if the error is not -EPROBE_DEFER and propagate it.
>> + * It replaces code sequence:
>> + *     if (err != -EPROBE_DEFER)
>> + *             dev_err(dev, ...);
>> + *     return err;
>> + * with
>> + *     return probe_err(dev, err, ...);
>> + *
>> + * Returns @err.
>> + *
>> + */
>> +int probe_err(const struct device *dev, int err, const char *fmt, ...)
>> +{
>> +       struct va_format vaf;
>> +       va_list args;
>> +
>> +       if (err != -EPROBE_DEFER) {
> Why not
>
> if (err == ...)
>  return err;
>
> ...
> return err;
>
> ?
>
> Better to read, better to maintain. No?

Yes, anyway next patch will re-factor it anyway.

>
>> +               va_start(args, fmt);
>> +
>> +               vaf.fmt = fmt;
>> +               vaf.va = &args;
>> +
>> +               __dev_printk(KERN_ERR, dev, &vaf);
> It would be nice to print an error code as well, wouldn't it?

Hmm, on probe fail error is printed anyway (with exception of
EPROBE_DEFER, ENODEV and ENXIO):
    "probe of %s failed with error %d\n"
On the other side currently some drivers prints the error code anyway
via dev_err or similar, so I guess during conversion to probe_err it
should be removed then.

If we add error code to probe_err is it OK to report it this way?
    dev_err(dev, "%V, %d\n", &vaf, err);

Regards
Andrzej

>
>> +               va_end(args);
>> +       }
>> +
>> +       return err;
>> +}
>> +
>>  static inline bool fwnode_is_primary(struct fwnode_handle *fwnode)
>>  {
>>         return fwnode && !IS_ERR(fwnode->secondary);
>> diff --git a/include/linux/device.h b/include/linux/device.h
>> index 90224e75ade4..06c2c797d132 100644
>> --- a/include/linux/device.h
>> +++ b/include/linux/device.h
>> @@ -1577,6 +1577,8 @@ do {                                                                      \
>>         WARN_ONCE(condition, "%s %s: " format, \
>>                         dev_driver_string(dev), dev_name(dev), ## arg)
>>
>> +int probe_err(const struct device *dev, int err, const char *fmt, ...);
>> +
>>  /* Create alias, so I can be autoloaded. */
>>  #define MODULE_ALIAS_CHARDEV(major,minor) \
>>         MODULE_ALIAS("char-major-" __stringify(major) "-" __stringify(minor))
>> --
>> 2.18.0
>>
>

