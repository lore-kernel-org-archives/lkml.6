Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-918286-1525274909-2-1879448064962347538
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525274908; b=nlGFkfAUkntdB3b9HM11YLH/SmgzAaVArITPE2lG7LjmyTGDXE
    zWjsVvW3UGibMHJYN4rRxJynvfzXoRktzSUKBxcMLDxX244m2AnaPQpxdDfpgeO2
    MmjExdZgJgjUWPIsNj0ndz5aVfqbFxBgIEX/bLuXOFhWjUUPIxcA8wSnu3iKsN/W
    hKaXaHhs1msAvyx5AOfuo2jpMaMCW1/N6nWd5DEpIXR0lMsnBF/LT2uSG/EcNWW5
    Go80PQI9VK39uGm8StUcyi5gIpbvZFyOxK9zmildv8FF2C9JWtOX6HjTWFU1U53B
    BpKsfxJp5UnEkNHsk+0rrbGnEpQye3tMgdug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525274908;
    bh=JfqAZ9bWeFQ2rsxxX6TIcbTjKFOZo120AfQOl7+glek=; b=eJmvanao2O3b
    mZYDNuyWw+//OSEgXeMUuoeXrJ9QKgxEkHdAwsUPxYPUTE7E0826gZifYVVwGF0K
    EkoCiVpP6G0u/Pqbqsd+rK2AsiOZOUfO8A13jhSUESCio6KpmoW3MoYFw9ZAJe5R
    1/VfZnOZmI0dRIRioUoaFjgNrDgWvGpzP9f7WtIJtAhuxz50RdoY/3+7e1VHk3vX
    ZQrEN3pbUhHrNjboxTMQmLZCPnLZcJfyQnoBIZvy6SUsSAiQr+xs9Rn5gtfj5BwQ
    Q8RYbtXrwhIp6J7Z3LGdjw1nVDkpd2y7izrRks0r/+Pry1q7BvBITguHQ+tdXUCX
    tX8Zx2c6Zw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=citrix.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=citrix.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-50 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=citrix.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=citrix.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-50 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPuXdbd1qYg33np3uQFZKn5ny5q7EZ84pfG7teewBap3/96WEy0S05cgdclgKqhUq4kbiKs0X69rpysAeneGXOtN93OoUM5eCoiEt/EIdz8tluf5eYPS
    gr15vN5Zl3FkJykuZ4QpfG7ebc5Q3xr4LCfNzPjSwCXu/lpTMHA367MUxssfU8RytQgvX+ntl/vekesigSYQdOFrs0V0feG788EQDlvTXesAmpPICQsbL+tC
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yPCof4ZbAAAA:8 a=iox4zFpeAAAA:8 a=-89Fc4ERMyDilhiCXsYA:9 a=QEXdDO2ut3YA:10
    a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752261AbeEBP2X (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 11:28:23 -0400
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:10155 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751941AbeEBP2U (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 2 May 2018 11:28:20 -0400
X-IronPort-AV: E=Sophos;i="5.49,354,1520899200";
   d="scan'208";a="72507851"
Subject: Re: [Xen-devel] [PATCH 2/4] xen/PVH: Use proper CS selector in long
 mode
To: Jan Beulich <JBeulich@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
CC: Juergen Gross <jgross@suse.com>,
        xen-devel <xen-devel@lists.xenproject.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20180430162339.17143-1-boris.ostrovsky@oracle.com>
 <20180430162339.17143-3-boris.ostrovsky@oracle.com>
 <5AE9713D02000078001C007B@prv1-mh.provo.novell.com>
 <6b7a748d-e289-c370-123a-678c6ad7d9dd@oracle.com>
 <5AE9D27402000078001C02ED@prv1-mh.provo.novell.com>
 <cb819dcb-1597-680e-31b3-b63fecb6d4c1@oracle.com>
 <5AE9D49B02000078001C0322@prv1-mh.provo.novell.com>
From: Andrew Cooper <andrew.cooper3@citrix.com>
Openpgp: preference=signencrypt
Message-ID: <c25989fb-b1da-ea88-37de-6c36ecdf72d2@citrix.com>
Date: Wed, 2 May 2018 16:28:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <5AE9D49B02000078001C0322@prv1-mh.provo.novell.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/05/18 16:09, Jan Beulich wrote:
>>>> On 02.05.18 at 17:08, <boris.ostrovsky@oracle.com> wrote:
>> On 05/02/2018 11:00 AM, Jan Beulich wrote:
>>>>>> On 02.05.18 at 16:57, <boris.ostrovsky@oracle.com> wrote:
>>>> On 05/02/2018 04:05 AM, Jan Beulich wrote:
>>>>>>>> On 30.04.18 at 18:23, <boris.ostrovsky@oracle.com> wrote:
>>>>>> Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>>>>> Reviewed-by: Jan Beulich <jbeulich@suse.com>
>>>>>
>>>>> But to understand why things have been working nevertheless it would
>>>>> have been nice if the commit message wasn't empty, but instead said
>>>>> something like "The two happen to be identical on 64-bit."
>>>> Why do you think they are identical? __KERNEL_CS points to entry#12
>>>> (which we don't specify in PVH GDT) while __BOOT_CS is the second entry
>>>> (which we do create).
>>> That's 32-bit's __KERNEL_CS. If the two weren't identical, the ljmp
>>> you adjust would never have worked afaict.
>>
>> Oh, right. My theory was that we were picking up something from the
>> stack (which is where 12th entry would be pointing) and the L bit, which
>> I think is the only one we'd care about, happened to always be set there.
> I don't think the L bit is the only one we care about, as I don't think you
> can load a non-code selector into CS (even if none of the attributes are
> later used for anything).

The type/s/dpl/p/d/l attributes still very much matter even in 64bit.

~Andrew
