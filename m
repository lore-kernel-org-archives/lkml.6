Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754333AbeCGKNE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 05:13:04 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:38183 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754280AbeCGKMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 05:12:52 -0500
X-Google-Smtp-Source: AG47ELutNezj183oFuZy11y8CJ5xvJanWT2ceZJjY9agE+L6CbfK7NxXWgDRN2ggf8n9FPMC07uBbnTe5JNzyD35z08=
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0mHEm8m8=CfV5Qmw0EcVCc31OetdFXHQ0KEvWk6K40Gw@mail.gmail.com>
References: <20180220205638.1959033-1-arnd@arndb.de> <20180228211514.GC13394@ziepe.ca>
 <CAK8P3a2dsQ7QAb64DCp9Fc2xXjEyHNjBFdRc=y6FanQKsXhADg@mail.gmail.com>
 <20180306234539.GB1037@ziepe.ca> <CAK8P3a0mHEm8m8=CfV5Qmw0EcVCc31OetdFXHQ0KEvWk6K40Gw@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 7 Mar 2018 11:12:50 +0100
X-Google-Sender-Auth: CilZAijSIa47UfD2EpSXypyIvMw
Message-ID: <CAK8P3a2cqjQzhaPwk9rE6=s4QQVFk8vAoYQfqSrh1nOi-KpZew@mail.gmail.com>
Subject: Re: [PATCH 1/2] infiniband: qplib_fp: fix pointer cast
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Selvin Xavier <selvin.xavier@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Eddie Wai <eddie.wai@broadcom.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 7, 2018 at 10:05 AM, Arnd Bergmann <arnd@arndb.de> wrote:

> A small complication is that I wrote the changelog for the build warning
> on 32-bit architectures, which is more elaborate. kernelci.org for
> some reasons currently skips the allmodconfig build on all 32-bit
> architectures (I should ask the kernelci maintainers to change that),

I see that Olof's build bot does have build results for arm32
allmodconfig, which is also big-endian, and reports the same
errors that I described in the patch changelog.

See

http://arm-soc.lixom.net/buildlogs/arm-soc/v4.16-rc4-25-g41c42fe/
http://arm-soc.lixom.net/buildlogs/arm-soc/v4.16-rc4-25-g41c42fe/buildall.arm.allmodconfig.log.passed

for today's results.

This bot reports one other warning for arm32, but it's
specific to the toolchain version used on that bot.
I have a fix for that one as well, but there was some
discussion on what the best approach would be.

      Arnd
