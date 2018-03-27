Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4045798-1522164175-2-15142801608971029954
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522164174; b=vS1h83OCEFKK5W3+SB2t4vIhZQf1Fca+HnuFEA5e9p7V+hK
    zqhiP7jKCfZSGgO/PhINium58PI8O07uG6NfWCg8sjGhzZ+t5tBa0HIeBj8aSHCr
    M4hn8HfZM77SLaocXyCnvmmk8SW7jV00rfIC+c1+WlKUXX6/GERO0euD47e7CmTr
    eHMdt3twMECLsOQ6Duv4tCiXpWON0R1l84eiW3a86mFhjG/toDYgn1rnI10Ljo6+
    /JGeJ0S4uYsHsh6AV5Ss4e7bKliSm342FPh/mcskAXGkFYFmUNLqzbSGz8UmFllI
    sC6g8Vi5Kdw+T/5SZDMnxOoCBkI18OtjS6hvdwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1522164174; bh=i
    86zJErbWOf4BPpHkL8bgjPeNdJeDqD0Ev72Ok0Y68E=; b=tp2G2qwQshTKQc14m
    Von0jODJpJeUpc8RFE5/fP5aFVY+HNkOcY5f5SKR/reBemqwO4Ez6c/iYwlhjrth
    PAIQ33390LgxDGnZPIXV4xTgf8D7sHDE/VAMqHocAlNUjeV7Z0WswvgOS+yTKn4h
    zgaRgB2O1QnRTXEMD0tRJcBaOorJBiHt10wQnWbE20eZQXn2VEsxU3nfL4DUUX5s
    vN7u8OSH3lScgY6BVlaaNtNj1XbHlcN7gX3Vu5mOLA/AdTuiyrLnco/CvQdB3d2D
    BB0MLkFszMdwRW0RdKWIw7s/9qi+P1gJp3/pf2C3SL9LcxWkSC9nuRVOkd1tVOcC
    rwP5g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b=kk1uMRbq x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=networkplumber.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=fD05UIg8;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=networkplumber.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b=kk1uMRbq x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=networkplumber.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=fD05UIg8;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=networkplumber.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJWt4eWd6O5AgReZF9jNJBOSjEvU4NQzsT/u3+KTWgnb0bG4/daNCPet/IRsfDjQaUVhkZOd87PeBmhw2cGHWzWxeS2pizq44IkNiJSVzu0e9aRs32tI
    5tHYUgEMKdVgfXvhyKKvx3A9gEshWvO7VqDr2MbWjIzt62QQP6S5O8Il4VD7tu/0znhYGAD4aQoAv6Vbh+ocCEKq3wx34MbR443gWZhDTgNLKp7gx0+uV7qG
    gR2ISlU3ai/K926BFINBCw==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Odnh0R2cAAAA:8 a=yMhMjlubAAAA:8
    a=DDOyTI_5AAAA:8 a=kd2A8AQCV0IhTsJHH1MA:9 a=CjuIK1q_8ugA:10
    a=lNAA6UHySJB7qmBR1x20:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx49Ys3XQHB9LVuIpPCmh7BNBHrK1PmB78VC1GfaZPj+Pok15EnruDKgc61AaU93kZOZYnsoOew==
Date: Tue, 27 Mar 2018 08:22:45 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Haiyang Zhang <haiyangz@linuxonhyperv.com>
Subject: Re: [PATCH net-next, 2/2] hv_netvsc: Add range checking for rx
 packet offset and length
Message-ID: <20180327082245.591612dc@xeon-e3>
In-Reply-To: <20180322190114.25596-3-haiyangz@linuxonhyperv.com>
References: <20180322190114.25596-1-haiyangz@linuxonhyperv.com>
 <20180322190114.25596-3-haiyangz@linuxonhyperv.com>
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
 devel@linuxdriverproject.org, vkuznets@redhat.com, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 22 Mar 2018 12:01:14 -0700
Haiyang Zhang <haiyangz@linuxonhyperv.com> wrote:

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
> +
> +			continue;
> +		}
> +

If one part of the RNDIS packet is wrong then the whole receive
buffer is damaged. Just return, don't continue.

It could really just be a statistic and a one shot log message.
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
