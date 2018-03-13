Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3907840-1520969736-2-5034671441671777201
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520969736; b=hL8YpOSKn0uEwmkJp5fmtiUvaUDbxsOO7YidIkgt0p17acs
    PYZLssZhqr+afZoIQyidvEaZa+72OFL9kAzEjqni9qPACdRw7AyN498URMVdDFKu
    Q7xQz7uA6rYpEzZT2xMqNcfpj9URXy2aYFpko7sj4gn635eddhY7BdZsCMQYOWR4
    c5arycEUg6kWJnr7r/FAyCOc04rR3V0NXXRDNrmGFHgzS14k9ZI30BJHUddgDC25
    J6sU2db1YNZjXSZ63XUS7EW5tZ32jKxCKSgyYvnNF6z61vgFIhd3KMjmO1dynZBy
    lAcSsiiXmVsCAjGNzBmQLh/eoM7UzA1JusruLFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520969736; bh=h
    JtVN30IpPN9zd3QyHDyyxr64NIBgDFmwMgW1ZjiIW4=; b=FInv8olsGaSXDQCrj
    TN0A+gWNnJt1nuWaJ+3lBpokYhWM+ZgBsGwAwAdgIVq30f2aWQrxEzYPoB3Za2l7
    oRwRXv4yUlSOTm5W6wV9FvHXoUfQBza+69XSxKC7Jep5G7e2VBSVw+iEkdLK0Kq1
    ui0OqtV9d1eqqnppCvI0hroV0heiRaLs69XO2pcyH1YxflPQeGG1s9TJ6RosvOLc
    UTzCUpsKImB0tNa5iSurUDZd72ag+1hyV5733ZJ8PbSbtxcSRwiSXKy5x7otn48z
    g7FSgL0dw2VKN/EC5MB3WoBNx6Sw/2aPywmbWadK7uPJbfzkXMJfhulcrwSq4kW5
    TxWtw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b=r8u+VZOe x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=networkplumber.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=f3h+sZXN;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=networkplumber.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b=r8u+VZOe x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=networkplumber.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=f3h+sZXN;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=networkplumber.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELv/Jt6g2JuACDOkdWu2eH84GOFcUxzVI8vLTYZFIYR2Khy4kn0i1v3f5Tsn9GcPt3kOTonYJQ==
Date: Tue, 13 Mar 2018 12:35:21 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Mohammed Gamal <mgamal@redhat.com>
Subject: Re: [PATCH] hv_netvsc: Make sure out channel is fully opened on send
Message-ID: <20180313123521.5b486da1@xeon-e3>
In-Reply-To: <1520968010-20733-1-git-send-email-mgamal@redhat.com>
References: <1520968010-20733-1-git-send-email-mgamal@redhat.com>
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
Cc: otubo@redhat.com, sthemmin@microsoft.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
 vkuznets@redhat.com, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 13 Mar 2018 20:06:50 +0100
Mohammed Gamal <mgamal@redhat.com> wrote:

> Dring high network traffic changes to network interface parameters
> such as number of channels or MTU can cause a kernel panic with a NULL
> pointer dereference. This is due to netvsc_device_remove() being
> called and deallocating the channel ring buffers, which can then be
> accessed by netvsc_send_pkt() before they're allocated on calling
> netvsc_device_add()
> 
> The patch fixes this problem by checking the channel state and returning
> ENODEV if not yet opened. We also move the call to hv_ringbuf_avail_percent()
> which may access the uninitialized ring buffer.
> 
> Signed-off-by: Mohammed Gamal <mgamal@redhat.com>
> ---
>  drivers/net/hyperv/netvsc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
> index 0265d70..44a8358 100644
> --- a/drivers/net/hyperv/netvsc.c
> +++ b/drivers/net/hyperv/netvsc.c
> @@ -757,7 +757,7 @@ static inline int netvsc_send_pkt(
>  	struct netdev_queue *txq = netdev_get_tx_queue(ndev, packet->q_idx);
>  	u64 req_id;
>  	int ret;
> -	u32 ring_avail = hv_ringbuf_avail_percent(&out_channel->outbound);
> +	u32 ring_avail;
>  
>  	nvmsg.hdr.msg_type = NVSP_MSG1_TYPE_SEND_RNDIS_PKT;
>  	if (skb)
> @@ -773,7 +773,7 @@ static inline int netvsc_send_pkt(
>  
>  	req_id = (ulong)skb;
>  
> -	if (out_channel->rescind)
> +	if (out_channel->rescind || out_channel->state != CHANNEL_OPENED_STATE)
>  		return -ENODEV;
>  
>  	if (packet->page_buf_cnt) {
> @@ -791,6 +791,7 @@ static inline int netvsc_send_pkt(
>  				       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
>  	}
>  
> +	ring_avail = hv_ringbuf_avail_percent(&out_channel->outbound);
>  	if (ret == 0) {
>  		atomic_inc_return(&nvchan->queue_sends);
>  

Thanks for your patch. Yes there are races with the current update
logic. The root cause goes higher up in the flow; the send queues should
be stopped before netvsc_device_remove is called. Solving it where you tried
to is racy and not going to work reliably.

Network patches should go to netdev@vger.kernel.org

You can't move the ring_avail check until after the vmbus_sendpacket because
that will break the flow control logic.

Instead, you should just move the avail_read check until just after the existing rescind
check.

Also, you shouldn't need to check for OPENED_STATE, just rescind is enough.




_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
