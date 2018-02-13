Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965967AbeBMWMc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 17:12:32 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:58203 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965931AbeBMWMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 17:12:30 -0500
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Enrico Weigelt <lkml@metux.net>
Subject: plan9 semantics on Linux - mount namespaces
Organization: metux IT consult
Message-ID: <0f058286-a432-379b-f559-f2fe713807ab@metux.net>
Date: Tue, 13 Feb 2018 22:12:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:I0IX5rhJP32igtPkv8T6JWV8CKMvUz2TMRTqme7fFA1OmwIl7dJ
 DqrbhPBum60DGFrBVUJaHl/Rd+KP0MDeidnpHBbFNgSUplsBxZcHfsQIRyRhDrAaMxp3LNo
 IbWRzFjNGtMl6Pas9EAcPbOuvjcWzJNuWxlDTnM8BZjREy477YHBgF6tH2mRKxxjD3Pj78G
 2Sc1duXgA33PmhafsDN4A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HwYWBb3hvnM=:VOV5WlMaMvKONsw3W4D/Lb
 uRdnBQEKzscYsFchdA9BNeMmo1WzmnatQrrIcTg3Ye0XScfE9b37keRo/VAu4a7c7KMsArcoB
 4WaNAKo20Y03mNsl9Ot4TDqtSi3wlCymYgwkoQfCRHoAjmqNPoY9zG0XyQZutgKQ+KwIDxW3G
 Hw26ZtxJTnj8uUGimygx7dgwb0gcTT5VMXGVvn90fnrIJ3WrAjQXU3Jb1y1ofotm0Lxx9zI7C
 wnz0h9PRII4wHv2n5JOGqNLka1Tp22YZWML6szmIKRLfy+HTsJtMHEujOZus6Yfddh1QAlgK9
 0lZGkxOh5s+K8tdJ/z8KXF8n3m1pGp0s9iaNVQB90WixMJs4Vlxyfcolf9I84JuCIulRcezXf
 QUcgiZDNqRdECcpcpozMdWVcTJSGC7xu4nwYWYhP2l4kVzc6GEWLPUUPUV866fmwWrz1VO7i7
 jJLuxryJxfqnbI3rz3v4sPfQoqbE5nfSrSVyw1l4KBHFitmvffZf3fcBYROJSIdBfUfll63Ay
 gEEfJMzM+j96ztq8Wsg1/HiHJRt0+X1qZi8z5JdfaUa+xMimC+JWT24XkRY+ML7XE2FO+x/MF
 Ybc441f4hKElA8k4Ar6zm+0KlPxGXRwcUqPn2vKk6QTAoXKLJqt2MFQefRyPnrulzVtNRA34M
 P1nHNNJKQ1reMrI2LcGUIs071YGV+yk3JGbq63vWIaY8TT22zzpKVWorwyVtNLX0pnoCQQaSO
 OJDcnAeG0esf1yptEYMXG9IGnP/P3e9kfjBCFNR+PpHV+82gv0+OIegx0shtqgW/uJY+CNU9X
 jNSis0QEYgu5jEkyYkZMcRFVh5zdVXtDvPC0IWmvbwzMAgU9isSuECjlA3nFGxuUiqtTM2G7K
 gSqBTQZ2h8lLaeKhteqIf8IImlbRGeD16+nHaCt0OCFIyUAOishZU2/iRvkSnw4g6njxychBl
 SBqmzSe5BrA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,


I'm currently trying to implement plan9 semantics on Linux and
yet sorting out how to do the mount namespace handling.

On plan9, any unprivileged process can create its own namespace
and mount/bind at will, while on Linux this requires CAP_SYS_ADMIN.

What is the reason for not allowing arbitrary users to create their
own private mount namespace ? What could go wrong here ?

IMHO, we could allow mount/bind under the following conditions:

* the process is in a private mount namespace
* no suid-flag is honored (either force all mounts to nosuid or
   completely mask it out)
* only certain whitelisted filesystems allowed (eg. 9P and FUSE)

Maybe that all could be enabled by a new capability.


any suggestions ?


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
