Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965239AbeEXIMg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 04:12:36 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:45628 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965201AbeEXIMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 04:12:31 -0400
X-Google-Smtp-Source: AB8JxZriSFD1xyIB6lgQc4tDhupf8F9yGKyhEP2/aSJVdk5sxfBx8Ll/oNHuVpym4pT3vl8N+SClVoVb2LIVboLkFbQ=
MIME-Version: 1.0
In-Reply-To: <20180523182404.11433-2-david@redhat.com>
References: <20180523182404.11433-1-david@redhat.com> <20180523182404.11433-2-david@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 24 May 2018 10:12:30 +0200
X-Google-Sender-Auth: D8OJnKQZbwrHnFuIoI7pFGJzGNo
Message-ID: <CAJZ5v0jar8TqC5MGRPcAVZfM3LmmoSV3fT3Sgok=r6D9cDG0+w@mail.gmail.com>
Subject: Re: [PATCH RFCv2 1/4] ACPI: NUMA: export pxm_to_node
To: David Hildenbrand <david@redhat.com>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 8:24 PM, David Hildenbrand <david@redhat.com> wrote:
> Will be needed by paravirtualized memory devices.

That's a little information.

It would be good to see the entire series at least.

> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/acpi/numa.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
> index 85167603b9c9..7ffee2959350 100644
> --- a/drivers/acpi/numa.c
> +++ b/drivers/acpi/numa.c
> @@ -50,6 +50,7 @@ int pxm_to_node(int pxm)
>                 return NUMA_NO_NODE;
>         return pxm_to_node_map[pxm];
>  }
> +EXPORT_SYMBOL(pxm_to_node);

EXPORT_SYMBOL_GPL(), please.

>
>  int node_to_pxm(int node)
>  {
> --
