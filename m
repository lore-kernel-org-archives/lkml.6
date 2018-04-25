Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756161AbeDYTCl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 15:02:41 -0400
Received: from namei.org ([65.99.196.166]:58270 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751084AbeDYTCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 15:02:38 -0400
Date: Thu, 26 Apr 2018 05:02:27 +1000 (AEST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul@paul-moore.com>
cc: David Herrmann <dh.herrmann@gmail.com>, linux-kernel@vger.kernel.org,
        teg@jklm.no, Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: Re: [PATCH 0/3] Introduce LSM-hook for socketpair(2)
In-Reply-To: <CAHC9VhR-V1R2BpCt1aA56q4yT_PWv1kzoWtksbNkm08stcOGPw@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1804260502030.12534@namei.org>
References: <20180423133015.5455-1-dh.herrmann@gmail.com> <alpine.LRH.2.21.1804260443110.11568@namei.org> <CAHC9VhR-V1R2BpCt1aA56q4yT_PWv1kzoWtksbNkm08stcOGPw@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Apr 2018, Paul Moore wrote:

> On Wed, Apr 25, 2018 at 2:44 PM, James Morris <jmorris@namei.org> wrote:
> > On Mon, 23 Apr 2018, David Herrmann wrote:
> >> This patch series tries to close this gap and makes both behave the
> >> same. A new LSM-hook is added which allows LSMs to cache the correct
> >> peer information on newly created socket-pairs.
> >
> > Looks okay to me.
> >
> > Once it's respun with the Smack backend and maybe the hook name change,
> > I'll merge this unless DaveM wants it to go in via his networking tree.
> 
> Note my objection to the hook placement in patch 2/3; I think we
> should move the hook out of the AF_UNIX layer and up into the socket
> layer.

I vote for this as it maintains the intended abstraction of the socket 
API.



-- 
James Morris
<jmorris@namei.org>
