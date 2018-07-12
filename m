Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1E3C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 01:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF89E2146F
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 01:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ge+NrZKc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF89E2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389566AbeGLBiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 21:38:54 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:30010 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388369AbeGLBix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 21:38:53 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20180712013149epoutp015ae6e911530586967910c14eaea01804~Aev8Jp26Z2746827468epoutp01Y;
        Thu, 12 Jul 2018 01:31:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180712013149epoutp015ae6e911530586967910c14eaea01804~Aev8Jp26Z2746827468epoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1531359109;
        bh=MLW78hb1dq/qTjdR+Gc6PC5vxuHYPQQ+j2Ucsv12EK8=;
        h=Subject:From:To:Cc:Date:In-reply-to:References:From;
        b=ge+NrZKccqj1mLp4A+CCx35ezovXPyvSG8u6q0Xu4WSZGOhLRacFhuUfekk0ToNf4
         dzjFnxY3a5r7l9OrzQT/ptNJGM1amWcf68uG5u50qe+2FRo1Jq+apo9/sQW+g7yc9b
         2mbDJ1XG+zDuOrLnfHLIYBYduAzmIDyK69Y6U2RA=
Received: from epsmges2p3.samsung.com (unknown [182.195.40.156]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180712013146epcas1p1e133c397217c55fe0a49ecf5ceec20e9~Aev54PgtT0365603656epcas1p1K;
        Thu, 12 Jul 2018 01:31:46 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        41.77.04186.28FA64B5; Thu, 12 Jul 2018 10:31:46 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20180712013146epcas2p3cb25893991134ce18cdfae82b7f98660~Aev5f2wRe2370723707epcas2p3y;
        Thu, 12 Jul 2018 01:31:46 +0000 (GMT)
X-AuditID: b6c32a47-9c7ff7000000105a-30-5b46af824445
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F3.E0.04192.28FA64B5; Thu, 12 Jul 2018 10:31:46 +0900 (KST)
MIME-version: 1.0
Content-type: text/plain; charset="utf-8"
Received: from [10.113.63.77] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PBQ00DPEC8XRP30@mmp1.samsung.com>; Thu, 12 Jul 2018 10:31:46 +0900 (KST)
Subject: Re: [PATCH] extcon: max3355: include mod_devicetable.h
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org
Organization: Samsung Electronics
Message-id: <ebd7d32f-48f6-1944-00a3-c2743f83b000@samsung.com>
Date:   Thu, 12 Jul 2018 10:31:45 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.7.0
In-reply-to: <ceb8cd99-91e3-aad6-bedc-bf5626c7683a@samsung.com>
Content-language: en-US
Content-transfer-encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTYRTnc9vddbX6WlonA1uXVaRobmt5jczCXBcqERJ6SNlFv9TcQ3Zn
        L/qjMs3sqQXmsBdCyIrEWWalWVZK2ru02UspUonsaa0WPbZdA//6fud8v3PO7/w4tERVSYXR
        ORY7sVl4E0MppPU3ZsZG7awxpsU0DmnY32WtcragqoZiH7zdR7E9324h9vHlSop9vqOaYgdf
        lEvZjiv2BTT3y1uGuLrqCM7l3ENxL7oaKa752Fk5d+C8E3Ft7otB3FdXeAq9mszLJnwmsamJ
        JcOamWPJimeWLE9PTDfMidFGaePYWEZt4c0knlm0NCXKmGPyCWPUG3lTvi+VwgsCM2v+PJs1
        307U2VbBHs+kabW6aG1MbLRO53v1a+bqDD7KOpL9zNtJ5bkVmz/uOi7bjn7SJSiYBjwbOt+7
        5CVIQatwA4JzfbVIDDwIigteof+so23tcj9W4SsIarsm+bESj4Mfh19J/ViCZ8LAUJlULH6J
        wOV6HPgYjxPgdHulxI8pHAHNA27Kj0NwKhwv/RUokOA3CE4U3g5MGIunQuePN0icMB8e1LXI
        ShBNS/E0cD9U+9OheCXs7P8ZoAf7+l+4e4QSRUyEgsLuYUFT4PqT/kB/wB4Kirz7ZeI2i+B7
        d/fwZuPhXdt5uYgnQ59TXB/wbgRDAwUyMTiE4FN7XZDI0kPfqZIgccQYKL7xW+5XB1gJxUUq
        kcLBu0tVw1Y0ISj/80h+CIU7RljmGGGZY4RyxwjlJ5HUiSaQPMGcRQRdnj5a4M1CviUrOsNq
        dqHAZUYsbkD195a2IEwjZrSSHmVMU8n4jcIWcwsCWsKEKB8d8aWUmfyWrcRmTbflm4jQggw+
        M0slYaEZVt+dW+zpWoNOr9ezhtg4fUwcM1HZ2pGUpsJZvJ3kEpJHbP/rgujgsO2oMWmKaXC0
        ozT5+6re+Ar3w73rzmhPKt5G3vzStcZcXhzefK1XU2S8uKIeJyRtbdo3ObhH7b0/9sthMv3v
        tt6DCYkLq3I9noXXWclgRqnG69xQgXI/9GybYWu42rlJs8JYr7zjuR/Z76Tlr5dpVhYmJq8f
        mBa39rIite5zxdPkv0MeRipk89oIiU3g/wFgo5CZrwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgkeLIzCtJLcpLzFFi42I5/e+xgG7Terdogx29fBZ/Jx1jt2hevJ7N
        4sLTHjaL+1+PMlpc3jWHzeJ24wo2i7d3prNYnN5d4sDh8fvXJEaPzSu0PDat6mTzuHNtD5vH
        /rlr2D36tqxi9Dh+YzuTx+dNcgEcUVw2Kak5mWWpRfp2CVwZt35dZSu4wVXxvmUeawPjT44u
        Rk4OCQETiRnHT7F3MXJxCAnsZJQ4PXcOI0iCV0BQ4sfkeyxdjBwczALqElOm5ELU3GeUmL7k
        MFiNsIC9xLJTc5hBbDYBLYn9L26wgdSLCIRI7D+kAlLPLPCYUWLSjUlQC/YzSizc+YcNpIFf
        QFHi6o/HUMvsJC5sPsQK0swioCpx46ICSFhUIELi3vlPYOWcQLu2np0CZjMLiEs0t95kgbDl
        JQ5eec4ygVFwFpKzZyGcPQtJxywkHQsYWVYxSqYWFOem5xYbFRjlpZbrFSfmFpfmpesl5+du
        YgTGz7bDWv07GB8viT/EKMDBqMTDu4HDLVqINbGsuDL3EKMEB7OSCO+lKUAh3pTEyqrUovz4
        otKc1OJDjNIcLErivPz5xyKFBNITS1KzU1MLUotgskwcnFINjNZSR38IPphgIBoe/4khWL1x
        2jQNrkn3tgpXtAcIP3XojC1lyii5m31siukVs8smHlVHP36u5pffMi1EZY9kxdOap5sL4qxe
        TjlQlyzfPLWxQCLJJP/U56f1Czo9p11nvPqeaXPKbreQmy/ZdGzOHizd5yA9s+ThDIELRzdI
        ODC8PbfO58Ta90osxRmJhlrMRcWJAM5y3o2bAgAA
X-CMS-MailID: 20180712013146epcas2p3cb25893991134ce18cdfae82b7f98660
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180711155116epcas3p1d50af5ed86f7f55f607657d195492582
References: <CGME20180711155116epcas3p1d50af5ed86f7f55f607657d195492582@epcas3p1.samsung.com>
        <20180711155039.3600663-1-arnd@arndb.de>
        <ceb8cd99-91e3-aad6-bedc-bf5626c7683a@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018년 07월 12일 10:30, Chanwoo Choi wrote:
> On 2018년 07월 12일 00:50, Arnd Bergmann wrote:
>> Another driver turned up that is missing linux/mod_devicetable.h after
>> the device IDs are split out from linux/platform_device.h:
>>
>> drivers/extcon/extcon-max3355.c:127:34: error: array type has incomplete element type 'struct of_device_id'
>>  static const struct of_device_id max3355_match_table[] = {
>>
>> Fixes: ac3167257b9f ("headers: separate linux/mod_devicetable.h from linux/platform_device.h")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>> Greg, please add that to the char-misc tree that already has
>> other related patches.
>> ---
>>  drivers/extcon/extcon-max3355.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/extcon/extcon-max3355.c b/drivers/extcon/extcon-max3355.c
>> index 0aa410836f4e..1335a476bfec 100644
>> --- a/drivers/extcon/extcon-max3355.c
>> +++ b/drivers/extcon/extcon-max3355.c
>> @@ -14,6 +14,7 @@
>>  #include <linux/gpio/consumer.h>
>>  #include <linux/interrupt.h>
>>  #include <linux/module.h>
>> +#include <linux/mod_devicetable.h>
>>  #include <linux/platform_device.h>
>>  
>>  struct max3355_data {
>>
> 
> Applied it. Thanks.
> 

If Greg pick up this patch, I'll drop it from extcon git.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
