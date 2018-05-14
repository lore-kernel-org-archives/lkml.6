Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-545174-1526289186-2-16095087605330095387
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='io',
  MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526289185; b=Q20jDIHlcIqksD0HZWLXFZvTck6p2xBYxDoAt5Wf05WXDhgerS
    wGut2+GuS0fDEIBc8qd5PvjusDYZYyRTxKvwxHMCDJb75h2a7Xn1wW4jpfwqiqXg
    r7ak+jG887Aao8kGFbHUx3Rt7xIBt4YBo6S/74GhT03r41cHjXe10MTNCMHPGT+n
    42mBucZIOqpmZa4nm++0mRnMGTBU6Zc+dOJ8h+3JUZIUEWCVAimEiMPZKhpOmxXS
    +BGngk9QDzTRgIFQhrS2xjWQExmUuvq5yIqRMqxNCinlSDvr+vWafzLJ3FV+Cv83
    iX2D+IwG4o/hsWO6EPWXOZ26jZTO6oR78JhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:in-reply-to:references:mime-version
    :content-type:content-transfer-encoding:subject:to:cc:from
    :message-id:sender:list-id; s=fm2; t=1526289185; bh=o65KDb8CljWm
    0bpCO1VVfZb5WdZ8fQvASxDm4WlaH9A=; b=NZq4cm44AOBrDyjcMDfZqOvFIzAK
    IrqGGDoP5ZbQp9fpfahCzoZZ5ERIlKfP6Mzw4vpgiRTlaF5Ut3UzI+37FQVxxoc2
    N5Mgj2WZzMyfI1ehAH/ba17Uwgw+D7Ji+WjQEsDkJVQQ2DtK9xnsPInrwsq3EmfV
    J8gRKuz0CKwECib5OK8+0FlVXUc8r82aHPbT3X5D2BSZHdicFExmAnvP8c431Z7h
    rOQJRDOYhctFP3gjGq4LbARylTMeAxopwPezafP3mxueUOVVssj4ILYkKj5zwOpl
    X3iCOewJ+CfjWzRp9h7ML6e3aHEq2rv+IQw1HXM3SWjV9cnyvCEiZX32XQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=prjkt-io.20150623.gappssmtp.com
    header.i=@prjkt-io.20150623.gappssmtp.com header.b=xXf5jTVm
    x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=prjkt.io;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=WlUfBO9p;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=prjkt.io header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=prjkt-io.20150623.gappssmtp.com
      header.i=@prjkt-io.20150623.gappssmtp.com header.b=xXf5jTVm
      x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=prjkt.io;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=WlUfBO9p;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=prjkt.io header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHzLqBqlu6zW1ZQRcj3MpCp/u++S6zb7C9XwhS6Luq/MiMLRy/ZheBL3uQAqhsQ7k1r1Mg/W8A8S0T3g8z2uJkMmDnWbLbNP+asWFKECbww13vgdv98N
    u06RU1amyqYd6FVD3bh0A+nPsi/1At2zbnX0JB8dT4pEZyYPV/DsFkFNEheou6v82qrZLOyY21pDDZSa4DOmVF7tqn06ET/msga5EeIHCMSrAes7fzvM1cMM
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=0U73VwB4dlIA:10
    a=xqWC_Br6kY4A:10 a=4_-BN3WEXhEA:10 a=VUJBJC2UJ8kA:10 a=ag1SF4gXAAAA:8
    a=VwQbUJbxAAAA:8 a=etD2MYYkJzPjFH1Jjy8A:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752014AbeENJMh (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 05:12:37 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:42924 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751626AbeENJMg (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 14 May 2018 05:12:36 -0400
X-Google-Smtp-Source: AB8JxZryPKQ+Dr6kQk5+lvoFPsQyQZ4PEeM3G3UKcsff7mLYyCV8a59iY5LlzyOZPHE4Il7cWFEjKg==
Date: Mon, 14 May 2018 14:42:28 +0530
User-Agent: K-9 Mail for Android
In-Reply-To: <20180514064704.046463679@linuxfoundation.org>
References: <20180514064704.046463679@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3.18 00/23] 3.18.109-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
CC: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
From: Harsh Shandilya <harsh@prjkt.io>
Message-ID: <BCB46BB5-7FF1-40C3-AC7F-548194797025@prjkt.io>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 14 May 2018 12:18:29 PM IST, Greg Kroah-Hartman <gregkh@linuxfoundation=
=2Eorg> wrote:
>This is the start of the stable review cycle for the 3=2E18=2E109 release=
=2E
>There are 23 patches in this series, all will be posted as a response
>to this one=2E  If anyone has any issues with these being applied, please
>let me know=2E
>
>Responses should be made by Wed May 16 06:46:49 UTC 2018=2E
>Anything received after that time might be too late=2E
>
>The whole patch series can be found in one patch at:
>	https://www=2Ekernel=2Eorg/pub/linux/kernel/v3=2Ex/stable-review/patch-3=
=2E18=2E109-rc1=2Egz
>or in the git tree and branch at:
>	git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/stable/linux-stable-rc=
=2Egit
>linux-3=2E18=2Ey
>and the diffstat can be found below=2E
>
>thanks,
>
>greg k-h

Merged and compiled on my OnePlus 3T, no immediate regressions=2E Thanks f=
or the update!
--=20
Harsh Shandilya
PRJKT Development LLC
