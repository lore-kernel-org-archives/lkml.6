Return-Path: <linux-efi-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1580296-1522761963-2-287164994637869323
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-efi-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522761963; b=CSbnf1ENT8iSVFuv9YSTV4QUECGIQ0UuCAurwb3/x6eaH98+Sb
    mIUuWRMOo8c3CFF5hzJ56WylDhCsxTyAWZR1uXOhhML2zjDx/JlC9LjTpqyuEkDC
    FsUY17zM3K59GCN5ux2zqZXQY6LagQ7YkOo1f3/9ggD9Kin529L1VO5bfFrG/WEH
    zmwMMRFSsCbN45b3k6W8yfltdIP/b2TMy/gZou/1AKQHr68HxOBzViRK8MnDChm+
    slin8plMYzIGdE9ZpJZwuAY2sPY29OxpQttSrtg/bvoLc8aos2zqpLur4SEcitRP
    QvZqljSutVZputUveFUEdc0e021TI7ADhLTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522761963; bh=Doem8jwNRHVCBdJjn20vxIWpSKwceECPyqokXHisK8
    M=; b=R/Ho+xSDivMJid/Q1XBdfgtuK2e02lbrGeoXUgnPrT32F9BKhIDRs8vQgM
    w2nLOTqunqQ6O5ydJiHYXMHWDPsIVKqFAAcQ9yIjMMxjC0+cIfAvOaKLjp8R4RQw
    6Bc0x1X+YLJRFiPftENW6PoGRhaqLws+mZIsC6dKKQNu5CO8KM9o2cVGhrUy0VnT
    NE2g1FuV1AvdgfZXvZEhdGz1WIqSr/zD7PhvvWGdEVPl/fy4G+1Ali4Et437Q+Lw
    LblnUUfN0zEqvYVKLpD7TUo7USpyOWhmnzB/zQ07PRKHtmSW4C1psW/vjTXAjJBM
    pn/eaVzv/bTIy6Y9jhc3GqcmWl0A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=IYsjcQaB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=EwhbHIY2;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=IYsjcQaB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=EwhbHIY2;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLhUHuIsWl1me30vlBv7sV4VxnwjebJP76PSUY0ED/TXlQlbyW1F48rkRcUKocPb0a6X/R8LxIafFn63GgsPzQhPMiFdoi8dBo4zFk6ChiKp3476XZfV
    6SK+R/oPpfimQAE0ltfyedhOHp+p4Ub43QzOiyhrDNm/cf0MXkH58A3Et3Ee44USuDmjvQO//jMHxfOPXlEgmN3Sx/OlK2Q0McoGTvr7W6U0spwDQg3xwcH3
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=K6HrmWtEAAAA:8 a=VwQbUJbxAAAA:8 a=qPi5sXiU7Hr6uySaj3wA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=yV38gEssg_2GhkhKF82i:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750748AbeDCN0C (ORCPT <rfc822;linux@kroah.com>);
        Tue, 3 Apr 2018 09:26:02 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:36963 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750714AbeDCN0B (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Apr 2018 09:26:01 -0400
X-Google-Smtp-Source: AIpwx4/73pPgzu+FY/eER4lit3Nd/SP7xI722IcdL7lRUJr+AR4vKf3/4mvV2WQU/SA6AhzfLus25Qo5zAzZf2SgXC0=
MIME-Version: 1.0
In-Reply-To: <17792.1522491600@warthog.procyon.org.uk>
References: <4136.1522452584@warthog.procyon.org.uk> <alpine.LRH.2.21.1803311145180.7769@namei.org>
 <17792.1522491600@warthog.procyon.org.uk>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 3 Apr 2018 15:25:56 +0200
Message-ID: <CAKv+Gu9Na0j=T4syinQhPNZTnbhvnpDXR+Za73EmH3FFXV6KHA@mail.gmail.com>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
To: David Howells <dhowells@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc: James Morris <jmorris@namei.org>,
        One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
        linux-efi@vger.kernel.org, Matthew Garrett <mjg59@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jforbes@redhat.com, linux-man@vger.kernel.org,
        joeyli <jlee@suse.com>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
X-Mailing-List: linux-efi@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

(+ Andy and Kees so they can respond to the thread)

On 31 March 2018 at 12:20, David Howells <dhowells@redhat.com> wrote:
> James Morris <jmorris@namei.org> wrote:
>
>> Are there any known coverage gaps now?
>
> I've covered all the ones I know about.
>

Andy (and Kees) responded to this without keeping all the cc's. Given
that I share Andy's concern wrt the general nature of these patches, I
will reiterate them here.

First of all, in my experience, when introducing any kind of 'secure'
mode, people will immediately assume that everything they use the
system for will be more secure going forward, and so they are more
likely to let their guard down, resulting in a less secure situation
than we started out with. So I already argued for calling this a
'lockdown policy' which is a clearly communicated as a best effort
attempt to make the system more robust against inadvertent
modifications, and documenting/logging clearly what it actually
*means*. The latter is especially important because many of these
things are arch specific, and need to be implemented for each arch
individually in order to take effect on them. Also, v4.17 lockdown
will most likely be different from v4.18 lockdown.

Furthermore, there is a fundamental deviation from common security
sense here, where things like command line parameters and other
lockdown specific tunables are blacklisted rather than whitelisted,
and so rather than locking everything down and re-enabling only once
what needs to be re-enabled for the system to work, we are now forever
going to have to track a moving target, where it is someone's job to
ensure that incoming changes don't regress lockdown mode on any of the
architectures it supports.

If the distros are shipping their kernels with these patches applied
to adhere to some kind of requirements imposed by MicroSoft in order
for them to be willing to sign shim images, can we please involve
those into the discussion as well? It seems to me that this is a
solution without a problem statement, and I would like to fully
understand the problem before reasoning about the solution.

-- 
Ard.
