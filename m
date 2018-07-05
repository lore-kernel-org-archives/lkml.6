Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD0BC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 23:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D87332407D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 23:23:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D87332407D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753951AbeGEXXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 19:23:45 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:37058 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753911AbeGEXXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 19:23:42 -0400
Received: by mail-oi0-f66.google.com with SMTP id k81-v6so20077327oib.4;
        Thu, 05 Jul 2018 16:23:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TMlBjLS5kfSjccmoE7a3VW7LgllgO4HkwXXvrdQnCCY=;
        b=b8z/4GMrjRGNeBh13LmCjt2uKRigq5UGbvKckMxD9fYM2ng7QLozF4zlZZgHDqUq8d
         ImcAxrarH9nuxN9mEQ6fTnJo6g4F78KSMzBGEsCXXbC4zst9mBa9T5ikfHuCMPmWcq5E
         lR6GISX8JogZKqWj0dACfZJUvvCQSLUBzGqYZKXNw1l+PIfrBite4OD3gYtFLsaLjZSR
         CvJhZ0REOC16WXr8PhPrhBzNn9OMyiJeUhDYPlNOP6TWo5oK1HalN8ScQ3QX1Eom/NPY
         lw+sc/QwdqBtigKJU1G1roXFD0qQPN7ww55tnltRp8GvlwCAuH+VEoaVhXsfSV58Yx8Q
         +WbA==
X-Gm-Message-State: APt69E0IIbLrpGUvAQQ8St1/3DsztRnRDDeoyjsgYQfhpC0+ZOrdOc/r
        Tr8mWZYJ1ipkTuNbg98eKQ==
X-Google-Smtp-Source: AAOMgpdUO9Ps/VBAd98QG8BSYpV5hu0xRxnCaQci1NIzxmwt4lluOlGTyUQbcS5f5TgNXRlXouvGOg==
X-Received: by 2002:aca:b909:: with SMTP id j9-v6mr8437824oif.135.1530833022252;
        Thu, 05 Jul 2018 16:23:42 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id g65-v6sm2587256oia.23.2018.07.05.16.23.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Jul 2018 16:23:41 -0700 (PDT)
Date:   Thu, 5 Jul 2018 17:23:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mars Cheng <mars.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, wsd_upstream@mediatek.com,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 3/4] dt-bindings: interrupt-controller: add binding
 for mt6765
Message-ID: <20180705232340.GA14969@rob-hp-laptop>
References: <1530669174-17623-1-git-send-email-mars.cheng@mediatek.com>
 <1530669174-17623-4-git-send-email-mars.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530669174-17623-4-git-send-email-mars.cheng@mediatek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 09:52:53AM +0800, Mars Cheng wrote:
> Update the dt-binding documentation of sysirq for mt6765
> 
> Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
> ---
>  .../interrupt-controller/mediatek,sysirq.txt       |    1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Rob Herring <robh@kernel.org>
