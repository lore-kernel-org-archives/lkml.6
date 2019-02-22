Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE70C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 05:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93F16207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 05:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVuYMlZG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbfBVFhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 00:37:47 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38591 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbfBVFhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 00:37:47 -0500
Received: by mail-wr1-f68.google.com with SMTP id v13so997889wrw.5;
        Thu, 21 Feb 2019 21:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FS+iAVnKOUuAsS6GDlAurm7gawMprGRMdeUDcdtD8RI=;
        b=JVuYMlZGJKUyRY1AIaRwYdrtndY7jnwN3ZfC4PdOvih5GclFYpYnPulXNegy/rcl7k
         SKxBnbOpVnaDxLk2ulUQaLl9Xi4hWza4EP2+kgrsSA6ObtOYkm+2sTTvg9KzY8n9Si7R
         IfHv/2o6+m3iT6er76wR43uTpsaHQFD+aq99F1Y0iBJ2CS1XjUhCl/pEx7GdTy9KjSJs
         4AnNKcYHerF6ofjmpXFqYtFK1mpoV5TM9+c6CR3tYews/mDoifGRdAluyFzR4Id5iOoQ
         tXODQpSBkOut6d01NIFFzAyf97vcLuzncnKVFsDnAo60+DBlWOf8y2sgf2tfUhNV1Gog
         Krvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FS+iAVnKOUuAsS6GDlAurm7gawMprGRMdeUDcdtD8RI=;
        b=MWi4oGN/N0qxGAJ41/RKScUVsamTMrq7QGXUB4qCJZ4u1sVGpfr2PT7CiIvJnVl4pb
         9aIO6GrkRYb4+Au7SkkbbHulH40trEYUp5r9QTlW7LEXgvveZJVjh6sqVUDa6b57nQFW
         LEGJ/Mb0escUFX3ZL41cyjOXcaAvici/+y+vLtpV79UA4izbdGJOyB413K1OCHYr2AaB
         jX8wbQW9MR+HPYoSdaPAHEbyIkdPdpCvShl6RKZcAh/zUSuHkwL1xzZz9g47/icn472N
         jbYSq7ojPDFPF+j1YBw6pG/LNe37E8hUyqINScI9z5+vWCmHDM/rLkqrJ7SSGwH3kTd0
         KYLg==
X-Gm-Message-State: AHQUAuZSU2Bs18PKzVklhD7+x28enkbp0RBn2CG1JFaPmR1oNRcc+ufm
        oLrfXPx9nEY5Qrc9hqT/h6hxEn0=
X-Google-Smtp-Source: AHgI3IaQVC7+iSyZzrPeNGB801SyDY4tTR8yp8CzbCGD/AVUVFmQ9YoDfM4GjWHaT+XVao2u/VfMaQ==
X-Received: by 2002:a5d:5585:: with SMTP id i5mr1490351wrv.239.1550813865476;
        Thu, 21 Feb 2019 21:37:45 -0800 (PST)
Received: from avx2 ([46.53.241.138])
        by smtp.gmail.com with ESMTPSA id b197sm1273180wmd.23.2019.02.21.21.37.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 21:37:44 -0800 (PST)
Date:   Fri, 22 Feb 2019 08:37:42 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Jeremy Cline <jcline@redhat.com>,
        David Both <dboth@millennium-technology.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc: update i_atime when reading files
Message-ID: <20190222053742.GA4270@avx2>
References: <20190221163714.22330-1-jcline@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190221163714.22330-1-jcline@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 11:37:14AM -0500, Jeremy Cline wrote:
> Prior to commit 1da4d377f943 ("proc: revalidate misc dentries"), the
> access, modify, and change times of files in /proc were just the current
> time.

Ehh, actually no. Doing

	$(which sleep) infinity </proc/foo &

will sabotage atime updates because dentry and inode will be pinned in
caches.

"revalidate misc denries" commit simply makes the effect (much) more
visible by making objects stay in caches for longer.

> Now the mtime and ctime values change mostly as a user would
> expect, but the atime isn't updated when the file read. This patch
> updates the access time of /proc files when they are read.

>  			rv = read(file, buf, count, ppos);
> +			if (rv >= 0)
> +				inode->i_atime = current_time(inode);
> +		}

Maybe it should be done given /proc is virtual so there are no concerns
about scheduling writes noone cares about to the filesystem.
