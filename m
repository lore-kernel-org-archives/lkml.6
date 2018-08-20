Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4D7C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 17:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 681EF21473
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 17:41:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 681EF21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbeHTU6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 16:58:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41624 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726197AbeHTU6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 16:58:19 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7KHdM6g107243
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 13:41:45 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m021q0gbb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 13:41:44 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Mon, 20 Aug 2018 11:41:44 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 20 Aug 2018 11:41:39 -0600
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7KHfaOH786792
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Aug 2018 10:41:36 -0700
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD75C6A047;
        Mon, 20 Aug 2018 11:41:36 -0600 (MDT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 230F66A054;
        Mon, 20 Aug 2018 11:41:33 -0600 (MDT)
Received: from oc8043147753.ibm.com (unknown [9.80.233.6])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 20 Aug 2018 11:41:32 -0600 (MDT)
Subject: Re: [PATCH v9 12/22] s390: vfio-ap: sysfs interfaces to configure
 control domains
To:     Cornelia Huck <cohuck@redhat.com>,
        Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
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
 <1534196899-16987-13-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180820162317.08bd7d23.cohuck@redhat.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Mon, 20 Aug 2018 13:41:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180820162317.08bd7d23.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18082017-0004-0000-0000-00001479F886
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009580; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01076346; UDB=6.00554848; IPR=6.00856315;
 MB=3.00022830; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-20 17:41:42
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082017-0005-0000-0000-00008886C039
Message-Id: <660de00a-c403-28c1-4df4-82a973ab3ad5@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-20_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808200182
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/20/2018 10:23 AM, Cornelia Huck wrote:
> On Mon, 13 Aug 2018 17:48:09 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>
>> From: Tony Krowiak <akrowiak@linux.ibm.com>
>>
>> Provides the sysfs interfaces for:
>>
>> 1. Assigning AP control domains to the mediated matrix device
>>
>> 2. Unassigning AP control domains from a mediated matrix device
>>
>> 3. Displaying the control domains assigned to a mediated matrix
>>     device
>>
>> The IDs of the AP control domains assigned to the mediated matrix
>> device are stored in an AP domain mask (ADM). The bits in the ADM,
>> from most significant to least significant bit, correspond to
>> AP domain numbers 0 to 255. On some systems, the maximum allowable
>> domain number may be less than 255 - depending upon the host's
>> AP configuration - and assignment may be rejected if the input
>> domain ID exceeds the limit.
> Please remind me of the relationship between control domains and usage
> domains... IIRC, usage domains allow both requests and configuration,
> while control domains allow only configuration, and are by convention a
> superset of usage domains.

A usage domain is a domain to which an AP command-request message can be
submitted for processing. A control domain is a domain that can
be changed by an AP command request message submitted to a usage domain.
AP command request messages to configure a domain will contain the domain
number of the domain to be modified. The AP firmware will check the
control domain mask (ADM) and will allow the request to proceed only if
the corresponding bit in the ADM is set.

>
> Is there a hard requirement somewhere in there, or can the admin
> cheerfully use different masks for usage domains and control domains
> without the SIE choking on it?

There is no hard requirement that control domains must be a superset of
the usage domains, it is merely an architectural convention. AFAIK,
SIE doesn't enforce this and will not break if the convention is not
enforced externally. Having said that, you should note that the AQM
and ADM masks configured for the mediated matrix device will be logically
OR'd together to create the ADM stored in the CRYCB referenced from the
guest's SIE state description. In other words, we are enforcing the
convention in our software.

>

