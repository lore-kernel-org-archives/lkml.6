Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752249AbeBHWzr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 17:55:47 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:51301 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751756AbeBHWzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 17:55:45 -0500
X-Google-Smtp-Source: AH8x226Jnabkzoeo8ZAQzbR6QKIUtWwHIzBOG6V8oaPM0mqKCX4RwUTVr2htopp9YyPClelhweCnbFPduLdSw/dLtTg=
MIME-Version: 1.0
In-Reply-To: <20180208.143356.2044831753683027153.davem@davemloft.net>
References: <20180207125320.9103-1-christian.brauner@ubuntu.com>
 <20180207125320.9103-2-christian.brauner@ubuntu.com> <20180208.143356.2044831753683027153.davem@davemloft.net>
From: Christian Brauner <christian.brauner@canonical.com>
Date: Thu, 8 Feb 2018 23:55:43 +0100
Message-ID: <CAPP7u0XPASDL1t5yJ8nGF9jnkxSBowyMWEYvi8m--6DF2s93GA@mail.gmail.com>
Subject: Re: [PATCH net 1/1 v4] rtnetlink: require unique netns identifier
To: David Miller <davem@davemloft.net>
Cc: Christian Brauner <christian.brauner@ubuntu.com>,
        Netdev <netdev@vger.kernel.org>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Stephen Hemminger <stephen@networkplumber.org>, w.bumiller@proxmox.com,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jiri Benc <jbenc@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Ahern <dsahern@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 8, 2018 at 8:33 PM, David Miller <davem@davemloft.net> wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
> Date: Wed,  7 Feb 2018 13:53:20 +0100
>
>> Since we've added support for IFLA_IF_NETNSID for RTM_{DEL,GET,SET,NEW}LINK
>> it is possible for userspace to send us requests with three different
>> properties to identify a target network namespace. This affects at least
>> RTM_{NEW,SET}LINK. Each of them could potentially refer to a different
>> network namespace which is confusing. For legacy reasons the kernel will
>> pick the IFLA_NET_NS_PID property first and then look for the
>> IFLA_NET_NS_FD property but there is no reason to extend this type of
>> behavior to network namespace ids. The regression potential is quite
>> minimal since the rtnetlink requests in question either won't allow
>> IFLA_IF_NETNSID requests before 4.16 is out (RTM_{NEW,SET}LINK) or don't
>> support IFLA_NET_NS_{PID,FD} (RTM_{DEL,GET}LINK) in the first place.
>>
>> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
>
> Applied, thanks Christian.

Thanks for applying, David.
