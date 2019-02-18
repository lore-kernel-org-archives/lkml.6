Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD96C10F01
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C2B6217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="wnOwwy3M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732065AbfBRPXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 10:23:24 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:47256 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730229AbfBRPXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 10:23:23 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 538F88EE22B;
        Mon, 18 Feb 2019 07:23:23 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZGqBFOFSp7tp; Mon, 18 Feb 2019 07:23:23 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id C21238EE130;
        Mon, 18 Feb 2019 07:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1550503403;
        bh=G6LDuXetk03iY8UKVD+MdtIkhxvC/jWVnn3QicsYAkA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=wnOwwy3ML6oA7p6voXKAjZgDlEdL0FKx0imumtKz65o5Qv7d95CdOr+lIskc34FQX
         3PyKi2X6l8k7sqqd6AvRlunuzlYRrhrEWvSHd1t2++G+vuOuaDQjCO1PmMgoiswOxm
         SG7v7EJDc2v8hkmwI3L/R9mRKwBF55IymmstWhnA=
Message-ID: <1550503401.2834.1.camel@HansenPartnership.com>
Subject: Re: [PATCH 4.4 091/143] scsi: aic94xx: fix module loading
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Date:   Mon, 18 Feb 2019 07:23:21 -0800
In-Reply-To: <20190218133532.383171387@linuxfoundation.org>
References: <20190218133529.099444112@linuxfoundation.org>
         <20190218133532.383171387@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-02-18 at 14:43 +0100, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me
> know.
> 
> ------------------
> 
> From: James Bottomley <James.Bottomley@HansenPartnership.com>
> 
> commit 42caa0edabd6a0a392ec36a5f0943924e4954311 upstream.
> 
> The aic94xx driver is currently failing to load with errors like
> 
> sysfs: cannot create duplicate filename
> '/devices/pci0000:00/0000:00:03.0/0000:02:00.3/0000:07:02.0/revision'
> 
> Because the PCI code had recently added a file named 'revision' to
> every PCI device.  Fix this by renaming the aic94xx revision file to
> aic_revision.  This is safe to do for us because as far as I can
> tell, there's nothing in userspace relying on the current aic94xx
> revision file so it can be renamed without breaking anything.
> 
> Fixes: 702ed3be1b1b (PCI: Create revision file in sysfs)

jejb@jarvis:~/git/linux> git describe --contains 702ed3be1b1b
v4.10-rc1~94^2~18^2~1

I suppose interface consistency is useful, but under the stable rules,
shouldn't this only be ported as far back as the bug it fixes?

James

