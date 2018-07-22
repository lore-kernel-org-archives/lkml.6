Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85B0C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 15:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D5B720874
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 15:08:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D5B720874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbeGVQFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 12:05:15 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33628 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728916AbeGVQFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 12:05:15 -0400
Received: by mail-ed1-f65.google.com with SMTP id x5-v6so13671745edr.0;
        Sun, 22 Jul 2018 08:08:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WieX9WUVNzdR9msWVwLxFsP71T+aQzXtJl8Jb6FLAhg=;
        b=nSLhJ4BUJSeCeM79FJgEoGGlLC+JZWwU+31aO6mQTLr7JwiNh/gEjuYRdviFXPPZze
         grNp+0WFOdM/mUL3VKbNFNyxbU6xYoWoVHOK45E7Lsn7crqL1zUCKBTqe4p1lKgIAInv
         1+BaLzz9j0442NX0VVgrxVYHZo+BASch8i/Ep6CR7Wj+oy8LLRZ7Cg8fre92qOFICJVh
         HCND7mNITEc1K6rMplPP6n5yKqXmXsj8Z2JraeSfR3+854c2JP29/ByrnuYWHZvVq1X7
         6e0RjK5LG+RXntutLCM7oOu5Qyk/3C4vzsiHYvKU5KWtqR4VBukv1fiqgVst/OFWDeWz
         nLfA==
X-Gm-Message-State: AOUpUlGPKJGtXzepc2JP0iHDvUGq7Jy3Qqn7HqhSfVOFy7JghBlSmXBv
        83Mwpu5QrmTpL0tEzvxBAmsGh+z/
X-Google-Smtp-Source: AAOMgpc6iUl9Kz0ZgpQPiZEID67yg+YcwbgvMEwIO0h06o76epLhmBcyJMwqKHNVzJ19zUsVOv1Hmg==
X-Received: by 2002:a50:80e6:: with SMTP id 93-v6mr10105833edb.252.1532272095001;
        Sun, 22 Jul 2018 08:08:15 -0700 (PDT)
Received: from kozik-lap (xdsl-188-155-58-14.adslplus.ch. [188.155.58.14])
        by smtp.googlemail.com with ESMTPSA id g1-v6sm4767464edr.52.2018.07.22.08.08.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 22 Jul 2018 08:08:14 -0700 (PDT)
Date:   Sun, 22 Jul 2018 17:08:12 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] ARM: dts: exynos5: add missing interrupts for pwm node
Message-ID: <20180722150812.dmk2qmhp3jwejt3b@kozik-lap>
References: <1531918767-7177-1-git-send-email-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1531918767-7177-1-git-send-email-linux.amoon@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 12:59:27PM +0000, Anand Moon wrote:
> Add missing GIC interrupts property for pwm nodes.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> Fixed the patch indentation issue with all tabs.
> sorry checkpatch could not figure out the error.
> ---
>  arch/arm/boot/dts/exynos5.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)

Thanks, applied with fixed subsystem prefix in subject and indentation.

Best regards,
Krzysztof

