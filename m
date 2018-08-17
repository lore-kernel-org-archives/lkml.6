Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DC1C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 13:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0400221935
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 13:23:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0400221935
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbeHQQ1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 12:27:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58226 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726495AbeHQQ1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 12:27:15 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7HDNph9100318
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 09:23:52 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kwvb5xxaw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 09:23:51 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Fri, 17 Aug 2018 07:23:37 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 17 Aug 2018 07:23:33 -0600
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7HDNVc966846972
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Aug 2018 06:23:31 -0700
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E4C3B136051;
        Fri, 17 Aug 2018 07:23:30 -0600 (MDT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE3DB136053;
        Fri, 17 Aug 2018 07:23:26 -0600 (MDT)
Received: from oc8043147753.ibm.com (unknown [9.80.206.50])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 17 Aug 2018 07:23:26 -0600 (MDT)
Subject: Re: [PATCH v9 10/22] s390: vfio-ap: sysfs interfaces to configure
 adapters
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Tony Krowiak <akrowiak@linux.vnet.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com,
        pbonzini@redhat.com, alex.williamson@redhat.com,
        pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com,
        mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com,
        thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        frankja@linux.ibm.com
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1534196899-16987-11-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180815115242.35a2a1ce.cohuck@redhat.com>
 <4bf27c7a-34c6-9160-cdc6-19022b86202b@linux.ibm.com>
 <20180816093015.19e54936.cohuck@redhat.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Fri, 17 Aug 2018 09:23:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180816093015.19e54936.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18081713-0016-0000-0000-0000091C3371
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009561; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01074832; UDB=6.00553932; IPR=6.00854790;
 MB=3.00022773; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-17 13:23:36
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18081713-0017-0000-0000-00004007D348
Message-Id: <6e933696-515c-0533-796b-ef75b8627c84@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-17_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=896 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808170147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/16/2018 03:30 AM, Cornelia Huck wrote:
> On Wed, 15 Aug 2018 12:59:35 -0400
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>
>> On 08/15/2018 05:52 AM, Cornelia Huck wrote:
>>> On Mon, 13 Aug 2018 17:48:07 -0400
>>> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>>>> +/**
>>>> + * unassign_adapter_store
>>>> + *
>>>> + * @dev: the matrix device
>>>> + * @attr: a mediated matrix device attribute
>>>> + * @buf: a buffer containing the adapter ID (APID) to be assigned
>>>> + * @count: the number of bytes in @buf
>>>> + *
>>>> + * Parses the APID from @buf and unassigns it from the mediated matrix device.
>>>> + * The APID must be a valid value
>>> A valid value, but not necessarily assigned, right?
>> You are correct, if the APID is not assigned, then the corresponding bit
>> will be
>> cleared regardless. In a previous version, the functions failed if the
>> APID is
>> not assigned, but a colleague removed that check. I guess it makes sense
>> given
>> it really does not hurt anything to ask to unassign an APID that isn't
>> assigned
>> to begin with. Would you prefer I update the comment, or do you feel the
>> user
>> should be made aware of an attempt to unassign an APID that is not assigned?
> I think the code is fine; updating the comment would be good.

Will do.

>

