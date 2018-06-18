Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1DFC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 06:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A417E20864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 06:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5GpEsR9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A417E20864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754899AbeFRGXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 02:23:12 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:46796 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754093AbeFRGXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 02:23:11 -0400
Received: by mail-pl0-f68.google.com with SMTP id 30-v6so8435491pld.13
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jun 2018 23:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9ida75I7DFfN8PgNFrzgd++5DZBUYN42mOWGU0D5Q0c=;
        b=V5GpEsR9O9m3Eji5ovOz/PhiWc9MB6CflZ+EhywZDhWJYxfFqpeorytHPf+wXTgNgl
         sjMqBqL66a5JdVvf7rIY7dsV2YTiY6T3vcGN5KiJsuqZjne9r5vrw/DBPgCb7Hsq6heQ
         zoSx0HlwjHp+EKyayZNxWjigqsjj9LuHUN4/c4/5plS1o1evIoU/1hsxCsIdJAqmcjUq
         Ip6cUFn0DvaFXmtM7T9uiI9vkNC8lG0YVQfNW5qdxf1mhT1XcCI5XRvMjIi9t9y9lUfx
         G5rSh4+pxx9ufxmPivIHfcSnQ7gI0YkPWLeBj5i0w/zatqXvaupQ+2ln/VmL7Ozjnfyb
         ReDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9ida75I7DFfN8PgNFrzgd++5DZBUYN42mOWGU0D5Q0c=;
        b=jrbox2QIDdM+bnRtub9VHewmebomurBqlkDffuE+TMzHIJuCyLe/nl8oVS2Ft+TerU
         uwFsGYJb6BnJpE5Qjj0Nz8WfdrE0NDlfdZTesPiHeszAiluuE2HbfK4Q3qAZCHGYMshQ
         fSPHeN6vKcdEGxVI2LBGD2CsLv4iq8acNhbC9Z6taRRzqswjY94KAQH0So8MWpCh7cBU
         LuNkVxZktUxuNzkMidev/hQce0THCJj2cTV7IrgdWSkchDbrzTPITXqPC/XmjDQnZIwM
         CIzFXrDPPVmbNnSSOtXoIOFARLKpubKMirtSYo3adKysc98v/z/G/3kHahkAK/qNvTx5
         gBiA==
X-Gm-Message-State: APt69E0ZY6VzK7WnnFPHRBnp8bwmsL9oubck19mI2HwrjENIvuLmXeFz
        lj50Xu7gs9wJCvVsP6Or2qk=
X-Google-Smtp-Source: ADUXVKIisdrY48OMMF4GhnBSksr6+kaQhFaB6s6VNrd6LQ+bSoOzaRAz32hfMdaA9c38B4nZremohg==
X-Received: by 2002:a17:902:1081:: with SMTP id c1-v6mr12605686pla.153.1529302991202;
        Sun, 17 Jun 2018 23:23:11 -0700 (PDT)
Received: from localhost ([110.70.54.122])
        by smtp.gmail.com with ESMTPSA id n68-v6sm25333204pfk.145.2018.06.17.23.23.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Jun 2018 23:23:09 -0700 (PDT)
Date:   Mon, 18 Jun 2018 15:23:06 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Maninder Singh <maninder1.s@samsung.com>, pmladek@suse.com
Cc:     sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, a.sahrawat@samsung.com,
        pankaj.m@samsung.com, v.narang@samsung.com,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH v2] printk: make sure to print log on console.
Message-ID: <20180618062306.GA29683@jagdpanzerIV>
References: <CGME20180601090029epcas5p3cc93d4bfbebb3199f0a2684058da7e26@epcas5p3.samsung.com>
 <20180601090029epcas5p3cc93d4bfbebb3199f0a2684058da7e26~z-a_jkmrI2993329933epcas5p3q@epcas5p3.samsung.com>
 <20180618061550.GA27996@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618061550.GA27996@jagdpanzerIV>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/18/18 15:15), Sergey Senozhatsky wrote:
> 
> On (06/01/18 14:26), Maninder Singh wrote:
> >
> > Signed-off-by: Vaneet Narang <v.narang@samsung.com>
> > Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> 
> Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

OK, we probably need v3 after all.

I think this

-               if (suppress_message_printing(msg->level)) {
+               if (msg->flags & LOG_NOCONS) {

must be changed to

-               if (suppress_message_printing(msg->level)) {
+               if (!ignore_loglevel && (msg->flags & LOG_NOCONS)) {


`ignore_loglevel' is a module param and can change any time via
	/sys/module/printk/parameters/ignore_loglevel
we need to respect its value.

	-ss
