Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1163969-1520620971-2-497378098535264678
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520620970; b=bzAZaQ73Waf6CFfimz52lGhqY6ELw2sdfb3vWPYIKp9pvxl
    JlaDdzNk5kHxn1CVwBRtlTQ+LrZCDO71pGi8qP8x2KS9toQVg1HS6c5oznzU8EQq
    h3Wr5Wle8KWAbIJeVgXBZpqLrwnWZ4R5u6U5KmX3ncOvlypENmWsyZuD85vP8lUo
    zTrmEpeoSUQ8jPOcW4OHSR7rVHg2gWTKYdFd716kO6+OFYA7WVHivp0NOoKLnY89
    kU8Vn6oUTl7/t8SWD9xI0J0BH9m7XWxAzI/wZqk4DnIq1s5yiaF8B2KT574g5apW
    8sFowSNx/hXrzWRvJEo16heDhS2MgY1hCBZbf7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520620970; bh=a
    qfDtHGOwDP9vmE2gpCq1jya0fhEWaEEhsb7bGZTEeQ=; b=im7Nvn+85avt1Febk
    s0WWBOIYpuuSqvqbUs6d3tdh4mR+mvMcup9LNOHtEmOGqBjMqTSM6bHKpaFDBicj
    qT0I0S2waIYufnfh8QjSMn6x7mYSMaNtfbD7OYEOEymPQu33qwIPB2/8evX4psjK
    x4uxtOvpkvZ88u6pPKdCdyKNhVTqBZga394XaWhlbDnHEhcly+Uo/SQ8wE/jIhhT
    oB8yoX498wdrhZNDd+UsDIZM3/ged1qkptiCGqVEhOYH9N++PixKZd7x6Ag8wVBX
    sTloXHmx3yTmdM8KJA2he0m51pQS+9se3mjnI+ypLfZHePeWH48+SblGva+ZsH2z
    TFHKw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b=Mbzz+3yU x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=cogentembedded.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=iTNDTddx;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=cogentembedded.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b=Mbzz+3yU x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=cogentembedded.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=iTNDTddx;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=cogentembedded.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELucn8wRhdDqT21rsoGJY9xJfEAShh+78bmaFkBGtLMv11S7bLBds+kNUAOhJaDr2FdJojDHRA==
Subject: Re: [PATCH net-next] hv_netvsc: Correct filter setting for
 multicast/broadcast
To: Mohammed Gamal <mgamal@redhat.com>, netdev@vger.kernel.org
References: <1520601923-26931-1-git-send-email-mgamal@redhat.com>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <6fcea84b-505b-68bc-709c-d793802f7f6d@cogentembedded.com>
Date: Fri, 9 Mar 2018 21:37:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1520601923-26931-1-git-send-email-mgamal@redhat.com>
Content-Language: en-MW
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
Cc: otubo@redhat.com, sthemmin@microsoft.com, linux-kernel@vger.kernel.org,
 devel@linuxdriverproject.org, vkuznets@redhat.com, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello!

On 03/09/2018 04:25 PM, Mohammed Gamal wrote:

> Commit 009f766 intended to filter multicast/broadcast, however

   At least 12 digits needed here, and the summary line too, just like you do
for the Fixes: tag.

> the NDIS filter wasn't set properly in non-promiscuous modes,
> which resulted in issues like DHCP timeouts.
> This patch sets the filter flags correctly.
> 
> Fixes: 009f766 ("hv_netvsc: filter multicast/broadcast")
> 
> Signed-off-by: Mohammed Gamal <mgamal@redhat.com>
[...]
MBR, Sergei
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
