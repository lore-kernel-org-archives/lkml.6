Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967452AbeBNL1v (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 06:27:51 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:37325 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967387AbeBNL1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 06:27:49 -0500
Subject: Re: plan9 semantics on Linux - mount namespaces
To: Aleksa Sarai <asarai@suse.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>
References: <0f058286-a432-379b-f559-f2fe713807ab@metux.net>
 <5633d335-3926-d98f-d6d7-948b1e2a0b2c@metux.net>
 <20180213222751.p3fyg7whg6jqlzz5@gordon>
 <39b08c53-3449-3164-c1b1-44ac587dd4ea@metux.net>
 <20180214045442.jyv6zpbwz5glzi4z@gordon>
 <9c097fd9-3035-d5be-a829-fc18e7734f18@metux.net>
 <20180214102410.dxgbayb4i76h5exo@gordon>
From: Enrico Weigelt <lkml@metux.net>
Organization: metux IT consult
Message-ID: <24ddea73-5c84-e098-caae-8a4c14834cbd@metux.net>
Date: Wed, 14 Feb 2018 12:27:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180214102410.dxgbayb4i76h5exo@gordon>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:StrEzz4mTRz/3P/4sRrID3ZA+DpiNOByNTpSP39GOP0f2ZgoFwr
 F2hW56Ht6Lc5B2t54PnUG0xB+TtQG5v0PUe0kysxlwC8fZokS/F/k+1NFlHALq6jo3ewlrx
 BAyL98XHIlUUl3fzmpwIoHF93VrRekV1X6oVYfltsHFts1kGhNdW+a//gx4QU8d5ZLUFRFN
 wsfQDkGnt0okY1cAGezMg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6MT3wZaMOj4=:+exLf7PAAFriRzgWz/rG01
 EAT+hhqqnCEE7homhE/wnh9f2wsheH6/bxgFuJE87fQwA5KvjLhcSzBWs++9blSXIExdtB45F
 xj1DA4aRThsILbAf97GumSxjIulV9zvYYahlYNyUXRvEJuXmvvpwAcKm5Nghi602Ml/KjGjmg
 daC2JAmagsKRS3fsqDTMG7TGS0aH+6PtUImR+BQ+Zj7VADADCGrsd1+qPQtq/XhrtAoz4h/oq
 JIVCOADnKdSBz46q+8qNiBfdDWYh1cNSB4tbI+gyTa5jGMgQa3YqkdGGmySsC1dPHYDDafoeH
 n5qB18bUj+WueoPSmZwWh2kKW6YedM7rGRMPckAPWSSP59KWE6IHU0dSKL+HBfaENmG4QQxCQ
 lmS81dmyl2HyM05518AmSc5CScx+I4pF2Fl0M4rQ8CTR1YzG0f3lwYPNV3ktQiJcEYYyt3AdS
 gmb5UfyGWtriE9m56CFVz2QPx0z9thr6/fAw4Obw3d7JGQRgqP0M8vvGhs/E2kMeuPhnoww57
 AyPef4z4eRgUY1owV8BsPGqusdh+JnxkA0cV0D1HB9LccbO0Y3JQS3anVMVRUVTvOo7rd9lfm
 r3c3IEdENmgp1+l9CBHyVOxE5Y61jXUhwIpnI9WesxOM369sy/KAGrtIb5Vx0Vbkvb4Dl0mFp
 UBcWMTKMdAC2o4k2iuAHBdoTE2Eoc9wkOmhzlF3bZVAhgYEImFozczQ8nI6iXCsDeYwIVmY/3
 kpC+G+EPJ6jCi+v7pS+au1ueETti1XhucRApEK2krQUV2dcNtcDoO8+/RDml4SSe1D7smmZw5
 sUwgj3foKis3Q58axzOUPI5RkhCOJDjChhn9boGDLmx/zv77TSkS1tAYlVzIIEMZh8duRtm
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.02.2018 11:24, Aleksa Sarai wrote:

> What distribution are you using and which release? 

On a self-compiled system.

Forgot to enable namespaces in the kernel. Now it seems to work
as root, but not as an unprivileged user:


daemon@alphabox:~ unshare -r -U
unshare: can't open '/proc/self/setgroups': Permission denied
daemon@alphabox:~ unshare -f -r -U
unshare: can't open '/proc/self/setgroups': Permission denied


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
