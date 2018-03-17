Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-189300-1521249405-2-9218394320191288265
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521249404; b=LWjO7rc/icp3Q8xoJRbfbjUrRm5eY7+/ARRq1RbpWkoZY7i
    hZvyhKFPgQIUeh85RYMkKNJ6imNV2gROkdJCULzt6EEzse6Ztc44qlib0Mich3Z3
    Xt273lPienzVqUBFghZUgaXbjNq2iqPbNXGmUHk4KWh85ZIE4LQ1MrNnWYE7xz6j
    2xi+/fSPdk+94uUuJQWodFL4ZAhUbH4KBNWkf2cmjPOkPrf2HySeidqZ8WA/Qxgj
    SdDsmwXp7gU+NMzF71EJyHd1kQoqw2wuJfSyR4zZ9kR8VUE1Ci85P3/tdhsTaEE4
    cKxj/N41H+tlNnL1hO04guE6ylz8uBuJZg0HAGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1521249404; bh=eivOtxyGfItuGmu/odzvOd8rujIuqI3AlrDfL+
    OG2Ts=; b=uH3pSs9FixyTr9Ti3ZCATgIlx/KTHJlulJpvWcWRLVcG+GbIHQ/bfg
    LuMKFV8VOxA4697hFFjlc1kaz5a+WMDrcj/HQ5t5W1bnWFLiQVXm/y4OwvhSv0E3
    3n3gdO9ehrRTNGyHiO37WoY5+likaX7PjucjW0qw5WUhRbw+oPd6ptnWFtGnP83T
    ccxb28mhoxFQU9URr3rXSWjnWvNqASASIC09hPR7mNkArER9y6XutIyTxBUHwXlC
    EB4MKBwX77IEVPj9lqLR7rUo/+x7vVrVFDD0tcL0kFuts34Ch5EfACGKnl/aHgv1
    /hu7KjuaS+HW1QOX1J2BjZMGNF4aDuuw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b=dDmuhO6r x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ILbP+vsE;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b=dDmuhO6r x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ILbP+vsE;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751917AbeCQBQl (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 21:16:41 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:33508 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751437AbeCQBQk (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 21:16:40 -0400
X-Google-Smtp-Source: AG47ELt1JPwl0CUr6pZfpgYFd6suAhMTtM/yJQQ6tC7l0Kn7YA+MZJeKn4iuD59FvHpDjydNfp+vMzkV52QTLxu853w=
MIME-Version: 1.0
In-Reply-To: <152116964416.8343.514895686858363582.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <152116964416.8343.514895686858363582.stgit@dwillia2-desk3.amr.corp.intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 16 Mar 2018 18:16:39 -0700
Message-ID: <CAPcyv4iLs7rdTxA19Syp4stQSfKbDYP912dD01_e_1QMnf3FkQ@mail.gmail.com>
Subject: Re: [PATCH] acpi, numa: fix pxm to online numa node associations
To: linux-nvdimm <linux-nvdimm@lists.01.org>
Cc: stable <stable@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Toshi Kani <toshi.kani@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

[ adding Toshi's correct address ]

On Thu, Mar 15, 2018 at 8:08 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> Commit 99759869faf1 "acpi: Add acpi_map_pxm_to_online_node()" added
> support for mapping a given proximity to its nearest, by SLIT distance,
> online node. However, it sometimes returns unexpected results due to the
> fact that it switches from comparing the PXM node to the last node that
> was closer than the current max.
>
>     for_each_online_node(n) {
>             dist = node_distance(node, n);
>             if (dist < min_dist) {
>                     min_dist = dist;
>                     node = n;   <---- from this point we're using the
>                                       wrong node for node_distance()
>
>
> Fixes: 99759869faf1 ("acpi: Add acpi_map_pxm_to_online_node()")
> Cc: <stable@vger.kernel.org>
> Cc: Toshi Kani <toshi.kani@hp.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
> Rafael, I can take this through the nvdimm tree with your ack. I have a
> few other nvdimm fixes pending for 4.16.
>
>  drivers/acpi/numa.c |   10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
> index 8ccaae3550d2..85167603b9c9 100644
> --- a/drivers/acpi/numa.c
> +++ b/drivers/acpi/numa.c
> @@ -103,25 +103,27 @@ int acpi_map_pxm_to_node(int pxm)
>   */
>  int acpi_map_pxm_to_online_node(int pxm)
>  {
> -       int node, n, dist, min_dist;
> +       int node, min_node;
>
>         node = acpi_map_pxm_to_node(pxm);
>
>         if (node == NUMA_NO_NODE)
>                 node = 0;
>
> +       min_node = node;
>         if (!node_online(node)) {
> -               min_dist = INT_MAX;
> +               int min_dist = INT_MAX, dist, n;
> +
>                 for_each_online_node(n) {
>                         dist = node_distance(node, n);
>                         if (dist < min_dist) {
>                                 min_dist = dist;
> -                               node = n;
> +                               min_node = n;
>                         }
>                 }
>         }
>
> -       return node;
> +       return min_node;
>  }
>  EXPORT_SYMBOL(acpi_map_pxm_to_online_node);
>
>
