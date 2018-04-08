Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2601583-1523201981-2-17694694267112251723
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523201980; b=CBupE4VPK+FYNocEPuDOl+neouwcD4tqeUy0qRr6+7NIgwfZ1C
    dig7CMjVDWlU+st0wMxng+Ae9J+tpuy/W9w0hn5ujxXyCbckMAdVoY1pihfy/N/u
    CvzJ2/CsWHFUBtFAOLfXC7LN7JxinM5jPjq2cZjeaxalwJFRnkeVph86tfDUizLF
    SeqZDMKAGOaHA2U/r/tJODmbFL2R4MfSs9FCe8oMFoZHOjoaSOGTH1Pr1PLylRT/
    aWLzdKTc31rRuFz/v7nN2/PWsOiXjPqB1egKbBbCAgEhiNCRs+YQCRdZqJPV2nZI
    tBj9KLTri7V/QqfZ3M7HLEcGsqQx/uFj1TsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:in-reply-to:references:mime-version
    :content-type:content-transfer-encoding:subject:to:cc:from
    :message-id:sender:list-id; s=fm2; t=1523201980; bh=3mewFntb5smk
    rKQcRkowUt3nkS/ycEAHLy+7WdRg5RE=; b=CrPpMXftDfS00kcO/Xi6ReR6NFei
    MrCjy4mRxbvjBSRZx/FBMAbRumdza2LqG7bE2kF55yyuCxe1ZtHOB6C5bLmUGUpX
    PuzejHxApt8hrFG627JY4yTncvsb6r8WA03xnWoPQr9z0D8l85Bd0mPcJ6aH0u4Z
    EGfKT2rW6+RK+ffNAY9zEFEoqKwnZOmf42qdZ6zUKlxKiLpkRh0Y7PEFXH9PiLsM
    bO47VqPZ4rgFIVufhnUQvdwlA9FYZFDuBjqMQJZB21eAQIbmvp3A0E4aKGy+0jMS
    wKRi/eEsr53qXYc7BkennSEeiTZafwYIRGQRRkNE2Hj6XRJjF70c1od6VA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=VD5uLOPT x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=eLwNaOgT;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=spam score=190 state=1
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=VD5uLOPT x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=eLwNaOgT;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=spam score=190 state=1
X-ME-VSCategory: spam
X-CM-Envelope: MS4wfL+Ay9joDOw2Y5Ls4jZpv/2LLy3WJqGbHPzcDFdWvirPbI5+jjC8qivDof9baz4PzIdmZQvXvfH38k58LX2PbquAR5zXDZYk8IOJlW7tDDgqYJXwlv0k
    mMcPmfUn48fEXTyKl8ZK18J0cu32148+TKjwMhZ0WqlZDRzMfr0lOZE3/nzjTfxS1H+ZsWZFOMEQfmHdThRvSJVsBfmKbALLdZVjUEG8NpKjdMRewQw8ZqU/
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=0aEd6-21V0kA:10 a=Kd1tUaAdevIA:10 a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8
    a=D9Xdf5UlAVM8PJMc1CAA:9 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752076AbeDHPji (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 11:39:38 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:36633 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751738AbeDHPjh (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 8 Apr 2018 11:39:37 -0400
X-Google-Smtp-Source: AIpwx4/EWNV1BSNTBwpGHtcfH2FJQ2PwRw4cix2lHhODVL7UpMQkkxe87eddi9Au9c9lY6mypuCwIA==
Date: Sun, 08 Apr 2018 21:09:26 +0530
User-Agent: K-9 Mail for Android
In-Reply-To: <20180408150708.GA15675@kroah.com>
References: <20180408150708.GA15675@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: Linux 3.18.103
To: Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
CC: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
From: Harsh Shandilya <msfjarvis@gmail.com>
Message-ID: <44D3EF7A-9E12-418A-8968-ACBBCD865F63@gmail.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 8 April 2018 8:37:08 PM IST, Greg KH <gregkh@linuxfoundation=2Eorg> wro=
te:
>I'm announcing the release of the 3=2E18=2E103 kernel=2E
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

Builds and boots on the OnePlus3T, running it for the past few hours with =
no visible regressions=2E

>thanks,
>
>greg k-h

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
