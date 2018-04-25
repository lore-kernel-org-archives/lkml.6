Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752219AbeDYVI1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 17:08:27 -0400
Received: from mout.gmx.net ([212.227.17.20]:39997 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751569AbeDYVIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 17:08:23 -0400
Subject: Re: [PATCH 22/22] parisc: use generic dma_noncoherent_ops
To: Christoph Hellwig <hch@lst.de>
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
        Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-hexagon@vger.kernel.org, linux-m68k@vger.kernel.org,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180420080313.18796-1-hch@lst.de>
 <20180420080313.18796-23-hch@lst.de>
 <e0b4f3be-68b9-c3af-e432-fd20419e2d70@gmx.de> <20180425072105.GA12308@lst.de>
From: Helge Deller <deller@gmx.de>
Message-ID: <84d9e1ac-86c3-6f2e-377f-2be44783b933@gmx.de>
Date: Wed, 25 Apr 2018 23:07:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180425072105.GA12308@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:wq8qm8fnDmtjl1RJ/c9wqUG9WGQC4zJhUgZvND2ybWW/ht8/tzH
 Fmm7U3J5dxJT5gCmWLc6PN8XmxC8am7DOfls6El4jOxzBpgaE07lAVUdBWpL4UwlvE1nvuQ
 Bva1ECQCkXWis9YFBzdrrQE0CHx7uB8mZrLd0DhjcXNCOPqjdyS+66tyZHjIZ0VAHt4EP2m
 7ccFmyyBZw/IyQNlXuWdQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hrdpd07IxKM=:qAKZE4f58vqhOpnbNS0EL+
 dgpOOw2eK47e/7dGNWy6b0sRNhkjib72nhfJIybMERArCQBX3fEEcRwryFclOze/xp5T+tW2W
 eG1QRaHE+A4M1JtZdmhXjfvIzKL008aPZPF/zdAMiVVfv+USvvIbj//fw58+hFpB1oB3UoTee
 QpiRoFTvpvyQYQmL5XbODTZRYVUjQpJODk7LnCeDZtM/MjHqKF85Qf6mffPfDBnWwuBFXA43p
 /UE/bcvQDeCj5WU8vUqPwTraOvE0IIJ98iJXpIBPdlC42s6bUOeAwRPPztHrY4HaR1pcBwlPm
 bVuufZguILXh+KIKgISYbeUVLLX2Orip59jxSp9ijETtYNTQ8PiczN0QJ875mPp69LAdkBzn0
 aA+dHWq5rcZADZefCUxEViRVHBAcvWRcWsGCHVdHERjGXMu6TyJrNXgq/sPI7jgFuD9Oj/Usa
 AQP5zyIh5d2BKMQfVmjVTm5gMbdJsXSkWUSjbHPvqnAJC0k5XOViYjoqylwT7JHsspS4Kiioj
 LNtMkaQjLdINHq8iB6kKTNPoMC3ny0kNIKwVQ/qkMvTW96gti4xwXC51kkOUIg/VCWwS6mE1H
 YzZ9w3HDkzqA5xQ6J2o1D+FXewAVo6ru2XiNgHOXek2oeKnZUwiVobNDbY0lnF3n4oZAh6aoy
 7yd2bYf1t4JNNYi4qaCfcyQWX7FnZkfVv83f5cNoJirUmwqqftbUvzsgnjzpikkApIZ6heNcA
 QCSduKf3nK2gpXcPh9rLfdY9uxmCUhsb8OF+Hj67IOma8y6FUZbidsQoaaoocP7VCmHkp+ITR
 ej2ORnrQrk026YYs+dgloWvJWp5yJ0oSqD+q/AcgWpn5xyqa0M=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.04.2018 09:21, Christoph Hellwig wrote:
> On Sat, Apr 21, 2018 at 07:43:46PM +0200, Helge Deller wrote:
>> This patch breaks a 32bit kernel on a B160L machine (PA7300LC CPU, "pcxl2").
>> After applying this patch series the lasi82956 network driver works unreliable. 
>> NIC gets IP, but ping doesn't work.
>> See drivers/net/ethernet/i825xx/lasi_82596.c, it uses dma*sync() functions.
> 
> Just to confirm:  Without the series it is known to actually work?

Yes.
I reverted this series from my tree, rebuilt, and then the issue was gone.
I won't be able to test again earlier than next week.

Helge
