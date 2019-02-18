Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70C0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0A502146F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729539AbfBRKG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 05:06:59 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:35758 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729460AbfBRKG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 05:06:59 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1IA4Oic010942;
        Mon, 18 Feb 2019 04:06:53 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail3.cirrus.com ([87.246.76.56])
        by mx0b-001ae601.pphosted.com with ESMTP id 2qpftrter5-1;
        Mon, 18 Feb 2019 04:06:53 -0600
Received: from EX17.ad.cirrus.com (ex17.ad.cirrus.com [172.20.9.81])
        by mail3.cirrus.com (Postfix) with ESMTP id 0FBB5611C8AF;
        Mon, 18 Feb 2019 04:07:05 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Mon, 18 Feb 2019
 10:06:52 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com
 [198.61.86.93])        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id
 x1IA6q9e002932;        Mon, 18 Feb 2019 10:06:52 GMT
Date:   Mon, 18 Feb 2019 10:06:52 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Jim Broadus <jbroadus@gmail.com>
CC:     <benjamin.tissoires@redhat.com>, <wsa@the-dreams.de>,
        <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i2c: Allow recovery of the initial IRQ by a i2c client
 device.
Message-ID: <20190218100652.GB27940@ediswmail.ad.cirrus.com>
References: <20190216001533.5465-1-jbroadus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190216001533.5465-1-jbroadus@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=832 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902180077
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 04:15:33PM -0800, Jim Broadus wrote:
> A previous change allowed i2c client devices to discover new IRQs upon
> reprobe. By clearing the IRQ in i2c_device_remove. However, if an IRQ was
> assigned in i2c_new_device, that information is lost.
> 
> For example, the touchscreen and trackpad devices on a Dell Inspiron laptop
> are I2C devices whose IRQs are defined by ACPI extended IRQ types. The
> client device structures are initialized during an ACPI walk. After
> removing the i2c_hid device, modprobe fails.
> 
> This change caches the initial IRQ value in i2c_new_device and then resets
> the client device IRQ to the initial value in i2c_device_remove.
> 
> Fixes: 6f108dd70d30 ("i2c: Clear client->irq in i2c_device_remove")
> Signed-off-by: Jim Broadus <jbroadus@gmail.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Apologies for the issues caused. I think this looks like a good fix
to me.

Thanks,
Charles
