Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3936C46464
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 01:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 836272156E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 01:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fsl0vECJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 836272156E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbeHOEQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 00:16:18 -0400
Received: from mail-pl0-f41.google.com ([209.85.160.41]:41811 "EHLO
        mail-pl0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbeHOEQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 00:16:18 -0400
Received: by mail-pl0-f41.google.com with SMTP id w19-v6so9034128ply.8;
        Tue, 14 Aug 2018 18:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=lyHln1WSabMGKtM/2j7P69npMr4pIQNBcgsTMSlFhHw=;
        b=Fsl0vECJGrudZg7GTW5MxOuCuVi4VgSV2v/EqYq7aGP23uS3TXPipdcLM/p3osd0gV
         7S7wXWb/SIr3UN0jYBBuiYlef3vNyVXnbZ55svET9zrD/JSxZNLKsjAVjTzdfSddXfY1
         GAQjKsMAOtTNNWtUQEzyupTAvdfvufWPZEk9K7qF/oWyJJMek+QnS2qKUeqDNeifX/dL
         Dp38VB6MYtvXoXRBHoM9NcpcHI0NYQuTJObucs32ba7jXFSSSsVSnKzKx0gL2WPZJsr1
         Zbzo5aGLQGVW9pJ9UpSfnptMdfgAFG7nARPwIbwvAxxr1Owmo1VTSWTYkpwvJGrxbJAU
         gNbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lyHln1WSabMGKtM/2j7P69npMr4pIQNBcgsTMSlFhHw=;
        b=ixmoAwEsUFofQEnq/xHPvPvAuhmNMGVVLfnnrmgLI7hXkDBw42sijZ3ST5Yyv37dx5
         gckIWNwULOGYWzf/DNkIqJWddhlja9H8sPITnivkmJtBviUe8pDg2/bEClHb9xslRtQR
         j46yoi3JMb5touWv6fcQvDy99Gxj5RRQdwaFSnWFd36EPB2oM6cljvIFQ0bw9+1GC0I6
         sQuiIyoFavUTDIhElpaxNMsSOJk44WPYTNmIbOGxG3tNPrKBvR2cukt5Qvyhu25NcLTW
         yhSbnJYujgU1Re2JSySTo8H9LEO2+K3kXCb83ICFSXJ6FTVQ7sEMTtt9dO/QjBNWCyun
         HDpw==
X-Gm-Message-State: AOUpUlFdPD5HUQdFlkfUgPWjaxqB0ZSzQnUO4VpFOcX7EbT4oOoF4p0t
        FTf8ppi5bhc4c2in9QEyyzA=
X-Google-Smtp-Source: AA+uWPxjPpjWmJDuT2J1qJHEKz2q8jGFpS/KetKLqSVSgKl0UP14miFlevWDS7z2wc47ROl2t+UpXA==
X-Received: by 2002:a17:902:18a:: with SMTP id b10-v6mr22782039plb.62.1534296386950;
        Tue, 14 Aug 2018 18:26:26 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id z5-v6sm46824019pfi.4.2018.08.14.18.26.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 18:26:26 -0700 (PDT)
Subject: Re: How delete node or property in overlayd dts?
To:     =?UTF-8?B?5byg5rOi?= <zbsdta@gmail.com>, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CADUUTHBZ---U7YNYYry7qJY=vt_QpXpytymqJQc9xLFE_NjsAg@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <c342562e-f915-a853-c2a8-eecefd94b88d@gmail.com>
Date:   Tue, 14 Aug 2018 18:26:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CADUUTHBZ---U7YNYYry7qJY=vt_QpXpytymqJQc9xLFE_NjsAg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/14/18 07:46, 张波 wrote:
> /delete-node/ /delete-prop/ could be used in dtsi files without device
> tree overlay.
> 
> but with device tree overlay,  /delete-node/ and  /delete-prop/ are not work.
> How to delete property and node in overlay dts?
> 
> for example,
> in basel.dts have following node
> node1 {
>     property1;
>     property3;
>     node2 {
>         property2;
>     }
> }
> 
> in overlay.dts as following
>  node1 {
>     /delete-property/ property1;
>     /delete-node/ node2;
> }
> 
> after overlay, property1 and node2 is not deleted.
> 

The /delete-node/ and /delete-prop/ directives are only used by the
dtc compiler within a single compilation.

There is nothing in the format of a devicetree blob to represent the
notion of deleting a property or a node.

You can not delete a property or a node in an overlay dtb.
