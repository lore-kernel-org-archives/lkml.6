Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB05C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 03:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9A4B2245A
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 03:28:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9A4B2245A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933150AbeGDD2m (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 23:28:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59216 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932351AbeGDD2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 23:28:40 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CADD040704A7;
        Wed,  4 Jul 2018 03:28:39 +0000 (UTC)
Received: from [10.72.12.45] (ovpn-12-45.pek2.redhat.com [10.72.12.45])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C0812027047;
        Wed,  4 Jul 2018 03:28:32 +0000 (UTC)
Subject: Re: [PATCH net-next 1/8] vhost: move get_rx_bufs to vhost.c
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, mst@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, wexu@redhat.com, tiwei.bie@intel.com,
        maxime.coquelin@redhat.com, jfreimann@redhat.com
References: <1530596284-4101-2-git-send-email-jasowang@redhat.com>
 <201807040813.LULqRH8c%fengguang.wu@intel.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <7183970a-4b1f-6322-2516-ea252375fe47@redhat.com>
Date:   Wed, 4 Jul 2018 11:28:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <201807040813.LULqRH8c%fengguang.wu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 04 Jul 2018 03:28:39 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 04 Jul 2018 03:28:39 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jasowang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年07月04日 09:01, kbuild test robot wrote:
> Hi Jason,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on net-next/master]
>
> url:https://github.com/0day-ci/linux/commits/Jason-Wang/Packed-virtqueue-for-vhost/20180703-154751
> config: x86_64-randconfig-s0-07032254 (attached as .config)
> compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
> reproduce:
>          # save the attached .config to linux build tree
>          make ARCH=x86_64
>
> Note: the linux-review/Jason-Wang/Packed-virtqueue-for-vhost/20180703-154751 HEAD 01b902f1126212ea2597e6d09802bd9c4431bf82 builds fine.
>        It only hurts bisectibility.
>
> All errors (new ones prefixed by >>):
>
>     drivers//vhost/net.c: In function 'handle_rx':
>>> drivers//vhost/net.c:738:15: error: implicit declaration of function 'get_rx_bufs' [-Werror=implicit-function-declaration]
>        headcount = get_rx_bufs(vq, vq->heads + nvq->done_idx,
>                    ^~~~~~~~~~~
>     cc1: some warnings being treated as errors
>
> vim +/get_rx_bufs +738 drivers//vhost/net.c

My bad, forget to do one by one compling test.

Will post V2.

Thanks

