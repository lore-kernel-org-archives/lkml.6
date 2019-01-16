Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9B4C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 05:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EACB20840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 05:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732756AbfAPFpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 00:45:42 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:32930 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732611AbfAPFpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 00:45:41 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EA8DDCB66FA50CDC83C3;
        Wed, 16 Jan 2019 13:45:38 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.408.0; Wed, 16 Jan 2019
 13:45:37 +0800
Subject: Re: [PATCH -next] LSM: Make some functions static
To:     <jmorris@namei.org>, <serge@hallyn.com>
References: <20190116053353.29320-1-yuehaibing@huawei.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <d638d4db-3706-46a7-fe65-66e96ac6e8d7@huawei.com>
Date:   Wed, 16 Jan 2019 13:45:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190116053353.29320-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pls ignore this duplicated patch.

On 2019/1/16 13:33, YueHaibing wrote:
> Fix the follow sparse warning:
> 
> security/security.c:533:5: warning: symbol 'lsm_task_alloc' was not declared. Should it be static?
> security/security.c:554:5: warning: symbol 'lsm_ipc_alloc' was not declared. Should it be static?
> security/security.c:575:5: warning: symbol 'lsm_msg_msg_alloc' was not declared. Should it be static?
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  security/security.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/security/security.c b/security/security.c
> index 9a98c52..750d3f3 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -530,7 +530,7 @@ int lsm_inode_alloc(struct inode *inode)
>   *
>   * Returns 0, or -ENOMEM if memory can't be allocated.
>   */
> -int lsm_task_alloc(struct task_struct *task)
> +static int lsm_task_alloc(struct task_struct *task)
>  {
>  	if (blob_sizes.lbs_task == 0) {
>  		task->security = NULL;
> @@ -551,7 +551,7 @@ int lsm_task_alloc(struct task_struct *task)
>   *
>   * Returns 0, or -ENOMEM if memory can't be allocated.
>   */
> -int lsm_ipc_alloc(struct kern_ipc_perm *kip)
> +static int lsm_ipc_alloc(struct kern_ipc_perm *kip)
>  {
>  	if (blob_sizes.lbs_ipc == 0) {
>  		kip->security = NULL;
> @@ -572,7 +572,7 @@ int lsm_ipc_alloc(struct kern_ipc_perm *kip)
>   *
>   * Returns 0, or -ENOMEM if memory can't be allocated.
>   */
> -int lsm_msg_msg_alloc(struct msg_msg *mp)
> +static int lsm_msg_msg_alloc(struct msg_msg *mp)
>  {
>  	if (blob_sizes.lbs_msg_msg == 0) {
>  		mp->security = NULL;
> 

