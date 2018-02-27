Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751901AbeB0WYU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 17:24:20 -0500
Received: from mail-io0-f179.google.com ([209.85.223.179]:36449 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751836AbeB0WYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 17:24:17 -0500
X-Google-Smtp-Source: AG47ELsCAUQ/jt9v8+I9s6LkxEwMUM4GRu1tmPnAgSmVZEpkWCEmEQglZ9BJmTMTnC/WNMamr88J3g==
Date: Tue, 27 Feb 2018 16:24:15 -0600
From: Andy Gross <andy.gross@linaro.org>
To: Abhishek Sahu <absahu@codeaurora.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, David Brown <david.brown@linaro.org>,
        Sricharan R <sricharan@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] i2c: qup: fixed releasing dma without flush
 operation completion
Message-ID: <20180227222415.GB20901@hector.attlocal.net>
References: <1517644697-30806-1-git-send-email-absahu@codeaurora.org>
 <1517644697-30806-2-git-send-email-absahu@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1517644697-30806-2-git-send-email-absahu@codeaurora.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 03, 2018 at 01:28:06PM +0530, Abhishek Sahu wrote:
> The QUP BSLP BAM generates the following error sometimes if the
> current I2C DMA transfer fails and the flush operation has been
> scheduled
> 
>     “bam-dma-engine 7884000.dma: Cannot free busy channel”
> 
> If any I2C error comes during BAM DMA transfer, then the QUP I2C
> interrupt will be generated and the flush operation will be
> carried out to make i2c consume all scheduled DMA transfer.
> Currently, the same completion structure is being used for BAM
> transfer which has already completed without reinit. It will make
> flush operation wait_for_completion_timeout completed immediately
> and will proceed for freeing the DMA resources where the
> descriptors are still in process.
> 
> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>

Reviewed-by: Andy Gross <andy.gross@linaro.org>
