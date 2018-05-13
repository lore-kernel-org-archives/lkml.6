Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3343056-1526232260-2-13886750046229830087
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526232259; b=l2DM6tSCDdwSinJHYIXE4zubl1GD0NwcPaggrwr2M/3qxLo/sR
    Au5aOWEgFLQxOmtMXbO5UjczZxbvXF8FSRlmsb8pV4QMs+SugQv5SH+51OZw2AXU
    UFiBEb9GxhGVqydDERlcz3Cg4OVcwU+RzdmsxLH9YJTVsO0I8k/fvA2nx0Euz8zb
    gDx6+UJ3zVEOQggZI3kfp873q7d1YpXT9+5m9QY7I8AW1MPmAlqopy7UKW021t+t
    0c50wjNGs4UgHaI4hs3P64RlfVwSKC6KsQaMsn1MOwaPsOICwDuUnmPoVPH5+c+k
    +gxyAy1sxBQsL6zdpi7i+QIwJ02wdNbeJ/Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526232259; bh=3sfi4
    xPFd1yKQT+/4SD7+8dGvec3vnujkmP8ayx6v1Q=; b=XZKh6ocs9Lr/BrLF/NMLx
    KWfq3gGo7MVKL6e205wG7qYLHeY50vGRb/zp9+BmJrNwEmZ7BCsnScWLBVUvk9CM
    jQA3wciPAd6B6OZmiw9OmqpSa7JFznT+PW7u2NgTYqYqMtuZZRKcMcCRRpRg/+ky
    m9W4bb877XkfL6FqqV0fD4ziPrGnVPsg9mYVFmyr5mzuJ2/1NAXjynZK1LYsjC9s
    jUJx2JuDRx4UQqxnL0S9CdkqCKCVUD+2OS66QgZ7U3Akm8IqCHYyHZd1BGCNomHU
    S+fz3UTf8/ooxXh+wamLI3KJpCnrl6vxLSC1k6FzYHmNuTv8PpH00u84kHHxsuYn
    A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=networkplumber-org.20150623.gappssmtp.com
    header.i=@networkplumber-org.20150623.gappssmtp.com header.b=qAq0tABJ
    x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=networkplumber.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=G4jjiLCe;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=networkplumber.org
    header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=networkplumber-org.20150623.gappssmtp.com
      header.i=@networkplumber-org.20150623.gappssmtp.com header.b=qAq0tABJ
      x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=networkplumber.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=G4jjiLCe;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=networkplumber.org
      header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIeDKN8xkeRpctuj23HBwq4hgM7w0urr3vqBMBUYChy8rHBdQ1SXr7D3dNB+9QZfC/7Wq/dT0nviUKRV8qL3gPBZDHHzqVDa/i4AwSC4b+z7TcJxAeQm
    iOrYg2Hnkw2re1WVaYhTSkTJzMaEVt96i9Xf2l2+V++ahyl7PnfmsIQ5wYXkqO+qcAOtJXQJODUGZJLspcFjH85fEkBkgazQFEVab0/0Z55yFjGjq1j0giq2
    0T4J/F5uZhL3dFYc4KbDJw==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Odnh0R2cAAAA:8 a=DDOyTI_5AAAA:8
    a=x31kuQR1FX0c29EMMfcA:9 a=CjuIK1q_8ugA:10 a=lNAA6UHySJB7qmBR1x20:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZq86v4h0pe0AeMXFb/8eqcdIEmYthyt5jEcAMNTd1UnPorB+iB+L81cJH+NPq03YxTvJI3kZw==
Date: Sun, 13 May 2018 10:24:09 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: kys@linuxonhyperv.com
Subject: Re: [PATCH 1/1] Drivers: hv: vmbus: enable VMBus protocol version 5.0
Message-ID: <20180513102409.4adc5200@xeon-e3>
In-Reply-To: <20180512093033.12325-1-kys@linuxonhyperv.com>
References: <20180512093033.12325-1-kys@linuxonhyperv.com>
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
Cc: olaf@aepfle.de, Stephen Hemminger <sthemmin@microsoft.com>,
 gregkh@linuxfoundation.org, jasowang@redhat.com, linux-kernel@vger.kernel.org,
 Michael Kelley <mikelley@microsoft.com>, apw@canonical.com,
 devel@linuxdriverproject.org, vkuznets@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, 12 May 2018 02:30:33 -0700
kys@linuxonhyperv.com wrote:

>  int vmbus_post_msg(void *buffer, size_t buflen, bool can_sleep)
>  {
> +	struct vmbus_channel_message_header *hdr;
>  	union hv_connection_id conn_id;
>  	int ret = 0;
>  	int retries = 0;
>  	u32 usec = 1;
>  
>  	conn_id.asu32 = 0;
> -	conn_id.u.id = VMBUS_MESSAGE_CONNECTION_ID;
> +	conn_id.u.id = vmbus_connection.msg_conn_id;
>  
>  	/*
>  	 * hv_post_message() can have transient failures because of
> @@ -372,6 +400,18 @@ int vmbus_post_msg(void *buffer, size_t buflen, bool can_sleep)
>  
>  		switch (ret) {
>  		case HV_STATUS_INVALID_CONNECTION_ID:
> +			/*
> +			 * See vmbus_negotiate_version(): VMBus protocol 5.0
> +			 * requires that we must use
> +			 * VMBUS_MESSAGE_CONNECTION_ID_4 for the Initiate
> +			 * Contact message, but on old hosts that only
> +			 * support VMBus protocol 4.0 or lower, here we get
> +			 * HV_STATUS_INVALID_CONNECTION_ID and we should
> +			 * return an error immediately without retrying.
> +			 */
> +			hdr = (struct vmbus_channel_message_header *)buffer;

Hate to pick o the details, but buffer is void * so cast is not necessary here.
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
