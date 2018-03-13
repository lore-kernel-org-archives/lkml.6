Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3393218-1520954530-2-10305501759163254787
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520954530; b=e3dD2f4Cbr1XjcdC9kNwE5uNF5kFMug8OJdN6ipViELIMxo
    gKa8zqtxiDTH2anWZgFFJx3OY8uTPaxeZ1IGgP9O9JLZRSaM/UWK6W+DlvlsH2kv
    HpoRWRtmlTpBHIFA07QvnqRxcf/POHSfBwunwqLsibmj53x7JYP1WbWsmDtUdB6X
    4vlo5ktztu19WtJQNtfu3rQTWoD1dmS9Tr8+ObY3I0/oQHzTa3VIeGA+n+ub1Tpv
    dxuQ6FdyD0KysRYKrYrzf9B3W/7LOagjHIpQyr2rl1GVlHOWT4CEr++uD4htl8H1
    KU9lB4s6tCxSgIlQ91u0QA4fiWE2iOfvqvQLUaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520954530; bh=VB7JKfXCPNZmsAu1EcNeuvxjWc1Yj4ILMzdCSW
    9Jc68=; b=gsag+zX4K4dxJdjNVr9e9oJjkn6zY6lIoX3oLXZo5F4HZW8eMH2DWb
    MzngIMK7nA1ck9xDWZwr2k18ADcgbcToguAvDZUZUpEAGwEgpb/NtTO7NxfIVYa7
    vsZdHwuTm/RFWjNA7VYnv6bR+wjO37PKtXgDgVu7VaqNAqsJ8ecwGHBRVAIs4iZt
    EjcKrLaJyvGeLc3dy4NCffT9pAL3LPcAUlnJXKzLLsxj0D8iSnzJ1YoPLmHb07jd
    ASmUP2yIEQIN6TUxAR/kIEVMC+CXdCgWSn0fjoOEG3QBXhwbYlk+ap5tbdWyIHkq
    Go57UK/U7pkm4cQqdpCoceM+zebPHN+w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Ro8kFFk9 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Twk1U5yk;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Ro8kFFk9 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Twk1U5yk;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751596AbeCMPWI (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 11:22:08 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:46753 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751365AbeCMPWH (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Mar 2018 11:22:07 -0400
X-Google-Smtp-Source: AG47ELtvEUAebRH5oVfMdVrEi4D0h0k+UuJcNHsHOiZiRX6TTsvMZ0eb4dOCaQEveYb+t1skZHNk9mPJmnw3YtCvAGY=
MIME-Version: 1.0
In-Reply-To: <20180313092133.GA13325@kroah.com>
References: <20171101151803.GB31285@kroah.com> <4ba67095-4075-688f-d3fb-157847aee4d9@csail.mit.edu>
 <28ffc363-5140-5685-d288-6e3dc07c6369@csail.mit.edu> <20180227085428.GA16879@kroah.com>
 <b20cbd94-ce9b-cb2c-dc95-a6821376823f@csail.mit.edu> <20180227124050.GB31888@kroah.com>
 <6bca5a97-f581-86b8-12ad-77147619d519@csail.mit.edu> <CAH2r5mt91WGHDk-+LP4EBTEfAOmrY2k6_X7KKjc0D+LcDCfxRw@mail.gmail.com>
 <309db6c4-7e21-bfbe-44d4-eb41f5516d5e@csail.mit.edu> <CAH2r5muUfsZsqaBqkAfi_dXRheib+7DN=VSsbGcV22C2MdJaGw@mail.gmail.com>
 <20180313092133.GA13325@kroah.com>
From: Steve French <smfrench@gmail.com>
Date: Tue, 13 Mar 2018 10:21:45 -0500
Message-ID: <CAH2r5mvmiTaC4W=LAaOvWv6xGEMce957c+u+Af6wNgxudbO3_w@mail.gmail.com>
Subject: Re: [PATCH 4.13 28/43] SMB3: Validate negotiate request must always
 be signed
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        Thomas Backlund <tmb@mageia.org>,
        =?UTF-8?Q?Aur=C3=A9lien_Aptel?= <aaptel@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Pavel Shilovskiy <pshilov@microsoft.com>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

There will be a fix needed to correct an oops in calc_signature,
besides the easy patch (smb3 validate negotiate patch).

On Tue, Mar 13, 2018 at 4:21 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Sun, Mar 11, 2018 at 07:37:55PM -0700, Steve French wrote:
>> Just got a wireshark trace - this is a fairly trivial issue (missing
>> the validate negotiate must be signed patch) - I had some trouble
>> getting this version of the kernel running (unrelated issue) and on
>> systems with access to Windows 2016...
>
> Ok, I have no idea what this means, or what I should do here because of
> it :(
>
> Any hints for what to do with the stable tree?
>
> totally confused,
>
> greg k-h



-- 
Thanks,

Steve
