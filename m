Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2590670-1521720189-2-1330445561344592110
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521720189; b=s82WvdjC2EI5FYJir5ZVwKMH/4oDnGeLtb3sM7LEls2WHvS
    Ev1H/qoEKgcedbSsG8erSCEOXUpULKNL+ZsBzdU86qNl/YUvYlhIr+H1fw/9ritO
    FufhGz+8wcSv7O/ybFdm+99zTNr+2hIwYmMuhtV80OcdlagSiufWpDkPcryz8lRo
    THwOlcaMETYISiBhonmUZLisF+1DRO0MBpvxkVP/bTK+oe4LxoYD48NFR6xaPmpo
    MgCUS8kwKSRIs9YmPy+5LTxfugUSXRMQYmX3IlXhkNYn/CvieARMvUGoQOiop8yB
    hD6si5DFzd3O40NyYDnajh0BFbrsjdainIyYqcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:in-reply-to:references:mime-version
    :content-type:content-transfer-encoding:subject:to:cc:from
    :message-id:sender:list-id; s=arctest; t=1521720189; bh=eqAMhxgu
    9rX38FxAEpTGfLQBLfp0IuuikPqy1nR2aCM=; b=ve7PH4P1pJY9etkCZnPzueHw
    RrVLCOPAHJCaY7f1Poh8/ZBY58OPsOva7ls2HBfSK42UrfTZR4yT2BofYcVOFbzK
    DYgRVeDz3jIWd+ABW8rMXzXmGmaw6p3L/NpfPeMiw23bOZ4FfQtNRnZV3K68XYdU
    7WjGvhQrK2OT9sPxFV9g5D/v6IFeJyzV1NDn07bTTILw4nvT5neyX8xzF+2B0LPo
    eAIV2encXDZqu2/tqJmVHsRk3ue3a2rn3r5DRtuxajj+FpVox2XcMljlkMesghxV
    irjcQB2tjGBZ1KdFBj91jXa7+8i8Mdasg5FSFs4GtC1nhTu90BAC39xzgcC7hA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=HJV1/62J x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=swnx9X/5;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=spam score=190 state=1
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=HJV1/62J x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=swnx9X/5;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=spam score=190 state=1
X-ME-VSCategory: spam
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753353AbeCVMDG (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Mar 2018 08:03:06 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:33825 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752266AbeCVMDF (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Mar 2018 08:03:05 -0400
X-Google-Smtp-Source: AG47ELu1EyC4QxNB06WFu0HE6S/BvwF1m8LvdGEVTxuiORbc+A8ksMVRqafdmxPNOXfmwPJ9DVFB9g==
Date: Thu, 22 Mar 2018 17:32:51 +0530
User-Agent: K-9 Mail for Android
In-Reply-To: <20180322090342.GA19711@kroah.com>
References: <20180322090342.GA19711@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: Linux 3.18.101
To: Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
CC: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
From: Harsh Shandilya <msfjarvis@gmail.com>
Message-ID: <D177B830-AA1C-4F6D-9F65-E3071AF52A3C@gmail.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 22 March 2018 2:33:42 PM IST, Greg KH <gregkh@linuxfoundation=2Eorg> wr=
ote:
>I'm announcing the release of the 3=2E18=2E101 kernel=2E
>
>All users of the 3=2E18 kernel series must upgrade=2E
>
>The updated 3=2E18=2Ey git tree can be found at:
>	git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/stable/linux-stable=2E=
git
>linux-3=2E18=2Ey
>and can be browsed at the normal kernel=2Eorg git web browser:
>	http://git=2Ekernel=2Eorg/?p=3Dlinux/kernel/git/stable/linux-stable=2Egi=
t;a=3Dsummary

Builds and boots on the OnePlus3T, no immediate regressions noticed=2E
--=20
Harsh Shandilya, PRJKT Development LLC
