Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBA6ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 08:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4946120882
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 08:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIZ+qtor"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4946120882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbeGOJSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 05:18:52 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:46791 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbeGOJSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 05:18:51 -0400
Received: by mail-lf0-f67.google.com with SMTP id l16-v6so30125892lfc.13;
        Sun, 15 Jul 2018 01:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Hlv/4+8T9RaYQSO7AjjR6Pm/eJyYsq3ofNI0fhMmYtI=;
        b=GIZ+qtorVISNXsb9b63b+GBBNiexJ9GH9nmmXvKQJ43VmSOKW+lR3/dIxkCKNoSlQo
         dkyNI14CVgLxP0L1qwzO29UYdKkjUB3mySxH5hZ1k7cVHTPXaNqiBDG737kGKGrITtO4
         jPa/hvRcAO6/BcisPjRZn3qJwN4wk5ljPknhv0Chz+bN5DJPdH6rNC343BQqf4wGzHBM
         vk6b9jTF+NFRyA1ejqfnskQ49HOntrC5j+w45Dt/IuWg9roS0YUIoUkjaNqWYLaPc/Dl
         OPleqF0ZZwC3JZvlhOjL1i02ucC0SKp1VQkMJxZVKJnNlnYzgZNpvwYaEQJwtYPtcKfq
         xqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hlv/4+8T9RaYQSO7AjjR6Pm/eJyYsq3ofNI0fhMmYtI=;
        b=cDFiGKeVXBAhRrYkDeD7sDW/S3u5gaXgpGku2bYwBLPMKNcFX+MI12bNNLk5m+b1dP
         hJYkfQA53i6JccSoHNmiRtIcNVwjfj9aZ0vawml4hTjyiKhEqoNwX6vzY805jcljV5YS
         ve51exIHXNZVFdKId+JgjTQNOCK0uOf3NVza3wKdITgDeXPb06yDyPxSAl8RhX42VHc2
         tTlKe04FlMtvmPgJgneGlMkAzCQjVB/VPLVMSxqdx4arI4NdkjgePNihJgrDDGEbVpVK
         VUNpBCBFIy7+YxfT+EGQQfyaT9kRaBKsvcCh4P5whzm0PJbNDt5NPzcf/Roev+81TmBS
         5v2w==
X-Gm-Message-State: AOUpUlEltHm1eJ+Jzrta3KyEANxFeGTmXXfrDRViEIillCFcaWvWge8m
        IHI+zd3UXSJWI2dMMPRbpqk=
X-Google-Smtp-Source: AAOMgpcTGzeVppJpDo1j4B+QTfpmAV24koyf0ktSuRgRFwjv5H1YcXA3SimpowOuDw4DKstHW+maQw==
X-Received: by 2002:a19:7d84:: with SMTP id y126-v6mr9584170lfc.94.1531644996714;
        Sun, 15 Jul 2018 01:56:36 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id z7-v6sm3826580lfg.89.2018.07.15.01.56.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Jul 2018 01:56:35 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1fecpQ-000642-8I; Sun, 15 Jul 2018 10:56:28 +0200
Date:   Sun, 15 Jul 2018 10:56:28 +0200
From:   Johan Hovold <johan@kernel.org>
To:     sean.wang@mediatek.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, marcel@holtmann.org,
        johan.hedberg@gmail.com, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Subject: Re: [PATCH v5 2/7] serdev: add dev_pm_domain_attach|detach()
Message-ID: <20180715085628.GI10204@localhost>
References: <cover.1531150733.git.sean.wang@mediatek.com>
 <d5904115ff1da38fe79b45fa3d59ef0688cea124.1531150733.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5904115ff1da38fe79b45fa3d59ef0688cea124.1531150733.git.sean.wang@mediatek.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 11:56:58PM +0800, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> In order to open up the required power gate before any operation can be
> effectively performed over the serial bus between CPU and serdev, it's
> clearly essential to add common attach functions for PM domains to serdev
> at the probe phase.
> 
> Similarly, the relevant dettach function for the PM domains should be
> properly and reversely added at the remove phase.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: linux-serial@vger.kernel.org

Reviewed-by: Johan Hovold <johan@kernel.org>
