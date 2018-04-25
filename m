Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755231AbeDYQx1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 12:53:27 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51238 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753508AbeDYQxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 12:53:25 -0400
Subject: Re: [PATCH] rds: ib: Fix missing call to rds_ib_dev_put in
 rds_ib_setup_qp
To: Dag Moxnes <dag.moxnes@oracle.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org
References: <1524655321-8379-1-git-send-email-dag.moxnes@oracle.com>
From: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <4ea2c988-fd68-3bc0-2f6b-f12648f6d4e9@oracle.com>
Date: Wed, 25 Apr 2018 09:53:17 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1524655321-8379-1-git-send-email-dag.moxnes@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8874 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=855
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804250156
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/2018 4:22 AM, Dag Moxnes wrote:
> The function rds_ib_setup_qp is calling rds_ib_get_client_data and
> should correspondingly call rds_ib_dev_put. This call was lost in
> the non-error path with the introduction of error handling done in
> commit 3b12f73a5c29 ("rds: ib: add error handle")
> 
> Signed-off-by: Dag Moxnes <dag.moxnes@oracle.com>
> ---
Thanks Dag for following it up.

Acked-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>
