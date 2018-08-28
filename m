Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F53C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B164D2088E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i9HtI1FM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B164D2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbeH1VG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 17:06:57 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50046 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbeH1VG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 17:06:57 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7SH3u3b181490;
        Tue, 28 Aug 2018 17:14:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=M7do1fumj2gd8jjtIm1/GLhikNG/3zXfdTShzyytiwk=;
 b=i9HtI1FMfKwgZO2pZ3brTXP/hOCJQzZ7OTxbPnD+pe1ywDRHVUnCQXzcjyoSiF6ciBtJ
 v2M+vMUZAiHq4rffUH1cTvpW0vGPDoBbhUdY7Flhv9Q/OyuJgR7w9sKn6pQNStDKdoAq
 +vl7yWK81QeHCFTTwZiVrqw7iqkhGWMAMjUVlYDuAcFrWBpYOS+9Py9v64xGu/GnjUv7
 QBibnWkK0PgmL2GepzlMSGlUflA3+tVRd0ScL5FZe+GFWP5iClLfC1cf3vLrdAmyMSjY
 QKvRV1rQQV9UejVsYatIy6K3fnPeRZFQPa3DlU9SZI4Jm9xEiP/24qW86SgCMYVuBytR cQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2m2xhtnask-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Aug 2018 17:14:15 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7SHE9vX007321
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Aug 2018 17:14:09 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7SHE8Pl010406;
        Tue, 28 Aug 2018 17:14:08 GMT
Received: from [10.211.202.81] (/10.211.202.81)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Aug 2018 10:14:08 -0700
Subject: Re: [PATCH V2] xen: export device state to sysfs
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
References: <c7cfcd6d-5245-b82f-781f-32bddec5aeab@oracle.com>
 <6cccd58c-f962-ac4b-bfb4-08df8432f4e5@oracle.com>
From:   Joe Jin <joe.jin@oracle.com>
Message-ID: <cb9d797b-0df1-8bb2-93b3-34caf6da6f30@oracle.com>
Date:   Tue, 28 Aug 2018 10:14:05 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <6cccd58c-f962-ac4b-bfb4-08df8432f4e5@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8999 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808280172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/18 9:53 AM, Boris Ostrovsky wrote:
> On 08/28/2018 10:56 AM, Joe Jin wrote:
>> Export device state to sysfs to allow for easier get device state.
>>
>> Signed-off-by: Joe Jin <joe.jin@oracle.com>
>> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>> Cc: Juergen Gross <jgross@suse.com>
>> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>> ---
>>  Documentation/ABI/stable/sysfs-bus-xen-backend | 9 +++++++++
>>  drivers/xen/xenbus/xenbus_probe.c              | 9 +++++++++
>>  2 files changed, 18 insertions(+)
>>
>> diff --git a/Documentation/ABI/stable/sysfs-bus-xen-backend b/Documentation/ABI/stable/sysfs-bus-xen-backend
>> index 3d5951c8bf5f..e8b60bd766f7 100644
>> --- a/Documentation/ABI/stable/sysfs-bus-xen-backend
> 
> 
> Won't this show up in the frontend as well?

Yes it will, current there is no any ABI document for xen-frontend.

Thanks,
Joe
> 
> -boris
> 
>> +++ b/Documentation/ABI/stable/sysfs-bus-xen-backend
>> @@ -73,3 +73,12 @@ KernelVersion:	3.0
>>  Contact:	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>>  Description:
>>                  Number of sectors written by the frontend.
>> +
>> +What:		/sys/bus/xen-backend/devices/*/state
>> +Date:		August 2018
>> +KernelVersion:	4.19
>> +Contact:	Joe Jin <joe.jin@oracle.com>
>> +Description:
>> +                The state of the device. One of: 'Unknown',
>> +                'Initialising', 'Initialised', 'Connected', 'Closing',
>> +                'Closed', 'Reconfiguring', 'Reconfigured'.
>> diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
>> index f2088838f690..5b471889d723 100644
>> --- a/drivers/xen/xenbus/xenbus_probe.c
>> +++ b/drivers/xen/xenbus/xenbus_probe.c
>> @@ -402,10 +402,19 @@ static ssize_t modalias_show(struct device *dev,
>>  }
>>  static DEVICE_ATTR_RO(modalias);
>>  
>> +static ssize_t state_show(struct device *dev,
>> +			    struct device_attribute *attr, char *buf)
>> +{
>> +	return sprintf(buf, "%s\n",
>> +			xenbus_strstate(to_xenbus_device(dev)->state));
>> +}
>> +static DEVICE_ATTR_RO(state);
>> +
>>  static struct attribute *xenbus_dev_attrs[] = {
>>  	&dev_attr_nodename.attr,
>>  	&dev_attr_devtype.attr,
>>  	&dev_attr_modalias.attr,
>> +	&dev_attr_state.attr,
>>  	NULL,
>>  };
>>  
> 
