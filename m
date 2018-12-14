Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABCDC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 04:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EA042080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 04:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SEAvQyE9";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YQvIpwhC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EA042080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbeLNEJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 23:09:51 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:49138 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbeLNEJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 23:09:50 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 37CE660208; Fri, 14 Dec 2018 04:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544760589;
        bh=BQZnCDxAu2sybs4TVB7XUfxNnM1O7V6PQq0aXMiMtmU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SEAvQyE98Ho+TI6XG6FtcEiZwEy2xp7kS9WplltWrHVrrD8aTkY44JBaRB8mg7mX6
         O3II2l+KP0so+YZGJuHWnpbZlLxInsrFDtIzgAfUDwzx+9QAQx3EVO/MfF38vWVruy
         NmNtt12irsTGaOFO4LorWmCG2H6ieZ04q+kbbyv4=
Received: from [10.79.165.223] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E54B86021A;
        Fri, 14 Dec 2018 04:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544760588;
        bh=BQZnCDxAu2sybs4TVB7XUfxNnM1O7V6PQq0aXMiMtmU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=YQvIpwhC4ZAblqYy9r+Ks8gbk5pd/KNlZtMkOF2ONXjpnYdZZrBrGkOkthrXU+Vo0
         NsWvvRv0C5CDDG2CWNhUOpCAwn6mvBOqC44x9w004BWqtXnq2mjkhw+qtUfobuCtln
         IFIQPX6J0hPrnfCRS6KAEhiWmuSitxf1mbmdfy/M=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E54B86021A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v12 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ
 Firmware bindings
To:     Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org,
        robh@kernel.org, skannan@codeaurora.org,
        linux-arm-msm@vger.kernel.org, evgreen@google.com,
        Matthias Kaehlcke <mka@chromium.org>
References: <1544687394-331-1-git-send-email-tdas@codeaurora.org>
 <1544687394-331-2-git-send-email-tdas@codeaurora.org>
 <154468968610.19322.9386616050590076502@swboyd.mtv.corp.google.com>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <822086a5-a3ca-f44c-33be-5a51894f39d5@codeaurora.org>
Date:   Fri, 14 Dec 2018 09:39:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <154468968610.19322.9386616050590076502@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen,

On 12/13/2018 1:58 PM, Stephen Boyd wrote:
> Quoting Taniya Das (2018-12-12 23:49:53)
>> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
>> new file mode 100644
>> index 0000000..2b82965
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
>> @@ -0,0 +1,172 @@
> [...]
>> +- reg-names
>> +       Usage:          Optional
>> +       Value type:     <string>
>> +       Definition:     Frequency domain name i.e.
>> +                       "freq-domain0", "freq-domain1".
>> +
>> +- freq-domain-cells:
> 
> Should be #freq-domain-cells? Or maybe #qcom,freq-domain-cells?
> 

Updated in the next series.

>> +       Usage:          required.
>> +       Definition:     Number of cells in a freqency domain specifier.
>> +
>> +* Property qcom,freq-domain
>> +Devices supporting freq-domain must set their "qcom,freq-domain" property with
>> +phandle to a cpufreq_hw followed by the Domain ID(0/1) in the CPU DT node.
>> +
>> +

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
