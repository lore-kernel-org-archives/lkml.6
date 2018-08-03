Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C213FC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7225C21759
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SHg/WEV9";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bXc9DCIU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7225C21759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731507AbeHCOPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 10:15:46 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47426 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727677AbeHCOPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 10:15:45 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 099D060AD8; Fri,  3 Aug 2018 12:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533298780;
        bh=AbX2Wxt9sMB9xSEZGFpQnYA1gMroJgQKawrKjz57FCk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SHg/WEV9mvKuK+JMAEobhOiyChvSX0Iq29OgI3XciKk0w8Dm6A3QzDz+xBifP6zka
         Bb/UkCn2yPTB/47f+z7PgthjCh3fZxZB0peIwnO7TXufUm9xalhR9G8I/WITS7C30p
         JfK1TNCzHgmQ0qhtDkPFseTEfQ/cMQNCm4TmCB5U=
Received: from [192.168.225.247] (unknown [49.32.113.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 83FFD6031A;
        Fri,  3 Aug 2018 12:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533298779;
        bh=AbX2Wxt9sMB9xSEZGFpQnYA1gMroJgQKawrKjz57FCk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=bXc9DCIUO2DzFM/xfCN79s0jghUONPGRYdHvHiByjUjs/PiQ0DuEL5Zcx9apPuaoH
         NJSUWLcEk/9Afm5chY5Vv7RNBDaP3aejvXgUCWVOA2WU1JKmbFEUOC4IGsiyxTMUMd
         vLlFAwlKRkdKZrEQBkKq38r6Knyel4F0O3PWnYuc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 83FFD6031A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: Introduce QCOM LPASS clock
 bindings
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        rohitkr@codeaurora.org
References: <1530773721-14668-1-git-send-email-tdas@codeaurora.org>
 <1530773721-14668-2-git-send-email-tdas@codeaurora.org>
 <153092054581.143105.16123786121344421693@swboyd.mtv.corp.google.com>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <408b3b59-d171-175c-f6da-b5d6f42a954d@codeaurora.org>
Date:   Fri, 3 Aug 2018 17:49:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <153092054581.143105.16123786121344421693@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/7/2018 5:12 AM, Stephen Boyd wrote:
> Quoting Taniya Das (2018-07-04 23:55:20)
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,lpasscc.txt b/Documentation/devicetree/bindings/clock/qcom,lpasscc.txt
>> new file mode 100644
>> index 0000000..fe7378b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/qcom,lpasscc.txt
>> @@ -0,0 +1,22 @@
>> +Qualcomm LPASS Clock Controller Binding
>> +-----------------------------------------------
>> +
>> +Required properties :
>> +- compatible   : shall contain "qcom,sdm845-lpasscc"
>> +- #clock-cells : from common clock binding, shall contain 1.
>> +- reg          : shall contain base register address and size.
>> +- reg-names    : shall contain the register names of LPASS domain
>> +                       "lpass_gcc", "lpass_cc", "lpass_qdsp6ss".
>> +
>> +Example:
>> +
>> +The below node has to be defined in the cases where the LPASS peripheral loader
>> +would bring the subsystem out of reset.
>> +
>> +       lpasscc: clock-controller {
>> +               compatible = "qcom,sdm845-lpasscc";
>> +               reg = <0x00147000 0x20>, <0x17014000 0x1f004>,
> 
> This first reg is inside GCC though? Why isn't it added to the gcc
> sdm845 driver? And then the next two might make sense as a different
> region, but the reg property ending in 20 looks really weird.
>
I have moved the GCC registers in the GCC driver with a device tree 
property flag. And also have mapped the lpass_qdsp6ss CC region.

>> +                       <0x17300020 0x20>;
>> +               reg-names = "lpass_gcc", "lpass_cc", "lpass_qdsp6ss";
>> +               #clock-cells = <1>;
>> +       };

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
