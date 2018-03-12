Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4187132-1520847508-2-10931937613420232982
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520847507; b=SfN6FEK7rpQqawC+h1GMGyHzZpcJ/0Tt8M5cCiE7kFGN9J0
    dwS7tTCpfylcWg/Aset94ZWfRMUnOaQ+/z4EMtUlATxCJ9uek5crNKZy4ncSP2Va
    IpucDiXSwXN2z3wOgG0zqHfrPxePG1UwSgdOh+uy2ocnD+qUC1t1gFt0K8Ynkw1R
    XVSl7y3LL6cNc57xHPZYLjs+dE6taVrMz1KWcqOcyrZyEsuCbhfa8xahKqBgr69F
    aXAI6xp8TFwAYHfG/Ci0hrniAd7MCdDQ9xP73Hs1ZSOo1C/t5Olm9Tx2/43RInpb
    CgvSp39CpLV/JwnecHJxjLIYf0ks9T90/EW/rtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:date:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520847507; bh=Q
    7n6IaI/A16dHRJYu6a4lgwBm2UJm3/qIoSThvpbgUA=; b=CqXl3ob8wzCqq4apB
    IDgGfCox6118t/qYav11KHcV694x3iImqxN5jalFL9gxkpowCLeaGUMcaA/v7jrJ
    ydPr1h0hTZ/zAzk5VFb9w0haxZWkESr9DN15X3WUq3TRk90oj9BqXdrMUEtocH8g
    n7HWKL7QybjBnB3MVvaQTptruIuuvwHLihe65C+fyWKx6KLCs+1bjbgBHJu005zv
    Vjc8ajb5orfqhuIVA3LVC7QdGoB0mvNu7lfR4XnZyEi8cvjVFvQHytBfRS/n5BIY
    FsOUqOhPihkcwPvkdEd8pyUUi2qB+aB13uC+howgk7HOi97yQtCcgMPF1zeRRfYm
    aq66Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=PAcIhZ/l x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-85 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=TSBalTQ/;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=PAcIhZ/l x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-85 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=TSBalTQ/;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELuhj2ER9lk70KsBnCdA0H+41Ll4WLTFYL0vcZB4KUgJR71jc53zT1hFNH7oU+UFMnuMTxB91Q==
From: "<Hariprasath Elango>" <hariprasath.elango@gmail.com>
X-Google-Original-From: "<Hariprasath Elango>" <hariprasath.elango>
Date: Mon, 12 Mar 2018 15:08:08 +0530
To: hariprasath.elango@gmail.com
Subject: Re: [PATCH] staging: wilc1000: use pre-defined macro
 is_broadcast_ether_addr
Message-ID: <20180312093808.GA9044@hariprasath>
References: <20180312084715.30103-1-hariprasath.elango@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180312084715.30103-1-hariprasath.elango@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: devel@driverdev.osuosl.org, vbabu3@visteon.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-wireless@vger.kernel.org, Hari Prasath <hgujulan@visteon.com>,
 linux-kernel@vger.kernel.org, Ganesh Krishna <ganesh.krishna@microchip.com>,
 aditya.shankar@microchip.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 12, 2018 at 02:17:15PM +0530, hariprasath.elango@gmail.com wrote:
> From: Hari Prasath <hgujulan@visteon.com>
> 
> Use the kernel pre-defined macro is_broadcast_ether_addr() instead of
> doing a memcmp here.
> 
> Signed-off-by: Hari Prasath <hgujulan@visteon.com>
> ---
>  drivers/staging/wilc1000/linux_mon.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/wilc1000/linux_mon.c b/drivers/staging/wilc1000/linux_mon.c
> index bbdfc7a..f93f411 100644
> --- a/drivers/staging/wilc1000/linux_mon.c
> +++ b/drivers/staging/wilc1000/linux_mon.c
> @@ -27,7 +27,6 @@ static struct net_device *wilc_wfi_mon; /* global monitor netdev */
>  
>  static u8 srcadd[6];
>  static u8 bssid[6];
> -static u8 broadcast[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
>  /**
>   *  @brief      WILC_WFI_monitor_rx
>   *  @details
> @@ -193,7 +192,7 @@ static netdev_tx_t WILC_WFI_mon_xmit(struct sk_buff *skb,
>  
>  	skb_pull(skb, rtap_len);
>  
> -	if (skb->data[0] == 0xc0 && (!(memcmp(broadcast, &skb->data[4], 6)))) {
> +	if (skb->data[0] == 0xc0 && is_broadcast_ether_addr(&skb->data[4])) {
>  		skb2 = dev_alloc_skb(skb->len + sizeof(struct wilc_wfi_radiotap_cb_hdr));
>  		if (!skb2)
>  			return -ENOMEM;
> -- 
> 2.10.0.GIT
> 

Kindly discard this patch. I will send a v2 as sent mail ID and
signed-off are not matching
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
