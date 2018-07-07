Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640ABC6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 08:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 215AA223C3
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 08:52:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 215AA223C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752944AbeGGIw3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 04:52:29 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38706 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750988AbeGGIw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 04:52:26 -0400
Received: by mail-ed1-f67.google.com with SMTP id a5-v6so10272872edt.5;
        Sat, 07 Jul 2018 01:52:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=GsqW26t01RWMr+zJu0eXCYC+h5odVo4DL8eZu5omo3I=;
        b=sv/QIT6RbqjWOaEhXtY0ODFdK6g7sBYtnW2y96aJetxTgDGzsuX9bI/0RHkmFtruSc
         jHeaiuiX3uBKi/C/sUdZ6R21keacL9CXH+sCu9cAG7+vKFuzRTP7VG2bIFxGZg2rokOK
         /g3lLTl+pt7EuRU0hVRGrBqg+M/h6nCgEZGJCufaf2FM+14TJ5ffT06VN5nzcg8iWPDt
         EZtQF4iUFWQaLUxEJKhRACuEOtWcfWLlDgubJipHG2evYAWo+gHVyPzW3mFk5eCLsttV
         iA+fb83fJUuGbOylc0HgpqkR2ZED85eOD3bSLKXZ44gk3AXSzyycgTQSFLGNoCZfO5dF
         FKHw==
X-Gm-Message-State: APt69E2gXkV2f8x2eRopLVcqrBv2l0t97ENFzFnd0acUPQadTETCb2oU
        8UOCq7lYHbRlmRzbMnMB61g=
X-Google-Smtp-Source: AAOMgpeHLAup0ZPiDXLXj3mWo3wd01ShKdr/RS9L9DyToB64N7iJnTtPeauCu2MjYLNJ5xrS+J5UfQ==
X-Received: by 2002:a50:9154:: with SMTP id f20-v6mr13838485eda.29.1530953544928;
        Sat, 07 Jul 2018 01:52:24 -0700 (PDT)
Received: from kozik-lap (adsl-84-227-236-43.adslplus.ch. [84.227.236.43])
        by smtp.googlemail.com with ESMTPSA id w26-v6sm697268eds.7.2018.07.07.01.52.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 07 Jul 2018 01:52:24 -0700 (PDT)
Date:   Sat, 7 Jul 2018 10:52:22 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, xc-racer2@live.ca
Subject: Re: [PATCH v3 0/9] Initial support for Samsung Galaxy S and Galaxy S
 4G
Message-ID: <20180707085222.6z6wihfvg7stfuya@kozik-lap>
References: <1530901970-14972-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1530901970-14972-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 08:32:41PM +0200, Paweł Chmiel wrote:
> This patch series adds support for Samsung Galaxy S and Galaxy S 4G.
> Both are commercial phone based on Aries family.
> 
> Changes from v2:
>   - Restored pinctrl nodes order
>   - Correct order of nodes in aries dtsi file
>   - Added Reviewed-by to one of patches
>   - Added Acked-by to one of patches
>   - Squashed two patches updating samsung-boards documentation 

I applied first DTS patch and last defconfig.  You can resend only the
DTS patches after fixing dtc warnings.  Then I'll apply them with the
bindings change.

Best regards,
Krzysztof

