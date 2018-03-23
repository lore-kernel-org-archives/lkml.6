Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1533320-1521818251-2-6071645751622989608
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521818250; b=XKwAi7LCmyEr/g4GY7g8h5a88IAsXvn1yl88/0rpi3Kubw2
    KY//C+ZRZyawFNDjCsPSCMtqSI7sGEoDruEcCJ88PVmaQMyiNdjGHIQeaoY9QI5f
    xsqjp16y+TCHGGoD947ijGP3Q/fWjXA/HvKGcK/IlckrVyINay85PCf/vl5POWIm
    NIAWRkUG1rpZy13zKoKXQdGJ7/8cphDlsExcX54PfBBOsw66cbFKVeTp4pwMkP8M
    O/tdmrIU8+IPL3wS0sx+rfayPno6W/LW2zcv4Gzrj2Ej8rV73IivUHdvPg7i9XkU
    Vhene9GFbCINphd7dMCbOCkCxFIH86Hs7Eb9sqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:references:date
    :in-reply-to:message-id:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521818250; bh=P
    HCh6uvcK2m8YHdWgMDwQ28KwA+jlr0h9+lZGklxcI4=; b=HFFkZ8qi0NHCkmNDV
    4A2D1oy/CTx+sLI7xTspCMqMJOCKM8E21gmn7nrhOM8sCBFkBAPGBz1FENppLLDw
    4kYu53rAlhRwifNTE1eIWpmi4nSBdjFCvFDLYJVRZj0D1Fd9TOqTv1Yy12n+KIcQ
    n3avxifRlK1aq0++b+unDA36AUvAreEVveqY5slzxZRVAEyLtI3OgA4OIJjcszPo
    N3LWdgYLjD/jD/Hq94urQ3x6SGpQ5b0sFZMH1AMO453zF2re6I/WvDOemuKsk2Ye
    +suECZIkphZtQxb1AO3BVTaWM08ea1DPAB1BDo0aEm2CwGju+fA/s4UG0d5u4qDY
    R8Zfg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Haiyang Zhang <haiyangz@linuxonhyperv.com>
Subject: Re: [PATCH net-next,
 2/2] hv_netvsc: Add range checking for rx packet offset and length
References: <20180322190114.25596-1-haiyangz@linuxonhyperv.com>
 <20180322190114.25596-3-haiyangz@linuxonhyperv.com>
Date: Fri, 23 Mar 2018 16:17:19 +0100
In-Reply-To: <20180322190114.25596-3-haiyangz@linuxonhyperv.com> (Haiyang
 Zhang's message of "Thu, 22 Mar 2018 12:01:14 -0700")
Message-ID: <87sh8q4y9s.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: olaf@aepfle.de, sthemmin@microsoft.com, netdev@vger.kernel.org,
 haiyangz@microsoft.com, linux-kernel@vger.kernel.org,
 devel@linuxdriverproject.org, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Haiyang Zhang <haiyangz@linuxonhyperv.com> writes:

> From: Haiyang Zhang <haiyangz@microsoft.com>
>
> This patch adds range checking for rx packet offset and length.
> It may only happen if there is a host side bug.
>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  drivers/net/hyperv/hyperv_net.h |  1 +
>  drivers/net/hyperv/netvsc.c     | 17 +++++++++++++++--
>  2 files changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_net.h
> index 0db3bd1ea06f..49c05ac894e5 100644
> --- a/drivers/net/hyperv/hyperv_net.h
> +++ b/drivers/net/hyperv/hyperv_net.h
> @@ -793,6 +793,7 @@ struct netvsc_device {
>
>  	/* Receive buffer allocated by us but manages by NetVSP */
>  	void *recv_buf;
> +	u32 recv_buf_size; /* allocated bytes */
>  	u32 recv_buf_gpadl_handle;
>  	u32 recv_section_cnt;
>  	u32 recv_section_size;
> diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
> index 1ddb2c39b6e4..a6700d65f206 100644
> --- a/drivers/net/hyperv/netvsc.c
> +++ b/drivers/net/hyperv/netvsc.c
> @@ -289,6 +289,8 @@ static int netvsc_init_buf(struct hv_device *device,
>  		goto cleanup;
>  	}
>
> +	net_device->recv_buf_size = buf_size;
> +
>  	/*
>  	 * Establish the gpadl handle for this buffer on this
>  	 * channel.  Note: This call uses the vmbus connection rather
> @@ -1095,11 +1097,22 @@ static int netvsc_receive(struct net_device *ndev,
>
>  	/* Each range represents 1 RNDIS pkt that contains 1 ethernet frame */
>  	for (i = 0; i < count; i++) {
> -		void *data = recv_buf
> -			+ vmxferpage_packet->ranges[i].byte_offset;
> +		u32 offset = vmxferpage_packet->ranges[i].byte_offset;
>  		u32 buflen = vmxferpage_packet->ranges[i].byte_count;
> +		void *data;
>  		int ret;
>
> +		if (unlikely(offset + buflen > net_device->recv_buf_size)) {
> +			status = NVSP_STAT_FAIL;
> +			netif_err(net_device_ctx, rx_err, ndev,
> +				  "Packet offset:%u + len:%u too big\n",
> +				  offset, buflen);

This shouldn't happen, of course, but I'd rather ratelimit this error or
even used something like netdev_WARN_ONCE().

> +
> +			continue;
> +		}
> +
> +		data = recv_buf + offset;
> +
>  		trace_rndis_recv(ndev, q_idx, data);
>
>  		/* Pass it to the upper layer */

-- 
  Vitaly
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
