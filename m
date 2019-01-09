Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBDAC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 08:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E5FA20821
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 08:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OiF6LQm9";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MGQ+91X+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbfAIIfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 03:35:19 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:54754 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729141AbfAIIfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 03:35:19 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 34E086089D; Wed,  9 Jan 2019 08:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547022918;
        bh=3z9lErcW4OLpFttk5/2rEtHgAvfObZGD/MYID4l3Ax8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OiF6LQm9PByQA2FzeB8dYDRKwRQSiSNYPvQuq2KBZ4axoVK9AsNHKxFr72JT37FAi
         5Oc9ca7o+0O4jeHQL6Gdu71xHK0/nTwTr6rmdfpSCEYoO6pqaYL7exgjdmoidupvZp
         Upd3PrjKw8KR7QCidk3tA+uQ6JHnXsTkEJ5qDlK4=
Received: from [10.204.110.203] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1D20760300;
        Wed,  9 Jan 2019 08:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547022916;
        bh=3z9lErcW4OLpFttk5/2rEtHgAvfObZGD/MYID4l3Ax8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MGQ+91X+x9tvpBrVK8ltCdu+OQuOXV0JaROcLBfBdjr7L6wIL46mT1523rrsCw0xG
         iJkaT7/6quIleXw1xyC7jZFSXWF1yMUrT+udBodPa1MTv0YvHVT9Xz+CIe27hDrevZ
         jprv/Sq2XUp7t6BI6BCbg8g6PNHQJaOc8NU+9gFA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1D20760300
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
Subject: Re: [PATCH 2/2] ASoC: qcom: defer probe if platform dai is not
 registered
To:     Mark Brown <broonie@kernel.org>
Cc:     plai@codeaurora.org, bgoswami@codeaurora.org,
        asishb@codeaurora.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, rohkumar@qti.qualcomm.com,
        srinivas.kandagatla@linaro.org, Ajit Pandey <ajitp@codeaurora.org>
References: <1545642133-16120-1-git-send-email-rohitkr@codeaurora.org>
 <1545642133-16120-3-git-send-email-rohitkr@codeaurora.org>
 <20190107182757.GS9570@sirena.org.uk>
From:   Rohit Kumar <rohitkr@codeaurora.org>
Message-ID: <b8e7daaa-d3dd-380c-fb37-d4867be76b5d@codeaurora.org>
Date:   Wed, 9 Jan 2019 14:05:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190107182757.GS9570@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Mark for review.

On 1/7/2019 11:57 PM, Mark Brown wrote:
> On Mon, Dec 24, 2018 at 02:32:13PM +0530, Rohit kumar wrote:
>> From: Ajit Pandey <ajitp@codeaurora.org>
>>
>> Platform DAI component probe is not called if it is not
>> present in component list during sound card registration.
>> Check if component is registered for platform dai before
>> soundcard registration.
> Why do we need to do this in the driver, I'd expect this to be something
> that we need to do for everything not just this driver so I'd expect it
> to be handled in the core?
True. Will post generic change which will not need change in machine driver.

-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the Linux Foundation.

