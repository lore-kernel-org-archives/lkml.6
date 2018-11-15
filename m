Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C81FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 01:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 032F42147C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 01:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YyeJXpJ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 032F42147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbeKOLWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 06:22:41 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:10626 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbeKOLWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 06:22:41 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20181115011656epoutp014ac87eb692e2f09465ecef599a3e6576~nJ07OC1hQ3212132121epoutp019;
        Thu, 15 Nov 2018 01:16:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20181115011656epoutp014ac87eb692e2f09465ecef599a3e6576~nJ07OC1hQ3212132121epoutp019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542244616;
        bh=eOQoPw6tWlvkabc/a35sDjL3dnWXrfy1nMqKJfHhY2w=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=YyeJXpJ67RUxGO4nK8OFF4+143EfiQVyMlwKsKu+luCjTtkX8U+inC+pojgd/KfAb
         tSgxsY3+6FuIjesbEXTy3MUjK1hOSKtmCZ8Ogg2wViFTG/oom8Hl6Ad+oDSP913z7h
         +1KRH53AGv49h0Xict/G4KvXasX3VzsFYNzfFl0U=
Received: from epsmges2p2.samsung.com (unknown [182.195.40.154]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181115011654epcas1p27ae04842884cc96a649e0e0b41eddc87~nJ04sv8Mn1815118151epcas1p2B;
        Thu, 15 Nov 2018 01:16:54 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F4.64.04407.509CCEB5; Thu, 15 Nov 2018 10:16:53 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20181115011653epcas2p2126d1257e99af8acff78f15f9e18bb68~nJ04UFCpN1423514235epcas2p2B;
        Thu, 15 Nov 2018 01:16:53 +0000 (GMT)
X-AuditID: b6c32a46-789ff70000001137-4f-5becc9054ed3
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id F7.D2.03702.509CCEB5; Thu, 15 Nov
        2018 10:16:53 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Received: from [10.113.63.77] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PI700IL0NK53O40@mmp2.samsung.com>; Thu, 15 Nov 2018 10:16:53 +0900 (KST)
Message-id: <5BECC905.4060802@samsung.com>
Date:   Thu, 15 Nov 2018 10:16:53 +0900
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
In-reply-to: <CAHp75VduXH0OKcD2AyR03eNrWW8bKGL-ijfQocfQ+MDCAq0yag@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHJsWRmVeSWpSXmKPExsWy7bCmhS7byTfRBrPlLF5OOMxocaztCbtF
        10IDi+bF69ks3hyfzmTRtXoni8XlXXPYLGYv6Wex+Nx7hNFi0bJWZosnC88wWdxuXMFmsXrP
        C2aLuV+mMlv0PNKyOL27xOLnofNMDoIeGx6tZvXYOesuu8fmFVoem1Z1snnMOxnosX/uGnaP
        9/uusnns/N7A7tG3ZRWjx/Eb25k8Pm+SC+COyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUz
        MNQ1tLQwV1LIS8xNtVVy8QnQdcvMAXpISaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQ
        klNgWaBXnJhbXJqXrpecn2tlaGBgZApUmJCd0b95F2vBd9aKl3N+MDcwXmTpYuTkkBAwkXh1
        poERxBYS2MEoMf+geBcjF5D9nVFi9eELzDBFH87sYIdIbGCUOP3pPFg3r4CgxI/J94BsDg5m
        AXmJI5eyQcLMApoSL75MYoGov8so0fJxGVS9lsSsg8/YQWwWAVWJF1famUBsNqD4/hc32EBs
        fgFFias/HoNdJCoQIbFz/jegenYOEQF9if1lEONnskq8euYOYgsLREmcu7gHrJpTIFji0J1m
        ZpC1EgL72CV2z/rEBnG/i0Tr0atQDwtLvDq+hR3ClpZ4tmojI0RDO6PElxfNrBDOBEaJD6c2
        M0FUGUs8W9jFBLGaT6Lj8F92kIclBHglOtqEIEo8JF7e72OEePgQq8SMSXNZJzDKzkIKo1mI
        MJqFFEYLGJlXMYqlFhTnpqcWGxUYIUfeJkZw2tVy28G45JzPIUYBDkYlHt4TVm+ihVgTy4or
        cw8xSnAwK4nwLqgBCvGmJFZWpRblxxeV5qQWH2I0BQbxRGYp0eR8YE7IK4k3NDUyNja2MDW3
        NDawVBLnfSg9N1pIID2xJDU7NbUgtQimj4mDU6qBUerZfYmKnOnTsv9ItrbNXnVGapbf5UlO
        n50Cb35bvsU89laMdVj8f5Wt3zXu5rsIvp2q4soYs8x8dziLXbfukWaViYfs+vgTJhu9n3A5
        8tvMFp7tMh2L8xrkypcfUKgzPRbApmNzc7rCRm87HbMvXhm6LSdOLGzc626lrGCnxyL0y5Cd
        t2ihEktxRqKhFnNRcSIA/DhL39EDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsVy+t9jQV3Wk2+iDTZ/Vrd4OeEwo8Wxtifs
        Fl0LDSyaF69ns3hzfDqTRdfqnSwWl3fNYbOYvaSfxeJz7xFGi0XLWpktniw8w2Rxu3EFm8Xq
        PS+YLeZ+mcps0fNIy+L07hKLn4fOMzkIemx4tJrVY+esu+wem1doeWxa1cnmMe9koMf+uWvY
        Pd7vu8rmsfN7A7tH35ZVjB7Hb2xn8vi8SS6AO4rLJiU1J7MstUjfLoEro3/zLtaC76wVL+f8
        YG5gvMjSxcjJISFgIvHhzA52EFtIYB2jRM8OSxCbV0BQ4sfke0A1HBzMAvISRy5lQ5jqElOm
        5HYxcgFV32eUWPu2iRmiXEti1sFnYGNYBFQlXlxpZwKx2YDi+1/cYAOx+QUUJa7+eMwIMkdU
        IEKi+0RlFyM7h4iAvsT+MpCJzAKzWSVOXb7GClItLBAl8WvKVCaIww6xSuzfXwJicwoESyx/
        d559AqPALCR3zkK4cxbCnQsYmVcxSqYWFOem5xYbFRjlpZbrFSfmFpfmpesl5+duYgTG3bbD
        Wv07GB8viT/EKMDBqMTDe8LqTbQQa2JZcWXuIUYJDmYlEd4FNUAh3pTEyqrUovz4otKc1OJD
        jNIcLErivPz5xyKFBNITS1KzU1MLUotgskwcnFINjLUujYVywuJrBHa94Ls9vV9DdF9q/pO5
        B1uesv4Oju1cEDDv1NpbP3r6V3WUh95d985lRvjxXgnZk5yfc3q4+2q5Bd02Hzp5V1L0c+rn
        bZOWPPF4mRGe3KKqMPnqzhL9z5PEHj7aXvH6U16o5pGNp4QS9JZt4bB5uPDf0fzpH12rjrnu
        y7fq5FBiKc5INNRiLipOBACVM9EntwIAAA==
X-CMS-MailID: 20181115011653epcas2p2126d1257e99af8acff78f15f9e18bb68
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181110181155epcas2p1ac9bffb2dc7dd6337db5c37f8a87bd5e
References: <20181110181101.24557-1-andriy.shevchenko@linux.intel.com>
        <CGME20181110181155epcas2p1ac9bffb2dc7dd6337db5c37f8a87bd5e@epcas2p1.samsung.com>
        <20181110181101.24557-2-andriy.shevchenko@linux.intel.com>
        <5BE8C821.5080002@samsung.com> <5BEB63C3.1020504@samsung.com>
        <CAHp75Vfe586+tr5mUdSHv4ehmpi0KwS_m+UC0tfFHrdXwKhkig@mail.gmail.com>
        <5BEBE741.6050101@samsung.com> <20181114093652.GK10650@smile.fi.intel.com>
        <5BEBEF7C.7060003@samsung.com>
        <CAHp75VcJwR7S8t2jSyRvtjKCwaUA5Pu=EL3+MjCgf3SVWnChEQ@mail.gmail.com>
        <5BEC018E.8020102@samsung.com>
        <CAHp75Vc3NC95Wt9T2qx9SCGtwoR2hA7azGAHhqz7LO-yKz=mew@mail.gmail.com>
        <CAHp75VduXH0OKcD2AyR03eNrWW8bKGL-ijfQocfQ+MDCAq0yag@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018년 11월 14일 23:04, Andy Shevchenko wrote:
> On Wed, Nov 14, 2018 at 1:17 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>> On Wed, Nov 14, 2018 at 1:05 PM Chanwoo Choi <cw00.choi@samsung.com> wrote:
> 
>>>> Changing NULL to -ENODEV is a trading bad to worse.
> 
>> P.S. I still disagree with your arguments in relation to de facto use of an API.
> 
> I spoke to colleagues of mine and they are agree that semantically
> -EPROBE_DEFER is a wrong error code from API that matches against some
> list.
> On the other hand, they agree with me that changing NULL to -ENODEV is
> a trading bad to worse.
> 
> So, I withdraw mine complaints against API.
> 

OK. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
