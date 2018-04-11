Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3269524-1523478164-5-16763848141591112119
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523478164; b=KGx8UYNlRgrUJ6AkmqxiTRNe27YFxn95aMesVptzuibVuI3C8D
    XYRpqLjKqtCbeFhLSXT50Xgwg/s1ldCJk3DoL0TU+q0oJLDDaWVvZ/TTtUUCfN38
    LXqJ4kF5fEf0Sik715H5GMlayBJmLfDf9i6pbGKEZNwjpmo3p/ZTPVWyWRpGvhAc
    0EO8FEnHoaPIPuCEPjWnX6LBEpBTm8kWrl3ZU3inW19Gt4jcGoqmtuCMf3CGOyqk
    Mr5bCMKG9Pr76akDBaZdFcim5Z8759CfcPS2g8UviavZubWPuanHVbMJ+68dS4P1
    BW6NY9h0as8SpRmVFI+ld+xGZqHplvdgKPUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:references:date:in-reply-to
    :message-id:mime-version:content-type:subject:sender:list-id; s=
    fm2; t=1523478164; bh=p5/UQOOs13SbwYz3Q/+Pk2Wqq3D5UD3/Af14BPGYoG
    c=; b=mHG7vYmrBhivzkgohkkf9lxWbd4W9BLkqmqxtTl/MQ5O7q3bIVytvFHDyt
    bvL0OCkDRM6nCXoL5fkwH4p+nT3OFDTfcOZXsRWdUVPzYCS0qpa7hDmBgtJc+St7
    /w9ThVS4XlCkvCWMuUJhwW3YibhUdBuKz6ENo6rUWf820cP9IlnplK0pWbymTlL8
    WOnAxgl8LywJygN07ZW4xinpcvyH9qAmP4b+7yhK/700I+FdxbtFkepj6YHXUCGh
    W3NMN1ue6vH5/jKBsSeJncJ1YpUlRYAYF4n5Jg//u1XlIOP5Mpx/jcLiJ59I4wI1
    vEYlhuvqKeSHvOX6apZ02zqVkj5Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xmission.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xmission.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfINRFIRMGBX/oJ6EWN63/sdlvZRvF9aruAK4wYhb/1xdJZFc/LYobwvqao9DUEvvqioMZ+hOwGrn5tplTKtJ1Mvg01zURGNwszphDAKgkc9oju8ekNKt
    m4ddqZ+fV599QmXpxxZj2OAWrSNmwPNdSilKk2jYBLJVyjz3Fgha4UMn7hg4XU41kILHkdgcsKrI4Y3vsw3QDEbQD2XsiLJDCQLgXj6kl26Esse/VYqFtlwg
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=20KFwNOVAAAA:8
    a=VwQbUJbxAAAA:8 a=u-CgsrzmgoaB1oUMz_AA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932910AbeDKSvr (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:51:47 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:36484 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755691AbeDKSvn (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 11 Apr 2018 14:51:43 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: David Howells <dhowells@redhat.com>
Cc: torvalds@linux-foundation.org, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, jmorris@namei.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
References: <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
        <152346403637.4030.15247096217928429102.stgit@warthog.procyon.org.uk>
Date: Wed, 11 Apr 2018 13:50:12 -0500
In-Reply-To: <152346403637.4030.15247096217928429102.stgit@warthog.procyon.org.uk>
        (David Howells's message of "Wed, 11 Apr 2018 17:27:16 +0100")
Message-ID: <87zi29k26z.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1f6Kq6-0002ih-Sn;;;mid=<87zi29k26z.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.140.30;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+HjSKZKEIiTmAWbs6f2zRx4tfe2/F5Omg=
X-SA-Exim-Connect-IP: 97.119.140.30
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on sa07.xmission.com
X-Remote-Spam-Level: **
X-Remote-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.1
X-Remote-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Remote-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Remote-Spam-Combo: **;David Howells <dhowells@redhat.com>
X-Remote-Spam-Relay-Country: 
X-Remote-Spam-Timing: total 15017 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 3.1 (0.0%), b_tie_ro: 2.3 (0.0%), parse: 0.73 (0.0%),
        extract_message_metadata: 2.7 (0.0%), get_uri_detail_list: 1.16 (0.0%),
        tests_pri_-1000: 2.7 (0.0%), tests_pri_-950: 1.15 (0.0%), tests_pri_-900:
        0.97 (0.0%), tests_pri_-400: 19 (0.1%), check_bayes: 18 (0.1%), b_tokenize: 6
        (0.0%), b_tok_get_all: 6 (0.0%), b_comp_prob: 2.0 (0.0%), b_tok_touch_all:
        2.2 (0.0%), b_finish: 0.63 (0.0%), tests_pri_0: 144 (1.0%),
        check_dkim_signature: 0.46 (0.0%), check_dkim_adsp: 2.8 (0.0%),
        tests_pri_500: 14837 (98.8%), poll_dns_idle: 14830 (98.8%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [PATCH 24/24] debugfs: Restrict debugfs when the kernel is locked down
X-Remote-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

David Howells <dhowells@redhat.com> writes:

> Disallow opening of debugfs files that might be used to muck around when
> the kernel is locked down as various drivers give raw access to hardware
> through debugfs.  Given the effort of auditing all 2000 or so files and
> manually fixing each one as necessary, I've chosen to apply a heuristic
> instead.  The following changes are made:
>
>  (1) chmod and chown are disallowed on debugfs objects (though the root dir
>      can be modified by mount and remount, but I'm not worried about that).
>
>  (2) When the kernel is locked down, only files with the following criteria
>      are permitted to be opened:
>
> 	- The file must have mode 00444
> 	- The file must not have ioctl methods
> 	- The file must not have mmap
>
>  (3) When the kernel is locked down, files may only be opened for reading.
>
> Normal device interaction should be done through configfs, sysfs or a
> miscdev, not debugfs.

> Note that this makes it unnecessary to specifically lock down show_dsts(),
> show_devs() and show_call() in the asus-wmi driver.
>
> I would actually prefer to lock down all files by default and have the
> the files unlocked by the creator.  This is tricky to manage correctly,
> though, as there are 19 creation functions and ~1600 call sites (some of
> them in loops scanning tables).

Why is mounting debugfs allowed at all?  Last I checked (it has been a while)
the code quality of debugfs was fine for debugging but debugfs was not
safe to mount on a production system.

Maybe the code quality is better now but for a filesystem that is
not supposed to be needed for developers letting us mount debugfs
seems odd.

Eric
