Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754062AbeDPIe5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 04:34:57 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42404 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754006AbeDPIez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 04:34:55 -0400
Subject: Re: [PATCH] blk-mq: mark hctx RESTART when get budget fails
To: Ming Lei <ming.lei@redhat.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1523865336-17326-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180416081503.GB23664@ming.t460p>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <11e10ccf-bdeb-4790-3bec-e3f49ab246c8@oracle.com>
Date: Mon, 16 Apr 2018 16:34:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180416081503.GB23664@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8864 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804160079
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming

Thanks for your kindly response.

On 04/16/2018 04:15 PM, Ming Lei wrote:
>> -		if (!blk_mq_get_dispatch_budget(hctx))
>> +		if (!blk_mq_get_dispatch_budget(hctx)) {
>> +			blk_mq_sched_mark_restart_hctx(hctx);
> The RESTART flag still may not take into effect if all requests are
> completed before calling blk_mq_sched_mark_restart_hctx().
> 

Yes, this is indeed a very tricky scenario.

Sincerely
Jianchao
