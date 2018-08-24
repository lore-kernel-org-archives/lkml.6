Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061D3C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFCBB2159F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:36:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFCBB2159F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=manjaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbeHXULr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 16:11:47 -0400
Received: from mail.manjaro.org ([176.9.38.148]:59712 "EHLO manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbeHXULq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 16:11:46 -0400
X-Greylist: delayed 1298 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Aug 2018 16:11:45 EDT
Received: from localhost (localhost [127.0.0.1])
        by manjaro.org (Postfix) with ESMTP id 6D09E30CD881;
        Fri, 24 Aug 2018 18:14:47 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9fVpd2GcnL3a; Fri, 24 Aug 2018 18:14:44 +0200 (CEST)
Subject: Re: [ANNOUNCE] 4.14.63-rt40
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        =?UTF-8?Q?Philip_M=c3=bcller?= <philm@manjaro.org>
References: <20180822141458.0b6b6af7@gandalf.local.home>
From:   Bernhard Landauer <oberon@manjaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=oberon@manjaro.org; prefer-encrypt=mutual; keydata=
 xsBNBFWiTO0BCADp2m6vJC6HqqA5fbl5c9TfoYZ+7Gc3c+yAsw6eCanyWOE34HXDAGkHDiPO
 zMLbUy0bNsS7jJvjxremNmFuDgXxDZZ5Xslgwj32X6PhcfexVPI0IlceZCQlthXRrsxwMFol
 oYYxVlsrpp/z++dJQ+8pb3yQ90c/TE+hiQdZZRLhXz8w+NIgLpKXb5fRkQQ9VfSpv5jCeUNL
 E/gG7ECkTVQrBUMEAFqSkOXq0PdVptJrC3hjWZGmjdCA4I515Tm6T5QqPKWRyaoG/w57dFc9
 Aq3ExZ19Txtxf6H/0wKDZa53fRGjYaQUuJzZYhhzC6JETPZARbzDe86FEjpQlwa23gW1ABEB
 AAHNJkJlcm5oYXJkIExhbmRhdWVyIDxvYmVyb25AbWFuamFyby5vcmc+wsB3BBMBCAAhBQJV
 okztAhsDBQsJCAcCBhUICQoLAgQWAgMBAh4BAheAAAoJENrTshFmPKJoDyUH/iMOmPfFdE22
 4mw3WYvtEXBryv42ATeLTxdGMzAaDZCZreGtc0NGsaYcIe4csT8/ON1Y8I60vIfp4lk0VvK5
 N0G85922sHT969v7bEUmN8xSG2dhAgsuqZReQD80JVpFez9KU599dPPX7DaVFXz5JvzlKYMQ
 RJOiLP6N+pdMiBbG9DXetxBBmr4IqM964NDJwLH3SNEzjQUr+8DxRi5pTWu1UKDnW2y5z2qP
 EEtYr8SJT3qy1gctsq1JYG2H/fLMEIXcZm/lBMfq8H2IQLyHm/WumkJKfTOmgMlbGVkzFT9W
 XxjPtQ+p50Aa79ti2wbZKYXLcy3NuFxbBGhNnOSYjlnOwE0EVaJM7QEIAMFIlWIATFKmAIz+
 kXJDdCV6Yfy2ptEphN0iaU6mj4jcBdaBcUzpDFSE1z5R6LqGyZ59DVsxW4Dk85CLrpY5+qGU
 FmtWwLD8LniXRUG385r/QD9aMP2b86WKfkK2cTCt81I3907N5shS2Ypq1dRrQhr7P6Wj0Cla
 r1nZWcnqV9dvwRnhMtKM3sZ2+120qRPiIVRnShAJ9OqUYStGUpk1h+W60Nt+cnFLPLc6wGD2
 QvLIv6Lk+Gonzq/yKDNbLArIlkECUBcu9NbDnsp7SGNGTuP1zP7ofvxEabfCLOrH9H8c0hlF
 QfiB1v6lqvGsb+al0H7szpN9e9H+5QtteAhPKisAEQEAAcLAXwQYAQgACQUCVaJM7QIbDAAK
 CRDa07IRZjyiaB/bCADaMnHznD5HY0FqMJciZzFtbZxLHsbGFEJx+RRGmo8AKx5hODNA+D4o
 blwkzafgbPnqACiLP9lt3y7eUZyKG61ZHOjREjRQvyBjc4O4YcGq1AcLzWbEzaq9ZJkALCC+
 84mHvsKzUzK+w8X4iJAmp4pwUBf4mKLrf7qMr1v3erYzdi71/qaTCesMKZ++GTQTjPEgiA0K
 LOmOiQMO2YkO8tqO6FJ2RU2zS/LGSaImfDUIU6Dvw19De2em793bSogTWdhS8P2jk60wj7h0
 xX7uevNZ1IIdD51gMQzgHF1bMj7QT4oSmFLLZJdYGItkODdblxSS8Dy6DumXbZLDoA+/XJ7W
Message-ID: <7e1b2b0a-2e52-8f0d-2e17-c3ba9232f8b7@manjaro.org>
Date:   Fri, 24 Aug 2018 18:14:43 +0200
MIME-Version: 1.0
In-Reply-To: <20180822141458.0b6b6af7@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US-large
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

for some reason I am not able to build 4.14.63-rt40 for Manjarolinux.
Even after removing all our custom patches build fails at

  LD [M]  drivers/gpu/drm/drm.o
  AR      drivers/gpu/built-in.o
make: *** [Makefile:1035: drivers] Error 2

My config can be found here for information:
https://gitlab.manjaro.org/packages/community/realtime-kernels/linux414-rt/raw/master/config.rt

Thank you for any advice!
regards
Bernhard

On 22/08/2018 20:14, Steven Rostedt wrote:
> Dear RT Folks,
>
> I'm pleased to announce the 4.14.63-rt40 stable release.
>
>
> This release is just an update to the new stable 4.14.63 version
> and no RT specific changes have been made.
>
> NOTE: There is a known issue with this release. The fix is here:
>
>   http://lkml.kernel.org/r/1534660115.6187.4.camel@gmx.de
>
> I did not apply it to this release because it needs to be added to
> v4.16-rt first before it gets backported. Feel free to apply it
> yourself if you have any concerns.
>
> You can get this release via the git tree at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
>
>   branch: v4.14-rt
>   Head SHA1: da6bee3cef4af60566dc56f3d48fce0b18165107
>
>
> Or to build 4.14.63-rt40 directly, the following patches should be applied:
>
>   http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz
>
>   http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.63.xz
>
>   http://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.63-rt40.patch.xz
>
>
>
>
> Enjoy,
>
> -- Steve
>
