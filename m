Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2747839-1524410682-2-17144935489428687616
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
    1524410680; b=RO+9d6285yhJVXjbkj3/CtpMx21/jlHxULUovv11uZ5v/JA0A8
    o+h/Nt/1woLAo1UIHuuSgDQBPZQoFX/tM6dUG4YUu5LnYDh7CGDTtR/kb1x8qZ/5
    DGI1Kf/6VoMDtqORlPcR5GT6yIdOMza070P7E3SSuzpX/wpFDvi/sNBndV1FjDoW
    8R04j9E+snniQX8mVFszrI8uBdhxjCr10CftPCFUgqvpQVd1wr2PgAUnBf6F8cEj
    MGb+DuWw+mtSGmsa76KHEiLeb528x+QCGPynKW9TCW66634zkGEjX9+wgXRvY9KZ
    cge9EL+CtvRe+8fG+5qyXxDNk/Iz44rXnRFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:in-reply-to:references:mime-version
    :content-type:content-transfer-encoding:subject:to:cc:from
    :message-id:sender:list-id; s=fm2; t=1524410680; bh=DbErLs8pvmBT
    VA5TyCp02iAPr6QLYAq+j0x/Ghzjq48=; b=CqfjZV1gITt0ycRGSV4BUnCS147t
    /Vh03DXheccMY1IRvY4Q8tUpAL7UzS5JSslFagh4ul7FohPNOOoKyzPh02zeWVpE
    +Yy30wnsd/pgCsNmTKpHy1nsfY7AA8g7OIl9bwnJZ7EN3Br2bAK3BxMBr1n26F4B
    ZA/Vc8toeMhYVCT/NjMm/LfsMtN5SXZdisE3mNSlgBOJsOyJaGUiTFdrIs51/37G
    SJr0vGPhn3BtLtpSqGva0rAPPahYAy8DgTwJQKl5Y6s8uNTKp1/sR9zA2AfsysX2
    5z7kayvmd5+6v8jWQMYEruOEAaP5bqKzpsEinx9P29R+d6FTs8LaVwrdpQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=prjkt-io.20150623.gappssmtp.com header.i=@prjkt-io.20150623.gappssmtp.com header.b=GGtl3ZpB x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=prjkt.io;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=kQ8Hi8+H;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=prjkt.io header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=prjkt-io.20150623.gappssmtp.com header.i=@prjkt-io.20150623.gappssmtp.com header.b=GGtl3ZpB x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=prjkt.io;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=kQ8Hi8+H;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=prjkt.io header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBe/ofnrF9uir5pEQnu2nii/HgaD2jBwFDdXkOnwBb7HcesaofW/wUymMvsazKD6fvifv1i5ke6rDUDpRRMCFOwUQ+B8xS9AyXebg8MrHegCzK5ahX2N
    VmU/nIwt5nn9aozgM7yKZXdBCflt/N4U5x/zfendPYHc3P5xO11RjEH+3kB/4AMnNVmOpasYwk1Gq/nDWFGO9xAh5jV+vnihCALPaM/4bzHrGc2f75PFLnVg
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=XatMZvNwr2AA:10
    a=Kd1tUaAdevIA:10 a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8 a=etD2MYYkJzPjFH1Jjy8A:9
    a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754974AbeDVPYX (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 11:24:23 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36177 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753891AbeDVPYS (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 11:24:18 -0400
X-Google-Smtp-Source: AIpwx4//A5EiAO/AHaTpsGQFRIHcsWDkajPubJSpGtF2brSEo18Gf5bH8AZqQwoTEqm2s3H/uic6Bw==
Date: Sun, 22 Apr 2018 20:54:09 +0530
User-Agent: K-9 Mail for Android
In-Reply-To: <20180422135315.254787616@linuxfoundation.org>
References: <20180422135315.254787616@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Autocrypt: addr=harsh@prjkt.io; keydata=mQINBForuUUBEADNrWLYhW8qjO6GmfU32cqU
 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
 GOzuzn9qgWR/VAqd9BA=
Subject: Re: [PATCH 3.18 00/52] 3.18.106-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
CC: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
From: Harsh Shandilya <harsh@prjkt.io>
Message-ID: <9E2F8372-38E5-4097-A03E-39E4F14F5C4A@prjkt.io>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 22 April 2018 7:23:33 PM IST, Greg Kroah-Hartman <gregkh@linuxfoundation=
=2Eorg> wrote:
>This is the start of the stable review cycle for the 3=2E18=2E106 release=
=2E
>There are 52 patches in this series, all will be posted as a response
>to this one=2E  If anyone has any issues with these being applied, please
>let me know=2E
>
>Responses should be made by Tue Apr 24 13:53:02 UTC 2018=2E
>Anything received after that time might be too late=2E
>
>The whole patch series can be found in one patch at:
>	https://www=2Ekernel=2Eorg/pub/linux/kernel/v3=2Ex/stable-review/patch-3=
=2E18=2E106-rc1=2Egz
>or in the git tree and branch at:
>	git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/stable/linux-stable-rc=
=2Egit
>linux-3=2E18=2Ey
>and the diffstat can be found below=2E
>
>thanks,
>
>greg k-h
Builds and boots on the OnePlus3T, no immediate regressions=2E Good ol' bo=
ring release :-)
--=20
Harsh Shandilya, PRJKT Development LLC
