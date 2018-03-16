Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3163216-1521209806-2-2005920789349275718
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521209805; b=ozpY6+1Zy1DVVVDXclhlmGsxvoj96BDCRRAFOQttyDLaAID
    MgmehdAzCAPQ5QFKFfU5tj0F98Yw+k8FFxCUhk6RgD+h00qBcdtDiF8/pvIiCDdv
    NiDQ2zhF7ctWBGDYxKYoeFrCjHU3saYwa/cA27Nx0nBcMJh+EcOkccJXpFt0U0OM
    San3hKiXoJSrtSPWzei4c7NzhGIRfnHQSNbN+86ty+D5CFJTcqrmorbBWm6DeZMR
    KcHsUnGKAQ864FmdwlrEkydwqMJtAEjCVpX2hnMmqELEVMMFC/WJHkNbccj5jvqT
    oxxeT4awJgGoTUA3e8F8oXQFjfquPvLIt3A2xGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:message-id:to:subject:from
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521209805; bh=L
    kUhR1as7szxs0A0Qa0ALRu658+Bn40fZIyF03dr2cc=; b=TJ+RHlFBMxErSjsFE
    yx8tgMZjJkLAbUCKCGaDzZRxUOUfRCrsCEGuigzc2oP8SOr0JhLY4HxYw7C9MSW+
    Obk9gV80KQMRUdHTp04gVcNg7Zc+B6EdCvTf8R7YJQS5jUP+l5Z+8YFr+J+hCVzv
    RvD4py3yEz/LIVLqWxXNz9lQTUuSwx9y+PJTa1Gw0M7J32XC2mFOcZ4kLRzsUD1c
    Iv/geBE6hxqquoylfhybqd9nCyyGWmzJxW7y/9gxtCrB4/75JRj85ea4OKRHk5UD
    A9WBnXndL2cua7f9RSicoivb5xErX4r+/gxOtx0s0pVa3dVCgaFFPv8dIUv3yeDP
    xr8tg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=davemloft.net;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=davemloft.net header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=davemloft.net;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=davemloft.net header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Fri, 16 Mar 2018 10:16:36 -0400 (EDT)
Message-Id: <20180316.101636.803564728843702383.davem@davemloft.net>
To: mgamal@redhat.com
Subject: Re: [PATCH] hv_netvsc: Make sure out channel is fully opened on send
From: David Miller <davem@davemloft.net>
In-Reply-To: <1520968010-20733-1-git-send-email-mgamal@redhat.com>
References: <1520968010-20733-1-git-send-email-mgamal@redhat.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
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
 vkuznets@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Mohammed Gamal <mgamal@redhat.com>
Date: Tue, 13 Mar 2018 20:06:50 +0100

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

Based upon the discusion on this patch, it looks like this will be fixed
in some other way.
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
