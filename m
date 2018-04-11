Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754395AbeDKV27 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 17:28:59 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54526 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753094AbeDKV26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 17:28:58 -0400
Subject: Re: [PATCH] soc: ti: knav_qmss: Use percpu instead atomic for stats
 counter
To: Vasyl Gomonovych <gomonovych@gmail.com>, ssantosh@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180411191629.21545-1-gomonovych@gmail.com>
From: "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <63d79bc4-2ee1-2350-2431-ae41b53b0914@oracle.com>
Date: Wed, 11 Apr 2018 14:28:17 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180411191629.21545-1-gomonovych@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8860 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=553
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804110199
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/18 12:16 PM, Vasyl Gomonovych wrote:
> Hwqueue has collect statistics in heavy use queue_pop/queu_push functions
> for cache efficiency and make push/pop faster use percpu variables.
> For performance reasons, driver should keep descriptor in software handler
> as short as possible and quickly return it back to hardware queue.
> Descriptors coming into driver from hardware after pop and return back
> by push to reduce descriptor lifetime in driver collect statistics on percpu.
> 
> Signed-off-by: Vasyl Gomonovych <gomonovych@gmail.com>
> ---
This is really good idea. Have you tested this patch ? If not it needs
to be tested on Keystone SOCs to make sure all works.

Regards,
Santosh
