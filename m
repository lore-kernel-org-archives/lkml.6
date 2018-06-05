Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752133AbeFEMeM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 08:34:12 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:33758 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751718AbeFEMeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 08:34:10 -0400
Date: Tue, 5 Jun 2018 13:34:09 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Ilya Matveychikov <matvejchikov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] ksys_mount: check for permissions before resource
 allocation
Message-ID: <20180605123409.GP30522@ZenIV.linux.org.uk>
References: <D2317950-0DB0-4311-ADB1-FF677B676E04@gmail.com>
 <BD48252B-65D7-4238-BDA2-71BAC1CEA855@gmail.com>
 <20180605112641.GN30522@ZenIV.linux.org.uk>
 <1E519BA2-4198-4255-BAE4-3125C59741A3@gmail.com>
 <20180605115340.GO30522@ZenIV.linux.org.uk>
 <0F38EDA5-DEC3-48A1-9375-47949C26DAE8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0F38EDA5-DEC3-48A1-9375-47949C26DAE8@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 04:07:15PM +0400, Ilya Matveychikov wrote:

> > If you depend upon preventing kmalloc'ed temporary allocations filled
> > with user-supplied data, you are screwed, plain and simple.  It really can't
> > be prevented, in a lot of ways that are much less exotic than mount(2).
> > Most of syscall arguments are copied in, before we get any permission
> > checks.  It does happen and it will happen - examining them while they are
> > still in userland is a nightmare in a lot of respects, starting with
> > security.
> 
> I agree that it’s impossible to completely avoid this kind of allocations
> and examining data in user-land will be the bigger problem than copying
> arguments to the kernel. But aside of that what’s wrong with the idea of
> having the permission check before doing any kind of work?

Presenting that as mitigating a vulnerability.  It's neither better nor worse
in that respect than the original.
