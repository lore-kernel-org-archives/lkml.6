Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1185227-1520621079-2-12840022524996513470
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520621079; b=d5nAsZ2z2PUXbyArBRXRlbg1yvZDiZvqr+m1kPXbOIcp8sF
    z3Jl/YvDoa7VYnqmbpR750AHJaEKVhrCMQ68ZYMY+sw1JoelVhLaPNEtCQa89UlZ
    FoT21vdAEVWNqgVvSlGjSC0P6eQYOK7kAYqIJk+9QOHc/3h5iBZv9YFH17dkLkcx
    7nWnHj+m4Cyx30nqFvDkfek9OTUB7oMi0ypiv3fWLp2wC25l5lS2wFRFM3hHNxft
    w8RoFJGadeIZ4RgKHTwg9mOwR2gF0omFO8i2SlVAJsxJrqzQZ4um7SIGKlyKtqDc
    AWggeM0iGnertp6DzrHXj6yR0Ks1kCc9bCZZT4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:references:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520621079; bh=G
    OGVSgOmXz6YGj0MktxKmJfQ4adxr42xCUpGPUDEKCM=; b=oixyw5LQqqocyB0bP
    9pnA+i8BjihohrF/jPWTv3KuwNDn/z/lMFwfrH91bkF/RduHIUd7/TG21AXrf4OM
    QUMEIJ+sbRPxLeZWBIjD1KPR3kspc9nt0N2efdQ6eP2axs+vLkNN0Tom+s/WGeuj
    fvRuONjVcxEw5nUBSc1pMgB0e1xtDnSuTM4Nq5DdYAQjjK/88tlnrDUZiIkKqvm2
    VR/hufXEIkKCovUDGIkyKX2ZdCjdKpO4yMh+s+xErZMR+K/E48FPuPD2InIzmcfL
    UJxdowKxwyF4DuxStbCIyhsc4p0sTxeclE79owTJcGCBRtwkQ/iggvcY542qn3lw
    mpvrA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b=o3+BDxp2 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=cogentembedded.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BzkjlQBH;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=cogentembedded.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b=o3+BDxp2 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=cogentembedded.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BzkjlQBH;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=cogentembedded.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELvdKSFvH9q2zGm5wzKGPMr5kbSSnfakawh0oVavZHJb+ILAwGnZ1U+/pq1NgyfL3NHLe+3t6Q==
Subject: Re: [PATCH net-next] hv_netvsc: Correct filter setting for
 multicast/broadcast
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
To: Mohammed Gamal <mgamal@redhat.com>, netdev@vger.kernel.org
References: <1520601923-26931-1-git-send-email-mgamal@redhat.com>
 <6fcea84b-505b-68bc-709c-d793802f7f6d@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <f91486d9-92de-4a67-f02c-358c1a503f6e@cogentembedded.com>
Date: Fri, 9 Mar 2018 21:38:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <6fcea84b-505b-68bc-709c-d793802f7f6d@cogentembedded.com>
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

On 03/09/2018 09:37 PM, Sergei Shtylyov wrote:

>> Commit 009f766 intended to filter multicast/broadcast, however
> 
>    At least 12 digits needed here, and the summary line too, just like you do
> for the Fixes: tag.
> 
>> the NDIS filter wasn't set properly in non-promiscuous modes,
>> which resulted in issues like DHCP timeouts.
>> This patch sets the filter flags correctly.
>>
>> Fixes: 009f766 ("hv_netvsc: filter multicast/broadcast")

   12 digits needed here as well.

>>
>> Signed-off-by: Mohammed Gamal <mgamal@redhat.com>

> [...]

MBR, Sergei

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
