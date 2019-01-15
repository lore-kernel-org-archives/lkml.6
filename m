Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2201C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 00:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C62E820578
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 00:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfAOAYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 19:24:02 -0500
Received: from ms.lwn.net ([45.79.88.28]:38538 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbfAOAYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 19:24:02 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 24B1C2E5;
        Tue, 15 Jan 2019 00:24:02 +0000 (UTC)
Date:   Mon, 14 Jan 2019 17:24:01 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Christian Brauner <christian@brauner.io>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] Documentation/filesystems: add binderfs
Message-ID: <20190114172401.018afb9c@lwn.net>
In-Reply-To: <20190111134100.24095-1-christian@brauner.io>
References: <20190111134100.24095-1-christian@brauner.io>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jan 2019 14:40:59 +0100
Christian Brauner <christian@brauner.io> wrote:

> This documents the Android binderfs filesystem used to dynamically add and
> remove binder devices that are private to each instance.
> 
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

Two quick notes:

> ---
> /* Changelog */
> v1:
> - switch from *.txt to *.rst format
> ---
>  Documentation/filesystems/binderfs.rst | 70 ++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/filesystems/binderfs.rst

You didn't add it to index.rst, so it won't actually become part of the
docs build.

> diff --git a/Documentation/filesystems/binderfs.rst b/Documentation/filesystems/binderfs.rst
> new file mode 100644
> index 000000000000..74a744b42db7
> --- /dev/null
> +++ b/Documentation/filesystems/binderfs.rst
> @@ -0,0 +1,70 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +The Android binderfs Filesystem
> +===============================
> +
> +Android binderfs is a filesystem for the Android binder IPC mechanism.  It
> +allows to dynamically add and remove binder devices at runtime.  Binder devices
> +located in a new binderfs instance are independent of binder devices located in
> +other binderfs instances.  Mounting a new binderfs instance makes it possible
> +to get a set of private binder devices.
> +
> +Mounting binderfs
> +-----------------
> +
> +Android binderfs can be mounted with:
> +
> +::

This can be more readably formatted as:

	Android binderfs can be mounted with::

I've applied the patches, taking the liberty of fixing both of those
things up.  Thanks!

jon
