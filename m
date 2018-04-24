Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3069549-1524576040-5-15523462142859554713
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524576039; b=UMNJGEm+elnbYIUayvdXD6s3WYUgI1ChoYIFxk5dPQReWOafrT
    /cheZeO7v0tZuJbsZqZzmTeZAwet4HVExS4CxzCfQZlv/nHk6+Qqskcn1HcOFV9V
    QA4khDRo/IXIpwHdIUPW8P/Xn8NbSZvjTq/QqvQZY+c2Lxia67aOOqP1HTbYd4yl
    jPZtmUp54zaVc2SZJJr391SzUjh7KvbW1js8TSW9YpvOL2ZTdRWJ5237GVQmS4CH
    oy0YdbHj/xjK4sZl5MGDWg3BhB0lyPQaOlqgGIVLHHJwwG0s4hAV0a8blsLwoYey
    y+ohlpLl9KAmn+iqEHZK23oxes8Pzh0xpTUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc
    :content-transfer-encoding:content-type:sender; s=fm2; t=
    1524576039; bh=sm/hng++VrOvuWhiyKhRpqyLaygYkUJ6jO5mvtnS5ks=; b=l
    HPfqVlrZbWEXZX5v397zWvv0ingrflqbn8RMUIzI/kgqpuZrteOEEkNqtyz3Yoae
    OEKvn1K+w77+LCf8g4RxgYSUG2b8SHtJSKtDzRvdckF3En5tDaw9wRuG8U1uzAdy
    T0cvghsJidEOygIbFmC8BwIEWg+ONKeHzhmCP7G0zA2ipY3lRk3bc9T1fveiXZO1
    XMXMDBkjlGCRkdrLDloGixN+ZuTKIYQpH6o4Lh0EZxVtmK7uYvWpd5VGyWn5pJKM
    6yFPVmNEqblZrgKbE8HgVOibtRUuhbueJy6C7QumQAzWt/S2VN7TbawNTrpCglRF
    mhAekjkeQL0s4/Ks7pIyw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Mhr77WvV;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Mhr77WvV;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGTFHNX1GgtXOTS1HEZH74HWpK+xwVx2XAlJTaqgWqPk+RmA2mSIyTCQeP9NTXGJCyn8KPTqCyHUzfeElmC1pYyyu9ZGUjncwP/ClvxiMUw3bBihtvt+
    aHQyjDttWYbfOkvt1fPKL2eSVO2xj260EF3+NtvnlgFIKKE/ZIaKoYAcUtWvmDA8zctyDMvA9eSUfqdatSTxhcPhZTesDYL9lEFwbgdvvNsY2lbzED4W23tC
    kU4RaLhxkq/MedM2Zl083Q==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8
    a=DDOyTI_5AAAA:8 a=jhcWdLLKQc5ZSgbHUSYA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZpV9BWT32sYWwSeJ3YxoH/clxc2cvmYHRFCvFr8Yg+m3GhtV1xCFLg1zcCAQ401ZkTHl+p/iQ==
Subject: Re: [PATCH] staging: rtl8723bs: fix
 rtw_cfg80211_monitor_if_xmit_entry()'s return type
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
 linux-kernel@vger.kernel.org
References: <20180424131829.5215-1-luc.vanoostenryck@gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <d9480ce9-5517-77ca-6753-bf24ed3049ce@redhat.com>
Date: Tue, 24 Apr 2018 15:20:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180424131829.5215-1-luc.vanoostenryck@gmail.com>
Content-Language: en-US
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
Cc: Arushi Singhal <arushisinghal19971997@gmail.com>,
 devel@driverdev.osuosl.org, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joe Perches <joe@perches.com>,
 Colin Ian King <colin.king@canonical.com>,
 Quytelda Kahja <quytelda@tamalin.org>, "David S. Miller" <davem@davemloft.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 24-04-18 15:18, Luc Van Oostenryck wrote:
> The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
> which is a typedef for an enum type, but the implementation in this
> driver returns an 'int'.
> 
> Fix this by returning 'netdev_tx_t' in this driver too.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Thank you for the patch, looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>   drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> index 46bc2e512..75d8a16f5 100644
> --- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> +++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> @@ -2472,7 +2472,7 @@ static int rtw_cfg80211_monitor_if_close(struct net_device *ndev)
>   	return ret;
>   }
>   
> -static int rtw_cfg80211_monitor_if_xmit_entry(struct sk_buff *skb, struct net_device *ndev)
> +static netdev_tx_t rtw_cfg80211_monitor_if_xmit_entry(struct sk_buff *skb, struct net_device *ndev)
>   {
>   	int ret = 0;
>   	int rtap_len;
> 
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
