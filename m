Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DEEC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17C9C214F1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="oSvmh5Bw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17C9C214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbeLCXM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 18:12:28 -0500
Received: from mail-qt1-f171.google.com ([209.85.160.171]:42328 "EHLO
        mail-qt1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbeLCXM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 18:12:27 -0500
Received: by mail-qt1-f171.google.com with SMTP id d19so15922696qtq.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 15:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=YdGuOGuOd+dAS1CsKU5Rg/N8Hk1GkzLD9up9MUo39Hk=;
        b=oSvmh5BwT+ZA+dfs3eu72mXiLlpiiWtjq4JAYHuq26RTqgEXDFe4a9SNQcmoBbBoGk
         WXHL4uNnhSZiIe1Ov5YFPcC8GuyV3OmOv9qDMcfKtaI61BoepJvmAw/NxR8bb+rkVRI4
         AEPoUHZz3HCbL+vsPhbLF7tyrEsSfVr8uwmQA9FFD7clazd4NsW0bouTGVaX79yHzcd8
         sC3iY5zuJL9WUfJsPccpZRlgRoz3EnhKr4Pbaknpkvb1VGLDgxIVWybJ0QtUPMr7/INj
         BJ4S8f/A4LiXHrIcm1AZdAMXPIfMmTr/EZ4KtPCZa0DzGSCL59zClZtH3X+96cWsRaoh
         o/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=YdGuOGuOd+dAS1CsKU5Rg/N8Hk1GkzLD9up9MUo39Hk=;
        b=ZWTdqkwjktuVgwWEuL5azs1+aons5Mn/i3DPCakrEJAgJ8K7z+x0y1lnYWkDQYE2++
         Z9KLSChylRR67MDB0LVHH7RSUdCbFoTfhDv32bEVwa/8lgVaYB/hjRisyA/ZqS7CWMCw
         Rn9FFVKuaT6X743u+OxQW4dC0+59TNvwTtXnp3pwEh1eHoQUoud/QUP8M5JUDd+sJReV
         N6gslBxUhHXNDM+g3K0V/oImfg4WGQ3jV1wPBHw+XDJzrWc/Sql58jCkxoPv6oBqoh1l
         Nxi56LpOxL5SuBXOld62PHIzVxXVebnfreo7+9Ug6VzPgnpV295x/tXX46+qeLJbnSbC
         qOiw==
X-Gm-Message-State: AA+aEWbjxL4xLeJdueCaHPhDcjLdca5xNm2yXm4sRIOnAiMpevqzByPR
        1n1uVbhmFUdBU9Sr4f6YX/1KWA==
X-Google-Smtp-Source: AFSGD/VfT+CF92piSNJlUr6gqzjEcAlGCekb5uBnqvHnLYWdFAqFgfU60muv7TDvD+VR94usJMSpSg==
X-Received: by 2002:aed:384a:: with SMTP id j68mr17198710qte.171.1543878745968;
        Mon, 03 Dec 2018 15:12:25 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id q17sm9798937qtc.19.2018.12.03.15.12.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 15:12:25 -0800 (PST)
Date:   Mon, 3 Dec 2018 15:12:22 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Salil Mehta <salil.mehta@huawei.com>
Cc:     <davem@davemloft.net>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, liuzhongzhu <liuzhongzhu@huawei.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [RFC net-next 3/9] net: hns3: Add "port vlan table" information
 query function
Message-ID: <20181203151222.6e56efcd@cakuba.netronome.com>
In-Reply-To: <20181202230933.15560-4-salil.mehta@huawei.com>
References: <20181202230933.15560-1-salil.mehta@huawei.com>
        <20181202230933.15560-4-salil.mehta@huawei.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Dec 2018 23:09:27 +0000, Salil Mehta wrote:
> From: liuzhongzhu <liuzhongzhu@huawei.com>
> 
> This patch prints port vlan table information.
> 
> debugfs command:
> echo dump port vlan tbl > cmd
> 
> Sample Command:
> root@(none)# echo dump port vlan tbl > cmd
>  vlan | port filter bitMap:
>  0000 | 00000000:00000000:00000000:00000000:00000000:00000001
> root@(none)#
> 
> Signed-off-by: liuzhongzhu <liuzhongzhu@huawei.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>

Adding debugfs files for basic switch concepts like MAC and VLAN tables
seems like a bit of a stretch to me.  I wonder what others think.
