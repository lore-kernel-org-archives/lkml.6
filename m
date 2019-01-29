Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A06AC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C0B420881
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbfA2J0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 04:26:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49070 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725799AbfA2J0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 04:26:01 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0T9Ptov142306
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 04:26:00 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qajr8dedc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 04:25:59 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <michaele@au1.ibm.com>;
        Tue, 29 Jan 2019 09:25:27 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 29 Jan 2019 09:25:24 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0T9PN3R3670346
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 29 Jan 2019 09:25:24 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D09C84C04E;
        Tue, 29 Jan 2019 09:25:23 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D5DF4C044;
        Tue, 29 Jan 2019 09:25:23 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 29 Jan 2019 09:25:23 +0000 (GMT)
Received: from localhost (unknown [9.102.48.146])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 2F1E0A01F5;
        Tue, 29 Jan 2019 20:25:22 +1100 (AEDT)
From:   Michael Ellerman <michaele@au1.ibm.com>
To:     Michael Bringmann <mwb@linux.vnet.ibm.com>,
        Tyrel Datwyler <turtle.in.the.kernel@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Juliet Kim <minkim@us.ibm.com>,
        Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        nathanl@linux.vnet.ibm.com
Subject: Re: [RFC 1/6] powerpc:/drc Define interface to acquire arch-specific drc info
In-Reply-To: <d881d17c-1157-a6a0-0784-33510a4ee674@linux.vnet.ibm.com>
References: <20181214204914.16435.59083.stgit@powerkvm6.aus.stglabs.ibm.com> <20181214204957.16435.29255.stgit@powerkvm6.aus.stglabs.ibm.com> <e7030879-59e4-88fd-3785-fdd98b7f0a3b@gmail.com> <63da6cfa-5272-0c78-ae91-0ad1130db3f1@linux.vnet.ibm.com> <d881d17c-1157-a6a0-0784-33510a4ee674@linux.vnet.ibm.com>
Date:   Tue, 29 Jan 2019 20:25:21 +1100
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 19012909-0012-0000-0000-000002EE5852
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012909-0013-0000-0000-000021259A09
Message-Id: <87d0ofstmm.fsf@concordia.ellerman.id.au>
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-29_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901290072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Bringmann <mwb@linux.vnet.ibm.com> writes:
> On 1/25/19 10:09 AM, Michael Bringmann wrote:
>> Adding Nathan Lynch
>> 
>> On 1/24/19 6:04 PM, Tyrel Datwyler wrote:
>>> On 12/14/2018 12:50 PM, Michael Bringmann wrote:
>>>> Define interface to acquire arch-specific drc info to match against
>>>> hotpluggable devices.  The current implementation exposes several
>>>> pseries-specific dynamic memory properties in generic kernel code.
>>>> This patch set provides an interface to pull that code out of the
>>>> generic kernel.
>>>>
>>>> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
>>>> ---
>>>>  include/linux/topology.h |    9 +++++++++
>>>>  1 file changed, 9 insertions(+)
>>>>
>>>> diff --git a/include/linux/topology.h b/include/linux/topology.h
>>>> index cb0775e..df97f5f 100644
>>>> --- a/include/linux/topology.h
>>>> +++ b/include/linux/topology.h
>>>> @@ -44,6 +44,15 @@
>>>
>>> As far as I know pseries is the only platform that uses DR connectors, and I
>>> highly doubt that any other powerpc platform or arch ever will. So, I'm not sure
>>> that this is really generic enough to belong in topology.h. If anything I would
>>> suggest putting this in an include in arch/powerpc/include/ named something like
>>> drcinfo.h or pseries-drc.h. That will make it visible to modules like rpaphp
>>> that want/need to use this functionality.
>
> It looks like the 'rpaphp' and 'rpadlpar_io' modules are also dependent upon the
> powerpc platform.

Yes that's right.

> Shouldn't the relevant source files be moved completely to the
> powerpc-specific directories out of drivers/pci/hotplug as well?

I don't think so. They are PCI hotplug drivers, so they should sit with
the other PCI hotplug drivers.

It's true that PCI hotplug drivers are more platform specific than other
types of drivers, but still they have some things in common with other
PCI hotplug drivers.

cheers

