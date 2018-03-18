Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1076671-1521410127-2-11319151035707373613
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521410127; b=F6XY8T6UaGweI/7u+FhZwISeAw1jIr1R7Vb5Ls1sRm6VKDu
    lI+JuV2xLNMrn9pDZZOkf3Yx1V/UlyqlPUZc+kKKMlb7mLyNRyliRwY9aPu3tdo+
    9ejoUymU1thO0eWkr+B3c4IrW3oleSZ2dGT3nt1ALZzj6rfQo9YwJGeR55PIuStI
    3VeRFW9ySZnspMu3OacXma4XFfd/MU7Tt5f81VBW/IhpBcaeAdThV8uvnSWoB0nQ
    ss2BJuvjmyOCMjNpwJIQ/DtaJvlC5Ji+dW3mHixb22zk2GbdZ0rYibjvRpGMfsxX
    d26RCldjqlvAIh8AKfxJLbz88jqcbMDxsR2GURA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1521410127; bh=KYe6Thnj/chYt8paxgCAFAnTirkCoO2c20ir31
    cUdQ4=; b=VhAiUMy1+MCb4yt7vz5hKO+JxEIk+QXsD2FYM7HKEIZDHic/HjVmu2
    ZRwO56cLx1Kv0BUDZYpLLjZ726KVKUyjT4WqlbJ+iLz8ySos20Z3O8fPc7MxZSqn
    IqVrR5fcSTrbD8t1dIj5glNTjyzLXgDhXiuqua4//lqoucfbeP9IGHcRixLZoU4a
    q3TNaIezQlHJvUPKyHyV+cVhkgLD6bn8T2DE5j9HJEzt7qLpqeKFpDCncRogWfUA
    yK9A4DrhwmXyrexcQoUfsLfcNEZgTd4gCMA8AciKUBTem3eNmjIK1eIjkY4MvUGB
    jlag28LKH6CLMd5yIXH+bSFZQJeJTM3g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=dQoxtPMD x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=sfWH5eLe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=dQoxtPMD x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=sfWH5eLe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754625AbeCRVzM (ORCPT <rfc822;greg@kroah.com>);
        Sun, 18 Mar 2018 17:55:12 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:33373 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754304AbeCRVzL (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 18 Mar 2018 17:55:11 -0400
X-Google-Smtp-Source: AG47ELsWfyKqNYmSCt7G7twLIlr2dz8Mmbwx4U5TrJ3cJzV3DUdxFK/30W2ZPr+T59KgFefG1L7tenXxp6CF6oNGcZc=
MIME-Version: 1.0
In-Reply-To: <152116964416.8343.514895686858363582.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <152116964416.8343.514895686858363582.stgit@dwillia2-desk3.amr.corp.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sun, 18 Mar 2018 22:55:10 +0100
X-Google-Sender-Auth: -GUrthSlcWLq7MQu-QONYtt6XDc
Message-ID: <CAJZ5v0hEnxFfH4cXqTXKqS+w2uGgiZze4TeS5FgqwrwuBb1R2w@mail.gmail.com>
Subject: Re: [PATCH] acpi, numa: fix pxm to online numa node associations
To: Dan Williams <dan.j.williams@intel.com>
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        Stable <stable@vger.kernel.org>, Toshi Kani <toshi.kani@hp.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 16, 2018 at 4:08 AM, Dan Williams <dan.j.williams@intel.com> wrote:
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

OK

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

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
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
