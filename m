Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2671055-1522389798-2-14201865543695418063
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
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522389797; b=bu2OUKAR7uYqmHToOukfLqwYx/7Hsyugu+tqIl6D475Xyz0Pda
    5NjXHvo2c32Pir4DH7PIs+Zrcawi/b+6H+ocLH5fQcck31+K8Xtz4vC62nf1IzUD
    1lHstLsOVOcWTXV/9VPGf25KSzoUv6/I1BslZXQEQp+PKiz/Aqc+3VEc/uCDXVCb
    bnjsoOnoeqYgrVMEqCAnltVHKiEJMuObKRlYOZZM1hZKaZnKJH8MX0iSnEDKlHYh
    y5nDpeu5c6PibQpuVfc/HcAJaHlkB76D4Kv/zdxdNPemFTEds/QQ2bNVGdsbbiGc
    cioV/BQd1SwGE+0ZrxBuohWxtiNvZfNDGuqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522389797; bh=Ddtwb
    a7qlBi/PM6WzBDYu10oQk/QVh5UGsENtMszAlw=; b=oPbBHwSDds9fxRQTwZkA1
    lZzdcifRsSHinXEv5sywL1M25mUOtIoFOA29mJJpoW3WG5zVmhH+a7GLKzxHI9l7
    B2+at456t+CyMJS8RCJg1V/J9ftz8eljRH8L7tkH1mthY0hUaUfZ8fag8H7QDo1E
    s+7ES6y/7MhH0N0DXG4es7ka4zuM0850qHbv0wq67eph72B4OuX9y3NDdeE3VBf4
    DsmQxM2zzePdUac1Yt/tWMWLZ1JxWVOP7dNqCzUAnA5q4pXJt6rSeiy9NCHiB7HE
    /8Py/QPJwvDMaa4MRTCi6CbF2AoasAWzvmks8k3CzUMhRwQAw+isWdZ6PJQHAQQ4
    Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGWJD8jAjfkSvE8dRLDGF0YNgxE1pVFsZrSQ0CidJ3BTtDYphe4zs6xYJsqoBEVj+0+GoFJHqe0abpmGuz6Y3a00BPscdLrFwOyLi5EL8J2iav39hRvT
    s2Mgs59BQdGjfYlcaMwQfr9YYKg5SXdaPWYt4HdYehK6EheO33frHVIWK/oF3ZQONVx0Pp6DGcxkn/ZkG+OeHZ6LXUa90dy4xWKxU4rtXff2QoSSue5F9jer
    GDBz4ExfMoaSyFkbpJ3GNw==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=IJv9LcIfAAAA:8 a=DDOyTI_5AAAA:8
    a=vDD48JHQrOGzIsrck90A:9 a=i4LNjD9uRrixXcL0:21 a=serdVw6V7r1idLbv:21
    a=CjuIK1q_8ugA:10 a=cmr4hm9N53k6aw-X_--Q:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx48wgpu2Cusgiz08JgIvFcH7m7ePAabjJBo1ifyNGEP0GcO3Fsddh+GQYnscFpyUiV6DIlPOvs1khLBS4wEEkQc=
MIME-Version: 1.0
In-Reply-To: <1522303346.2210.19.camel@perches.com>
References: <20180329055152.13059-1-quytelda@tamalin.org>
 <1522303346.2210.19.camel@perches.com>
From: Quytelda Kahja <quytelda@tamalin.org>
Date: Thu, 29 Mar 2018 23:03:10 -0700
X-Gmail-Original-Message-ID: <CAFLvi20F6HhQqunU2Pde6e4fahFHEnRW2sR-c6V0L-fbsMJQhA@mail.gmail.com>
Message-ID: <CAFLvi20F6HhQqunU2Pde6e4fahFHEnRW2sR-c6V0L-fbsMJQhA@mail.gmail.com>
Subject: Re: [PATCH 1/9] staging: ks7010: Replace manual array copy with
 ether_addr_copy().
To: Joe Perches <joe@perches.com>
X-Provags-ID: V03:K0:T+W0jfsaQYnyjoNIQxeRV/d8g6vLLfSPxp0+I3sEZM0nDlTaE9/
 NviD8TftrEQsQ7zGMEzy0WqHhQdIWFFyg7qFnoNsTKbiMifzSD/ERnqnOugypq+y+I77egO
 XzdZANn0XIY042ICY7ENg6g1qc4aHgO1UoQWRi3v4FY9o4VzyrBzVUbiKsAtKSSAZ2VzpJq
 uZQrZcBrjCewLy4V4g7/g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZA6SHMdb2N0=:3XHWNHbGw9SVgIU36LPEJ2
 w4N/Z87zgpXHGIZ/jvxKM5ICFXwvE9ZMzRGP0T5x9pWyWoXUbgWHn8YSvyfzgoCUO3DnRpy9l
 AMogc+MvRykI7KuPFiME+T7a7rYopxpkDkln+W4w9cuk1B3DonV5QQDAy/dYvbTvZ6XG9V13a
 vT+wQOZoCfLCy2UiXsbsl8Fm3SHuPFodTc2KhClkAwRH0zeAzEtebm+jTIzVSalpUugbt7XJS
 sPteQefP0y7T2LsMhxzKVL6oCyGcs6VycRh1crAocd7GIAw+QhZZrOeQJiYjywkTsr6pBdltb
 vsz2JMY+aojo4jvTMpB33mVtBgm85HnDecIu+fReCekC2/Wa+Mb34Quq3Vmzq9Inv4w93//Qo
 4WHbdNLSscavQEwAXKJmu/0AvaGTD3T5BEkmof55kcp1/Mawz2NpMi2hnaiKA4q1cj8pOUNw0
 y9xRweA3tQUm3OPjdlk6JVXMGNubRnTGtIH3xX7dyLvYdN4zAgbq5QIl+L9pzvUnvDF4166Wk
 kF9i05f099+rzZi1CmNFM4UcfWCtuYC2Xlv0OHs8gTd1egIhWsAsdqjFdcX3P68UYfE9PLb/p
 iq1xRGgDslTFOCGjJRVjtH53awFyRagg8vvrDjZNz+zebA7QN0+8j3Vdy4+IObBqDRQF4lbBE
 +ljBJKXfdbKWXtuiouicJoYhY3a3BWYr3TRHSab5cFoGdWKjGrrlgpGdCW4z6vLm0DiAL9bgG
 IrP4tymSa+cQM/9IIA40o4AZ8qkLI41bppPgzvbSeF1gdzz31Ztw1qxkbAk=
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
Cc: devel@driverdev.osuosl.org, Greg KH <gregkh@linuxfoundation.org>,
 driverdev-devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
 wsa@the-dreams.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

If we just want to have the address field full of zeros during the
driver probe, is there a reason we should zero it explicitly here?
When the 'struct net_device' is first allocated using
alloc_etherdev(), the dev_addr field is explicitly set to zeros (in
the subfunction dev_addr_init() in net/core/dev_addr_lists.c), so it
should be zeroed already at this point in the code.

Thank you,
Quytelda Kahja

On Wed, Mar 28, 2018 at 11:02 PM, Joe Perches <joe@perches.com> wrote:
> On Wed, 2018-03-28 at 22:51 -0700, Quytelda Kahja wrote:
>> Copying the dummy HW address into the struct net_device doesn't need
>> to be done byte by byte; use ether_addr_copy() instead.
>> Additionally, dev->dev_addr is not eight bytes long.
>> ether_setup() sets the dev->addr_len to ETH_ALEN (defined as 6)
>> in the net core code.
> []
>> diff --git a/drivers/staging/ks7010/ks_wlan_net.c b/drivers/staging/ks7010/ks_wlan_net.c
> []
>> @@ -2900,15 +2900,7 @@ int ks_wlan_net_start(struct net_device *dev)
>>       timer_setup(&update_phyinfo_timer, ks_wlan_update_phyinfo_timeout, 0);
>>
>>       /* dummy address set */
>> -     memcpy(priv->eth_addr, dummy_addr, ETH_ALEN);
>
> why remove the copy of dummy_addr into priv->eth_addr ?
>
> Also, dummy_addr could be removed and eth_zero_addr()
> used instead.
>
>> -     dev->dev_addr[0] = priv->eth_addr[0];
>> -     dev->dev_addr[1] = priv->eth_addr[1];
>> -     dev->dev_addr[2] = priv->eth_addr[2];
>> -     dev->dev_addr[3] = priv->eth_addr[3];
>> -     dev->dev_addr[4] = priv->eth_addr[4];
>> -     dev->dev_addr[5] = priv->eth_addr[5];
>> -     dev->dev_addr[6] = 0x00;
>> -     dev->dev_addr[7] = 0x00;
>> +     ether_addr_copy(dev->dev_addr, priv->eth_addr);
>
> Perhaps
>
>         eth_zero_addr(priv->eth_addr);
>         eth_zero_addr(dev->dev_addr);
>
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
