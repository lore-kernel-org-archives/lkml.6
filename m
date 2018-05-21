Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752971AbeEUQTA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 12:19:00 -0400
Received: from gateway33.websitewelcome.com ([192.185.145.239]:29101 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752698AbeEUQSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 12:18:55 -0400
X-Authority-Reason: nr=8
Subject: Re: [PATCH 01/11] media: tm6000: fix potential Spectre variant 1
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <3d4973141e218fb516422d3d831742d55aaa5c04.1524499368.git.gustavo@embeddedor.com>
 <20180423152455.363d285c@vento.lan>
 <3ab9c4c9-0656-a08e-740e-394e2e509ae9@embeddedor.com>
 <20180423161742.66f939ba@vento.lan>
 <99e158c0-1273-2500-da9e-b5ab31cba889@embeddedor.com>
 <20180426204241.03a42996@vento.lan>
 <df8010f1-6051-7ff4-5f0e-4a436e900ec5@embeddedor.com>
 <20180515085953.65bfa107@vento.lan> <20180515141655.idzuh2jfdkuu5grs@mwanda>
 <f342d8d6-b5e6-0cbf-d002-9561b79c90e4@embeddedor.com>
 <20180515193936.m25kzyeknsk2bo2c@mwanda>
 <0f31a60b-911d-0140-3546-98317e2a0557@embeddedor.com>
 <d34cf31f-6dc5-ee2d-ea6d-513dd5e8e5c3@embeddedor.com>
 <20180517083440.14e6b975@vento.lan> <20180517084324.3242c257@vento.lan>
 <20180517091340.7d8c62b2@vento.lan>
 <5921004a-a7d3-59c9-2ef4-b6a490390d3f@embeddedor.com>
Message-ID: <b3c23490-4113-c56f-8511-eea6cb054c48@embeddedor.com>
Date: Mon, 21 May 2018 11:18:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <5921004a-a7d3-59c9-2ef4-b6a490390d3f@embeddedor.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.192.46.223
X-Source-L: No
X-Exim-ID: 1fKnWP-003yuN-Rc
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.70]) [187.192.46.223]:43416
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/17/2018 01:08 PM, Gustavo A. R. Silva wrote:
> 
> BTW, Mauro, you sent a patch to fix an spectre v1 issue in this file 
> yesterday: dvb_ca_en50221.c:1480, but it seems there is another instance 
> of the same issue some lines above:
> 
> diff --git a/drivers/media/dvb-core/dvb_ca_en50221.c 
> b/drivers/media/dvb-core/dvb_ca_en50221.c
> index 1310526..7edd9db 100644
> --- a/drivers/media/dvb-core/dvb_ca_en50221.c
> +++ b/drivers/media/dvb-core/dvb_ca_en50221.c
> @@ -1398,6 +1398,7 @@ static int dvb_ca_en50221_io_do_ioctl(struct file 
> *file,
> 
>                  info->type = CA_CI_LINK;
>                  info->flags = 0;
> +               slot = array_index_nospec(slot, ca->slot_count + 1);
>                  sl = &ca->slot_info[slot];
>                  if ((sl->slot_state != DVB_CA_SLOTSTATE_NONE) &&
>                      (sl->slot_state != DVB_CA_SLOTSTATE_INVALID)) {
> 
> 

Hi Mauro,

Just to let you know, I was running smatch during the weekend and the 
tool is still reporting all these Spectre media warnings (and a lot more):

https://patchwork.linuxtv.org/project/linux-media/list/?submitter=7277

Thanks
--
Gustavo
