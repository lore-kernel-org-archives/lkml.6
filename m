Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967149AbeBNKSV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 05:18:21 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:53105 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966996AbeBNKSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 05:18:20 -0500
Subject: Re: plan9 semantics on Linux - mount namespaces
To: Aleksa Sarai <asarai@suse.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>
References: <0f058286-a432-379b-f559-f2fe713807ab@metux.net>
 <5633d335-3926-d98f-d6d7-948b1e2a0b2c@metux.net>
 <20180213222751.p3fyg7whg6jqlzz5@gordon>
 <39b08c53-3449-3164-c1b1-44ac587dd4ea@metux.net>
 <20180214045442.jyv6zpbwz5glzi4z@gordon>
From: Enrico Weigelt <lkml@metux.net>
Organization: metux IT consult
Message-ID: <9c097fd9-3035-d5be-a829-fc18e7734f18@metux.net>
Date: Wed, 14 Feb 2018 10:18:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180214045442.jyv6zpbwz5glzi4z@gordon>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:woWVlLWVe4V7EQaYtcs8VA1lsh1dNasFFxQjPI/kqMKcoeokmyR
 AEecx7OhOdMVIqxc6O/1aoog+p1qWl/DkKxLqVSSbr1g4MWmKeZ0rvmtXYfQWL8wFtuT4bx
 aEA9zQo/ZkpaClMuv4flpHvtf3V14ERiU8x0c/eHSZxGS1JvFjxLKQxHMptLvG1ckd9cotp
 htoXcps6ePLzCWIFQ8WEw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:N9aoFEuL1J0=:L8NZQwhaZ5wc1MKUzlpcan
 Kd1QWHgBQkqfar4ffpajJeG0a+g8kX/jQK/1DwiNN3/EZ0hQ817dYYKc19VquiAOvmF0TiAAW
 O1MFrnFXgoXwqjGdc4KB4QTUbJ5tyhYcLl5mW6WuK8Ufw/z1nUaJNQ3Pu3GiUX4GSlEenMcV5
 lfcUYKTYlCwrNqaYiugXlVSPOixcT8dSr7/C/HwZbOH0C0DgWVrBY2GawxpTiFrNcFiiDF+4f
 DzTi1xEmkoFgwzl68knGQdCPeRkWRdQhfUeTobFXaxZs6yBGtwYeM3UxY1EtDsT+GGW0jPZ4Q
 xIMgEEiB+yZOIegjjFfjPt2LORzl9NFPj3L2eX9vJAF5yhrrw7TRotZKGXKnz1U+aBK3UmFqo
 NJXrGqLNrYxmCFsSjxrrAiYJ9ZAnJ9/85pj2cwjtGsY19CDiZ4TQZdTgWNz7OK/ckS7vucMsz
 HzdSaBxpzaY0CxOidrU/fe/7qHlt1qnr17HgedhOpWDiQRBOpwyTIXBnqoBFqStjivS+Cz7w3
 pGgeO5SZAvnio22Tw4kGaVsTFSbpvviUymK3N/xtyivWemnijQY28okTZAqoNcObhjP7pgJeL
 KkCLQB3JIAeProgBsWqEULbEj/De2o2G6F6JqG/a2dutzii4trNRsPkSiYxMnWfHJc30q1/B8
 PNHAyo365H2tJHnnD7bzPrPpBpE1eHM8pZAi2PRNXbdBx9xQ9zXh71FP2nyct+nGJSoJuyMfN
 Q9HVbQpUnjbam5p/VimqjhbXOD8P9hguApOEjRdXLzNUXQQpnWO3Dp6vWro=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.02.2018 04:54, Aleksa Sarai wrote:

> It depends how old your kernel is and what distro you use. Arch Linux > disables user namespaces entirely, Debian requires that you set a 
sysctl> to enable unprivileged user namespaces, and RHEL requires you to 
set> both a sysctl and a kernel boot-flag. Also check how old your 
kernel is> (unprivileged user namespace support was added in 3.8).
Just tried on a mainline kernel (4.15). Same problem:

root@alphabox:~ unshare -U -r
unshare: unshare(0x14000000): Invalid argument


root@alphabox:/proc/sys/user cat max_user_namespaces
5922


Am I missing something ?


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
