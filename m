Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751713AbeCWCGJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 22:06:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38374 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751551AbeCWCGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 22:06:08 -0400
Date: Thu, 22 Mar 2018 19:06:06 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        takahiro.akashi@linaro.org, ebiederm@xmission.com, vgoyal@redhat.com,
        dyoung@redhat.com, prudo@linux.vnet.ibm.com
Subject: Re: [PATCH 1/2] resource: add walk_system_ram_res_rev()
Message-Id: <20180322190606.859a0f1c7e2d1b2958daeb9f@linux-foundation.org>
In-Reply-To: <20180323005845.GA25740@localhost.localdomain>
References: <20180322033722.9279-1-bhe@redhat.com>
        <20180322033722.9279-2-bhe@redhat.com>
        <20180322152929.9b421af2f66cc819ad691207@linux-foundation.org>
        <20180323005845.GA25740@localhost.localdomain>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Mar 2018 08:58:45 +0800 Baoquan He <bhe@redhat.com> wrote:

> > erk, this is pretty nasty.  Isn't there a better way :(
> 
> Yes, this is not efficient.
> 
> In struct resource{}, ->sibling list is a singly linked list. I ever
> thought about changing it to doubly linked list, yet not very sure if
> it will have effect since struct resource is a core data structure.

Switching to a list_head sounds OK.  The only issue really is memory
consumption and surely we don't have tens of thousands of struct
resources floating about(?).  Or if we do have a lot, the machine is
presumably huge (hope?).

> AKASHI's method is more acceptable, and currently only kexec has this
> requirement.

What method is that?
