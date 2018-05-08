Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932460AbeEHOXQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 10:23:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:44948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932354AbeEHOXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 10:23:15 -0400
Date: Tue, 8 May 2018 11:23:11 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCH] perf: test 60 fails on s390 inline missing on s390
Message-ID: <20180508142311.GF13491@kernel.org>
References: <20180503065837.71043-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180503065837.71043-1-tmricht@linux.ibm.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, May 03, 2018 at 08:58:37AM +0200, Thomas Richter escreveu:
> perf test 60: probe libc's inet_pton & backtrace it with ping
> fails on 4.17.0rc3. It turned out that function __inet_pton
> is reported as inline:
> 
> [root@s8360047 perf]# ./perf script -i /tmp/perf.data.111
> ping 12457 [000]  1584.478959: probe_libc:inet_pton: (3ffb5a347e8)
>                   1347e8 __inet_pton (inlined)
>                    f19d7 gaih_inet.constprop.5 (/usr/lib64/libc-2.24.so)
>                    f4c3f __GI_getaddrinfo (inlined)
>                     410b main (/usr/bin/ping)
> 
> Allow __inet_pton listed as inline.

Thanks, applied,

- Arnaldo
