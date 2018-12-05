Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91F9C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C12220879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZzD7yNiE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C12220879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbeLEQAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 11:00:50 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41588 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbeLEQAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 11:00:47 -0500
Received: by mail-wr1-f68.google.com with SMTP id x10so20234628wrs.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 08:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e+A/P8vIx8+I9YlWXdN5xVJYj8QHf39w8WJQL5W9WYc=;
        b=ZzD7yNiEhJ0fMtpwE414Jq6o8OHF8cYzckJF+Vy8UvE/EKPHes2By5llFn49gsvoAt
         Qx4Yv68rbKLrbadEoBCEgaigezfGKcpNcnfnGP9OwViG76oGg1VLdHRaRcSImOmfmbux
         ueEzBLmr5LrgcqYM/68yvMO9mnE/TK4ukEDDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e+A/P8vIx8+I9YlWXdN5xVJYj8QHf39w8WJQL5W9WYc=;
        b=g56g/+7dKrWr6O/PyuJjV8YSX3B8pBswqKsXQCOUin6VlJ88pkNReVc0ITwG2Nnfj7
         6e96gQe1F5iESx1pYIM7oXjec/j+5IKgMu5u0TTSJFJBbJMTaKAIoBTxWiuSTDL5/C9/
         GYRBvvqAEwldasbZ5d1uTngwa7JMVihvvr9LPJzQOgcyC74hWdM91w7TkK7IAPrcrn3J
         uSwLQjQiAZYNOiYB5sKu4T6Aiuou0Y6eNbpe7wGjRapxfgX0bii/V75rtQpELqhtGbPS
         yeP2cfpnaw8Il8jCjW7yTkWYT3c/OOHtiaOKkrHxJA4wrMGl7iSJzOKV773kY3QlG/9o
         /wDw==
X-Gm-Message-State: AA+aEWZ5d2d3teqPWSZbUbp2zJ0sv81OwMvc3ekwVBY8Fo/85aXirga9
        1w8ZxUnIb+n6JscVLpp2l8CWIA==
X-Google-Smtp-Source: AFSGD/XvAvuiN5pERyry+QGYHVUGT70IIcmxdo3YBr0LAHsUeZRa1NpqhNrYEBmAq+u+Oie+H2yxXw==
X-Received: by 2002:adf:ecc8:: with SMTP id s8mr2477658wro.208.1544025645287;
        Wed, 05 Dec 2018 08:00:45 -0800 (PST)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id t76sm27171160wme.33.2018.12.05.08.00.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 08:00:44 -0800 (PST)
Subject: Re: [PATCH v10 5/7] interconnect: qcom: Add sdm845 interconnect
 provider driver
To:     Evan Green <evgreen@chromium.org>
Cc:     linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        rjw@rjwysocki.net, robh+dt@kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        khilman@baylibre.com, Vincent Guittot <vincent.guittot@linaro.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, Alexandre Bailon <abailon@baylibre.com>,
        maxime.ripard@bootlin.com, Arnd Bergmann <arnd@arndb.de>,
        thierry.reding@gmail.com, ksitaraman@nvidia.com,
        sanjayc@nvidia.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20181127180349.29997-1-georgi.djakov@linaro.org>
 <20181127180349.29997-6-georgi.djakov@linaro.org>
 <CAE=gft4tO96n0vAubo1_vvcTO4yarDcTNOTuL6cLpmLDDNxrfA@mail.gmail.com>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <cfcb39ba-860c-5a3f-911f-ab52b5250390@linaro.org>
Date:   Wed, 5 Dec 2018 18:00:44 +0200
MIME-Version: 1.0
In-Reply-To: <CAE=gft4tO96n0vAubo1_vvcTO4yarDcTNOTuL6cLpmLDDNxrfA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Evan,

On 12/1/18 02:39, Evan Green wrote:
> On Tue, Nov 27, 2018 at 10:04 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>>
>> From: David Dai <daidavid1@codeaurora.org>
>>
>> Introduce Qualcomm SDM845 specific provider driver using the
>> interconnect framework.
>>
>> Signed-off-by: David Dai <daidavid1@codeaurora.org>
>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>> ---
>>  .../bindings/interconnect/qcom,sdm845.txt     |  24 +
>>  drivers/interconnect/Kconfig                  |   5 +
>>  drivers/interconnect/Makefile                 |   1 +
>>  drivers/interconnect/qcom/Kconfig             |  13 +
>>  drivers/interconnect/qcom/Makefile            |   5 +
>>  drivers/interconnect/qcom/sdm845.c            | 836 ++++++++++++++++++
>>  .../dt-bindings/interconnect/qcom,sdm845.h    | 143 +++
>>  7 files changed, 1027 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt
>>  create mode 100644 drivers/interconnect/qcom/Kconfig
>>  create mode 100644 drivers/interconnect/qcom/Makefile
>>  create mode 100644 drivers/interconnect/qcom/sdm845.c
>>  create mode 100644 include/dt-bindings/interconnect/qcom,sdm845.h
>>
>> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt b/Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt
>> new file mode 100644
>> index 000000000000..d45150e99665
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt
>> @@ -0,0 +1,24 @@
>> +Qualcomm SDM845 Network-On-Chip interconnect driver binding
>> +-----------------------------------------------------------
>> +
>> +SDM845 interconnect providers support system bandwidth requirements through
>> +RPMh hardware accelerators known as Bus Clock Manager(BCM). The provider is able
>> +to communicate with the BCM through the Resource State Coordinator(RSC)
>> +associated with each execution environment. Provider nodes must reside within
>> +an RPMh device node pertaining to their RSC and each provider maps to
>> +a single RPMh resource.
>> +
>> +Required properties :
>> +- compatible : shall contain only one of the following:
>> +                       "qcom,sdm845-rsc-hlos"
> 
> I wonder if maybe hlos isn't necessary. Unless you somehow imagine
> secure mode would have a device tree entry in here as well? Probably
> not.

Ok, will remove it. David, please chime in if you have any concerns with
this.

>> +- #interconnect-cells : should contain 1
>> +
>> +Examples:
>> +
>> +apps_rsc: rsc {
>> +               qnoc: qnoc-rsc-hlos {
>> +                       compatible = "qcom,sdm845-rsc-hlos";
>> +                       #interconnect-cells = <1>;
>> +               };
>> +};
>> +
> ...
>> diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
>> new file mode 100644
>> index 000000000000..1678de91ca52
>> --- /dev/null
>> +++ b/drivers/interconnect/qcom/sdm845.c
>> @@ -0,0 +1,836 @@
> ...
>> +
>> +static void tcs_list_gen(struct list_head *bcm_list,
>> +                        struct tcs_cmd *tcs_list, int *n)
> 
> We could make the prototype of this function be:
> 
> static void tcs_list_gen(struct list_head *bcm_list,
>         struct tcs_cmd tcs_list[SDM845_MAX_VCD], int n[SDM845_MAX_VCD])
> 
> which would catch errors if somebody later passed in an array that
> wasn't the right size, since we blindly memset below.

Yes, sounds good. I will try to optimize it.

Thanks,
Georgi

>> +{
>> +       struct qcom_icc_bcm *bcm;
>> +       bool commit;
>> +       size_t idx = 0, batch = 0, cur_vcd_size = 0;
>> +
>> +       memset(n, 0, sizeof(int) * SDM845_MAX_VCD);
>> +
>> +       list_for_each_entry(bcm, bcm_list, list) {
>> +               commit = false;
>> +               cur_vcd_size++;
>> +               if ((list_is_last(&bcm->list, bcm_list)) ||
>> +                   bcm->aux_data.vcd != list_next_entry(bcm, list)->aux_data.vcd) {
>> +                       commit = true;
>> +                       cur_vcd_size = 0;
>> +               }
>> +               tcs_cmd_gen(&tcs_list[idx], bcm->vote_x, bcm->vote_y,
>> +                           bcm->addr, commit);
>> +               idx++;
>> +               n[batch]++;
>> +               /*
>> +                * Batch the BCMs in such a way that we do not split them in
>> +                * multiple payloads when they are under the same VCD. This is
>> +                * to ensure that every BCM is committed since we only set the
>> +                * commit bit on the last BCM request of every VCD.
>> +                */
>> +               if (n[batch] >= MAX_RPMH_PAYLOAD) {
>> +                       if (!commit) {
>> +                               n[batch] -= cur_vcd_size;
>> +                               n[batch + 1] = cur_vcd_size;
>> +                       }
>> +                       batch++;
>> +               }
>> +       }
>> +}
>> +
