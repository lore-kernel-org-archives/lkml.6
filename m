Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6CDC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 06:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D93B21852
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 06:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545202585;
	bh=tlu7Xwb1hzDYyqD2tgUdoFaFpTrj9P7NqlkTHs3BliA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kLtjOR7Hw21nVXYDbWcKd5ysolt0C6PjjTF0/u8Nnl2J4Pd82NzRzJRQCsTyfVQOL
	 /c6gKD3jfhb8CARwezI5zLKpZBhylR6b8n5OvVMr+E4wZOt3e8FFhYF4iX8y1dxngU
	 PtiiKa85oPtjQQg8ExlsOiGA2Km/2+qzjZ7MD4+c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbeLSG4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 01:56:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:44738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727232AbeLSG4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 01:56:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F01672184A;
        Wed, 19 Dec 2018 06:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545202583;
        bh=tlu7Xwb1hzDYyqD2tgUdoFaFpTrj9P7NqlkTHs3BliA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yweGbTB434wTwDDxSQqW17dZZjhJ7ed1T5paBnmOGs3JhUQtLVvG3Ast0EuM4JCMP
         LmFSVdzwglDMIz5jMJw0pwvhmTCDGVnzU6ob9Wgnml9vlu++LnhPZ5N0atjjIvG7NS
         bLwXzSwoK3w65eZMZ/xXpqEQN2AR5z25bL17xaxA=
Date:   Wed, 19 Dec 2018 07:56:21 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     peng.hao2@zte.com.cn
Cc:     arnd@arndb.de, andy.shevchenko@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 1/3]  misc/pvpanic: return 0 for empty body
 registerfunction
Message-ID: <20181219065621.GA21256@kroah.com>
References: <20181218102817.GA29083@kroah.com>
 <201812190811376451432@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201812190811376451432@zte.com.cn>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 08:11:37AM +0800, peng.hao2@zte.com.cn wrote:
> >On Tue, Dec 18, 2018 at 05:46:41PM +0800, Peng Hao wrote:
> >> Return 0 for empty body register function normally.
> >>
> >> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> >> ---
> >> QEMU community requires additional PCI devices to simulate PVPANIC devices
> >> so that some architectures can not occupy precious less than 4G of memory
> >> space.
> >
> >What is this for below the --- line?
> >
> >And again, you did not specify what changed from the previous versions.
> >I can not take these unless you provide it.
> 
> The previous version of the code is basically unchanged, and the new patches just 
> adds a PCI interface. Previous versions only support ACPI and FDT interfaces.
> The QEMU community requires a PCI interface so that some architectures do not occupy
>  precious low 4G memory address.

No, you are changing things between each version, hopefully based on the
review comments.  And the testing that is being provided for you showing
you where your code breaks the build.

That goes in the "what changed" lines, as is documented in the kernel
documentation.  Please follow that when resubmitting if you wish for
your changes to be able to be accepted.

thanks,

greg k-h
