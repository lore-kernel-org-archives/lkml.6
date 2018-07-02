Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE460C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 980E220836
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KK+kuBld"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 980E220836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753434AbeGBU6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 16:58:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43470 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752437AbeGBU6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 16:58:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dIrFNkRWhaHtvvGfm+4ArKO3x/7uuaURjX+qAaQ2IGU=; b=KK+kuBldqgjWvpbPhS94FahoC
        BbTyo8HjAPu5gwM1dKwKpRITLBJj264NbrO76iKMw91pWRlbXiOoj7QDocJjMkZxEvNl8ybKf7Q6o
        VhhsdIsu5oOd2QXJ/SgAYdn65i0E+U+9TOhPIr1X4Epq7UT0T6IkI4iv9WYjHovxmB14RKKJ48+CM
        6rk2Ly/nmGUCcbALzvoUCPb2rM7NCeSL9WMIb7VKFec7HrYLzt1nIy/livj8Ut+7ixHdQlNPUDxCG
        2hS7U1ZvUjdwm4sIyrcuUdIc7jvd6EJvnhy2GhAI6aE57Gef8AT8uEK+uSQLFwMkf0FsYBInG8Jhf
        FO/vlrJKw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fa5u8-00053C-24; Mon, 02 Jul 2018 20:58:36 +0000
Subject: Re: [PATCH 5/5] kconfig: move the "Executable file formats" menu to
 fs/Kconfig.binfmt
To:     Christoph Hellwig <hch@lst.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180702144711.22111-1-hch@lst.de>
 <20180702144711.22111-6-hch@lst.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <fe9bf260-82f6-214f-08f9-a896e68af214@infradead.org>
Date:   Mon, 2 Jul 2018 13:58:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180702144711.22111-6-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/18 07:47, Christoph Hellwig wrote:
> No need to have this in the top-level Kconfig.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>


> ---
>  Kconfig           | 2 --
>  fs/Kconfig.binfmt | 5 +++++
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/Kconfig b/Kconfig
> index 5f580c81d85d..f9969589a6b4 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -15,9 +15,7 @@ source "init/Kconfig"
>  
>  source "kernel/Kconfig.freezer"
>  
> -menu "Executable file formats"
>  source "fs/Kconfig.binfmt"
> -endmenu
>  
>  source "mm/Kconfig"
>  
> diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
> index 56df483de619..b795f8da81f3 100644
> --- a/fs/Kconfig.binfmt
> +++ b/fs/Kconfig.binfmt
> @@ -1,3 +1,6 @@
> +
> +menu "Executable file formats"
> +
>  config BINFMT_ELF
>  	bool "Kernel support for ELF binaries"
>  	depends on MMU
> @@ -187,3 +190,5 @@ config COREDUMP
>  	  This option enables support for performing core dumps. You almost
>  	  certainly want to say Y here. Not necessary on systems that never
>  	  need debugging or only ever run flawless code.
> +
> +endmenu
> 


-- 
~Randy
