Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2790495-1517845809-2-6169183217803307038
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517845808; b=NoYzfcLnStAX3veAuC8FVaSkPmeAFsmqCjWiaX+dIBNK3X6
    jNWngA5BJWZyWOnqNC9KhrFZbj+6QhGsFbE8wkdzDZbkr0KbRBhj/RaPJMb5ajZ1
    nlR82WrQnZ/t9VoqiKMQr11XJFnQ7LpU2R/AWBcLQkoFRNIMpwUMTtriS4/YVqm+
    Uy4cPD6C3v+/BdoSkR5cjoQuE5kiS/lKadLgKggELJLTb5MwHBHBchgsnK75ybeZ
    5KuokcCVjfMV5/OG2Cqaltv3qpFCyzuBraIanP2UoOxsOjsgA5/djQ/Y5HvxzgFQ
    d8amnAK1ntWetVUBP/caqrMbZGkJpW1mXk9tDUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1517845808; bh=wJSGzGIzkgoRHfyvMGkAn2p0734Gbp8G3r4cHw+5ZnM=; b=X
    BtjFJJsoOo27Ofyi7V5RX/zCwoIoPLP/3EG1/UWmTuOPkmDzMmZhtKyfGZLSRwvB
    slYr++LMvrKQGQUB8Ng4YwJz3nItkYhOvTC5CKR8F6AT98LWURrhy39Vfb1gHZyK
    m24SH3mB275eORCtZeO4iOouXJD+09YBA6n7Zbvk92ZiPgK9L0Mur3x5g6+zKI1R
    g0p6ZMjJtgkCpwduDV4ZFewvqRRgr/WgcourV8eiiM0p2SvxXjIe5zYlaDToTh4q
    lg6SUs8uazUlmckErgt0wTBicaw77UA7eppJlRhzbh1ALu0JQouY3zldTyvfc+5J
    Fm6chV3QL1xWX8uZhHTyA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=FXaKnzqI x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ufsRid70;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=FXaKnzqI x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ufsRid70;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753102AbeBEPuE (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Feb 2018 10:50:04 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:43350 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753091AbeBEPuE (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Feb 2018 10:50:04 -0500
X-Google-Smtp-Source: AH8x226iwXfS7SJN12IzLBmpcwRWHRpa+4107c/R0n3JtbKKbmiXwgsgggwMx44WnrtWpoAlnTmom81Z6J5CuJaqUFk=
MIME-Version: 1.0
In-Reply-To: <20180203051824.GC1329@kroah.com>
References: <20180202140826.117602411@linuxfoundation.org> <20180203043519.eut367kib3dwbybt@xps>
 <20180203051824.GC1329@kroah.com>
From: Milosz Wasilewski <milosz.wasilewski@linaro.org>
Date: Mon, 5 Feb 2018 15:50:02 +0000
Message-ID: <CAJrz+7KfzV_fJ9BsWOJ-t4-MGR1HT11V7xuFwLBVLBYaUSpxaQ@mail.gmail.com>
Subject: Re: [PATCH 4.15 00/55] 4.15.1-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Shuah Khan <shuahkh@osg.samsung.com>,
        lkft-triage@lists.linaro.org, patches@kernelci.org,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 3 February 2018 at 05:18, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Fri, Feb 02, 2018 at 10:35:19PM -0600, Dan Rue wrote:
>> On Fri, Feb 02, 2018 at 05:58:18PM +0100, Greg Kroah-Hartman wrote:
>> > This is the start of the stable review cycle for the 4.15.1 release.
>> > There are 55 patches in this series, all will be posted as a response
>> > to this one.  If anyone has any issues with these being applied, pleas=
e
>> > let me know.
>> >
>> > Responses should be made by Sun Feb  4 14:07:50 UTC 2018.
>> > Anything received after that time might be too late.
>> >
>> > The whole patch series can be found in one patch at:
>> >     kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.1-rc1.gz
>> > or in the git tree and branch at:
>> >   git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc=
.git linux-4.15.y
>> > and the diffstat can be found below.
>>
>> Results from Linaro=E2=80=99s test farm.
>>
>> No regressions since 4.15 release, but you'll notice high failure counts
>> in kselftest. These are because it was the first RC and I ran the tests
>> multiple times - first without a skipfile, and then again with a partial
>> skipfile. All of the failures look like known issues that we also saw on
>> 4.15 release.
>
> Why does kselftest need a "skip list"?  Shouldn't all of the tests that
> ship in the kernel tree, pass on that release?  Is anyone looking into
> the failures?  That seems like a pretty obvious thing :(

They should and it would be great to see that. Unfortunately this
isn't he case. Some examples (from 4.15):
test_kmod.sh - path to the module is wrong
https://lkml.org/lkml/2017/11/6/654

sync - missing cflags in makefile
https://patchwork.kernel.org/patch/10166499/

seccomp_bpf - open(2) is a legacy syscall, replaced with openat(2) since 2.=
6.16
https://lkml.org/lkml/2018/1/9/1141

reuseport_bpf: this test doesn't give consistent results. It usually
fails when ran from run_kselftests.sh script. Passes when run
standalone on 1st attempt and fails again on 2nd attempt.

There is also a group of tests (BPF) that are not correctly built in
our openembedded build. The OE recipe needs to be fixed to make sure
all .o files are where they are expected to be. There are more failed
tests, but I don't have a good explanation what is going on.

>
> And was anyone testing the -rc releases to catch this before 4.15 came
> out?  If not, why not?  I thought you all were testing rc releases
> now...

These are usually old problems and they are also included in the
skiplist for mainline. We're trying to report any regressions in
mainline tests, but this work has slightly lower priority than LTS :(

milosz

>
> Anyway, thanks for the reports.
>
> thanks,
>
> greg k-h
> _______________________________________________
> Lkft-triage mailing list
> Lkft-triage@lists.linaro.org
> https://lists.linaro.org/mailman/listinfo/lkft-triage
