Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F5FECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FE97206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XDoy7IIb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FE97206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732119AbeGTPeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 11:34:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39313 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731546AbeGTPen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 11:34:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id h10-v6so11563473wre.6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 07:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:subject:to:cc:references:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BNZLJrsjRYshtbPp4D/+TQbKFHkQONsPqN0Wn1BzeS4=;
        b=XDoy7IIbZKXqTJfS+yGTvoHMO4i5N9jjDGnhataO6Ew86M0GYozG6k09MkhbtpCtG6
         EomiUNuq0g87ElGi1xwcwGHu2DpWfErSeSySbq0x9iWButv7NjEX4/ggl+Z9p2CJIclu
         D/Sc3bHK9b/LCfJkfcKjbuz8aGg8cyu5XrnBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BNZLJrsjRYshtbPp4D/+TQbKFHkQONsPqN0Wn1BzeS4=;
        b=dms3U6khVngtcF1Nead2UBbkb06UpfCzS56LRaHTsbbGyYJrcMDClfwoyN5U8Zfmba
         P2xLXPdmIziKp0zEf2M5bmqrPqmiviud9rPNPSJqLcsy67Hl/HH/teAtPKlq1l4LJBAZ
         4s7ECFf6lEd+Fr9SEh9Fl7GhRl5T4Ko2TDaqu6yLB3XFWAyM1K/CpXXtUEzIfv2H6PV4
         6Ca+tiPicNCujIK7xhWhMrS6TEG/4bmADv5iXHOMxI8LCvIwzOlUd2aooQx0HYvXn0GV
         rI169dklqhcdlkYlMC3UQF7T5U3vYjXnxAzO+EBsm/v9kVuSgeTvUbF0WMOwb7+aw2ts
         RSKA==
X-Gm-Message-State: AOUpUlF7kpDPDoDpGhTjnN02g6PUBMFMxMTAjzjpQ0gnq7SQi76pwgpp
        vnbArQzbkFP3d9mVPma/ojGpxg==
X-Google-Smtp-Source: AAOMgpeNNjMEC6sRcnV7tKrVbuvoKflkO4FoEFHUk733/r0X/1310yNDktWXMtxB4jyjGpvnQ9mF2Q==
X-Received: by 2002:adf:f342:: with SMTP id e2-v6mr1696651wrp.161.1532097963857;
        Fri, 20 Jul 2018 07:46:03 -0700 (PDT)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id 31-v6sm3403536wra.26.2018.07.20.07.46.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 07:46:03 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v6 6/8] interconnect: qcom: Add msm8916 interconnect
 provider driver
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com,
        khilman@baylibre.com, abailon@baylibre.com,
        vincent.guittot@linaro.org, skannan@codeaurora.org,
        bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        evgreen@chromium.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
References: <20180709155104.25528-1-georgi.djakov@linaro.org>
 <20180709155104.25528-7-georgi.djakov@linaro.org>
 <20180709235610.GO129942@google.com>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <ad263e3f-cdb6-d3b7-35ef-91dfa6f98fe4@linaro.org>
Date:   Fri, 20 Jul 2018 17:46:01 +0300
MIME-Version: 1.0
In-Reply-To: <20180709235610.GO129942@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 07/10/2018 02:56 AM, Matthias Kaehlcke wrote:
> Hi,
> 
> On Mon, Jul 09, 2018 at 06:51:02PM +0300, Georgi Djakov wrote:
>> Add driver for the Qualcomm interconnect buses found in msm8916 based
>> platforms.
>>
>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>> ---
>>  drivers/interconnect/Kconfig        |   5 +
>>  drivers/interconnect/Makefile       |   1 +
>>  drivers/interconnect/qcom/Kconfig   |  10 +
>>  drivers/interconnect/qcom/Makefile  |   2 +
>>  drivers/interconnect/qcom/msm8916.c | 499 ++++++++++++++++++++++++++++
>>  5 files changed, 517 insertions(+)
>>  create mode 100644 drivers/interconnect/qcom/msm8916.c
>>

[..]

>> +/**
>> + * struct qcom_icc_node - Qualcomm specific interconnect nodes
>> + * @name: the node name used in debugfs
>> + * @links: an array of nodes where we can go next while traversing
>> + * @id: a unique node identifier
> 
> nit: move up to keep 'links' and 'num_links' together? Also 'name' and
> 'id' are similar fields, so keeping them together makes sense.

Ok.

>> + * @num_links: the total number of @links
>> + * @port: the offset index into the masters QoS register space
>> + * @buswidth: width of the interconnect between a node and the bus (bytes)
>> + * @ap_owned: the AP CPU does the writing to QoS registers
>> + * @qos_mode: QoS mode for ap_owned resources
>> + * @mas_rpm_id:	RPM id for devices that are bus masters
>> + * @slv_rpm_id:	RPM id for devices that are bus slaves
>> + * @rate: current bus clock rate in Hz
>> + */
>> +struct qcom_icc_node {
>> +	unsigned char *name;
>> +	u16 links[MSM8916_MAX_LINKS];
>> +	u16 id;
>> +	u16 num_links;
>> +	u16 port;
>> +	u16 buswidth;
>> +	bool ap_owned;
>> +	enum qcom_qos_mode qos_mode;
>> +	int mas_rpm_id;
>> +	int slv_rpm_id;
>> +	u64 rate;
>> +};
>> +
>> +struct qcom_icc_desc {
>> +	struct qcom_icc_node **nodes;
>> +	size_t num_nodes;
>> +};
>> +
>> +#define DEFINE_QNODE(_name, _id, _port, _buswidth, _ap_owned,		\
>> +			_mas_rpm_id, _slv_rpm_id, _qos_mode,		\
>> +			_numlinks, ...)					\
>> +		static struct qcom_icc_node _name = {			\
>> +		.id = _id,						\
>> +		.name = #_name,						\
> 
> nit: init fields in same order as parameters.

Ok.

>> +		.port = _port,						\
>> +		.buswidth = _buswidth,					\
>> +		.qos_mode = _qos_mode,					\
>> +		.ap_owned = _ap_owned,					\
>> +		.mas_rpm_id = _mas_rpm_id,				\
>> +		.slv_rpm_id = _slv_rpm_id,				\
>> +		.num_links = _numlinks,					\
>> +		.links = { __VA_ARGS__ },				\
>> +	}
>> +
>> +DEFINE_QNODE(mas_video, MASTER_VIDEO_P0, 8, 16, 1, -1, -1, QCOM_QOS_MODE_BYPASS, 2, SNOC_MM_INT_0, SNOC_MM_INT_2);
>> +DEFINE_QNODE(mas_jpeg, MASTER_JPEG, 6, 16, 1, -1, -1, QCOM_QOS_MODE_BYPASS, 2, SNOC_MM_INT_0, SNOC_MM_INT_2);
>> +DEFINE_QNODE(mas_vfe, MASTER_VFE, 9, 16, 1, -1, -1, QCOM_QOS_MODE_BYPASS, 2, SNOC_MM_INT_1, SNOC_MM_INT_2);
>> +DEFINE_QNODE(mas_mdp, MASTER_MDP_PORT0, 7, 16, 1, -1, -1, QCOM_QOS_MODE_BYPASS, 2, SNOC_MM_INT_0, SNOC_MM_INT_2);
>> +DEFINE_QNODE(mas_qdss_bam, MASTER_QDSS_BAM, 11, 16, 1, -1, -1, QCOM_QOS_MODE_FIXED, 1, SNOC_QDSS_INT);
>> +DEFINE_QNODE(mas_snoc_cfg, MASTER_SNOC_CFG, 0, 16, 0, 20, -1, QCOM_QOS_MODE_BYPASS, 1, SNOC_QDSS_INT);
>> +DEFINE_QNODE(mas_qdss_etr, MASTER_QDSS_ETR, 10, 16, 1, -1, -1, QCOM_QOS_MODE_FIXED, 1, SNOC_QDSS_INT);
>> +DEFINE_QNODE(mm_int_0, SNOC_MM_INT_0, 0, 16, 1, -1, -1, QCOM_QOS_MODE_FIXED, 1, SNOC_MM_INT_BIMC);
>> +DEFINE_QNODE(mm_int_1, SNOC_MM_INT_1, 0, 16, 1, -1, -1, QCOM_QOS_MODE_FIXED, 1, SNOC_MM_INT_BIMC);
>> +DEFINE_QNODE(mm_int_2, SNOC_MM_INT_2, 0, 16, 1, -1, -1, QCOM_QOS_MODE_FIXED, 1, SNOC_INT_0);
>> +DEFINE_QNODE(mm_int_bimc, SNOC_MM_INT_BIMC, 0, 16, 1, -1, -1, QCOM_QOS_MODE_FIXED, 1, SNOC_BIMC_1_MAS);
>> +DEFINE_QNODE(snoc_int_0, SNOC_INT_0, 0, 8, 0, 99, 130, QCOM_QOS_MODE_FIXED, 3, SLAVE_QDSS_STM, SLAVE_SYSTEM_IMEM, MNOC_BIMC_MAS);
>> +DEFINE_QNODE(snoc_int_1, SNOC_INT_1, 0, 8, 0, 100, 131, QCOM_QOS_MODE_FIXED, 3, SYSTEM_SLAVE_FAB_APPS, SLAVE_CATS_128, SLAVE_OCMEM_64);
>> +DEFINE_QNODE(snoc_int_bimc, SNOC_INT_BIMC, 0, 8, 0, 101, 132, QCOM_QOS_MODE_FIXED, 1, SNOC_BIMC_0_MAS);
>> +DEFINE_QNODE(snoc_bimc_0_mas, SNOC_BIMC_0_MAS, 0, 8, 0, 3, -1, QCOM_QOS_MODE_FIXED, 1, SNOC_BIMC_0_SLV);
>> +DEFINE_QNODE(snoc_bimc_1_mas, SNOC_BIMC_1_MAS, 0, 16, 1, -1, -1, QCOM_QOS_MODE_FIXED, 1, SNOC_BIMC_1_SLV);
>> +DEFINE_QNODE(qdss_int, SNOC_QDSS_INT, 0, 8, 1, -1, -1, QCOM_QOS_MODE_FIXED, 2, SNOC_INT_0, SNOC_INT_BIMC);
>> +DEFINE_QNODE(bimc_snoc_slv, BIMC_SNOC_SLV, 0, 8, 1, -1, -1, QCOM_QOS_MODE_FIXED, 2, SNOC_INT_0, SNOC_INT_1);
>> +DEFINE_QNODE(snoc_pnoc_mas, MNOC_BIMC_MAS, 0, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 1, MNOC_BIMC_SLV);
> 
> Shouldn't this be SNOC_PNOC_MAS?

I am sharing these IDs between multiple SoC (with different interconnect
topology) for the case where the same consumer driver is used on
different SoCs. This is to allow a directly reference the ports by the
consumer driver in the case where we are using platform data only. Will
update it, as now we have a patch to allow translation via DT and this
is not a limitation anymore.

>> +DEFINE_QNODE(pnoc_snoc_slv, PNOC_SNOC_SLV, 0, 8, 0, -1, 45, QCOM_QOS_MODE_FIXED, 3, SNOC_INT_0, SNOC_INT_BIMC, SNOC_INT_1);
>> +DEFINE_QNODE(slv_srvc_snoc, SLAVE_SERVICE_SNOC, 0, 8, 0, -1, 29, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_qdss_stm, SLAVE_QDSS_STM, 0, 4, 0, -1, 30, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_imem, SLAVE_SYSTEM_IMEM, 0, 8, 0, -1, 26, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_apss, SYSTEM_SLAVE_FAB_APPS, 0, 4, 0, -1, 20, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_cats_0, SLAVE_CATS_128, 0, 16, 0, -1, 106, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_cats_1, SLAVE_OCMEM_64, 0, 8, 0, -1, 107, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(mas_apss, MASTER_AMPSS_M0, 0, 8, 1, -1, -1, QCOM_QOS_MODE_FIXED, 3, SLAVE_EBI_CH0, BIMC_SNOC_MAS, SLAVE_AMPSS_L2);
>> +DEFINE_QNODE(mas_tcu0, MASTER_TCU_0, 5, 8, 1, -1, -1, QCOM_QOS_MODE_FIXED, 3, SLAVE_EBI_CH0, BIMC_SNOC_MAS, SLAVE_AMPSS_L2);
>> +DEFINE_QNODE(mas_tcu1, MASTER_TCU_1, 6, 8, 1, -1, -1, QCOM_QOS_MODE_FIXED, 3, SLAVE_EBI_CH0, BIMC_SNOC_MAS, SLAVE_AMPSS_L2);
>> +DEFINE_QNODE(mas_gfx, MASTER_GRAPHICS_3D, 2, 8, 1, -1, -1, QCOM_QOS_MODE_FIXED, 3, SLAVE_EBI_CH0, BIMC_SNOC_MAS, SLAVE_AMPSS_L2);
>> +DEFINE_QNODE(bimc_snoc_mas, BIMC_SNOC_MAS, 0, 8, 1, -1, -1, QCOM_QOS_MODE_FIXED, 1, BIMC_SNOC_SLV);
>> +DEFINE_QNODE(snoc_bimc_0_slv, SNOC_BIMC_0_SLV, 0, 8, 0, -1, 24, QCOM_QOS_MODE_FIXED, 1, SLAVE_EBI_CH0);
>> +DEFINE_QNODE(snoc_bimc_1_slv, SNOC_BIMC_1_SLV, 0, 8, 1, -1, -1, QCOM_QOS_MODE_FIXED, 1, SLAVE_EBI_CH0);
>> +DEFINE_QNODE(slv_ebi_ch0, SLAVE_EBI_CH0, 0, 8, 0, -1, 0, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_apps_l2, SLAVE_AMPSS_L2, 0, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(snoc_pnoc_slv, MNOC_BIMC_SLV, 0, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 1, PNOC_INT_0);
> 
> Shouldn't this be SNOC_PNOC_SLV?
> 
>> +DEFINE_QNODE(pnoc_int_0, PNOC_INT_0, 0, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 8, PNOC_SNOC_MAS, PNOC_SLV_0, PNOC_SLV_1, PNOC_SLV_2, PNOC_SLV_3, PNOC_SLV_4, PNOC_SLV_8, PNOC_SLV_9);
>> +DEFINE_QNODE(pnoc_int_1, PNOC_INT_1, 0, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 1, PNOC_SNOC_MAS);
>> +DEFINE_QNODE(pnoc_m_0, PNOC_M_0, 0, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 1, PNOC_INT_0);
>> +DEFINE_QNODE(pnoc_m_1, PNOC_M_1, 0, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 1, PNOC_SNOC_MAS);
>> +DEFINE_QNODE(pnoc_s_0, PNOC_SLV_0, 0, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 5, SLAVE_CLK_CTL, SLAVE_TLMM, SLAVE_MSM_TCSR, SLAVE_SECURITY, SLAVE_MSS);
>> +DEFINE_QNODE(pnoc_s_1, PNOC_SLV_1, 0, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 5, SLAVE_IMEM_CFG, SLAVE_CRYPTO_0_CFG, SLAVE_RPM_MSG_RAM, SLAVE_MSM_PDM, SLAVE_PRNG);
>> +DEFINE_QNODE(pnoc_s_2, PNOC_SLV_2, 0, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 5, SLAVE_SPDM, SLAVE_BOOT_ROM, SLAVE_BIMC_CFG, SLAVE_PNOC_CFG, SLAVE_PMIC_ARB);
>> +DEFINE_QNODE(pnoc_s_3, PNOC_SLV_3, 0, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 5, SLAVE_MPM, SLAVE_IPS_CFG, SLAVE_RBCPR_CFG, SLAVE_QDSS_CFG, SLAVE_DEHR_CFG);
>> +DEFINE_QNODE(pnoc_s_4, PNOC_SLV_4, 0, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 3, SLAVE_VENUS_CFG, SLAVE_CAMERA_CFG, SLAVE_DISPLAY_CFG);
>> +DEFINE_QNODE(pnoc_s_8, PNOC_SLV_8, 0, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 3, SLAVE_USB_HS, SLAVE_SDCC_1, SLAVE_BLSP_1);
>> +DEFINE_QNODE(pnoc_s_9, PNOC_SLV_9, 0, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 3, SLAVE_SDCC_4, SLAVE_LPASS, SLAVE_GRAPHICS_3D_CFG);
>> +DEFINE_QNODE(slv_imem_cfg, SLAVE_IMEM_CFG, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_crypto_0_cfg, SLAVE_CRYPTO_0_CFG, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_msg_ram, SLAVE_RPM_MSG_RAM, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_pdm, SLAVE_MSM_PDM, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_prng, SLAVE_PRNG, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_clk_ctl, SLAVE_CLK_CTL, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_mss, SLAVE_MSS, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_tlmm, SLAVE_TLMM, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_tcsr, SLAVE_MSM_TCSR, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_security, SLAVE_SECURITY, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_spdm, SLAVE_SPDM, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_pnoc_cfg, SLAVE_PNOC_CFG, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_pmic_arb, SLAVE_PMIC_ARB, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_bimc_cfg, SLAVE_BIMC_CFG, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_boot_rom, SLAVE_BOOT_ROM, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_mpm, SLAVE_MPM, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_qdss_cfg, SLAVE_QDSS_CFG, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_rbcpr_cfg, SLAVE_RBCPR_CFG, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_snoc_cfg, SLAVE_IPS_CFG, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
> 
> Shouldn't this be SLAVE_SNOC_CFG ?
> 
>> +DEFINE_QNODE(slv_dehr_cfg, SLAVE_DEHR_CFG, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_venus_cfg, SLAVE_VENUS_CFG, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_display_cfg, SLAVE_DISPLAY_CFG, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_camera_cfg, SLAVE_CAMERA_CFG, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_usb_hs, SLAVE_USB_HS, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_sdcc_1, SLAVE_SDCC_1, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_blsp_1, SLAVE_BLSP_1, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_sdcc_2, SLAVE_SDCC_4, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_gfx_cfg, SLAVE_GRAPHICS_3D_CFG, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_audio, SLAVE_LPASS, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(mas_blsp_1, MASTER_BLSP_1, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 1, PNOC_M_1);
>> +DEFINE_QNODE(mas_spdm, MASTER_SPDM, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 1, PNOC_M_0);
>> +DEFINE_QNODE(mas_dehr, MASTER_DEHR, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 1, PNOC_M_0);
>> +DEFINE_QNODE(mas_audio, MASTER_LPASS, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 1, PNOC_M_0);
>> +DEFINE_QNODE(mas_usb_hs, MASTER_USB_HS, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 1, PNOC_M_1);
>> +DEFINE_QNODE(mas_pnoc_crypto_0, MASTER_CRYPTO_CORE0, 0, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 1, PNOC_INT_1);
>> +DEFINE_QNODE(mas_pnoc_sdcc_1, MASTER_SDCC_1, 7, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 1, PNOC_INT_1);
>> +DEFINE_QNODE(mas_pnoc_sdcc_2, MASTER_SDCC_2, 8, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 1, PNOC_INT_1);
>> +DEFINE_QNODE(pnoc_snoc_mas, PNOC_SNOC_MAS, 0, 8, 0, 29, -1, QCOM_QOS_MODE_FIXED, 1, PNOC_SNOC_SLV);
> 
> nit: you could consider to group these by NoC and use alphabetical
> order within each block, and also sort msm8916_*_nodes below. Purely
> optional though :)

Ok, will see what i can do.

> 
>> +static struct qcom_icc_node *msm8916_snoc_nodes[] = {
>> +	&mas_video,
>> +	&mas_jpeg,
>> +	&mas_vfe,
>> +	&mas_mdp,
>> +	&mas_qdss_bam,
>> +	&mas_snoc_cfg,
>> +	&mas_qdss_etr,
>> +	&mm_int_0,
>> +	&mm_int_1,
>> +	&mm_int_2,
>> +	&mm_int_bimc,
>> +	&snoc_int_0,
>> +	&snoc_int_1,
>> +	&snoc_int_bimc,
>> +	&snoc_bimc_0_mas,
>> +	&snoc_bimc_1_mas,
>> +	&qdss_int,
>> +	&bimc_snoc_slv,
>> +	&snoc_pnoc_mas,
>> +	&pnoc_snoc_slv,
>> +	&slv_srvc_snoc,
>> +	&slv_qdss_stm,
>> +	&slv_imem,
>> +	&slv_apss,
>> +	&slv_cats_0,
>> +	&slv_cats_1,
>> +};
>> +
>> +static struct qcom_icc_desc msm8916_snoc = {
>> +	.nodes = msm8916_snoc_nodes,
>> +	.num_nodes = ARRAY_SIZE(msm8916_snoc_nodes),
>> +};
>> +
>> +static struct qcom_icc_node *msm8916_bimc_nodes[] = {
>> +	&mas_apss,
>> +	&mas_tcu0,
>> +	&mas_tcu1,
>> +	&mas_gfx,
>> +	&bimc_snoc_mas,
>> +	&snoc_bimc_0_slv,
>> +	&snoc_bimc_1_slv,
>> +	&slv_ebi_ch0,
>> +	&slv_apps_l2,
>> +};
>> +
>> +static struct qcom_icc_desc msm8916_bimc = {
>> +	.nodes = msm8916_bimc_nodes,
>> +	.num_nodes = ARRAY_SIZE(msm8916_bimc_nodes),
>> +};
>> +
>> +static struct qcom_icc_node *msm8916_pnoc_nodes[] = {
>> +	&snoc_pnoc_slv,
>> +	&pnoc_int_0,
>> +	&pnoc_int_1,
>> +	&pnoc_m_0,
>> +	&pnoc_m_1,
>> +	&pnoc_s_0,
>> +	&pnoc_s_1,
>> +	&pnoc_s_2,
>> +	&pnoc_s_3,
>> +	&pnoc_s_4,
>> +	&pnoc_s_8,
>> +	&pnoc_s_9,
>> +	&slv_imem_cfg,
>> +	&slv_crypto_0_cfg,
>> +	&slv_msg_ram,
>> +	&slv_pdm,
>> +	&slv_prng,
>> +	&slv_clk_ctl,
>> +	&slv_mss,
>> +	&slv_tlmm,
>> +	&slv_tcsr,
>> +	&slv_security,
>> +	&slv_spdm,
>> +	&slv_pnoc_cfg,
>> +	&slv_pmic_arb,
>> +	&slv_bimc_cfg,
>> +	&slv_boot_rom,
>> +	&slv_mpm,
>> +	&slv_qdss_cfg,
>> +	&slv_rbcpr_cfg,
>> +	&slv_snoc_cfg,
>> +	&slv_dehr_cfg,
>> +	&slv_venus_cfg,
>> +	&slv_display_cfg,
>> +	&slv_camera_cfg,
>> +	&slv_usb_hs,
>> +	&slv_sdcc_1,
>> +	&slv_blsp_1,
>> +	&slv_sdcc_2,
>> +	&slv_gfx_cfg,
>> +	&slv_audio,
>> +	&mas_blsp_1,
>> +	&mas_spdm,
>> +	&mas_dehr,
>> +	&mas_audio,
>> +	&mas_usb_hs,
>> +	&mas_pnoc_crypto_0,
>> +	&mas_pnoc_sdcc_1,
>> +	&mas_pnoc_sdcc_2,
>> +	&pnoc_snoc_mas,
>> +};
>> +
>> +static struct qcom_icc_desc msm8916_pnoc = {
>> +	.nodes = msm8916_pnoc_nodes,
>> +	.num_nodes = ARRAY_SIZE(msm8916_pnoc_nodes),
>> +};
>> +
>> +static int qcom_icc_aggregate(struct icc_node *node, u32 avg_bw, u32 peak_bw,
>> +			      u32 *agg_avg, u32 *agg_peak)
>> +{
>> +	*agg_avg += avg_bw;
>> +	*agg_peak = max(*agg_peak, peak_bw);
>> +
>> +	return 0;
>> +}
>> +
>> +static int qcom_icc_set(struct icc_node *src, struct icc_node *dst,
>> +			u32 avg, u32 peak)
>> +{
>> +	struct qcom_icc_provider *qp;
>> +	struct qcom_icc_node *qn;
>> +	struct icc_node *node;
>> +	struct icc_provider *provider;
>> +	u64 avg_bw = icc_units_to_bps(avg);
>> +	u64 peak_bw = icc_units_to_bps(peak);
>> +	u64 rate = 0;
> 
> Initialization is unnecessary.

Ok.

>> +	int ret = 0;
>> +
>> +	if (!src)
>> +		node = dst;
>> +	else
>> +		node = src;
>> +
>> +	qn = node->data;
>> +	provider = node->provider;
>> +	qp = to_qcom_provider(node->provider);
> 
> nit: you could pass provider instead of node->provider.

Ok.

>> +
>> +	/* set bandwidth */
>> +	if (qn->ap_owned) {
>> +		/* TODO: set QoS */
>> +	} else {
>> +		/* send message to the RPM processor */
>> +		if (qn->mas_rpm_id != -1) {
>> +			ret = qcom_icc_rpm_smd_send(QCOM_SMD_RPM_ACTIVE_STATE,
>> +						    RPM_BUS_MASTER_REQ,
>> +						    qn->mas_rpm_id,
>> +						    avg_bw);
>> +			if (ret) {
>> +				pr_err("qcom_icc_rpm_smd_send mas error %d\n",
>> +				       ret);
>> +				return ret;
>> +			}
>> +		}
>> +
>> +		if (qn->slv_rpm_id != -1) {
>> +			ret = qcom_icc_rpm_smd_send(QCOM_SMD_RPM_ACTIVE_STATE,
>> +						    RPM_BUS_SLAVE_REQ,
>> +						    qn->slv_rpm_id,
>> +						    avg_bw);
>> +			if (ret) {
>> +				pr_err("qcom_icc_rpm_smd_send slv error %d\n",
>> +				       ret);
>> +				return ret;
>> +			}
>> +		}
>> +	}
>> +
>> +	rate = max(avg_bw, peak_bw);
> 
> This looks trivial, however avg_bw is a sum of average bandwidths and
> peak_bw is the max peak bandwidth of all nodes, which is not evident
> in this context. I guess it makes sense since a node that uses it's
> peak bandwdith frequently would have a average bandwidth close to that
> value, which would be reflected in avg_bw.

Yes, i will try to use better naming of variables.

>> +static int qnoc_probe(struct platform_device *pdev)
>> +{
>> +	const struct qcom_icc_desc *desc;
>> +	struct qcom_icc_node **qnodes;
>> +	struct icc_node *node;
>> +	struct qcom_icc_provider *qp;
>> +	struct resource *res;
>> +	struct icc_provider *provider;
>> +	size_t num_nodes, i;
>> +	int ret;
>> +
>> +	/* wait for RPM */
>> +	if (!qcom_icc_rpm_smd_available())
>> +		return -EPROBE_DEFER;
>> +
>> +	desc = of_device_get_match_data(&pdev->dev);
>> +	if (!desc)
>> +		return -EINVAL;
>> +
>> +	qnodes = desc->nodes;
>> +	num_nodes = desc->num_nodes;
>> +
>> +	qp = devm_kzalloc(&pdev->dev, sizeof(*qp), GFP_KERNEL);
>> +	if (!qp)
>> +		return -ENOMEM;
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	qp->base = devm_ioremap_resource(&pdev->dev, res);
>> +	if (IS_ERR(qp->base))
>> +		return PTR_ERR(qp->base);
>> +
>> +	qp->bus_clk = devm_clk_get(&pdev->dev, "bus_clk");
>> +	if (IS_ERR(qp->bus_clk))
>> +		return PTR_ERR(qp->bus_clk);
>> +
>> +	ret = clk_prepare_enable(qp->bus_clk);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "error enabling bus_clk: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	qp->bus_a_clk = devm_clk_get(&pdev->dev, "bus_a_clk");
>> +	if (IS_ERR(qp->bus_a_clk))
> 
> 		clk_disable_unprepare(qp->bus_clk);
> 
> Same for other error paths.
> 
>> +		return PTR_ERR(qp->bus_a_clk);
>> +
>> +	ret = clk_prepare_enable(qp->bus_a_clk);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "error enabling bus_a_clk: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	provider = &qp->provider;
>> +	provider->dev = &pdev->dev;
>> +	provider->set = &qcom_icc_set;
>> +	provider->aggregate = &qcom_icc_aggregate;
>> +	INIT_LIST_HEAD(&provider->nodes);
>> +	provider->data = qp;
>> +
>> +	ret = icc_provider_add(provider);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "error adding interconnect provider\n");
> 
> 		clk_disable_unprepare(qp->bus_a_clk);
> 
> Same for other error paths.
> 
>> +		return ret;
>> +	}
>> +
>> +	for (i = 0; i < num_nodes; i++) {
>> +		int ret;
>> +		size_t j;
>> +
>> +		node = icc_node_create(qnodes[i]->id);
>> +		if (IS_ERR(node)) {
>> +			ret = PTR_ERR(node);
>> +			goto err;
>> +		}
>> +
>> +		node->name = qnodes[i]->name;
>> +		node->data = qnodes[i];
>> +		icc_node_add(node, provider);
>> +
>> +		dev_dbg(&pdev->dev, "registered node %s\n", node->name);
>> +
>> +		/* populate links */
>> +		for (j = 0; j < qnodes[i]->num_links; j++)
>> +			if (qnodes[i]->links[j])
>> +				icc_link_create(node, qnodes[i]->links[j]);
>> +	}
>> +
>> +	platform_set_drvdata(pdev, provider);
>> +
>> +	return ret;
>> +err:
>> +	list_for_each_entry(node, &provider->nodes, node_list) {
>> +		icc_node_del(node);
>> +		icc_node_destroy(node->id);
>> +	}
>> +	icc_provider_del(provider);
>> +
>> +	return ret;
>> +}
>> +
>> +static int qnoc_remove(struct platform_device *pdev)
>> +{
>> +	struct icc_provider *provider = platform_get_drvdata(pdev);
>> +	struct icc_node *n;
>> +
>> +	list_for_each_entry(n, &provider->nodes, node_list) {
>> +		icc_node_del(n);
>> +		icc_node_destroy(n->id);
>> +	}
> 
> 	clk_disable_unprepare(qp->bus_a_clk);
> 	clk_disable_unprepare(qp->bus_clk);

Will fix!

Thanks,
Georgi

