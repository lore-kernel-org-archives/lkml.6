Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754591AbeD3P0a (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 11:26:30 -0400
Received: from gateway23.websitewelcome.com ([192.185.50.129]:31172 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752939AbeD3P02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 11:26:28 -0400
X-Authority-Reason: nr=8
Subject: Re: [PATCH][next] media: ispstat: don't dereference user_cfg before a
 null check
To: Sakari Ailus <sakari.ailus@iki.fi>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Colin King <colin.king@canonical.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180424130618.18211-1-colin.king@canonical.com>
 <20180426083731.72bmygsp2waf3eeu@valkosipuli.retiisi.org.uk>
 <2302951.d1m0yxIoYN@avalon>
 <20180430151503.d3kq2zomil6uh2xf@valkosipuli.retiisi.org.uk>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <9c1e7c1e-c391-4b91-7836-61a8b9d5489a@embeddedor.com>
Date: Mon, 30 Apr 2018 10:26:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180430151503.d3kq2zomil6uh2xf@valkosipuli.retiisi.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.172.56.86
X-Source-L: No
X-Exim-ID: 1fDAh9-003xkh-6j
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.74]) [187.172.56.86]:59962
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

On 04/30/2018 10:15 AM, Sakari Ailus wrote:
>> Isn't there a guarantee that new_buf won't be NULL ? The new_buf pointer comes
>> from the parg variable in video_usercopy(), which should always point to a
>> valid buffer given that the ioctl number specifies a non-zero size.
> 
> Fair question. After looking at the code, I agree with you; there should be
> no reason to perform the check in the first place. It may have been that
> the function has been used differently in the past but the check should be
> rather removed now.
> 
> I'll drop the patch.
> 

Please, if the check isn't needed anymore, make sure it is removed.

This helps to reduce the number of false positives reported by static 
analyzers.

Thanks
--
Gustavo
