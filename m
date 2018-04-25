Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754156AbeDYLGn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 07:06:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46944 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752831AbeDYLGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 07:06:37 -0400
Subject: Re: [PATCH 01/10] vfio: ccw: Moving state change out of IRQ context
To: Cornelia Huck <cohuck@redhat.com>
Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>,
        Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, pasic@linux.vnet.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
References: <1524149293-12658-1-git-send-email-pmorel@linux.vnet.ibm.com>
 <1524149293-12658-2-git-send-email-pmorel@linux.vnet.ibm.com>
 <20180424065442.GV12194@bjsdjshi@linux.vnet.ibm.com>
 <ac4b7441-2d17-922b-695e-98c01d87cd42@linux.vnet.ibm.com>
 <20180424115929.5b5e1ff0.cohuck@redhat.com>
 <245ee547-75bc-95f5-5acb-bfa96f91afd2@linux.ibm.com>
 <20180425085726.3a8a97a5.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Wed, 25 Apr 2018 13:06:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180425085726.3a8a97a5.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18042511-0020-0000-0000-000004159FBF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042511-0021-0000-0000-000042AA0B2D
Message-Id: <bf8256f2-17a4-e1ec-ec35-a10bde734b65@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-25_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804250105
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/25/2018 08:57 AM, Cornelia Huck wrote:
>> AFAIU this will be the problem of the person implementing the clear
>> and the halt for vfio-ccw. I.e. it's a non-problem right now.
> Well, that person is me:)  I will post some RFC Real Soon Now if I stop
> getting sidetracked...
> 

Makes sense. It should be fine either way AFAIU.

CSCH, more precisely the clear function is supposed to clear the
interruption request(s) too. But I guess there is no way of the CP to
identify an I/O interrupt that should have been cleared -- that is catch
us disrespecting the architecture. I can't think of a way to establish
must happen before relationship...

But discarding the first interrupt and delivering just one for the CSCH
is fine too for the same reason.

Regards,
Halil
