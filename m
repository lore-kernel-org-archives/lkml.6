Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342D2C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 034D2206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BXGRaKI2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfANQyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 11:54:10 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40201 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbfANQyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 11:54:09 -0500
Received: by mail-pl1-f193.google.com with SMTP id u18so10398940plq.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 08:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kodeNV6E0BiVHtTgfRjZXsJv1BXwC9SiHJb9CnuMytM=;
        b=BXGRaKI2lF2ZuiAZrnSGt6H9H545+0wb+yGLDMVhdli3qwelHIxtmzCq5V9ne6DlAE
         f/n7xJ7AH4YLpXozUMwoMYY2NM7EcFCS+Dh2bCNcjnOSWHr6E0dlAx04b3/vi1st0Eid
         FUpZzsSq7ex/1fOFunzmf1UcrG/6MgCUmAEvMjfRfExAdRezw7uyVI/7xWtLF8bwF4Ca
         U0MeSjBDi26B5AAXzcC/K2DXitpDrz2N4R+DkMvvpTC3HmlmOlZMKuSQTNIlnJKxmlq8
         S/oinKHWn9sU3fB34CCm5d3KbfUzARvrBqqGwkvYICa8a5uCYMMasxBO54BP93XGdsIy
         g6hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kodeNV6E0BiVHtTgfRjZXsJv1BXwC9SiHJb9CnuMytM=;
        b=VRuotMTrwcenjpsMOk+MdPujQN5VB5WnBj9SlsPNz+y5PWAztwNpRrIENehmWzPsLM
         lx6tnAnkwklKrsrxOODvpqiTvyYuOVdRDMg69B7pdrUzk8Z3WTabXwSm5u3L+oSvcACX
         aRB0kpGdJ7Js/ADYrSDfSnJ1hCZeUQxwPpjFXTjlpYQisNxlaoXD0lkjvvfv6WFqPfQf
         sOxFl2+wrdmXO9E+p15rtDIVVr1xMsb6+LFqeC398QOkLjbY1wJMgwHeCJ6CpEq8B8JR
         UoLPUwOJ8N8l5Mq631O0UL+iCrdRjsWLaelDlDPhBW2rKG9AyKbblKCBYZPUvNJvZRXu
         BMpw==
X-Gm-Message-State: AJcUukcUjCGCQGjvLgwXlTzO6bqs1AqHLh4DQV2GeTv6ZlRGt5fhlISa
        KQYNEggVheQymyuaE4z1zZVHsw==
X-Google-Smtp-Source: ALg8bN7mZ3NDkAaPn/FlR3h8DT8nbmKGoKjPaEKJUi6m8MEtLxB6arijuTGBk7z03qJSvlJJs4O/gQ==
X-Received: by 2002:a17:902:b090:: with SMTP id p16mr17313414plr.190.1547484848549;
        Mon, 14 Jan 2019 08:54:08 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id e23sm1269257pfh.68.2019.01.14.08.54.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 08:54:07 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gj5V0-0006iE-NW; Mon, 14 Jan 2019 09:54:06 -0700
Date:   Mon, 14 Jan 2019 09:54:06 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Joel Nider <joeln@il.ibm.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] docs-rst: update index file with infiniband docs
Message-ID: <20190114165406.GC22910@ziepe.ca>
References: <1547456451-7102-1-git-send-email-joeln@il.ibm.com>
 <1547456451-7102-3-git-send-email-joeln@il.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547456451-7102-3-git-send-email-joeln@il.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 11:00:50AM +0200, Joel Nider wrote:
> Link the previously converted Documentation/infiniband/user_verbs.rst
> to the main index by creating a new subsystem (Infiniband) under the
> root document. This manifests as a new section under "Kernel API
> Documentation" in the index.html, as well as a new section in the
> table of contents pane.
> 
> This has been tested with 'make htmldocs'.
> ---

Missed signed-off-by

>  Documentation/conf.py              |  2 ++
>  Documentation/index.rst            |  1 +
>  Documentation/infiniband/conf.py   | 10 ++++++++++
>  Documentation/infiniband/index.rst |  9 +++++++++
>  4 files changed, 22 insertions(+)
>  create mode 100644 Documentation/infiniband/conf.py
>  create mode 100644 Documentation/infiniband/index.rst
> 
> diff --git a/Documentation/conf.py b/Documentation/conf.py
> index 72647a3..ff71088 100644
> --- a/Documentation/conf.py
> +++ b/Documentation/conf.py
> @@ -389,6 +389,8 @@ latex_documents = [
>       'ext4 Data Structures and Algorithms', 'ext4 Community', 'manual'),
>      ('gpu/index', 'gpu.tex', 'Linux GPU Driver Developer\'s Guide',
>       'The kernel development community', 'manual'),
> +    ('infiniband/index', 'infiniband.tex', 'Infiniband subsystem',
> +     'The kernel development community', 'manual'),
>      ('input/index', 'linux-input.tex', 'The Linux input driver subsystem',
>       'The kernel development community', 'manual'),
>      ('kernel-hacking/index', 'kernel-hacking.tex', 'Unreliable Guide To Hacking The Linux Kernel',
> diff --git a/Documentation/index.rst b/Documentation/index.rst
> index c858c2e..8d91ea5 100644
> --- a/Documentation/index.rst
> +++ b/Documentation/index.rst
> @@ -82,6 +82,7 @@ needed).
>     core-api/index
>     media/index
>     networking/index
> +   infiniband/index
>     input/index
>     gpu/index
>     security/index
> diff --git a/Documentation/infiniband/conf.py b/Documentation/infiniband/conf.py
> new file mode 100644
> index 0000000..dc42d33
> --- /dev/null
> +++ b/Documentation/infiniband/conf.py
> @@ -0,0 +1,10 @@
> +# -*- coding: utf-8; mode: python -*-
> +
> +project = "Linux Infiniband Documentation"
> +
> +tags.add("subproject")
> +
> +latex_documents = [
> +    ('index', 'infiniband.tex', project,
> +     'The kernel development community', 'manual'),
> +]
> diff --git a/Documentation/infiniband/index.rst b/Documentation/infiniband/index.rst
> new file mode 100644
> index 0000000..2dedc65
> --- /dev/null
> +++ b/Documentation/infiniband/index.rst
> @@ -0,0 +1,9 @@
> +Infiniband Documentation
> +========================
> +
> +Contents:
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   user_verbs
> -- 
> 2.7.4
> 
