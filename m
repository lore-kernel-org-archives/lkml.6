Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5CFC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 03:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B6420844
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 03:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="GyoxY+ea";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R5By0Z1V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62B6420844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388225AbeGXEen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 00:34:43 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:34387 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388140AbeGXEen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 00:34:43 -0400
Received: by mail-vk0-f65.google.com with SMTP id l143-v6so1376653vke.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 20:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=8xBqHfj+h9JaQucRna70u2kTOWQGl60PEQjHGQ9dWKk=;
        b=GyoxY+ea5v1vECA1YYKAzoSir1cpCG1lclnSaCXV6bXF9XQEeNzdldFAb3lxkFW5st
         KA4P76dVyLbeq9uSk8A9MWuw2Ovtho8Lh07nDJ8WeHWRLJB5kQvEbY79wdcF1IcS9pL0
         fKNdBmX67/de4VK9ViwwvKq2UmFs/8skwo1iOyMwU+lX3wubVGH0Pq96hIbWl1/7B73w
         j9iwrgPoFFsAm0LevR1Z33yJnlIrFZ7O8kv6/eFcyVh6BNrAlIT8odl3c4Rj/iHB8huw
         NxcvSqUASoaf4xqBsvJKuHihTisK24z29zExH5KogLJIyXEiljXjdSkXphOl/35iK7ot
         DEYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=8xBqHfj+h9JaQucRna70u2kTOWQGl60PEQjHGQ9dWKk=;
        b=R5By0Z1VHUkOgI5D2zlsCItltiv7ifb8ho1pWRxvy7DBWTCrnW0IVHCEygJjlfG2P6
         TOSzzqg4/8nrZvFSuDjY+QhMM3dDnM6pvBi91kTVYzQJh6C2rXJHwWaEC5s77AArOOat
         DIQGBAvAZJovyrsF29DkunDpcRFULbwabiw8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=8xBqHfj+h9JaQucRna70u2kTOWQGl60PEQjHGQ9dWKk=;
        b=ex/S2xK8MMrodTElrsqT5GJ5qSsWQpOAq0OaWc32W+l8YK0dqRKpOMyWvULeol8oBy
         NxybNuW6iSFIngIblaB6ckbX+EnGqDThh1jId9Cx25TvsCdrIIAEFj8NtC13Bju1tmO+
         w5JgecyV86Kfz7DyHIg/JYRuKUyAh7zSTz79wx5T5kSoxeJfOkaQBa/7uLpTAkrcrM8g
         vr5IgGOirQLwaKg0eNi4suL6mlrcmgH3Aw+NJgdf/XOJUl803w/VKV2o0AyHWakZ/9b2
         2G2Zi/glP8M+5kgiLIDVdde+8gQShoz/glacOC/mKbTQfyWGQLMIoRydNkMl12IH7oxo
         luJQ==
X-Gm-Message-State: AOUpUlEjtsvSRLJH4g5VItgWfxawJ8PihhhBuVs7xuqCuPpFFE61hWZy
        X9DZWQBe84Hop4alTYV2sbEMH+bSqpKo3JOGwklr7g==
X-Google-Smtp-Source: AAOMgpdMWhBegeIDEo6vK8zziihWNUoasu3Je6K5nZD0MnTqqVRYS8V9BLcqms7bRIaDVRiaItXxsveSv59iV3hgR9U=
X-Received: by 2002:a1f:ebc7:: with SMTP id j190-v6mr9294171vkh.114.1532403022446;
 Mon, 23 Jul 2018 20:30:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:cd5:0:0:0:0:0 with HTTP; Mon, 23 Jul 2018 20:30:21 -0700 (PDT)
In-Reply-To: <f4f92dcd-7a63-f9de-a7a0-c403672d5c6c@codeaurora.org>
References: <20180723215404.74296-1-dianders@chromium.org> <20180723215404.74296-3-dianders@chromium.org>
 <f4f92dcd-7a63-f9de-a7a0-c403672d5c6c@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 23 Jul 2018 20:30:21 -0700
X-Google-Sender-Auth: -boQoYvWeDywXYSV8ucZD0RvBRo
Message-ID: <CAD=FV=WkC5BsreD8t8_+-5J3ztFp5nAFAA+HSwHVvYW3ED3yiA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] clk: qcom: Add qspi (Quad SPI) clocks for sdm845
To:     Taniya Das <tdas@codeaurora.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <andy.gross@linaro.org>, grahamr@codeaurora.org,
        Girish Mahadevan <girishm@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Brown <david.brown@linaro.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 23, 2018 at 7:22 PM, Taniya Das <tdas@codeaurora.org> wrote:
>
>
> On 7/24/2018 3:24 AM, Douglas Anderson wrote:
>>
>> Add both the interface and core clock.
>>
>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>> ---
>>
>> Changes in v2:
>> - Only 19.2, 100, 150, and 300 MHz now.
>> - All clocks come from MAIN rather than EVEN.
>> - Use parent map 0 instead of new parent map 9.
>>
>>   drivers/clk/qcom/gcc-sdm845.c | 63 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 63 insertions(+)
>>
>> diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
>> index 0f694ed4238a..5bca634e277a 100644
>> --- a/drivers/clk/qcom/gcc-sdm845.c
>> +++ b/drivers/clk/qcom/gcc-sdm845.c
>> @@ -162,6 +162,13 @@ static const char * const gcc_parent_names_10[] = {
>>         "core_bi_pll_test_se",
>>   };
>>   +static const char * const gcc_parent_names_9[] = {
>> +       "bi_tcxo",
>> +       "gpll0",
>> +       "gpll0_out_even",
>> +       "core_pi_sleep_clk",
>> +};
>> +
>
>
> Please remove this.

Oops, that's embarrassing.  Please stay tuned for v3.

-Doug
