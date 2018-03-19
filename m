Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1744695-1521431072-2-14470739872286169188
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521431071; b=otKs6S3zj4G0omE0uYXWlza7T+TgTImqPthOcge1FoQd10e
    rfx81m9aGuH60GUv0d3wFRxl+iyybEueTw4EJnMUzIe4FMSnWMTazb/mjwFbBLP1
    TG6oT4FccxF6Yov6N1Lxx+nMKLF4f8sWcosD/TdJ3njokbEufPsix25HNwuo5wns
    /obUXskxC5CjQUTjO60w3QX/+M2fvhMo+QGiYkjlc2NLVoQo/z2PRA9uUWs2dDHx
    1igIHomO0j7N/euwNlo4Nv1O3f1CFyLP0S1hzq8/+G3viwL7VgCwgMLOFP1wB9DE
    eM3EYd6HWnKcGeEV/HxOlUGrJoOAneZFDBfgx+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc
    :content-transfer-encoding:content-type:sender; s=arctest; t=
    1521431071; bh=oAK+N2ExvcR4TBOE1GGuIC8lxkK5x/QY5tS8SXNeXGw=; b=S
    tHhE+ba5A+4zZPQ3GL5PWrAyGDdvArjJQuUgQW7svLhuzGmDRgm6xpimHrLtdilE
    I5uwOIsyWY9793ccUNWqPBNaqnTcNblp5E7PZSCYMmgBFJ6C8g1eVydA4LaLGsMk
    H6hAWmJVilj7gwu2OEO+DRiPXBSUGg4rZbPWvB4JLc8UFAQRpC0ws8Azj9ZHq8jY
    8EcNor/+UA/0I4QbmyXONAJI5BxY6PMW+7MYJLQLB+1dK5IfZadvZEAl8rovQkhm
    uKvy6AsglCBlNRNVAbsh9sPSnj/G80JiEKDiIrIb1BSuzToN83En6RgV4popwNOn
    1sWKyAefiz9i1icFxPxWA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=vGECttS8 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Ua3oWeHt;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=vGECttS8 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Ua3oWeHt;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELsIxKTuLNgXq22cr30ITd2iWHVPV7/PSVBxQPsYCw+e/6OjkTULa7jFIj5za2kQDP1cKp/qEQ==
Subject: Re: [PATCH 1/2] pci: host: pci-hyperv: Replace GFP_ATOMIC with
 GFP_KERNEL in hv_pci_onchannelcallback
To: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang
 <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>
References: <1521384782-23539-1-git-send-email-baijiaju1990@gmail.com>
 <SN6PR2101MB0893202C038AB406C6A6546BA0D40@SN6PR2101MB0893.namprd21.prod.outlook.com>
From: Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <c13413c3-67e2-fd1f-c8d0-28e810c6287b@gmail.com>
Date: Mon, 19 Mar 2018 11:44:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <SN6PR2101MB0893202C038AB406C6A6546BA0D40@SN6PR2101MB0893.namprd21.prod.outlook.com>
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
Cc: "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 2018/3/19 10:52, KY Srinivasan wrote:
>
>> -----Original Message-----
>> From: Jia-Ju Bai <baijiaju1990@gmail.com>
>> Sent: Sunday, March 18, 2018 7:53 AM
>> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
>> <haiyangz@microsoft.com>; Stephen Hemminger
>> <sthemmin@microsoft.com>; bhelgaas@google.com
>> Cc: devel@linuxdriverproject.org; linux-pci@vger.kernel.org; linux-
>> kernel@vger.kernel.org; Jia-Ju Bai <baijiaju1990@gmail.com>
>> Subject: [PATCH 1/2] pci: host: pci-hyperv: Replace GFP_ATOMIC with
>> GFP_KERNEL in hv_pci_onchannelcallback
>>
>> hv_pci_onchannelcallback() is not called in atomic context.
>>
>> The call chain ending up at hv_pci_onchannelcallback() is:
>> [1] hv_pci_onchannelcallback() <- hv_pci_probe()
>> hv_pci_probe() is only set as ".probe" in hv_driver
>> structure "hv_pci_drv".
> This function is setup as the function to handle interrupts on the channel. Hence the
> need for GFP_ATOMIC.
>

Oh, sorry for my incorrect patch.
Thanks for your reply :)


Best wishes,
Jia-Ju Bai
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
