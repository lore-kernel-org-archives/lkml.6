Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752878AbeA3UIx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 15:08:53 -0500
Received: from www62.your-server.de ([213.133.104.62]:48120 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752854AbeA3UIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 15:08:52 -0500
Subject: Re: net: hang in unregister_netdevice: waiting for lo to become free
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>, David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        netdev <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Dan Streetman <ddstreet@canonical.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
References: <CACT4Y+ZyUxeUqEB7q1EHcs4j93mtk9UOBuYhJtcnnc8AfApoLw@mail.gmail.com>
 <CAM_iQpVo0iSXKSR=Qc+7syn77BnhE2R72M2u5YfJF=fBkJHjsw@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <7fd7e3b3-77b1-0936-b169-d08b946bedc7@iogearbox.net>
Date: Tue, 30 Jan 2018 21:08:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAM_iQpVo0iSXKSR=Qc+7syn77BnhE2R72M2u5YfJF=fBkJHjsw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/30/2018 07:32 PM, Cong Wang wrote:
> On Tue, Jan 30, 2018 at 4:09 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
>> Hello,
>>
>> The following program creates a hang in unregister_netdevice.
>> cleanup_net work hangs there forever periodically printing
>> "unregister_netdevice: waiting for lo to become free. Usage count = 3"
>> and creation of any new network namespaces hangs forever.
> 
> Interestingly, this is not reproducible on net-next.

The most recent change on netns refcnt was 4ee806d51176 ("net: tcp: close
sock if net namespace is exiting") in net/net-next from 5 days ago, maybe
fixed due to that?
