Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932430AbeBLBmV (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 20:42:21 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:34980 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753745AbeBLBmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 20:42:20 -0500
Subject: Re: [PATCH 2/9] nvme: fix the deadlock in nvme_update_formats
To: Sagi Grimberg <sagi@grimberg.me>, keith.busch@intel.com, axboe@fb.com,
        hch@lst.de
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <1518341920-1060-1-git-send-email-jianchao.w.wang@oracle.com>
 <1518341920-1060-3-git-send-email-jianchao.w.wang@oracle.com>
 <6cc12ce7-07ca-35ac-0bae-c6d875854504@grimberg.me>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <a74830c3-ae4e-68ca-866d-669c7007e2c4@oracle.com>
Date: Mon, 12 Feb 2018 09:40:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <6cc12ce7-07ca-35ac-0bae-c6d875854504@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8802 signatures=668668
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=645
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802120019
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sagi

Thanks for your kindly response and directive.
That's really appreciated.

On 02/11/2018 07:16 PM, Sagi Grimberg wrote:
>>       mutex_lock(&ctrl->namespaces_mutex);
>>       list_for_each_entry(ns, &ctrl->namespaces, list) {
>> -        if (ns->disk && nvme_revalidate_disk(ns->disk))
>> -            nvme_ns_remove(ns);
>> +        if (ns->disk && nvme_revalidate_disk(ns->disk)) {
>> +            list_del_init(&ns->list);
>> +            list_add_tail(&ns->list, &rm_list);
> 
> list_move_tail?

Yes, I will use this interface next version, as well as the 1st patch.

Sincerely
Jianchao

> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> https://urldefense.proofpoint.com/v2/url?u=http-3A__lists.infradead.org_mailman_listinfo_linux-2Dnvme&d=DwICAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=7WdAxUBeiTUTCy8v-7zXyr4qk7sx26ATvfo6QSTvZyQ&m=w-s8SrsXdziNNWDrav4KevPTjbt0WNbNQsEmXKL--FY&s=o0wVdE60HzA9inklf3xGMxQjy6l6JHNoDICmOHDBZMA&e=
> 
