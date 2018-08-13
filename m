Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E031C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 22:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDD6F2175D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 22:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GhmnFRH8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDD6F2175D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730966AbeHNBep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 21:34:45 -0400
Received: from merlin.infradead.org ([205.233.59.134]:41770 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730203AbeHNBep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 21:34:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Vf6kwD7gn6jRHDWELeRNRsKwXLvxvsLJfCUHUSJ126I=; b=GhmnFRH8TuC40D04Rr2da6sHqF
        q98DKYFb4V/WU+165Fnc2n96XWwyP6Ed+MProrJCx1SLHT0HB3N0OogmKsNn9Ft04eFZrObPiLzjO
        Xf3+aa44PteZpY0yGoLPI8McV9KKxMQC0W/EzV+FhEshxXt4dUysEvpcjmBM8IgM0rSUTGNKdaqj1
        2u9EzF9ejy0RsqbPd/DcRCqCWboBVCfWmSa1LDw+oFuz4gz1MpJm52HlVQdeA6NVQOSFTKj4wRqGH
        buC+p6BuqBUYvPl1I3z6nkUQZZMIN6b+CKL2tAJeeJZ1tMu4wk16Qy4xyYCt3nip2ii6KfDlmA6b9
        Znho210w==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fpLfL-0007NU-Uf; Mon, 13 Aug 2018 22:50:24 +0000
Subject: Re: [PATCH] mailbox: mediatek: add module license
To:     Arnd Bergmann <arnd@arndb.de>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     HS Liao <hs.liao@mediatek.com>, CK Hu <ck.hu@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20180813214500.3398337-1-arnd@arndb.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e5ccb767-2c8c-b677-42ae-436666570c14@infradead.org>
Date:   Mon, 13 Aug 2018 15:50:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180813214500.3398337-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/13/2018 02:44 PM, Arnd Bergmann wrote:
> The missing license tag in the new driver causes a compile-time warning,
> and may result in the module being unusable if it calls EXPORT_SYMBOL_GPL()
> functions:
> 
> WARNING: modpost: missing MODULE_LICENSE() in drivers/mailbox/mtk-cmdq-mailbox.o
> 
> Fixes: 623a6143a845 ("mailbox: mediatek: Add Mediatek CMDQ driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/mailbox/mtk-cmdq-mailbox.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
> index 6f92c5ee12f7..aec46d5d3506 100644
> --- a/drivers/mailbox/mtk-cmdq-mailbox.c
> +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
> @@ -567,3 +567,5 @@ static void __exit cmdq_drv_exit(void)
>  
>  subsys_initcall(cmdq_drv_init);
>  module_exit(cmdq_drv_exit);
> +
> +MODULE_LICENSE("GPL v2");
> 

https://lore.kernel.org/lkml/99f4666b-95fc-a1dd-04d3-3d1d803990fb@infradead.org/


-- 
~Randy
