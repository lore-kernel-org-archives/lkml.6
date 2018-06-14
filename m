Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E2D49C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97113208D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eY2hU5tz";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eY2hU5tz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97113208D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754991AbeFNKY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 06:24:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41764 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754790AbeFNKYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 06:24:24 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8F510601D2; Thu, 14 Jun 2018 10:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528971863;
        bh=1Z1xYTaj9n8p28FEJkNb8TZLUkw7HSwkKbEARi5FR08=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=eY2hU5tzrIxSJq1II8ouTibsOdNzOyTr9oz40R8xMXu+PBT3HJzQqPa6opXYuECPP
         74aSv9nwCRs+lIt+9A9Hi5Ai7Ay/84Nf1joYp8E1puLx1jr6LuKtZUpzbJ929OezQh
         IDqfP7OVwsuzPO0GYknSwRjv0BPJUhIlsAQsL9MM=
Received: from [10.79.40.126] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 535B76022C;
        Thu, 14 Jun 2018 10:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528971863;
        bh=1Z1xYTaj9n8p28FEJkNb8TZLUkw7HSwkKbEARi5FR08=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=eY2hU5tzrIxSJq1II8ouTibsOdNzOyTr9oz40R8xMXu+PBT3HJzQqPa6opXYuECPP
         74aSv9nwCRs+lIt+9A9Hi5Ai7Ay/84Nf1joYp8E1puLx1jr6LuKtZUpzbJ929OezQh
         IDqfP7OVwsuzPO0GYknSwRjv0BPJUhIlsAQsL9MM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 535B76022C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Subject: Re: [PATCH 5/5] soc: qcom: Remove depends on ARCH_QCOM
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-soc@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
References: <20180613125401.11734-1-niklas.cassel@linaro.org>
 <20180613125401.11734-6-niklas.cassel@linaro.org>
 <CAFp+6iFsLfKoLy+mzLP7-RGwSrkdA5sSt0UwNT7O6ehmn=VckQ@mail.gmail.com>
 <CAFp+6iEfd_iBCUtuYbe+vsc31BSC2UVee6YNNSGX5XxMMjJ=aA@mail.gmail.com>
 <20180614083116.GA18093@centauri.lan>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Message-ID: <0d81a67c-07be-21f5-da2d-ef18b039d30d@codeaurora.org>
Date:   Thu, 14 Jun 2018 15:54:18 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180614083116.GA18093@centauri.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi NIklas,


On 6/14/2018 2:01 PM, Niklas Cassel wrote:
> On Thu, Jun 14, 2018 at 12:08:10PM +0530, Vivek Gautam wrote:
>> On Thu, Jun 14, 2018 at 12:05 PM, Vivek Gautam
>> <vivek.gautam@codeaurora.org> wrote:
>>> On Wed, Jun 13, 2018 at 6:24 PM, Niklas Cassel <niklas.cassel@linaro.org> wrote:
>>>> Since commit cab673583d96 ("soc: Unconditionally include qcom Makefile"),
>>>> we unconditionally include the soc/qcom/Makefile.
>>>>
>>>> This opens up the possibility to compile test the code even when
>>>> building for other architectures.
>>> Why do we want to do this when all of it is qcom specific?
>>> Besides, wouldn't this increase the binary size for other platforms.
> To be able to compile test drivers that select some of these Kconfigs,
> even when building for other architectures.

Are these other drivers which select these Kconfigs not QCOM dependent?
We should make them so if that's not the case, and also add COMPILE_TEST
for them too.

>
> The binary size shouldn't increase if they don't enable these Kconfigs.
>
>> Sorry, my bad. Send the message without completing.
>>
>> Besides above points, the COMPILE_TEST flag should allow you
>> to compile test all of these drivers. If COMPILE_TEST is missing
>> in some of the configs, we should try adding that.
>> Or, is there anything that I am missing here for the intention of this patch?
> That is another alternative.
> So either make sure that all these Kconfigs
> have "depends on ARCH_QCOM || COMPILE_TEST",
> or
> remove ARCH_QCOM from these Kconfigs.
>
> A third, and perhaps best alternative is to do like
> drivers/soc/mediatek/Kconfig
>
> menu "MediaTek SoC drivers"
>      depends on ARCH_MEDIATEK || COMPILE_TEST
>
> Make sure that our root menu entry depends on ARCH_QCOM || COMPILE_TEST,
> that way we could remove ARCH_QCOM for all Kconfigs.
>
> Thoughts?

To me the first and third approach look same. So I will leave it to Andy 
to decide
which is cleaner.
For 2nd option, I would still say that there shouldn't be a need for 
these drivers
to be compiled outside of the ARCH_QCOM, besides for compile test purpose.

Thanks & Regards
Vivek

>
>
> Regards,
> Niklas
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

