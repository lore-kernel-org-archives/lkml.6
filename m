Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3571806-1521884421-2-8020331105411955242
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
    t=1521884420; b=aMquD/rHwwfOy35gg4OPC5VNDOZTrkPC0arTe7EFu14C2K+
    vJj9WfbkeagAuRHDwNmGNo5C6CAbj62XXH7zJwpkIsaue+HM5P0sT/AUteGfxfmq
    wlQzsTfIZ2v4TbsdIxRdRlKJ3YxKJ+A32xguQt77hiPxtJU93/0ATUNP+ro3145Z
    wEJp2bOP3cLGVxW5Zbw+7w6Z90vuL+4g8ogFo7sOh8PpGGMpxnz5OVzLkohvGk4F
    AUjJepGdapEu4Q0eu987AHQSK6n9Tlkbbo813/SscjpUu7TIwW1RMZY6RH4cGcqm
    dDD9cftIsPcKMRTTg3eEEBMR+EYWSdOFc085eLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:in-reply-to:references:mime-version
    :content-type:content-transfer-encoding:subject:to:cc:from
    :message-id:sender:list-id; s=arctest; t=1521884420; bh=5Uu+Izi2
    G3nHF9Q+8TKZbQZSrKf2Dcw0eAxSErp6lg8=; b=HT9Mv9Y+HIPhwj33dI22zczF
    UJl9Rwg5oX16UsOqZJwaAs6Zp+ShapPkoAsHu6YLKNjVlku0Js9dPZue6qkT0LkF
    mcMyCXxKoLywsOBl81VHj/zMpcK1GHXOQV3200wjVVnOY2+R95nTaCdA50a1UGde
    Sh+TZRU0oiliDejMxN3Y0vjxba9GGKsm3mcSfPNlKF+lc6CzBZlaSoE5G3G4ah9j
    Iep+CR+qQd9qrFMudcswG6cmLTcKSyFYjRyY8un3MecqvP2ilUMiClAq3vL/p4TI
    iWi4bq46BPqYywvidIP6BgiEECLwJRaUSuJjzFeGKdlbweNs49vQkd8ipGMuUA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=URBRhLGA x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qoG5nnbc;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=spam score=190 state=1
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=URBRhLGA x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qoG5nnbc;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=spam score=190 state=1
X-ME-VSCategory: spam
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751858AbeCXJkS (ORCPT <rfc822;greg@kroah.com>);
        Sat, 24 Mar 2018 05:40:18 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:51199 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751797AbeCXJkR (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 24 Mar 2018 05:40:17 -0400
X-Google-Smtp-Source: AG47ELuDRulA6H6iEIdD4cQcw66d+w9WlUg8EMrxvFPchxkhd134T6jolJjCyiRDeO39jgXRw0a4cw==
Date: Sat, 24 Mar 2018 15:10:06 +0530
User-Agent: K-9 Mail for Android
In-Reply-To: <20180323094248.117679641@linuxfoundation.org>
References: <20180323094248.117679641@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3.18 00/47] 3.18.102-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
CC: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
From: Harsh Shandilya <msfjarvis@gmail.com>
Message-ID: <8B6252C0-646E-498D-A599-13B3A1CF51D9@gmail.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 23 March 2018 3:24:51 PM IST, Greg Kroah-Hartman <gregkh@linuxfoundatio=
n=2Eorg> wrote:
>This is the start of the stable review cycle for the 3=2E18=2E102 release=
=2E
>There are 47 patches in this series, all will be posted as a response
>to this one=2E  If anyone has any issues with these being applied, please
>let me know=2E
>
>Responses should be made by Sun Mar 25 09:42:36 UTC 2018=2E
>Anything received after that time might be too late=2E
>
>The whole patch series can be found in one patch at:
>	https://www=2Ekernel=2Eorg/pub/linux/kernel/v3=2Ex/stable-review/patch-3=
=2E18=2E102-rc1=2Egz
>or in the git tree and branch at:
>	git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/stable/linux-stable-rc=
=2Egit
>linux-3=2E18=2Ey
>and the diffstat can be found below=2E
>
>thanks,
>
>greg k-h

Builds and boots on the OnePlus3T, no regressions noticed so far=2E Slight=
 merge issue in GPU drivers due to CAF changes, kernel-common should merge =
without a problem=2E
--=20
Harsh Shandilya, PRJKT Development LLC
