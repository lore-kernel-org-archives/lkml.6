Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751657AbeDMPTd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 11:19:33 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:46602 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750928AbeDMPTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 11:19:32 -0400
Subject: Re: [PATCH] soc: ti: knav_qmss: Use percpu instead atomic for stats
 counter
From: "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>
To: Vasyl Gomonovych <gomonovych@gmail.com>
Cc: ssantosh@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20180411191629.21545-1-gomonovych@gmail.com>
 <63d79bc4-2ee1-2350-2431-ae41b53b0914@oracle.com>
Organization: Oracle Corporation
Message-ID: <89591f43-19c6-26b5-c0f7-e370721ec397@oracle.com>
Date: Fri, 13 Apr 2018 09:19:07 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <63d79bc4-2ee1-2350-2431-ae41b53b0914@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8861 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=581
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804130141
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/18 3:28 PM, santosh.shilimkar@oracle.com wrote:
> On 4/11/18 12:16 PM, Vasyl Gomonovych wrote:
>> Hwqueue has collect statistics in heavy use queue_pop/queu_push functions
>> for cache efficiency and make push/pop faster use percpu variables.
>> For performance reasons, driver should keep descriptor in software 
>> handler
>> as short as possible and quickly return it back to hardware queue.
>> Descriptors coming into driver from hardware after pop and return back
>> by push to reduce descriptor lifetime in driver collect statistics on 
>> percpu.
>>
>> Signed-off-by: Vasyl Gomonovych <gomonovych@gmail.com>
>> ---
> This is really good idea. Have you tested this patch ? If not it needs
> to be tested on Keystone SOCs to make sure all works.
> 
Thanks for confirming the tests done with rapidIO offlist. Will queue
this patch for next merge window.

Regards,
Santosh
