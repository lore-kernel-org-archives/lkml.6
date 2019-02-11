Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF01C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 579A3218A6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="BKaUabJ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbfBKMjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:39:35 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41902 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbfBKMjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:39:35 -0500
Received: by mail-wr1-f68.google.com with SMTP id x10so4520262wrs.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 04:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kcLlCfINWyn/0PQ+HV583LdbWskjR0UzDPoMZ2wku/0=;
        b=BKaUabJ8cRgN3IOJ49wyNvzCJM1W3Tl1t/tqNr7Cnvf7ClB/KqhhaR0hmpgjoOvu7H
         aKvEyF3D5Y5VLH7R2con8gFhU3g7S6fUsaHZfS003wzOaZ/k8tuoPJq8JObI6jPjCNAH
         eJTiysRhHoVJGZ42mxknp+SueNTWdveulTbvAV13FGCqeZ2qjGCnnzeAzKsjquwrCd3y
         tj3YXRpy8T/Dqxut/2Dv7xUPxqDsmAU/cmAtCjPTANbYJLeU9EUJCfwRrVE9C3Vvb2Z/
         5A9pWqo2paiSLdZtK10mzKXzRV3122fSGQUaWC1Ww+6GvRGn4TJfQKRQbODWhwFLcCBt
         ui7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kcLlCfINWyn/0PQ+HV583LdbWskjR0UzDPoMZ2wku/0=;
        b=Qn85yXVnZz20bPCOYofhnG3If+dFz3a5IvhWYO38TPBS9vWo8DiCd8FtAkOe6KajIs
         vtSPo5JSRU2XNW5s8Wr83p0ShQt+oSOSSV7+ICktMwPQRn08zzPJu+y6eObV63RkRRS+
         9hPDz3Oojp1vXbnew+3sIgGN6oN+B7XGQKe8YGTR27eTnSpDQdN21hGHQRjQJEYaLUTY
         S2iI0IZ3NKGCMEnsztkAVjP8AZemYXXoFbIdSmL8ZHvEqm9K3IlNgv0wMkgVZwhuD+1a
         gkr/taP7y62nj+aVYNXJhLKLYBAORSqdMRQBt3g6kBx8PWQlzDkn3WwYhLUVuUX0A84w
         1+nA==
X-Gm-Message-State: AHQUAuZlviqo0NiajwfquPR3S2+8EFm8Vj/697j8l0HB0xXpt7bbM857
        lHKbmC7D0OQlJnxbmn2i5l88qg==
X-Google-Smtp-Source: AHgI3IaPGBAgh9ybmlEdYw+C19LAy5fQFEXDasOMQLVOtEef0dqCGi1e8gwihR5NxHjzHvgLDOM2lQ==
X-Received: by 2002:adf:dfca:: with SMTP id q10mr2358735wrn.45.1549888773770;
        Mon, 11 Feb 2019 04:39:33 -0800 (PST)
Received: from localhost (mail.chocen-mesto.cz. [85.163.43.2])
        by smtp.gmail.com with ESMTPSA id y20sm23541720wra.51.2019.02.11.04.39.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 04:39:33 -0800 (PST)
Date:   Mon, 11 Feb 2019 13:30:10 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, idosch@mellanox.com,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        bridge@lists.linux-foundation.org, jiri@mellanox.com,
        andrew@lunn.ch, vivien.didelot@gmail.com
Subject: Re: [PATCH net-next v3 6/9] staging: fsl-dpaa2: ethsw: Handle
 SWITCHDEV_PORT_ATTR_GET/SET
Message-ID: <20190211123010.GI2251@nanopsycho>
References: <20190210234007.16173-1-f.fainelli@gmail.com>
 <20190210234007.16173-7-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190210234007.16173-7-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Feb 11, 2019 at 12:40:04AM CET, f.fainelli@gmail.com wrote:
>Following patches will change the way we communicate getting or setting
>a port's attribute and use a blocking notifier to perform those tasks.
>
>Prepare ethsw to support receiving notifier events targeting
>SWITCHDEV_PORT_ATTR_GET/SET and simply translate that into the existing
>swdev_port_attr_{set,get} calls.
>
>Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Jiri Pirko <jiri@mellanox.com>
