Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-805435-1524664926-2-14833792965907929675
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org', XOriginatingCountry='DE'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524664924; b=M6OzflcwalwX+wBALgOshlVA4PYF96FgZObVoz3o4CFSjfqWZt
    Gp7qkNDLNlSo1XgiPk2FkwG1YXPMMJM190dT0Hu4OT9eo+LSn8wpqgNeADZwKIFp
    rp6NSjL4xa+edsDfOn8VkQoZjOHQVTPA7/aJ4V6ONlwThzN5zDWRiAGzA7c0iuzr
    fIJiQ8weWo6lg2YbQP++dRYY8quZnztc60qF3AFbS6Yok5qVBhMagVDQPEXZkI8H
    ugJVEoqkwJtzjcwk26gnK0erYKy+eN540B12VlTaz8gYeBFA6xuTybcOXI8RNz4j
    e5tiDRgBvR1D8KYQGxtk+HAOgC/2uyFhO6oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:in-reply-to:references:mime-version
    :content-type:content-transfer-encoding:subject:to:cc:from
    :message-id:sender:list-id; s=fm2; t=1524664924; bh=JsqsyWrLXgrM
    bdrAS2cWypXK1T8x6SY75jrhVyBw96A=; b=X0GGSrcliCC0qXvEfiMoBmRcG2P8
    Jwm4UuvRqkqQbGTXZzIhA8qceSP2tLYTB7Pafvlwv5RNqgE4ERAOW/rbQEj4oadO
    YexILXzSJ37lFJbNHT+YkfcUjgSnQZlFHDoCuQFObq/kTEhDdwRDun/AinQtLJVo
    E5c7FVEz5/stjEGRnX436Lbh7uLuntTeQOnIeWIvnZVDlAcr6yLeLJ+9wvpyqipM
    ED/74oV4YovSGM6qprm9c1R4Z8QFav1ZY3LrATEKa2Lt2/cmsk22Hog9hL1TA5lP
    Ng3w1RBPrdpzgZaZm3RDG7M0FVVm67dQfuAA3izkY/vOOyJHxVP/XuExug==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=amitshah.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amitshah.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=amitshah.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amitshah.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMHy/IInEyz9uJDTZJ51F48R5QlVNEVisE0wTCOaVcGyh7Efv2SlERlVaUg39xRxpvWmS4nYV40vEYEIyRZfWVBIUhjkKTHsw1bpcGwaMV5P8R70Fd/N
    bRwyVLwyerFqEBL34QTuNB3rSEbdVUVOVDhUdjhB9FB3tVTjTspycGOVA95JD+TAu2srtaeUKVAR2fYePI1ss3T+Z9YdRhKACxdDyjLCRPYuHunNGLYdvkOY
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=akm08q72c4EA:10 a=IkcTkHD0fZMA:10
    a=Kd1tUaAdevIA:10 a=20KFwNOVAAAA:8 a=CjiYaNSMAAAA:8 a=ELSpWC10zHltu_Ej5KsA:9
    a=QEXdDO2ut3YA:10 a=jFRs6jQBfVEfJ4qOU6Pr:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754014AbeDYOCB convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Wed, 25 Apr 2018 10:02:01 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:38107 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753509AbeDYOCA (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 10:02:00 -0400
X-Originating-IP: 185.220.70.132
Date: Wed, 25 Apr 2018 07:01:33 -0700
In-Reply-To: <20180424214104-mutt-send-email-mst@kernel.org>
References: <1524248223-393618-1-git-send-email-mst@redhat.com> <20180424214104-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH 0/6] virtio-console: spec compliance fixes
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
CC: Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        virtualization@lists.linux-foundation.org, stable@vger.kernel.org,
        Tiwei Bie <tiwei.bie@intel.com>,
        Jason Wang <jasowang@redhat.com>
From: Amit Shah <amit@amitshah.net>
Message-ID: <33E19766-1FBE-446D-8D04-17B0960EA013@amitshah.net>
X-Remote-Spam-Level: 
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 24 April 2018 11:41:29 AM GMT-07:00, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>On Fri, Apr 20, 2018 at 09:17:59PM +0300, Michael S. Tsirkin wrote:
>> Turns out virtio console tries to take a buffer out of an active vq.
>> Works by sheer luck, and is explicitly forbidden by spec.  And while
>> going over it I saw that error handling is also broken -
>> failure is easy to trigger if I force allocations to fail.
>> 
>> Lightly tested.
>
>Amit - any feedback before I push these patches?

I'm traveling this week, will be able to take a look early next week.

                Amit

-- 
http://amitshah.net
