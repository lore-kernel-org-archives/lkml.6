Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752618AbeDSMC7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 08:02:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38252 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752322AbeDSMC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 08:02:58 -0400
Subject: Re: [PATCH] vfio-ccw: process ssch with interrupts disabled
To: Cornelia Huck <cohuck@redhat.com>,
        Dong Jia Shi <bjsdjshi@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180413140509.9042-1-cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 19 Apr 2018 14:01:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180413140509.9042-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18041912-0040-0000-0000-0000044F4C52
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041912-0041-0000-0000-000020F3A158
Message-Id: <dd958a03-d5e8-c826-6fc6-7229c3acbe1e@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-19_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804190108
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/13/2018 04:05 PM, Cornelia Huck wrote:
> When we call ssch, an interrupt might already be pending once we
> return from the START SUBCHANNEL instruction. Therefore we need to
> make sure interrupts are disabled until after we're done with our
> processing.
> 
> Note that the subchannel lock is the same as the ccwdevice lock that
> is mentioned in the documentation for ccw_device_start() and friends.
> 
> Signed-off-by: Cornelia Huck<cohuck@redhat.com>

Acked-by: Halil Pasic <pasic@linux.vnet.ibm.com>
