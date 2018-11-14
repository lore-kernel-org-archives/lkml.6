Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72C6C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 09:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DB3A22360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 09:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AJZsvrIR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DB3A22360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732430AbeKNTQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 14:16:07 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:62882 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727776AbeKNTQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 14:16:06 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20181114091340epoutp01ef0089779f84f29107c96d4d3d891097~m8r4b77QN0642006420epoutp01H;
        Wed, 14 Nov 2018 09:13:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20181114091340epoutp01ef0089779f84f29107c96d4d3d891097~m8r4b77QN0642006420epoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542186820;
        bh=S2gn4YyB+De3Or5KGI6Y5e7NSUVAZy6a6JvN0VmO5OI=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=AJZsvrIRKbK57WajUInZGxyhvTQ4dwI0w+SZOD81cBNjIQfhaabdYU9g/IgIchuVc
         TUbtdUZULLdxjsC43EI0e6f7FXcUf07rns+iTzuQnOEydl4LTWkyB0geHUyylCNd1T
         dGWx/3cUz8aJEP/LMZB7OvZ0UMzd/lLIECUCOAkw=
Received: from epsmges1p2.samsung.com (unknown [182.195.40.154]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20181114091338epcas1p359b0f840e44adc5774beb8c5dd6ca3ab~m8r2cWr5j0331803318epcas1p3a;
        Wed, 14 Nov 2018 09:13:38 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        5E.78.04069.247EBEB5; Wed, 14 Nov 2018 18:13:38 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181114091338epcas1p2959991201c73f2c3c703ca7b242a9f68~m8r2J89J13113131131epcas1p2z;
        Wed, 14 Nov 2018 09:13:38 +0000 (GMT)
X-AuditID: b6c32a36-f13ff70000000fe5-02-5bebe742d977
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 05.55.03701.147EBEB5; Wed, 14 Nov
        2018 18:13:38 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Received: from [10.113.63.77] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PI6009SNEYP3LA0@mmp2.samsung.com>; Wed, 14 Nov 2018 18:13:37 +0900 (KST)
Message-id: <5BEBE741.6050101@samsung.com>
Date:   Wed, 14 Nov 2018 18:13:37 +0900
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        USB <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        rogerq@ti.com, Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v1 2/5] extcon: Return -EPROBE_DEFER when extcon device
 is not found
In-reply-to: <CAHp75Vfe586+tr5mUdSHv4ehmpi0KwS_m+UC0tfFHrdXwKhkig@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta0wTWRj1dtrpoFbH+rpbI+JETWwEOmDhasC3ZlSMGN1kY2NwFu4C0k6b
        TiG6v/CJVlAQjQYtD/EF+OKxbKsGNkUBcUVEiQ0GdqNEC5h1E0DUxMe0o5F/3z3nfPd+59x7
        KULbROqodMGB7QJvZsjxyvqmheHhq14PmgyDF+egvH2nFag/vwmg5kN9auQsM6D95TdI9KZF
        wp1VHiV6cuscic5eOK5EQ3l3ATp/6SCB+sr+VqDne6+QqOqOn0Cu4VMEyn2hRw9uO9AH7yPF
        Ci1380WVivMU9ai52it6rqbyCMkV39/CNbquqrm3DV0k5xnNVnPH6ioB1+L7U8EN1YQmTtie
        EZeG+RRsD8NCsjUlXUiNZzZuTVqdZIwxsOHsEhTLhAm8BcczaxISw9elmyVbTFgWb86UoERe
        FJnIZXF2a6YDh6VZRUc8g20pZtsSW4TIW8RMITUi2WpZyhoMUUZJuDMjzdXwQGWrmry7ofY1
        mQ2qJzoBRUF6MbxWqnWCEEpLuwFscWInGC/VowB63N0gQAQ07TkPCZm4KRFPqokAoaGnwPeF
        vcrARgQ9B97tzAjABL0Q+odPKGV9D4C9L0fVsl4P244+UwZqJT0f1j79FMRJCW/0+8hAPZme
        C7vevwwePJ3+BXpK3kkaNTWNjoSNWYEtCbpDBd9W1wdHmEpvh+2P7wTlIfRWWHDmcnBOSHvV
        sLm1WCEbWAPL2058q6fCgZY6tWx+Fuy8Fy/rcwAc9u9XyYt8AP9vq/3WEA1flTkVsrNJ8L+R
        XJXcrIGHD2llCQf7/zkGZMO9CjhwoZDIB7OLxmRU9COjojEZlQKiEszANtGSikXWFjX27mpA
        8AHrY9zgfHuCF9AUYCZq/vUNmLQqPkvcY/ECSBHMNM1m06BJq0nh9/yO7dYke6YZi15glCIu
        IHTTk63SdxAcSawxKjo6Gi1mY4wsy8zU9OlcJi2dyjtwBsY2bP/ep6BCdNngV58Hx7kGO91c
        6AJcIZ5ct7J8eWiEsInMOVDh67KVMk31CapFQ67+x286flp/uXubrjOquWLW9d9it1Dz9r0i
        Qf6H076O7tj2rBufRdcGYVfJwZ8nbCs4Wtiwo/UP/7jcEXGe7nads3jXl3R3K16VN/JXiemS
        Iy7y49qZp3yGns+MUkzjWT1hF/mvceJtfdYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsVy+t9jQV2n56+jDTb18lj0Nk1nsng54TCj
        xbG2J+wWXQsNLJoXr2ezeHMcKN61eieLxeVdc9gsZi/pZ7H43HuE0WLRslZmiycLzzBZ3G5c
        wWaxes8LZou5X6YyW/Q80rI4vbvE4ueh80wOQh4bHq1m9dg56y67x+YVWh6bVnWyecw7Geix
        f+4ado/3+66yeez83sDu0bdlFaPH8RvbmTw+b5IL4I7isklJzcksSy3St0vgypi77zRrwWr+
        in2bn7M1MG7k6WLk5JAQMJE4136WuYuRi0NIYB2jxJ7dB5lAErwCghI/Jt9j6WLk4GAWkJc4
        cikbwlSXmDIlF6L8PqPE3M1fWSHKtSROdV9nAbFZBFQlNl/5yw5iswHF97+4wQZi8wsoSlz9
        8ZgRZI6oQIRE94nKLkZ2DhEBfYn9ZSATmQUusUo8eHcSrFpYIEri15SpTBCr7jFJbLhxkBkk
        wSkQLLGss4d9AqPALCSHzkI4dBbCoQsYmVcxSqYWFOem5xYbFRjmpZbrFSfmFpfmpesl5+du
        YgRG4bbDWn07GO8viT/EKMDBqMTDa3H7VbQQa2JZcWXuIUYJDmYlEV7/6NfRQrwpiZVVqUX5
        8UWlOanFhxilOViUxHlv5x2LFBJITyxJzU5NLUgtgskycXBKNTDWvOjQzeEKj2o4FeA9L4N3
        c2GZu5Wz2p6L1Rqvfgl9VN64KFwprKjyYt/T220ehplfGGSyvS7+XWzjs1Shqra3y7hRxtbL
        Vn6et9amhHdT4v7zbv+7XKH9e2rtZFtZq5K/uzsL5JlUO7ncL7KcOF91zHdNCt9SmyA7wwz9
        27euf+G+YG1iq8RSnJFoqMVcVJwIAHqv4Iq+AgAA
X-CMS-MailID: 20181114091338epcas1p2959991201c73f2c3c703ca7b242a9f68
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181110181155epcas2p1ac9bffb2dc7dd6337db5c37f8a87bd5e
References: <20181110181101.24557-1-andriy.shevchenko@linux.intel.com>
        <CGME20181110181155epcas2p1ac9bffb2dc7dd6337db5c37f8a87bd5e@epcas2p1.samsung.com>
        <20181110181101.24557-2-andriy.shevchenko@linux.intel.com>
        <5BE8C821.5080002@samsung.com> <5BEB63C3.1020504@samsung.com>
        <CAHp75Vfe586+tr5mUdSHv4ehmpi0KwS_m+UC0tfFHrdXwKhkig@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018년 11월 14일 17:35, Andy Shevchenko wrote:
> On Wed, Nov 14, 2018 at 1:53 AM Chanwoo Choi <cw00.choi@samsung.com> wrote:
> 
>> I was thinking about again to change from NULL to EPROBE_DEFER.
>>
>> extcon_get_extcon_dev() function was almost called in the probe function.
>> But, this function might be called on other position instead of probe.
> 
> *Might be* sounds like a theoretical thing, care to share what is in you mind?
> Current users and more important the new coming one are *all* doing the same.
> 
>> ENODEV is more correct error instead of EPROBE_DEFER.
> 
> So, you are proposing to continue duplicating conversion from ENODEV
> to EPROBE_DEFER in *each* caller?

The extcon core don't know the caller situation is in either probe() or other position
in the caller driver. The caller driver should decide the kind of error value
by using the return value of extcon_get_extcon_dev().

extcon_get_extcon_dev() function cannot be modified for only one case.
If some device driver call extcon_get_extcon_dev() out of probe() fuction,
EPROBE_DEFER is not always correct.

> 
>> Sorry. I'll withdraw my opinion related acked-by tag until we are clarifying it.
> 
> I honestly don't know what to clarify here.
> 
> When we would have a real case we can change API correspondingly.
> For now, the score is 5:0 with use cases in practice.
> 
>> On 2018년 11월 12일 09:24, Chanwoo Choi wrote:
>>> On 2018년 11월 11일 03:10, Andy Shevchenko wrote:
>>>> All current users of extcon_get_extcon_dev() API considers
>>>> an extcon device a mandatory to appear. Thus, they all convert
>>>> NULL pointer to -EPROBE_DEFER error code.
>>>>
>>>> There is one more caller anticipated with the same requirements.
>>>>
>>>> To decrease a code duplication and a burden to the callers,
>>>> return -EPROBE_DEFER directly from extcon_get_extcon_dev().
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
