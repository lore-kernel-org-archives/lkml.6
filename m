Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1293483-1519082862-2-10668699906126536583
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519082862; b=qwzbL81lL0ukWvhi09pUB9AmiILIYbD1DooZKi9RU+Y50wm
    be7xs4ofxL0R3EkzVbLLw8FMOZ2Q+J0W9E2PmuIoC6QhzeNmcwi/G4MPtmhOHBLv
    3rqAshB72GGJiftY0YfEQybeysQK8eZZvBpHL2NVMt1HKCmzBiDkPrsfXYjGVg30
    iWC8MyQ4t20yC6aZ0okufcmT6BjNW2IUT/2IjhHQ2/tvJOOfNFgJY+znSHXsQ1W+
    9V4p7d7iAZsICIBrfjPL/kfuEX4ckKDsaNWgPgaF386GT9dHoNZl45hFpCBj/DVE
    vMBtuFGGirFEFi+f0Rve/h1gtaWDkbu9MOKUhNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1519082862; bh=MGJCwc92G8a01a517OUPZTqFGCzvK5+lOiLy0Y
    JcE/g=; b=Rgcnq5jIw0shorNqtiWCYbnJXuPwnuPh3lFBMXBWdcUFQQES6pUTLO
    E2ugKKJ24QM3TS6EH1XaLMCdIN06KhHgh6ryVKmF5Fs1a41bycSW3dyuQrusrT2Q
    Y3vh8qqO3BXMe4NY2khSkBmoNvVNVf/FXnIzRG8FbLDOExzzrPG1n7+4fpg7Vn1R
    cGbfVjBC7Oc5Yz0HM7MtQkz+RNWFCM4ajdzQMRmdUkPL/bS/QoWzpBKNu0KKYanb
    IMynHrbEnzwX06wi9rVm8GGyDCFA7y/K8qgaCnq3Q4pGhS7wr2QZ1dqf5FT0vkvP
    lmu7GOFCtGp6W116sh5NtL8Ju96/V6Aw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=omv/biv0 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=uBa/7WUP;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=omv/biv0 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=uBa/7WUP;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932241AbeBSX13 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Feb 2018 18:27:29 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:38075 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932195AbeBSX12 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Feb 2018 18:27:28 -0500
X-Google-Smtp-Source: AH8x226CK+FS6joeK6RyQv/jo8nkhQDp9eV7pCjH526Jii4EERA9XMJ7PNQQ0luQD3Gaql0I0PH/f7PG8zvhv907iYY=
MIME-Version: 1.0
In-Reply-To: <c35cd314-9dad-5d25-4627-1cc8687dbf7f@suse.de>
References: <CALQ-8CJ8biPVCKvg+Gri9Am+TRBP0Rw-cWL42U2F_z8VvWTNfg@mail.gmail.com>
 <c35cd314-9dad-5d25-4627-1cc8687dbf7f@suse.de>
From: Max Ivanov <ivanov.maxim@gmail.com>
Date: Mon, 19 Feb 2018 23:27:07 +0000
Message-ID: <CALQ-8CKP7GcK-oVwaWz3ZU0qvBOj19eJTwJf0cYQz4Di1Q3n3A@mail.gmail.com>
Subject: Re: iSCSI session logout regression after fbce4d97fd ("scsi: fixup
 kernel warning during rmmod()")
To: Hannes Reinecke <hare@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc: Johannes Thumshirn <jthumshirn@suse.de>,
        Kyle Fortin <kyle.fortin@oracle.com>,
        Don Brace <don.brace@microsemi.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        labbott@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> As already explained in the previous mail, there is a fixup for this in
> commit 81b6c9998979 ('scsi: core: check for device state in
> __scsi_remove_target()').
> Please check if this is applied, too.

I tested commit 81b6c9998979 cherry-picked on top of 4.14.20 and it
indeed solves the problem.

Can it be backported to 4.14 LTS, please?
