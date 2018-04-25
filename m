Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756129AbeDYSvS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 14:51:18 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:43934 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755371AbeDYSvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 14:51:15 -0400
X-Google-Smtp-Source: AB8JxZqjboaCrl4yewxQehWeMop7occdfQ9Oe9vjRTdzpjtz9uX8ce15HmBmIu1ZTwJIhzP+EjAObFvLjnwPAMTXyok=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <alpine.LRH.2.21.1804260443110.11568@namei.org>
References: <20180423133015.5455-1-dh.herrmann@gmail.com> <alpine.LRH.2.21.1804260443110.11568@namei.org>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 25 Apr 2018 14:51:12 -0400
Message-ID: <CAHC9VhR-V1R2BpCt1aA56q4yT_PWv1kzoWtksbNkm08stcOGPw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Introduce LSM-hook for socketpair(2)
To: James Morris <jmorris@namei.org>
Cc: David Herrmann <dh.herrmann@gmail.com>, linux-kernel@vger.kernel.org,
        teg@jklm.no, Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 2:44 PM, James Morris <jmorris@namei.org> wrote:
> On Mon, 23 Apr 2018, David Herrmann wrote:
>> This patch series tries to close this gap and makes both behave the
>> same. A new LSM-hook is added which allows LSMs to cache the correct
>> peer information on newly created socket-pairs.
>
> Looks okay to me.
>
> Once it's respun with the Smack backend and maybe the hook name change,
> I'll merge this unless DaveM wants it to go in via his networking tree.

Note my objection to the hook placement in patch 2/3; I think we
should move the hook out of the AF_UNIX layer and up into the socket
layer.

-- 
paul moore
www.paul-moore.com
