Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754945AbeD3QwC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 12:52:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60012 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754848AbeD3QwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 12:52:00 -0400
Subject: Re: [PATCH v2 5/5] vfio: ccw: add traceponits for interesting error
 paths
To: Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>,
        Halil Pasic <pasic@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        borntraeger@de.ibm.com, bjsdjshi@linux.ibm.com, pmorel@linux.ibm.com
References: <20180423110113.59385-1-bjsdjshi@linux.vnet.ibm.com>
 <20180423110113.59385-6-bjsdjshi@linux.vnet.ibm.com>
 <20180427121353.4453bdc2.cohuck@redhat.com>
 <20180428055023.GS5428@bjsdjshi@linux.vnet.ibm.com>
 <20180430135153.1d108675.cohuck@redhat.com>
 <ca160353-696e-86f6-8a37-dd6a2f7fae8d@linux.ibm.com>
 <20180430170358.0ee6fe6a.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Mon, 30 Apr 2018 18:51:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180430170358.0ee6fe6a.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18043016-0040-0000-0000-0000045389C9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18043016-0041-0000-0000-000020F7A20A
Message-Id: <42c331bf-8ba1-7a67-5ec8-6bebcfad4ed7@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-30_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804300161
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/30/2018 05:03 PM, Cornelia Huck wrote:
>> I think the naming of this fctl thing is a bit cryptic,
>> but if we don't see this as ABI I'm fine with it -- can be improved.
>> What would be a better name? I was thinking along the lines accept_request.
>> (Bad error code would mean that the request did not get accepted. Good
>> code does not mean the requested function was performed successfully.)
> I think fctl is fine (if you don't understand what 'fctl' is, you're
> unlikely to understand it even if it were named differently.)
> 

AFAIU this fctl is a bit more complicated than the normal fctl. But
better let sleeping dogs lie.

>> Also I think vfio_ccw_io_fctl with no zero error code would make sense
>> as dev_warn. If I were an admin looking into a problem I would very much
>> appreciate seeing something in the messages log (and not having to enable
>> tracing first). This point seems to be a good one for high level 'request gone
>> bad' kind of report. Opinions?
> I'd also exclude -EOPNOTSUPP (as this also might happen with e.g. a halt/clear enabled user space, which probes availability of halt/clear support by giving it a try once (yes, I really want to post my patches this week.))
> 

I'm looking forward to the clear/halt. It hope it will help me understand
the big vfio-ccw picture better. There are still dark spots, but I don't
feel like doing something against this, as there is quite some activity
going on here -- and I don't want to hamper the efforts by binding resources.

Regards,
Halil
