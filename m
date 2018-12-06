Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881B9C65BAF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A9B120700
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="T1obotVh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A9B120700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbeLFPHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:07:20 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:45455 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeLFPHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 10:07:19 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181206150718euoutp02203ecf9831c3616afb5c27f826bff195~txs62t_Dz1208512085euoutp029
        for <linux-kernel@vger.kernel.org>; Thu,  6 Dec 2018 15:07:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181206150718euoutp02203ecf9831c3616afb5c27f826bff195~txs62t_Dz1208512085euoutp029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1544108838;
        bh=Go9MZf7o4c+Rx84P/9rugvEINruN1s5hYHzCZTpyGNY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=T1obotVhIMqRuGz2TNZVGEN092M5wcxDRlUwnNWZfA6FutkgFu45tUY9n7o6aa1l2
         faDbPnGcJRLr+5hcgyuHz2vy4VIfol+BYX92cgszCm+Iy6XPjK0OGitJqDoN5k/VYX
         3tSvPHEf4/b0/tWyfmy6dYvQsH9Wv6m8DK8z+uKU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181206150717eucas1p1b36113eac45dd1fe229d176871fc6f8b~txs6K1T-L0909409094eucas1p1o;
        Thu,  6 Dec 2018 15:07:17 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 68.B4.04294.52B390C5; Thu,  6
        Dec 2018 15:07:17 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181206150716eucas1p284eda9ba897df22916f4330387ab6968~txs5F3HU12703727037eucas1p2E;
        Thu,  6 Dec 2018 15:07:16 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181206150716eusmtrp11cd2c11c0948591027b72758c76eb2bb~txs43UTTJ1990419904eusmtrp1p;
        Thu,  6 Dec 2018 15:07:16 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-dd-5c093b25fec6
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A0.BF.04128.42B390C5; Thu,  6
        Dec 2018 15:07:16 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181206150715eusmtip2590c0c41bc3eac46910b1dc527233925~txs4Vqs5n2770527705eusmtip2n;
        Thu,  6 Dec 2018 15:07:15 +0000 (GMT)
Subject: Re: [PATCH] usb: dwc2: Revert
 "usb: dwc2: Disable all EP's on disconnect"
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <5abb1e89-bf49-6c08-742a-a782111b41dc@samsung.com>
Date:   Thu, 6 Dec 2018 16:07:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181206145218.GQ3073@unbuntlaptop>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBKsWRmVeSWpSXmKPExsWy7djPc7qq1pwxBuf/C1lsnLGe1eL1v+ks
        FvNvJlk8u7WXyaJ58Xo2i8Zfe9ktLu+aw2axaFkrswOHx6HDHYwe804Geuyfu4bd4+PTWywe
        fVtWMXps2f+Z0ePzJrkA9igum5TUnMyy1CJ9uwSujNstE1kLFrBXzPo5g72B8TFrFyMnh4SA
        icSUmW8Yuxi5OIQEVjBKzN86Dcr5wigx+d1vdpAqIYHPjBInDtrBdMyYfpUVomg5o8T7XbPY
        IZz3jBKf9s9jAqkSFgiRePFgHdgOEQEdicudP8CKmAVWM0mc2f2CBSTBJmAo0fW2iw3E5hWw
        k5j+7QiYzSKgInFt6nmgQRwcogIxErue10CUCEqcnPkErJUTqPX75+3MIDazgLzE9rdzoGxx
        iVtP5jOB7JIQOMQu8XTVYqhHXSQm3WxngbCFJV4d38IOYctInJ7cwwLR0Mwo0T4D4h0JgR5G
        ia1zdrBBVFlLHD5+kRXkImYBTYn1u/Qhwo4SXzbOZgYJSwjwSdx4KwhxBJ/EpG3TocK8Eh1t
        QhDVahKzjq+DW3vwwiXmCYxKs5C8NgvJO7OQvDMLYe8CRpZVjOKppcW56anFRnmp5XrFibnF
        pXnpesn5uZsYgenp9L/jX3Yw7vqTdIhRgINRiYf3xQP2GCHWxLLiytxDjBIczEoivAx6HDFC
        vCmJlVWpRfnxRaU5qcWHGKU5WJTEeasZHkQLCaQnlqRmp6YWpBbBZJk4OKUaGBViJzFdCD4l
        UvV8z9c9Qe0vNmSH/uN9V6axbf45JsYL6jtSr6/8orhho1LptKN3vr9bY326/9VD4f/Pv2Wn
        vGNgzj983PaHuqufToWo5LH+2wfqXivdu7yzkF+m79y8Q1sn/A7TdbN+7MPhpa14gvuIr9Aq
        U+UT14Le7d83MXq5iLqotuvdxl1KLMUZiYZazEXFiQCwkCgPSwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsVy+t/xe7oq1pwxBhsOc1hsnLGe1eL1v+ks
        FvNvJlk8u7WXyaJ58Xo2i8Zfe9ktLu+aw2axaFkrswOHx6HDHYwe804Geuyfu4bd4+PTWywe
        fVtWMXps2f+Z0ePzJrkA9ig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07
        m5TUnMyy1CJ9uwS9jNstE1kLFrBXzPo5g72B8TFrFyMnh4SAicSM6VeBbC4OIYGljBJ9H0+w
        QyRkJE5Oa4AqEpb4c62LDaLoLaNEx5d9YAlhgRCJnYtmMYHYIgI6Epc7f7CDFDELrGWS+Nr7
        ngWiYwejxIKeYywgVWwChhJdb0FGcXLwCthJTP92BMxmEVCRuDb1PNgkUYEYiSmXX7NC1AhK
        nJz5BKyXE6j3++ftzCA2s4C6xJ95l6BseYntb+dA2eISt57MZ5rAKDQLSfssJC2zkLTMQtKy
        gJFlFaNIamlxbnpusZFecWJucWleul5yfu4mRmBMbjv2c8sOxq53wYcYBTgYlXh4XzxgjxFi
        TSwrrsw9xCjBwawkwsugxxEjxJuSWFmVWpQfX1Sak1p8iNEU6LmJzFKiyfnAdJFXEm9oamhu
        YWlobmxubGahJM573qAySkggPbEkNTs1tSC1CKaPiYNTqoFR80DjlyCVtxuEUlztzbiKeb6o
        74/+G3TgJUcy61xZhai1UbbPA6UnOZdLzJGMv6eqtPZf6KV0tc++n4/2nOtnKIuI2bPWrOX0
        tuN9XksM+goPhLmXZ94tTp6XdqujyXLy0nsmErfLPDpPpX71skp8P8nIKGbN9tTSFgmhl6Vz
        2r/fulnFl6rEUpyRaKjFXFScCAA/kO803wIAAA==
X-CMS-MailID: 20181206150716eucas1p284eda9ba897df22916f4330387ab6968
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181121154518eucas1p2cc7ffd4d071ff420c747e1d0c387ee5d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181121154518eucas1p2cc7ffd4d071ff420c747e1d0c387ee5d
References: <CGME20181121154518eucas1p2cc7ffd4d071ff420c747e1d0c387ee5d@eucas1p2.samsung.com>
        <20181121154504.13052-1-m.szyprowski@samsung.com>
        <20181206145218.GQ3073@unbuntlaptop>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On 2018-12-06 15:52, Dan Carpenter wrote:
> Hi Marek,
>
> I'm surprised you don't get deadlocks when you apply this patch.

Why should I get it? It is just a revert to the state before applying
the mentioned incorrect patch.

> On Wed, Nov 21, 2018 at 04:45:04PM +0100, Marek Szyprowski wrote:
>
>> @@ -4020,9 +4008,7 @@ static int dwc2_hsotg_ep_disable(struct usb_ep *ep)
>>  
>>  	epctrl_reg = dir_in ? DIEPCTL(index) : DOEPCTL(index);
>>  
>> -	locked = spin_is_locked(&hsotg->lock);
>> -	if (!locked)
>> -		spin_lock_irqsave(&hsotg->lock, flags);
>> +	spin_lock_irqsave(&hsotg->lock, flags);
>>  
> One of the callers is already holding the hsotg->log.  The
> spin_is_locked() test would avoid the deadlock.

Before that broken patch, there was no call to any function which takes
spinlock again, so no deadlock.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

