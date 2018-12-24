Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1EEC64E79
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 15:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE7C72184A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 15:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qe4JNPXN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725822AbeLXPQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 10:16:43 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46988 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbeLXPQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 10:16:42 -0500
Received: by mail-lj1-f196.google.com with SMTP id v15-v6so10558422ljh.13;
        Mon, 24 Dec 2018 07:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=ORVhNXgCPZM3kHw5IZwdFIVL9pqzwUYqYW+syPJ+CqY=;
        b=qe4JNPXNB7+rw2ccSih6zJA6hDZCEIkZTxMc0rFJS3yZt1wtGsimghrdtR72TL2Lol
         9hMvL0gwPEV0X9xvQUQxwj6bqxJbkAXymSVydX1SPR8fTAt/7N1p31DMraISisdYGew5
         GLcL16BiIadg6Hhl/vqCPyE4wjsd77s+XHwKCP9w7AnII4tuT36GHeCv4mRqDjC9zFYR
         PvhEhsTblEajIL48AhwzKBJXH0fYqa8sCuaPF3/2cEzZ6YlbUJyIarxoQyS8fyzoSxNA
         ARpBF7HOsM7k2rrE7kn6l2xCnKrDYsOANVyvZ8IMv4n6dHf4c4V+NVmA0geIjYs7mClB
         SwQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ORVhNXgCPZM3kHw5IZwdFIVL9pqzwUYqYW+syPJ+CqY=;
        b=fP+RkTm/WRS93W7GU20YjlCJC8n4BkQU9qC3tDSNLg4MOgSStZT+InUo7uvcYxDN+a
         NimFgnBiNmwaZaAguRFUWSA7+0yO7co09Tsg7/wckG999iDJAqqHzuOZt+0LaRvDwRof
         1dsbqgaysyU0wI03PmueaBQXb0Mlv4POk2iII6J4mB16Hc2Aa3JHsZv5zTW+DWX3QbM6
         gCo8O2TxiwwFegKi84DWWrHWsZ2YFArzp0ww8GqviSfp1AvzjAkr9xr/R+cF9JO25jSU
         CprHFosMUpzScTnn2o7xXEWzcdakh5xbe3yM+24NN2MmR/n6rleKuwLp32hfRDzWwJa4
         amZQ==
X-Gm-Message-State: AJcUukfBwfPuA+7izibfUUBCXCsN1HhER9Uj35i+yZwIERwEOJGvVefx
        lENZIUZ+/AUKpGKjpUoGtZg2++AE1vc+4gmg
X-Google-Smtp-Source: ALg8bN4YK+MxT5LFHTZGhMLQu+o26ojUAbzkbdh3XDO0z63pUETPi9m8LH7stG5A5aGMIsklDgJR2Q==
X-Received: by 2002:a2e:91d1:: with SMTP id u17-v6mr7762324ljg.160.1545664600234;
        Mon, 24 Dec 2018 07:16:40 -0800 (PST)
Received: from im-mac (pool-109-191-228-208.is74.ru. [109.191.228.208])
        by smtp.gmail.com with ESMTPSA id f11sm6443936lfi.12.2018.12.24.07.16.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Dec 2018 07:16:39 -0800 (PST)
Message-ID: <4a78261cba6647cd9665ed42f175eeedf412b85b.camel@gmail.com>
Subject: Re: [EXT] [PATCH v1] bnx2x: Fix NULL pointer dereference in
 bnx2x_del_all_vlans() on some hw
From:   Ivan Mironov <mironov.ivan@gmail.com>
To:     Sudarsana Reddy Kalluru <skalluru@marvell.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc:     Ariel Elior <ariel.elior@cavium.com>,
        Sudarsana Kalluru <sudarsana.kalluru@cavium.com>,
        "everest-linux-l2@cavium.com" <everest-linux-l2@cavium.com>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Mon, 24 Dec 2018 20:16:38 +0500
In-Reply-To: <CY4PR18MB125333EFFE5875193E66927FD3BB0@CY4PR18MB1253.namprd18.prod.outlook.com>
References: <20181224115609.21752-1-mironov.ivan@gmail.com>
         <CY4PR18MB125333EFFE5875193E66927FD3BB0@CY4PR18MB1253.namprd18.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.3 (3.30.3-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-12-24 at 14:26 +0000, Sudarsana Reddy Kalluru wrote:
> Thanks a lot for root-causing the issue and the patch.
> Another (simpler) way to address this would be to invoke bnx2x_del_all_vlans() only for the newer chips, e.g., 
> +       if (!CHIP_IS_E1(bp)) {
> 	/* Remove all currently configured VLANs */
>                rc = bnx2x_del_all_vlans(bp);
>                if (rc < 0)
>                        BNX2X_ERR("Failed to delete all VLANs\n");
> +       }
> Could you please check on this?

Done. See the PATCH v2 in the mailing list. I tested it on my system.

