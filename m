Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752045AbeDDPmO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 11:42:14 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:34971 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751780AbeDDPmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 11:42:12 -0400
X-Google-Smtp-Source: AIpwx49+8OXKIHDImsGTVk1y5Y2FCdWLe4aCVmhMh/fS8J5PTXRvVawQjxyVhYATQJCT8cj55EntFmQXTJKSnPp6uiA=
MIME-Version: 1.0
In-Reply-To: <5181fd00-1943-6e76-ea18-1d3951dd9b58@cumulusnetworks.com>
References: <20180404121347.3089169-1-arnd@arndb.de> <5181fd00-1943-6e76-ea18-1d3951dd9b58@cumulusnetworks.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 4 Apr 2018 17:42:11 +0200
X-Google-Sender-Auth: ApcuqXNOQFGahIp4980VjNPxtOo
Message-ID: <CAK8P3a2LubLXqX8ZUrHCYq0KksgJatJVMW-x5n7vCKZ=-NEFAw@mail.gmail.com>
Subject: Re: [PATCH] netdevsim: remove incorrect __net_initdata annotations
To: David Ahern <dsa@cumulusnetworks.com>
Cc: Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S. Miller" <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 4, 2018 at 5:33 PM, David Ahern <dsa@cumulusnetworks.com> wrote:
> On 4/4/18 6:12 AM, Arnd Bergmann wrote:
>> The __net_initdata section cannot currently be used for structures that
>> get cleaned up in an exitcall using unregister_pernet_operations:
>>

>
> I am confused ... I do the same thing in the VRF driver and that code
> has been there since June 2017.

I don't see any exit call in that driver, the only caller of
unregister_pernet_operations() there is in the init function itself,
and the module cannot be removed.

     Arnd
