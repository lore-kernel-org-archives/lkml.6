Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB29C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 09:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 200E12080F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 09:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mdadp71S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 200E12080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732627AbeKNTvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 14:51:23 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:47693 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727595AbeKNTvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 14:51:23 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20181114094849epoutp02a4a6f5e2c55c6e8b5506835f70265a18~m9KkOhHGx2013220132epoutp02Y;
        Wed, 14 Nov 2018 09:48:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20181114094849epoutp02a4a6f5e2c55c6e8b5506835f70265a18~m9KkOhHGx2013220132epoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542188929;
        bh=lJ9ZwXaM24ZxHFgxUGFQNaxGJR8v/GfIWNWLQ5Pwz6Y=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=mdadp71SSA7bu8Mp1gIBGJOVpPl62Halch9eXSGwNE2ceJlzi5mxP/C7yRfUamwkg
         AZn3hCyxLfBShetXHE6gRb5yAv8EMCidXV1ifjkBcReDW3O04yo5N4Y9DSJCxA2cHs
         aVXf818oVPxmyjds7OkFnipo0j+XUWi/aKxYJGFE=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.154]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181114094845epcas1p1371a40307d8a273e74ebe3a3d7c926f4~m9Kg1skDY0149001490epcas1p1m;
        Wed, 14 Nov 2018 09:48:45 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        16.66.04149.D7FEBEB5; Wed, 14 Nov 2018 18:48:45 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181114094845epcas1p27da469100fc5f3f78e67154fa6e3df89~m9KgRv79b0359303593epcas1p2I;
        Wed, 14 Nov 2018 09:48:45 +0000 (GMT)
X-AuditID: b6c32a38-653ff70000001035-37-5bebef7d2a6f
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EF.38.03701.C7FEBEB5; Wed, 14 Nov 2018 18:48:45 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Received: from [10.113.63.77] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PI600CGBGL89U00@mmp1.samsung.com>; Wed, 14 Nov 2018 18:48:44 +0900 (KST)
Message-id: <5BEBEF7C.7060003@samsung.com>
Date:   Wed, 14 Nov 2018 18:48:44 +0900
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
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
In-reply-to: <20181114093652.GK10650@smile.fi.intel.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLJsWRmVeSWpSXmKPExsWy7bCmnm7t+9fRBqc2qlm8nHCY0eJY2xN2
        i66FBhbNi9ezWbw5Pp3Jomv1ThaLy7vmsFnMXtLPYvG59wijxaJlrcwWTxaeYbK43biCzWL1
        nhfMFnO/TGW26HmkZXF6d4nFz0PnmRwEPTY8Ws3qsXPWXXaPzSu0PDat6mTzmHcy0GP/3DXs
        Hu/3XWXz2Pm9gd2jb8sqRo/jN7YzeXzeJBfAHZVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9q
        ZmCoa2hpYa6kkJeYm2qr5OIToOuWmQP0kZJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1
        ICWnwLJArzgxt7g0L10vOT/XytDAwMgUqDAhO+PXBteCf7wVm24oNTAu4u5i5OSQEDCReLLj
        FnsXIxeHkMAORomJH19BOd8ZJSbNXsIMU3Vo2UqoxG5Gia/P+sESvAKCEj8m32PpYuTgYBaQ
        lzhyKRskzCygKfHiyyQWiPq7jBIPFzyCqteS2PrxOCuIzSKgKnH+w0OwOBtQfP+LG2wgNr+A
        osTVH48ZQWxRgQiJnfO/AS1m5xAR0JfYXwYxfiarxKtn7iC2sECUxLmLe8CqOQUsJI6+O8kM
        slZCYB+7xIKpZ6Dud5Fo+7WDBcIWlnh1fAs7yMkSAtISl47aQtS3M0p8edHMCuFMYJT4cGoz
        E0SDscSzhV1MEJv5JN597WGFaOaV6GgTgijxkHh5v48R4t/VzBJnvu1lncAoOwspiGYhgmgW
        UhAtYGRexSiWWlCcm55abFhgghx1mxjBSVfLYgfjnnM+hxgFOBiVeHgtbr+KFmJNLCuuzD3E
        KMHBrCTC6x/9OlqINyWxsiq1KD++qDQntfgQoykwhCcyS4km5wMzQl5JvKGpkbGxsYWJoZmp
        oaGSOO8TqbnRQgLpiSWp2ampBalFMH1MHJxSDYwK7jO3HJvvPGe3Xq/rdumPP3YWnF4cOznM
        ee75lqlnHsfem5XwPlNuQzPD25BX5xxPLk+fkHW6LqLmwh8Jv78u2x9n2he8qv2bmbxgxxXD
        W5nPy0QzmBdW3Lv+rvTm7l7vtzbGfB6iUcu2HV3/tspo/4xV5/U9wuVm7MyoM3G/EH6J3TZ/
        2/1SJZbijERDLeai4kQATZlsTNADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsVy+t9jAd3a96+jDTa9Y7J4OeEwo8Wxtifs
        Fl0LDSyaF69ns3hzfDqTRdfqnSwWl3fNYbOYvaSfxeJz7xFGi0XLWpktniw8w2Rxu3EFm8Xq
        PS+YLeZ+mcps0fNIy+L07hKLn4fOMzkIemx4tJrVY+esu+wem1doeWxa1cnmMe9koMf+uWvY
        Pd7vu8rmsfN7A7tH35ZVjB7Hb2xn8vi8SS6AO4rLJiU1J7MstUjfLoEr49cG14J/vBWbbig1
        MC7i7mLk5JAQMJE4tGwlexcjF4eQwE5GiS2dDYwgCV4BQYkfk++xdDFycDALyEscuZQNYapL
        TJmSC1F+n1Fi4vLf7BDlWhJbPx5nBbFZBFQlzn94yAxiswHF97+4wQZi8wsoSlz98ZgRZI6o
        QIRE94nKLkZ2DhEBfYn9ZSATmQVms0qcunwNbIqwQJTErylTmUBsIYHVzBIP33iD2JwCFhJH
        351knsAoMAvJnbMQ7pyFcOcCRuZVjJKpBcW56bnFRgWGeanlesWJucWleel6yfm5mxiBUbft
        sFbfDsb7S+IPMQpwMCrx8FrcfhUtxJpYVlyZe4hRgoNZSYTXP/p1tBBvSmJlVWpRfnxRaU5q
        8SFGaQ4WJXHe23nHIoUE0hNLUrNTUwtSi2CyTBycUg2M1TrHcqKt/lZ+NHeRW/FBPO9a2kJh
        UfMfX/VmfZJ/b/ht0YSfkvMd0ktEsq5V5v4SOunD4ttYvf1CeNrNTw82Rss7zNOPXVZiNOf1
        99xE25QDNw38cgOC/0zPORibavvs8o435bMf7dJxtZfLbziREP1TQln5y9uELS+/quSovl28
        UkcukGeyEktxRqKhFnNRcSIAuL0bKLYCAAA=
X-CMS-MailID: 20181114094845epcas1p27da469100fc5f3f78e67154fa6e3df89
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
        <5BEBE741.6050101@samsung.com> <20181114093652.GK10650@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018년 11월 14일 18:36, Andy Shevchenko wrote:
> On Wed, Nov 14, 2018 at 06:13:37PM +0900, Chanwoo Choi wrote:
>> On 2018년 11월 14일 17:35, Andy Shevchenko wrote:
>>> On Wed, Nov 14, 2018 at 1:53 AM Chanwoo Choi <cw00.choi@samsung.com> wrote:
>>>
>>>> I was thinking about again to change from NULL to EPROBE_DEFER.
>>>>
>>>> extcon_get_extcon_dev() function was almost called in the probe function.
>>>> But, this function might be called on other position instead of probe.
>>>
>>> *Might be* sounds like a theoretical thing, care to share what is in you mind?
>>> Current users and more important the new coming one are *all* doing the same.
>>>
>>>> ENODEV is more correct error instead of EPROBE_DEFER.
>>>
>>> So, you are proposing to continue duplicating conversion from ENODEV
>>> to EPROBE_DEFER in *each* caller?
>>
>> The extcon core don't know the caller situation is in either probe() or other position
>> in the caller driver. The caller driver should decide the kind of error value
>> by using the return value of extcon_get_extcon_dev().
>>
>> extcon_get_extcon_dev() function cannot be modified for only one case.
>> If some device driver call extcon_get_extcon_dev() out of probe() fuction,
>> EPROBE_DEFER is not always correct.
> 
> I agree with this, but look at the current state of affairs. All users do the same.
> If we need to have another case we may consider this later.

Because we know the potential wrong case of this change, I can't agree this change.
If extcon_get_extcon_dev() returns ENODEV instead of EPROBE_DEFER,
it is clear and then there are no problem on both current and future.

> 
> API inside the kernel are not carved in the stone.
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
