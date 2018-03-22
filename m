Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3449376-1521746072-2-17558899607858684701
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
    t=1521746072; b=Hqle4wxK4RWWAq8v8WurnvSmmWKFbxVZw9x5B6U4lMHdgK9
    4dUjJBQ/v2VeZM+gea1s8TExzJAttf7pb+jFSfsJnQ4se2+8vMDf8ydWEzhA9suK
    oexIn57ZNIhDOKpX2MipczXaJ2IepG5CpHha58JFrYy48is9Pi0S/iaORJlq2QgU
    4ZSap37I+Y/xIEe3pL9sy+7tYruRUKRDKfH9OyOkwmQT2fQAD7ljnEpz/ZinVpdH
    dOlX/lmA2TMAuX3Mz5cR2PhRtr1gzrJRWV+zZT9KZQBn0WTgDMaqDcd6HbW0fcj1
    VpBtp2UkgeWQEUkpk6PVd/k3+f1UgtcdrdKSicg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1521746072; bh=I7iG+8hJSESDXNs8BApV01OfzPEPOswue+PEUu
    uwlso=; b=prjqlC1HvbrbKApHxKpOS4b/cwtZ07DpsxAbkSYDnCsLnGx/jQ/i2a
    KiweTxeQG9P4C81GbZ/DV3M3kX4ENhoqTidbGx+qR5vScczeBFwI5YCYynRqyLx3
    9HC4UFN89uN/Shw1nfRG1KDT5WMLmPVFtg4jVScsGZvpoJSgnq40v686rouMDIXS
    UGHd3DnKtJGC4DjwPWqxFPXzQGIvF1jIok6+K88L94MH562NIDM6SomEFrClGO5h
    69hXcqbkmfLlO1bmuRxTenIBYszgPpW40exJuzbxGHZoFUJRCbPl9AcX82Ui/43K
    5Y0kDbWqCtpZX7qZVVybSqxP/qVc7FdQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=RRQLn71k x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=EJ+lXkjj;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=RRQLn71k x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=EJ+lXkjj;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752119AbeCVTO3 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Mar 2018 15:14:29 -0400
Received: from mail-lf0-f44.google.com ([209.85.215.44]:33010 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751814AbeCVTO1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Mar 2018 15:14:27 -0400
X-Google-Smtp-Source: AG47ELttwhYBKlP8rMP95iko8hEvCQfD8RHnXNXru7M9Sl1FN6kWte7QwtDyMTfrnJXXvJvRsRQBOvIbXRo2pr6aFbw=
MIME-Version: 1.0
In-Reply-To: <6745f869-e249-a891-8d76-79f2830dd57f@csail.mit.edu>
References: <28ffc363-5140-5685-d288-6e3dc07c6369@csail.mit.edu>
 <20180227085428.GA16879@kroah.com> <b20cbd94-ce9b-cb2c-dc95-a6821376823f@csail.mit.edu>
 <20180227124050.GB31888@kroah.com> <6bca5a97-f581-86b8-12ad-77147619d519@csail.mit.edu>
 <CAH2r5mt91WGHDk-+LP4EBTEfAOmrY2k6_X7KKjc0D+LcDCfxRw@mail.gmail.com>
 <309db6c4-7e21-bfbe-44d4-eb41f5516d5e@csail.mit.edu> <CAH2r5muUfsZsqaBqkAfi_dXRheib+7DN=VSsbGcV22C2MdJaGw@mail.gmail.com>
 <20180313092133.GA13325@kroah.com> <CAH2r5mvmiTaC4W=LAaOvWv6xGEMce957c+u+Af6wNgxudbO3_w@mail.gmail.com>
 <20180316133241.GC11397@kroah.com> <CAH2r5mvYxpr_0CPZNiNJTGhFNaM06w-EoTT7WS8oVjVZq8HCCw@mail.gmail.com>
 <6745f869-e249-a891-8d76-79f2830dd57f@csail.mit.edu>
From: Pavel Shilovsky <piastryyy@gmail.com>
Date: Thu, 22 Mar 2018 12:14:24 -0700
Message-ID: <CAKywueS_8hhS3X=cCAD9etPr=L348kY3Wfv+n9q=gBV2ey6cbw@mail.gmail.com>
Subject: Re: [PATCH 4.13 28/43] SMB3: Validate negotiate request must always
 be signed
To: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Cc: Steve French <smfrench@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

2018-03-21 22:12 GMT-07:00 Srivatsa S. Bhat <srivatsa@csail.mit.edu>:
> On 3/21/18 7:02 PM, Steve French wrote:
>> Found a patch which solves the dependency issue.  In my testing (on
>> 4.9, with Windows 2016, and also to Samba) as Pavel suggested this
>> appears to fix the problem, but I will let Srivatsa confirm that it
>> also fixes it for him.  The two attached patches for 4.9 should work.
>>
>
> Indeed, those two patches fix the problem for me on 4.9. Thanks a lot
> Steve, Pavel and Aurelien for all your efforts in fixing this!
>
> I was also interested in getting this fixed on 4.4, so I modified the
> patches to apply on 4.4.88 and verified that they fix the mount
> failure. I have attached my patches for 4.4 with this mail.
>
> Steve, Pavel, could you kindly double-check the second patch for 4.4,
> especially around the keygen_exit error path?

The patch looks good. Thanks for the backport.

--
Best regards,
Pavel Shilovsky
