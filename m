Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965542AbeEXIra (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 04:47:30 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:38410 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965497AbeEXIrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 04:47:23 -0400
X-Google-Smtp-Source: AB8JxZrsWCiimQp+iFPN27q4MxKNfppPyWXtK6zUPgtB/2MSN+wpOGhItgKYjtFG898KREbvN64f4/8UUFdFzIZ61nw=
MIME-Version: 1.0
In-Reply-To: <5342a59c-4ca1-2cf5-a1d4-07a6d6f03587@redhat.com>
References: <20180523182404.11433-1-david@redhat.com> <20180523182404.11433-2-david@redhat.com>
 <CAJZ5v0jar8TqC5MGRPcAVZfM3LmmoSV3fT3Sgok=r6D9cDG0+w@mail.gmail.com> <5342a59c-4ca1-2cf5-a1d4-07a6d6f03587@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 24 May 2018 10:47:22 +0200
X-Google-Sender-Auth: uM8WNbRVMjtmNRngYQago_mkvyw
Message-ID: <CAJZ5v0grgYRi24oyFP0xcjip5Z5apLE5ozn8znahdtkqKvD_MA@mail.gmail.com>
Subject: Re: [PATCH RFCv2 1/4] ACPI: NUMA: export pxm_to_node
To: David Hildenbrand <david@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 10:33 AM, David Hildenbrand <david@redhat.com> wrote:
> On 24.05.2018 10:12, Rafael J. Wysocki wrote:
>> On Wed, May 23, 2018 at 8:24 PM, David Hildenbrand <david@redhat.com> wrote:
>>> Will be needed by paravirtualized memory devices.
>>
>> That's a little information.
>>
>> It would be good to see the entire series at least.
>
> It's part of this series (guess you only received the cover letter and
> this patch). Here a link to the patch using it:
>
> https://lkml.org/lkml/2018/5/23/803

OK, thanks!

It looks like you have a reason to use it in there, but please note
that CONFIG_ACPI_NUMA depends on CONFIG_NUMA, so you don't need to use
the latter directly in the #ifdef.  Also wouldn't IS_ENABLED() work
there?

Moreover, you don't need the local node variable in
virtio_mem_translate_node_id().
