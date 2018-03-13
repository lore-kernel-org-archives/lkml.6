Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934323AbeCMQJO convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 12:09:14 -0400
Received: from smtp-out4.electric.net ([192.162.216.185]:61130 "EHLO
        smtp-out4.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932443AbeCMQJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 12:09:11 -0400
From: David Laight <David.Laight@ACULAB.COM>
To: "'Gustavo A. R. Silva'" <gustavo@embeddedor.com>,
        Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] drm/nouveau/secboot: remove VLA usage
Thread-Topic: [PATCH] drm/nouveau/secboot: remove VLA usage
Thread-Index: AQHTut2QNsR4nq4lykyamoPGyKeiK6POVYlQ
Date: Tue, 13 Mar 2018 16:10:03 +0000
Message-ID: <6977788dfbac4b70b54fd56310cc27fe@AcuMS.aculab.com>
References: <20180313144812.GA30043@embeddedgus>
In-Reply-To: <20180313144812.GA30043@embeddedgus>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Outbound-IP: 156.67.243.126
X-Env-From: David.Laight@ACULAB.COM
X-Proto: esmtps
X-Revdns: 
X-HELO: AcuMS.aculab.com
X-TLS: TLSv1.2:ECDHE-RSA-AES256-SHA384:256
X-Authenticated_ID: 
X-PolicySMART: 3396946, 3397078
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gustavo A. R. Silva
> Sent: 13 March 2018 14:48
> In preparation to enabling -Wvla, remove VLA. In this particular
> case directly use macro NVKM_MSGQUEUE_CMDLINE_SIZE instead of local
> variable cmdline_size. Also, remove cmdline_size as it is not
> actually useful anymore.
...
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/ls_ucode_msgqueue.c
> b/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/ls_ucode_msgqueue.c
> index 6f10b09..2da147b 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/ls_ucode_msgqueue.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/ls_ucode_msgqueue.c
> @@ -80,12 +80,12 @@ acr_ls_msgqueue_post_run(struct nvkm_msgqueue *queue,
>  			 struct nvkm_falcon *falcon, u32 addr_args)
>  {
>  	struct nvkm_device *device = falcon->owner->device;
> -	u32 cmdline_size = NVKM_MSGQUEUE_CMDLINE_SIZE;
> -	u8 buf[cmdline_size];
> +	u8 buf[NVKM_MSGQUEUE_CMDLINE_SIZE];
> 
> -	memset(buf, 0, cmdline_size);
> +	memset(buf, 0, NVKM_MSGQUEUE_CMDLINE_SIZE);
>  	nvkm_msgqueue_write_cmdline(queue, buf);
> -	nvkm_falcon_load_dmem(falcon, buf, addr_args, cmdline_size, 0);
> +	nvkm_falcon_load_dmem(falcon, buf, addr_args,
> +			      NVKM_MSGQUEUE_CMDLINE_SIZE, 0);

I think I'd use 'sizeof (buf)' in both those lines.

	David
