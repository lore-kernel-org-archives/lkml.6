Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752867AbeEVVHh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 17:07:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43156 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751575AbeEVVHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 17:07:36 -0400
Date: Tue, 22 May 2018 14:07:35 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "open list:KASAN" <kasan-dev@googlegroups.com>
Subject: Re: [PATCH v2 2/2] kasan: fix memory hotplug during boot
Message-Id: <20180522140735.71dcd92e7b013629a7f15f91@linux-foundation.org>
In-Reply-To: <09c36096-f8c8-b9e9-0bed-113e494f159a@virtuozzo.com>
References: <20180522100756.18478-1-david@redhat.com>
        <20180522100756.18478-3-david@redhat.com>
        <f4378c56-acc2-a5cf-724c-76cffee28235@virtuozzo.com>
        <ff21c6e7-cb32-60d8-abd3-dfc6be3d05f7@redhat.com>
        <09c36096-f8c8-b9e9-0bed-113e494f159a@virtuozzo.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 May 2018 22:50:12 +0300 Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:

> 
> 
> On 05/22/2018 07:36 PM, David Hildenbrand wrote:
> > On 22.05.2018 18:26, Andrey Ryabinin wrote:
> >>
> >>
> >> On 05/22/2018 01:07 PM, David Hildenbrand wrote:
> >>> Using module_init() is wrong. E.g. ACPI adds and onlines memory before
> >>> our memory notifier gets registered.
> >>>
> >>> This makes sure that ACPI memory detected during boot up will not
> >>> result in a kernel crash.
> >>>
> >>> Easily reproducable with QEMU, just specify a DIMM when starting up.
> >>
> >>          reproducible
> >>>
> >>> Signed-off-by: David Hildenbrand <david@redhat.com>
> >>> ---
> >>
> >> Fixes: fa69b5989bb0 ("mm/kasan: add support for memory hotplug")
> >> Acked-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> >> Cc: <stable@vger.kernel.org>
> > 
> > Think this even dates back to:
> > 
> > 786a8959912e ("kasan: disable memory hotplug")
> > 
> 
> Indeed.

Is a backport to -stable justified for either of these patches?
