Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2234106-1521979959-2-16806154346521028644
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
    t=1521979959; b=dBlJKI3+WVwpvBC7VT1jSNgoAsTxd4qrFgNEZdz9mUeYkDR
    3y1DwVtyy7eq20TyFIdktllPGROR4xnugVJirerHmUxA5ayyvpZHEPEJlSdyl1TZ
    Y4Ef/5tkNhrHAjUSAhpswcMA0glP385DaM4bH5upYzMP3TedtBuoWjUJixrFVLjU
    /S9LmeHfdWXlo7osfIwBVGQYUX216dn9N8M7xu6YCnEVNrAVW16TtMiP7enliL9+
    ZQEtvwsQtYOUQvsUG0VWhQ8KpvpkdL4yXRveSJE5RyOdaG1oQ9I1pGWLEnlYsPcF
    1NyfMKCh3M5SowQHCu4SW/x3WsVbZxL7QnWYl+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:in-reply-to:references:mime-version
    :content-type:content-transfer-encoding:subject:to:cc:from
    :message-id:sender:list-id; s=arctest; t=1521979959; bh=lM73CNno
    pXQF7mEhexKN5yt86kTFKDVq2+RrA/BTFOM=; b=ALrRPwPRZ8A0k7Un5hDR9T2v
    /2HCXgBF1UnxDvZ2jnq5pF8rFjiGVjfWbxweEQK4kOeEJq+W7W+sioXxAYDfXvnx
    B5pvFZmfvVmnpT7fDBAPxaCCvbZ3Nnjp6EvwXowO/XMyzm5IVAu1e0gDQ8eDfiHd
    G7ght3o/W/OXycz4cn9wvqsUM+fjtu1vsyexAGIz4lyLuqAA1w0559X02mRnPbNx
    iC3s/faAwxAKoEVPMzalaG1RbCqx2dCLC7SbvPMb+1MDvoL2ZmLUncGL3Ebg7Eo9
    03Q4XCwSsvXHFfh5wZkKR+ibnBaWIm0b5yF2VaGpHhx1bSEBR97eOkFxg7XN4g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=AJW2KXNK x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BWtWLbvM;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=spam score=190 state=1
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=AJW2KXNK x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BWtWLbvM;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=spam score=190 state=1
X-ME-VSCategory: spam
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752707AbeCYMMh (ORCPT <rfc822;greg@kroah.com>);
        Sun, 25 Mar 2018 08:12:37 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:45324 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751997AbeCYMMh (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 25 Mar 2018 08:12:37 -0400
X-Google-Smtp-Source: AG47ELs56ire6gWnPQ8HVP6pUNcWCBJIipwi2v5pYAaF71/kjcVRQTAJn5de0+dVGL84MxqDGk5s4Q==
Date: Sun, 25 Mar 2018 15:21:07 +0530
User-Agent: K-9 Mail for Android
In-Reply-To: <20180325085952.GA31575@kroah.com>
References: <20180325085952.GA31575@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: Linux 3.18.102
To: Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
CC: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
From: Harsh Shandilya <msfjarvis@gmail.com>
Message-ID: <42C0153F-EB4A-47D6-A401-313B88CBCAFD@gmail.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 25 March 2018 2:29:52 PM IST, Greg KH <gregkh@linuxfoundation=2Eorg> wr=
ote:
>I'm announcing the release of the 3=2E18=2E102 kernel=2E
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
Builds and boots on the OnePlus3T, no regressions noticed so far=2E Thanks=
!

>thanks,
>
>greg k-h

--=20
Harsh Shandilya
PRJKT Development LLC
