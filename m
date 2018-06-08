Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id cPvHJgmBGluqTwAAmS7hNA
	; Fri, 08 Jun 2018 13:13:45 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 89BDC607E4; Fri,  8 Jun 2018 13:13:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 20286606FA;
	Fri,  8 Jun 2018 13:13:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 20286606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752729AbeFHNNn (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 09:13:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39180 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752430AbeFHNNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 09:13:41 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w58D9DuT075494
        for <linux-kernel@vger.kernel.org>; Fri, 8 Jun 2018 09:13:41 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jft1k1g12-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 09:13:40 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Fri, 8 Jun 2018 14:13:34 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 8 Jun 2018 14:13:32 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w58DDUOw25690114
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Jun 2018 13:13:31 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0664642047;
        Fri,  8 Jun 2018 14:03:49 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 399FE42045;
        Fri,  8 Jun 2018 14:03:47 +0100 (BST)
Received: from oc3836556865.ibm.com (unknown [9.152.98.255])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  8 Jun 2018 14:03:47 +0100 (BST)
Subject: Re: [PATCH RFC 2/2] vfio-ccw: support for halt/clear subchannel
To: Cornelia Huck <cohuck@redhat.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20180509154822.23510-1-cohuck@redhat.com>
 <20180509154822.23510-3-cohuck@redhat.com>
 <c18f9b9f-da00-1a0b-8ef0-7ac223c73d1a@linux.ibm.com>
 <20180515181006.0cb1dfc2.cohuck@redhat.com>
 <a5d08fb7-d9c1-b230-fe0c-acebbda2ba65@linux.ibm.com>
 <20180522145208.310143ea.cohuck@redhat.com>
 <4e4001cc-540e-0f2b-bbd1-1f82ca594bb3@linux.ibm.com>
 <20180605151449.22aafbfc.cohuck@redhat.com>
 <e73038ff-fb2d-5865-8b84-e775990f3983@linux.ibm.com>
 <20180606142131.74ea2eb7.cohuck@redhat.com>
 <5b77ec9c-41b8-2e32-ce79-d9005b93fdd0@linux.ibm.com>
 <20180607115442.6a779ed9.cohuck@redhat.com>
 <86d57698-3ea7-a390-2217-07c6d41ca9ed@linux.ibm.com>
 <20180608142022.7dd6a658.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Fri, 8 Jun 2018 15:13:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180608142022.7dd6a658.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18060813-0020-0000-0000-00000298ADE7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060813-0021-0000-0000-000020E4B97B
Message-Id: <d68340a2-bb1b-cef9-e394-f0d55983c0bb@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-08_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806080151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/08/2018 02:20 PM, Cornelia Huck wrote:
>>> My proposal is to do the same
>>> copying to scsw(r) again, which would mean we get a request with both
>>> the halt and the start bit set. The vfio code now needs to do a hsch
>>> (instead of a ssch). The real channel subsystem should figure this out,
>>> as we can't reliably check whether the start function has concluded
>>> already (there's always a race window).
>> This I do not agree scsw(r) is part of the driver.
>> The interface here is not a device interface anymore but a driver
>> interface.
>> SCSW is a status, it is at its place in QEMU device interface with the
>> guest
>> but here pwrite() sends a command.
> Hm, I rather consider that "we write a status, and the backend figures
> out what to do based on that status".
> 

The status of what? Kind of a target status?

I think this approach is the source of lots of complications. For instance
take xsch. How are we supposed to react to a guest xsch (in QEMU and
in the kernel module)? My guess is that the right thing to do is to issue
an xsch in the vfio-ccw kernel module on the passed through subchannel.
But there is no bit in fctl for cancel.

Bottom line is: I'm not happy with the current design but I'm not sure
if it's practical to do something about it (i.e. change it radically).

Regards,
Halil
