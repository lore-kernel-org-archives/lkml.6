Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751454AbeBWG2z convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 01:28:55 -0500
Received: from mout.perfora.net ([74.208.4.194]:45113 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750943AbeBWG2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 01:28:54 -0500
Date: Fri, 23 Feb 2018 07:28:33 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <98bfea14-de25-e764-94b4-2f0dd687149a@wwwdotorg.org>
References: <20180222230451.15515-1-marcel@ziswiler.com> <98bfea14-de25-e764-94b4-2f0dd687149a@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] clk: tegra: fix pllu rate configuration
To: Stephen Warren <swarren@wwwdotorg.org>
CC: linux-tegra@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org
From: Marcel Ziswiler <marcel@ziswiler.com>
Message-ID: <5E71CC53-1C99-45FD-9615-D95C88DC085B@ziswiler.com>
X-Provags-ID: V03:K0:rZtui7sdewY5hfIwjKud5oNfVYnIiBMr8llNfrxk4n1w2IW00Fs
 pPkyEDI02M0G6FDvkfKsbK43Dv2LpPTVVqA1yX9r8RXFXgXy5xzHxjdYtIWNbEsD/TlZYnc
 ZX82wZTpqTbbcbOC0UIseTIHIDaW3G+lcAEc/cu6tzKH7h3y7rQHzN5Hxx8Grl18jdj5wVZ
 y6nGnETIp0LkKrrdZhPEA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:S6KOWFypF2s=:pVpVBFY8g1VH7DzMbBHHYZ
 EZzPoVNEuWHtbIiy+mgQagKYnH4N5TZ98+fNeOPoh09bOG6QcDCD/0HMCU4IxLSOTE5onHqe5
 Rd/VPOs0RdJ4l66c63KbdaoSJzbT3Jylr0DCJt8fbIgPg3AbDRbTMoLVBjdEN2slm8kTqJfYx
 OP14rIPnGBn2soClruGdvUnQTM1OodHZZDC+R0ibWSAcTCuXoaidtAzFqOlE4+kd01iXKiYCg
 h52RhejoUZdV0mmNp3Gztar3MZGABsDXwBeGVCbxoRUwa+U1kHX6zNuyaSo6XtLIouc3ogQmi
 +MBqvF0bo6KCFPjgTMcrJaCBiOn3Iiusj6OoSYyoV3c1t3ME+Di/MdXUPiQ0KqTS+phpxi2Vf
 TytOQb0xyuMq0cxGi/W+z5gtQoUUUn7AtKDqVSzIF1iGncA/xEZuUa64Nyk7MhBFd09SmAA+U
 uN1WN7JajBg7az6LuEdKskfdPDTmWU66YlcZM3Kaji7Mo5zRQ8ZNUg4aryigcuC4GCECt1qEn
 edAsk2bAksYEhjtxw00YqBElZIooS++jegI62Q6t8Tz3r7nKJ4btmt3+Qe41yDoIVnCfWkz7Z
 BLauGjMoLJZeKhyEkQVhX4vqKmCZnNy/1+MYYBi+Ylyvv9Zk5tZhOP2We/lozep66EKcBFUL7
 WbTxY7uzSd2o71byYnyJQZ4Y0DrtGiqRBOEpFoKGvtEX9xtSjVw9KM3GtPRyOuSz9uqhA75GK
 4zGa3BC3SXIz4yaJ3cc6zL93yVH7thQWTH8t+okf9e45ibO0UJk04AQrHG0=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On February 23, 2018 12:47:56 AM GMT+01:00, Stephen Warren <swarren@wwwdotorg.org> wrote:
>On 02/22/2018 04:04 PM, Marcel Ziswiler wrote:
>> Turns out latest upstream U-Boot does not configure/enable pllu which
>> leaves it at some default rate of 500 kHz:
>
>I assume this is only because U-Boot just happened not to access any
>USB 
>devices. In other words, if you break into the U-Boot boot flow and 
>explicitly initialize/access USB, then USB works both in U-Boot and in 
>the kernel even without this patch?

Exactly.

> If that's not the case, it seems 
>there's a bug in U-Boot.
>
>Either way, I have no issue with this patch. I just want to make sure 
>there weren't other bugs in U-Boot that needed fixing.

No, rest assured U-Boot is working just fine on the legacy Tegras. The only thing in need of fixing lately was NAND on Colibri T20 and Harmony.
