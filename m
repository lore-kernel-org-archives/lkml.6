Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398A5C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E778420870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MGtHMyzU";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="i+cQcQHW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E778420870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbeIJVxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 17:53:11 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43528 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbeIJVxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 17:53:11 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9EBF76081C; Mon, 10 Sep 2018 16:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536598691;
        bh=ciwg8gQmP2Cd79O7rr+D1N/kcw+DDtbGgBbaBbbOvAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MGtHMyzUnbhK5DS+8FoLhnlQDlgySMeaeQ2ORqgovAjy8A/O8vM+4NzF+HGwmk54u
         +bKIZ9r8rfXz18O6KJzYP4CSFHu0cukwoHY41qj5E5tLQnZffd0mCUvkOh2ssOygw2
         fi9TaQXKhCkpAvgECEgqQJV5ouGqchJpz+K9pfIo=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 19C856078C;
        Mon, 10 Sep 2018 16:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536598690;
        bh=ciwg8gQmP2Cd79O7rr+D1N/kcw+DDtbGgBbaBbbOvAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i+cQcQHWplIAmn8M6+fXsvme8pDWcAwBNEIoFQaGp4kLf4nU6OwrHIoSD+ey68GbG
         AphryN9gisdGgfQk/UXA00rBp4lCcP4bV7rwyNV+s8pijWpb8rPI3+IlLsJC+FAyxx
         lRTYxxkCzd1zIXNY42ZChqhxDKaKkF16XiWa/m5k=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 19C856078C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Mon, 10 Sep 2018 10:58:08 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Rob Herring <robh@kernel.org>
Cc:     marc.zyngier@arm.com, bjorn.andersson@linaro.org, sboyd@kernel.org,
        evgreen@chromium.org, linus.walleij@linaro.org,
        rplsssn@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, rnayak@codeaurora.org,
        devicetree@vger.kernel.org, andy.gross@linaro.org,
        dianders@chromium.org
Subject: Re: [PATCH v3 2/5] dt-bindings: pinctrl: add wakeup capable GPIOs
 for SDM845
Message-ID: <20180910165808.GF15710@codeaurora.org>
References: <20180904211810.5506-1-ilina@codeaurora.org>
 <20180904211810.5506-3-ilina@codeaurora.org>
 <20180910162822.GA5636@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180910162822.GA5636@bogus>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10 2018 at 10:28 -0600, Rob Herring wrote:
>On Tue, Sep 04, 2018 at 03:18:07PM -0600, Lina Iyer wrote:
>> Update the documentation to use interrupts-extended format for
>> specifying the TLMM summary IRQ line that is requested from GIC and the
>> PDC interrupts corresponding to the wakeup capable GPIOs.
>>
>> Update the example to show PDC interrupts for the wakeup capable GPIOs
>> for SDM845.
>>
>> Cc: devicetree@vger.kernel.org
>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>> ---
>> Changes in v2:
>> 	- Fix PDC IRQ number in example
>> 	- Describe IRQ trigger type in example
>> ---
>>  .../bindings/pinctrl/qcom,sdm845-pinctrl.txt  | 104 +++++++++++++++++-
>>  1 file changed, 101 insertions(+), 3 deletions(-)
>
>As I also mentioned in v2. Please add acks/reviewed-bys when posting new
>versions.
>
Sorry Rob. I added to patch 5, but forgot this one. Thanks for pointing
out. Will add it in the next spin. Sorry for wasting your time.

-- Lina

