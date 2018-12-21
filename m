Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E13C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD6E821908
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fs0hIHGA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389486AbeLUKXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 05:23:37 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:42333 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731708AbeLUKXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 05:23:37 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181221102335euoutp011274f7d7024709eb6af727f4b80c9d71~yUgfYgrFy1219612196euoutp01a
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 10:23:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181221102335euoutp011274f7d7024709eb6af727f4b80c9d71~yUgfYgrFy1219612196euoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1545387815;
        bh=O/ucLtkM5Qg/zU83iKty74smZi+/dkmNMNiDAlDPziQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=fs0hIHGAG0TdAapoqv44P8lqIMeVeNIFbtDEMgK9tfJkZYtiOFBjLzeuND2zYyPLI
         kMbv7mW0qKSlpWPjrf31JyIkRWf5CRAELrKqS5+zC4VzqmedxdiPpxle4Tjsy1LU3G
         jEsgl1HsYxXjcEsK0+buF6ZNpONF3VNI8kUrX4CE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181221102335eucas1p2d961ab35bf2d1f46ff40d35bcea06590~yUgewLOJg2028120281eucas1p2o;
        Fri, 21 Dec 2018 10:23:35 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 14.12.04441.62FBC1C5; Fri, 21
        Dec 2018 10:23:34 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181221102333eucas1p201a4730db5b171abaa927f5f6d2dfe9e~yUgdrtQHa2029220292eucas1p2r;
        Fri, 21 Dec 2018 10:23:33 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181221102333eusmtrp23691ea48cd3635b39437d9a94bc09214~yUgdcwy302615126151eusmtrp2i;
        Fri, 21 Dec 2018 10:23:33 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-4a-5c1cbf26d259
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B1.7A.04284.52FBC1C5; Fri, 21
        Dec 2018 10:23:33 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181221102333eusmtip20abbca83896363629e7b728175f854f6~yUgc-E1hY0039600396eusmtip2p;
        Fri, 21 Dec 2018 10:23:33 +0000 (GMT)
Subject: Re: [PATCH 3/4] tty: serial: samsung: Increase maximum baudrate
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Beomho Seo <beomho.seo@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <9be9bcd6-5b8a-da40-b232-a650eaa88d38@samsung.com>
Date:   Fri, 21 Dec 2018 11:23:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181221101553.GI13248@dell>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBKsWRmVeSWpSXmKPExsWy7djPc7pq+2ViDGa90LfYOGM9q8XpT9vY
        LZoXr2ezOH9+A7vF/a9HGS0u75rDZjHj/D4mizOLe9ktDr9pZ7WYMfklmwOXx6ZVnWwed67t
        YfPYP3cNu0ffllWMHp83yQWwRnHZpKTmZJalFunbJXBlTN4rVzCXp+LCnY2MDYztXF2MnBwS
        AiYS83b1M3UxcnEICaxglPj0czKU84VRov1oCzNIlZDAZ0aJZc9LYToOHDrHDFG0nFFiw9wt
        rBDOe0aJCRsms4NUCQt4SHxZ8YCti5GDQ0RAReLcG3OQMLPAZyaJh+8DQGw2AUOJrrddbCA2
        r4CdxK5175lAbBYBVYmP93ewgNiiAjESTxv2sUDUCEqcnPkEzOYU0JKYcaObFWKmvMT2t3OY
        IWxxiVtP5oN9ICFwil3i67NOVoirXSQe7ehjhLCFJV4d38IOYctI/N8J09AM9PKMWewQTg+j
        xNY5O9ggqqwlDh+/yAryDbOApsT6XfoQYUeJ+atmgj0pIcAnceOtIMQRfBKTtk1nhgjzSnS0
        CUFUq0nMOr4Obu3BC5eYJzAqzULy2iwk78xC8s4shL0LGFlWMYqnlhbnpqcWG+allusVJ+YW
        l+al6yXn525iBKan0/+Of9rB+PVS0iFGAQ5GJR7eC9ulY4RYE8uKK3MPMUpwMCuJ8HbYysQI
        8aYkVlalFuXHF5XmpBYfYpTmYFES561meBAtJJCeWJKanZpakFoEk2Xi4JRqYOSq0ef/s8vZ
        rOORl/Cd5LxMbc17e4N4+W4EVHyq1dmx+G6Lb3k6t5DawZi2339V2la7pMkLykj9sDq4wvax
        fdy77+v38ukeDrp5YEpdzryVhuWnpu5t3fYtSd6IN/5Ni6iehGs8s3E1+10Rx1PMQdITIhRW
        vPSe7nI1aHn2gwUbTqp03vAOV2Ipzkg01GIuKk4EAEbtVnFLAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsVy+t/xe7qq+2ViDKY/VbfYOGM9q8XpT9vY
        LZoXr2ezOH9+A7vF/a9HGS0u75rDZjHj/D4mizOLe9ktDr9pZ7WYMfklmwOXx6ZVnWwed67t
        YfPYP3cNu0ffllWMHp83yQWwRunZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq
        6dvZpKTmZJalFunbJehlTN4rVzCXp+LCnY2MDYztXF2MnBwSAiYSBw6dY+5i5OIQEljKKNHz
        biUzREJG4uS0BlYIW1jiz7UuNoiit4wS/4/1s4EkhAU8JL6seABkc3CICKhInHtjDlLDLPCZ
        SeLAp0ZGiIanjBI7NzeCNbAJGEp0ve0Cs3kF7CR2rXvPBGKzCKhKfLy/gwVkkKhAjMSzBdUQ
        JYISJ2c+YQGxOQW0JGbc6AY7iFlAXeLPvEvMELa8xPa3c6BscYlbT+YzTWAUmoWkfRaSlllI
        WmYhaVnAyLKKUSS1tDg3PbfYUK84Mbe4NC9dLzk/dxMjMCK3Hfu5eQfjpY3BhxgFOBiVeHg1
        dknHCLEmlhVX5h5ilOBgVhLh7bCViRHiTUmsrEotyo8vKs1JLT7EaAr020RmKdHkfGCyyCuJ
        NzQ1NLewNDQ3Njc2s1AS5z1vUBklJJCeWJKanZpakFoE08fEwSnVwNiswHPe/4XTsVKGM5cY
        i5eJSr18rGZ4falfV6PWu5jNF1TO2DoKbl/hmsZ8f6LO4/v393GmTL+zy1T8A2fIdevXByzP
        Hrd3PNGj4vczd/F9qUehdsdWHPoa57r99x/V69391/SZOzondgcvEvnN+n61peiJteUb599r
        9fz6S+t0p9SnPzVJB+YpsRRnJBpqMRcVJwIAciDRwd4CAAA=
X-CMS-MailID: 20181221102333eucas1p201a4730db5b171abaa927f5f6d2dfe9e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181214113418eucas1p2bfb6f0d04010e73f6ca35c3a6664b316
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181214113418eucas1p2bfb6f0d04010e73f6ca35c3a6664b316
References: <20181214113410.22848-1-m.szyprowski@samsung.com>
        <CGME20181214113418eucas1p2bfb6f0d04010e73f6ca35c3a6664b316@eucas1p2.samsung.com>
        <20181214113410.22848-4-m.szyprowski@samsung.com>
        <20181221101553.GI13248@dell>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 2018-12-21 11:15, Lee Jones wrote:
> On Fri, 14 Dec 2018, Marek Szyprowski wrote:
>> From: Seung-Woo Kim <sw0312.kim@samsung.com>
>>
>> This driver can be used to communicate with Bluetooth chip in high-speed
>> UART mode, so increase the maximum baudrate to 3Mbps.
>>
>> Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
>> [mszyprow: rephrased commit message]
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>>  drivers/tty/serial/samsung.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
>> index 2a49b6d876b8..9fc3559f80d9 100644
>> --- a/drivers/tty/serial/samsung.c
>> +++ b/drivers/tty/serial/samsung.c
>> @@ -1287,7 +1287,7 @@ static void s3c24xx_serial_set_termios(struct uart_port *port,
>>  	 * Ask the core to calculate the divisor for us.
>>  	 */
>>  
>> -	baud = uart_get_baud_rate(port, termios, old, 0, 115200*8);
>> +	baud = uart_get_baud_rate(port, termios, old, 0, 3000000);
> Does that mean the low speed devices will stop working?  It looks like
> this should be dynamically configurable based on what device is
> connected to it, no?

The changed parameter is maximum supported rate, so this change doesn't
affect any low speed device.

>>  	quot = s3c24xx_serial_getclk(ourport, baud, &clk, &clk_sel);
>>  	if (baud == 38400 && (port->flags & UPF_SPD_MASK) == UPF_SPD_CUST)
>>  		quot = port->custom_divisor;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

