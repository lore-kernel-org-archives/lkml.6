Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54939C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5A2D2080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pb2Umif1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730908AbeLNUaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 15:30:12 -0500
Received: from mail-lf1-f42.google.com ([209.85.167.42]:36422 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730713AbeLNUaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 15:30:11 -0500
Received: by mail-lf1-f42.google.com with SMTP id a16so5216892lfg.3;
        Fri, 14 Dec 2018 12:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=J6TNEvlLs1ed12BaSSMNQMExRzGWZ3UoU+8VT2TxGVk=;
        b=Pb2Umif1WBA7yMiepV7sygKL6gLwzrGmenaHxF8KYwj/D798Jd+m7Bfj9QKkyfpQP6
         hM4E3cN/EEHeqp7P7S/7VTiNAcdFvqgUAHrdu523kn5M17pW4LYwbb3tfjkU3rojo8oA
         +24aaID2e4UcpH0ns3qh/RyJeePp+zpOXlfcqzPv419/leLdE+XIC58XteQONgsFcW/c
         dYfs6oz/ZGSV7yX8m+Bw0slm6n4bZQj0hGKOMhgSTHjFobjbFm2Aw7oai69OmZ7jH+MW
         DIr4XAZ2k40Ao7d0p+bNj2vWZsKJmWZHfp4FEjiCgmNJaAaYdzz9pC22SeHhhvD/KSSx
         4CQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=J6TNEvlLs1ed12BaSSMNQMExRzGWZ3UoU+8VT2TxGVk=;
        b=UGH92/ENgO/sX/9ERNN5fhBGWbL+960JnLd6ITS5fN1VuQWe9OvjpJ16b3/lB8zoYE
         pGbsZoicwDh+Oqt7y/S9TkBTL2QERcC2Uakyanaor5InjcCBOANeQOKsSZWA4SUcXZj2
         3VKzh9rJvFMJvEHphX005churac2dGJ6AC/JCes5kHYWhy8/MbeCofQ1hj+yYaMJcJRY
         ZKsZLvFrNzAWFLN0yd46Tv1/HDoLNO+0gbk5epohqjXFoHvvzKZEvBnywRN0wpN4hWNe
         JQ96vbCQ6zXKvO8GekSkuJ1fCJsuz9gxB6/5RyI2A3lhHA2HnW5axEwqcqCuJwM+b8aO
         eEuQ==
X-Gm-Message-State: AA+aEWZBJHra73wnd4HgVd/6zHU08TOmxEehtFI1vN4j7xhe8haxWohl
        +9q8Hgf8SGF9bw0oi1dL5Gk=
X-Google-Smtp-Source: AFSGD/UNvFWt48QRMPKHm3G8JaHzWVC6zgghD/tlL5fctRZbD3KDFP9yYZgTOTpKUlzmTRGLCWDK1A==
X-Received: by 2002:a19:9e11:: with SMTP id h17mr2745071lfe.73.1544819409371;
        Fri, 14 Dec 2018 12:30:09 -0800 (PST)
Received: from im-mac (pool-109-191-228-208.is74.ru. [109.191.228.208])
        by smtp.gmail.com with ESMTPSA id 67-v6sm1033879ljc.26.2018.12.14.12.30.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 12:30:08 -0800 (PST)
Message-ID: <449fb880e94d478fb35e01da93c5b1fa1732f7d8.camel@gmail.com>
Subject: Re: [PATCH 0/6] Add support of the HBA mode on HP Smart Array P410i
 controllers
From:   Ivan Mironov <mironov.ivan@gmail.com>
To:     Don.Brace@microchip.com, linux-scsi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, don.brace@microsemi.com,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        esc.storagedev@microsemi.com
Date:   Sat, 15 Dec 2018 01:30:06 +0500
In-Reply-To: <BYAPR11MB285586623125DD1C98EE87F1E1A10@BYAPR11MB2855.namprd11.prod.outlook.com>
References: <20181214132115.21440-1-mironov.ivan@gmail.com>
         <BYAPR11MB285586623125DD1C98EE87F1E1A10@BYAPR11MB2855.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.3 (3.30.3-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-12-14 at 19:38 +0000, Don.Brace@microchip.com wrote:
> NAKing this series.
> - The P410 controllers do not fully support HBA mode and we do not support adding it to the hpsa driver.
> 

Could you please elaborate on what exactly you mean by "do not fully
support HBA mode"?

HBA mode looks supported on P410i (at least to some degree) because:
*) There is an official method to enable/disable it on these
controllers. Only for itanium-based servers unfortunately.
*) This method is mentioned in various documents from HP regarding
Integrity servers.
*) Controller reacts on the change of corresponging bit in nvram_flags
by immediately removing any configured RAID arrays and by refusing to
configure new arrays. Which is totally expected for HBA mode.
*) HBA mode works for me on P410i with patched driver.

