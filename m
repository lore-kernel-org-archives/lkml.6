Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-841013-1524864803-2-5924821041438497942
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='io',
  MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524864802; b=dI1rAxhc0+jJQp1pdoC+Qu8gRJTeyeFe7jYmb/aczhHT8LdgZv
    Kcgtih/Bwpvhh3ly58vgAGBTH+/7uNTizD03vqHB6SDt48aTQ/Q9gyqZuJrigH10
    iM3GEGrHSLQ35DZ5VtwEAmB2Qq6mTqKBLq+Sw03HJBn7lKwVegZE89sP5lytxs9X
    tpQ0PHzUuwC7oDjo+Ain85ymJXi5K6A3Y6X3feetBMTicpRSEAtPSg5c2Ha/zMTj
    0tSlENyZyGxPogipxuMyWw1XsHEuLblbh/L+vc/5Jllov1y47r3PFWA1oIFqLuk5
    LG1jwbHvcJGROkrb57ZQMIxZKMnzVNrJl5eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:in-reply-to:references:mime-version
    :content-type:content-transfer-encoding:subject:to:cc:from
    :message-id:sender:list-id; s=fm2; t=1524864802; bh=56Wy85LO4yzT
    29KuhoMpI9AD0p7OH5FfUHDsxcJeBAs=; b=f/B+Ev7CnzJ8b9ffQ0U8XnBj/aGC
    KS0m2bXuegayPaZT8ITP/IN3fhUjTyg1Ugrf1lL2y3ULrkk6iqcFHXPgT0FzGskC
    pTfj1nqnmEL0Tpv+5kHrsVWeJTPFnfqJ09yybRgjWGTIj7oZ9W+akx52GT/VKTWc
    lR8PVpwKIh7upL4kN5AMWn4L7xVKpIG2bjfMIMgF8L0RcEQrj2MryGCS3MAmCaEK
    RMNmuJfgcvS3MmS4buK/CAbOnXhCErHHqfBiBzApLbwX78i7CYvA9yuZVhdug/iE
    GcwIzv+9tQmSZZRPM2/2bu2ArDa0Gq+qXhmyA/n1vJRXU9MtqGMDaw138w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=prjkt-io.20150623.gappssmtp.com header.i=@prjkt-io.20150623.gappssmtp.com header.b=ws5vAyVD x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=prjkt.io;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=M8j+hCnd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=prjkt.io header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=prjkt-io.20150623.gappssmtp.com header.i=@prjkt-io.20150623.gappssmtp.com header.b=ws5vAyVD x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=prjkt.io;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=M8j+hCnd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=prjkt.io header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIxQVRI0ccHcBr+fmay7ZCXwYkqHTA+GrrBkTNE5mAULem8Qy4DgRqQ16kYPFBlfTiRZ1y6wMbAuHTIyDWlOkWeAyNRkB84zfGZgiHroc462Sl8i1ZMc
    SSNZcAQKH9ryG5POvtKaQSpHo+gvNMq/QvpZmSMlHvtKLKziV7Ae3brWoX3bMAcT6LIz6U+6VdN9cStul1RZh/LHY5pka6CoW8xsybaAbzvoItw9AZtAt953
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=28HZq395EAYA:10
    a=xqWC_Br6kY4A:10 a=4_-BN3WEXhEA:10 a=Kd1tUaAdevIA:10 a=ag1SF4gXAAAA:8
    a=VwQbUJbxAAAA:8 a=FcoxQdFLmMKw-mexHu4A:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759153AbeD0VdU (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 17:33:20 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37362 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757815AbeD0VdS (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 27 Apr 2018 17:33:18 -0400
X-Google-Smtp-Source: AB8JxZp06kmPllyqvUHsFWcqbLOhFRIzdDq5KNdRAItIjk/jUAhtYIA4h2RgMPCLl6Kf/8dnWANSfQ==
Date: Sat, 28 Apr 2018 03:03:04 +0530
User-Agent: K-9 Mail for Android
In-Reply-To: <20180427135631.584839868@linuxfoundation.org>
References: <20180427135631.584839868@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Autocrypt: addr=harsh@prjkt.io; keydata=mQINBForuUUBEADNrWLYhW8qjO6GmfU32cqU
 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
 GOzuzn9qgWR/VAqd9BA=
Subject: Re: [PATCH 3.18 00/24] 3.18.107-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
CC: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
From: Harsh Shandilya <harsh@prjkt.io>
Message-ID: <651C4935-B2B0-4281-BEE1-DC18DB3ECF57@prjkt.io>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 27 April 2018 7:27:35 PM IST, Greg Kroah-Hartman <gregkh@linuxfoundation=
=2Eorg> wrote:
>This is the start of the stable review cycle for the 3=2E18=2E107 release=
=2E
>There are 24 patches in this series, all will be posted as a response
>to this one=2E  If anyone has any issues with these being applied, please
>let me know=2E
>
>Responses should be made by Sun Apr 29 13:56:20 UTC 2018=2E
>Anything received after that time might be too late=2E
>
>The whole patch series can be found in one patch at:
>	https://www=2Ekernel=2Eorg/pub/linux/kernel/v3=2Ex/stable-review/patch-3=
=2E18=2E107-rc1=2Egz
>or in the git tree and branch at:
>	git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/stable/linux-stable-rc=
=2Egit
>linux-3=2E18=2Ey
>and the diffstat can be found below=2E
No issues on the OnePlus 3, usage seems fine so far=2E Thanks!

--=20
Harsh Shandilya, PRJKT Development LLC
