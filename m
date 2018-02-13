Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966020AbeBMWTx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 17:19:53 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:34941 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965900AbeBMWTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 17:19:52 -0500
Subject: Re: plan9 semantics on Linux - mount namespaces
From: Enrico Weigelt <lkml@metux.net>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <0f058286-a432-379b-f559-f2fe713807ab@metux.net>
Cc: Linux Containers <containers@lists.linux-foundation.org>
Organization: metux IT consult
Message-ID: <5633d335-3926-d98f-d6d7-948b1e2a0b2c@metux.net>
Date: Tue, 13 Feb 2018 22:19:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <0f058286-a432-379b-f559-f2fe713807ab@metux.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:t4V4fBdWLi707Vf0/ed0i+UM0+tnOr6yYKHUHr7chLmRwbVaavY
 R7k3zYGG/3sfaMsXvgEMQgJrLJVsTw1NtB39EpVaYoYSsllhUTLJXDx59h/7IfCX4sJMF+C
 9I/aAs5dvA1c2VafEUQh9FMfh9u4uKwwZUA/kfEY9V1ySZi06JHUTIx+xMR1nQ6ApH9CsJU
 428KXdboQEqHPMiMJww+w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TGf9kgR1LeU=:hkj5QF3meZvVB0WAAVp3la
 DrEmqA1OsdAEFAFNzXGsgJzt84EdtWLZmrnkRYJO3JGhzBVj/Dm9yR9d/p+FoXaGeoqExVcEX
 Lf2NXGQMpmhykerLPZVb5rLtQmndWsvQL8RjkUVlVpEtSHZitq9tYg1mCrGV9/BT+CekZNNNS
 L+FLhe0V0AlGDVYj/MSFZeruEUqZxO56d82sOsWKOyiqVmSa42rKfHDIFDbEOL+SwtEoCNNRH
 RmOk+EqUcobmfybuX8Jqo40YiKav0z8RN6VKqucfNeFTvvBgIzOYY9Fen0FnZnfwZsxkPIG+7
 WTx861/KrZbkUknIkKLkRawoJfPMyNdfeSgX7GySOD4ZiOL2RC4yt0YTvpOudiTT5MgmY/3tM
 KT9l4RzXMvOdIN++yBrwOjuULFd5UV9pwz2CWxXgwSxKEwqUXJvhVP4ZZdVHk2+U18jf94Eo+
 0VxksU1kMpzot7APP9vF3OkXe+ciSV8AgtMewSXaZ31xTwUKP7dHwW6lrDFdByCJcn7/iqzQo
 fbFR/LW9Xcgz1Ca//GPgoC8f+ytaJEPQDlFymM9m5/MYD0CcNjxnVCO7RNYDV/gUNcIUn6iIK
 O6iH13LDDonY2AHHVij9RpHvUHZqnvxjjVrrqqmmO4HQmDlQf2Ay0/cyWgJGwxtbr4qnp6wPR
 vd1For8s51agjJgSkwNs+nBGxvKj3YI0j8KPsVz3Jz3RDV8ppPg7tEbdODlrF/mAX/DpYTqcH
 YjodZrwO4AyDnIBQFKqaIYBsnWRyWStRmsg//MxKtQoNonQJNwey/XopJr8=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.02.2018 22:12, Enrico Weigelt wrote:

CC @containers@lists.linux-foundation.org

> Hi folks,
> 
> 
> I'm currently trying to implement plan9 semantics on Linux and
> yet sorting out how to do the mount namespace handling.
> 
> On plan9, any unprivileged process can create its own namespace
> and mount/bind at will, while on Linux this requires CAP_SYS_ADMIN.
> 
> What is the reason for not allowing arbitrary users to create their
> own private mount namespace ? What could go wrong here ?
> 
> IMHO, we could allow mount/bind under the following conditions:
> 
> * the process is in a private mount namespace
> * no suid-flag is honored (either force all mounts to nosuid or
>    completely mask it out)
> * only certain whitelisted filesystems allowed (eg. 9P and FUSE)
> 
> Maybe that all could be enabled by a new capability.
> 
> 
> any suggestions ?
> 
> 
> --mtx
> 


-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
