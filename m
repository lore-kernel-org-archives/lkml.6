Return-Path: <georgi.djakov@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1523538550; cv=none;
        d=google.com; s=arc-20160816;
        b=TiIeqpTmipLAeSMvPEqNS1n3AbjGlnNn02EAQECFt2PdfIBt5VwaZtQTQQ0IQTCakB
         CGPCsdrTWM6eHuGExFd6vk+N03Qcikkguki4S2tGCLz+KnR0JRv94w+RMrIO/g2w2RYn
         VChyYZL9Km9YSNbkNRIPbO1gHzyNr25w5xZ5E5LKZDE+LXrmm173Zut3NSiIVFuBH87k
         YiuJme36CxaOISDKyMhNyCL8kLWYRDdEPp5D3K/SkXb73+tz5ikvLIn8EhXDsUnLFjm4
         VpttIl5fU3DxB+HQ/tGmKgkTzqdncEs2G6zqcU+7ShyGs/xcSouNW+xNKC7YtHFHEy08
         La1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :date:message-id:openpgp:references:cc:to:subject:from
         :dkim-signature:arc-authentication-results;
        bh=s6Wv/vWNQzCe1plrEWUz1ATDKPlxVK+Hc1PHPrCUToU=;
        b=iHf7OKmxew+ZdcXIiGxBTf5XefOnAnx05T+xqL7uwnNIRppj8r8iC9nGhoubM0WUAh
         Oe2sQQmvB81hfRwcLcdirbAs0Nl+heOOVIABW6NnHJfV0YAypGjpP0Wq1W6CCjbyQ8xG
         aKVW/YLqIoCZFgmLRikacRJcf3FvipoN5vYTy7l9iK0kb4gL/hcfgBBE62dl+P1DUBbH
         4v6Jdl47vDsgvMG4LGLWYF/wvaWJ1AEM75uRdXtTd8+Xl2TrvMvznHXOx8E1cjGdrb0X
         5fn5I327qSOR+4Xpp4OjCqV9vE/bz0EGshngmHddrvcFXp4skbZuPu2Lxq5J9tldGATx
         IdaQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=C4fhPhLJ;
       spf=pass (google.com: domain of georgi.djakov@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=georgi.djakov@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=C4fhPhLJ;
       spf=pass (google.com: domain of georgi.djakov@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=georgi.djakov@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx49xSyW+AEVKsPzNYMhYDh0/gUxt+5FpKLCrVRNBB1jgd9OWOqxpLrcS4AKfMNMqSrIy8hk8/w==
From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH v4 5/7] interconnect: qcom: Add msm8916 interconnect provider
 driver
To: Matthias Kaehlcke <mka@chromium.org>
Cc: linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, rjw@rjwysocki.net,
 robh+dt@kernel.org, mturquette@baylibre.com, khilman@baylibre.com,
 vincent.guittot@linaro.org, skannan@codeaurora.org,
 bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
 seansw@qti.qualcomm.com, davidai@quicinc.com, mark.rutland@arm.com,
 lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
References: <20180309210958.16672-1-georgi.djakov@linaro.org>
 <20180309210958.16672-6-georgi.djakov@linaro.org>
 <20180405225846.GB130399@google.com>
Openpgp: preference=signencrypt
Message-ID: <9334aaad-845b-32e5-eb4f-06fee7be2931@linaro.org>
Date: Thu, 12 Apr 2018 16:09:08 +0300
MIME-Version: 1.0
In-Reply-To: <20180405225846.GB130399@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594495928598793277?=
X-GMAIL-MSGID: =?utf-8?q?1597545959487431463?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Matthias,

On 04/06/2018 01:58 AM, Matthias Kaehlcke wrote:
> On Fri, Mar 09, 2018 at 11:09:56PM +0200, Georgi Djakov wrote:
>> Add driver for the Qualcomm interconnect buses found in msm8916 based
>> platforms.
>>
>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>> ---
>>  drivers/interconnect/Kconfig        |   5 +
>>  drivers/interconnect/Makefile       |   1 +
>>  drivers/interconnect/qcom/Kconfig   |  11 +
>>  drivers/interconnect/qcom/Makefile  |   2 +
>>  drivers/interconnect/qcom/msm8916.c | 482 ++++++++++++++++++++++++++++++++++++
>>  include/linux/interconnect/qcom.h   | 350 ++++++++++++++++++++++++++
>>  6 files changed, 851 insertions(+)
>>  create mode 100644 drivers/interconnect/qcom/Kconfig
>>  create mode 100644 drivers/interconnect/qcom/msm8916.c
>>  create mode 100644 include/linux/interconnect/qcom.h
>>

[..]

>> +
>> +DEFINE_QNODE(mas_video, 63, 8, 16, 1, -1, -1, QCOM_QOS_MODE_BYPASS, 2, 10000, 10002);
> 
> IIUC this should be something like:
> 
> +DEFINE_QNODE(mas_video, MASTER_VIDEO_P0, MASTER_ADM_PORT1, 16, 1, -1,
> -1, QCOM_QOS_MODE_BYPASS, 2, SNOC_MM_INT_0, SNOC_MM_INT_2);
> 
> and similar for the other nodes.
>

Yes, exactly.

>> +DEFINE_QNODE(mas_jpeg, 62, 6, 16, 1, -1, -1, QCOM_QOS_MODE_BYPASS, 2, 10000, 10002);
>> +DEFINE_QNODE(mas_vfe, 29, 9, 16, 1, -1, -1, QCOM_QOS_MODE_BYPASS, 2, 10001, 10002);
>> +DEFINE_QNODE(mas_mdp, 22, 7, 16, 1, -1, -1, QCOM_QOS_MODE_BYPASS, 2, 10000, 10002);
>> +DEFINE_QNODE(mas_qdss_bam, 53, 11, 16, 1, -1, -1, QCOM_QOS_MODE_FIXED, 1, 10009);
>> +DEFINE_QNODE(mas_snoc_cfg, 54, 0, 16, 0, 20, -1, QCOM_QOS_MODE_BYPASS, 1, 10009);
>> +DEFINE_QNODE(mas_qdss_etr, 60, 10, 16, 1, -1, -1, QCOM_QOS_MODE_FIXED, 1, 10009);
>> +DEFINE_QNODE(mm_int_0, 10000, 0, 16, 1, -1, -1, QCOM_QOS_MODE_FIXED, 1, 10003);
>> +DEFINE_QNODE(mm_int_1, 10001, 0, 16, 1, -1, -1, QCOM_QOS_MODE_FIXED, 1, 10003);
>> +DEFINE_QNODE(mm_int_2, 10002, 0, 16, 1, -1, -1, QCOM_QOS_MODE_FIXED, 1, 10004);
>> +DEFINE_QNODE(mm_int_bimc, 10003, 0, 16, 1, -1, -1, QCOM_QOS_MODE_FIXED, 1, 10008);
>> +DEFINE_QNODE(snoc_int_0, 10004, 0, 8, 0, 99, 130, QCOM_QOS_MODE_FIXED, 3, 588, 519, 10027);
>> +DEFINE_QNODE(snoc_int_1, 10005, 0, 8, 0, 100, 131, QCOM_QOS_MODE_FIXED, 3, 517, 663, 664);
>> +DEFINE_QNODE(snoc_int_bimc, 10006, 0, 8, 0, 101, 132, QCOM_QOS_MODE_FIXED, 1, 10007);
>> +DEFINE_QNODE(snoc_bimc_0_mas, 10007, 0, 8, 0, 3, -1, QCOM_QOS_MODE_FIXED, 1, 10025);
>> +DEFINE_QNODE(snoc_bimc_1_mas, 10008, 0, 16, 1, -1, -1, QCOM_QOS_MODE_FIXED, 1, 10026);
>> +DEFINE_QNODE(qdss_int, 10009, 0, 8, 1, -1, -1, QCOM_QOS_MODE_FIXED, 2, 10004, 10006);
>> +DEFINE_QNODE(bimc_snoc_slv, 10017, 0, 8, 1, -1, -1, QCOM_QOS_MODE_FIXED, 2, 10004, 10005);
>> +DEFINE_QNODE(snoc_pnoc_mas, 10027, 0, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 1, 10028);
>> +DEFINE_QNODE(pnoc_snoc_slv, 10011, 0, 8, 0, -1, 45, QCOM_QOS_MODE_FIXED, 3, 10004, 10006, 10005);
>> +DEFINE_QNODE(slv_srvc_snoc, 587, 0, 8, 0, -1, 29, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_qdss_stm, 588, 0, 4, 0, -1, 30, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_imem, 519, 0, 8, 0, -1, 26, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_apss, 517, 0, 4, 0, -1, 20, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_cats_0, 663, 0, 16, 0, -1, 106, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_cats_1, 664, 0, 8, 0, -1, 107, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(mas_apss, 1, 0, 8, 1, -1, -1, QCOM_QOS_MODE_FIXED, 3, 512, 10016, 514);
>> +DEFINE_QNODE(mas_tcu0, 104, 5, 8, 1, -1, -1, QCOM_QOS_MODE_FIXED, 3, 512, 10016, 514);
>> +DEFINE_QNODE(mas_tcu1, 105, 6, 8, 1, -1, -1, QCOM_QOS_MODE_FIXED, 3, 512, 10016, 514);
>> +DEFINE_QNODE(mas_gfx, 26, 2, 8, 1, -1, -1, QCOM_QOS_MODE_FIXED, 3, 512, 10016, 514);
>> +DEFINE_QNODE(bimc_snoc_mas, 10016, 0, 8, 1, -1, -1, QCOM_QOS_MODE_FIXED, 1, 10017);
>> +DEFINE_QNODE(snoc_bimc_0_slv, 10025, 0, 8, 0, -1, 24, QCOM_QOS_MODE_FIXED, 1, 512);
>> +DEFINE_QNODE(snoc_bimc_1_slv, 10026, 0, 8, 1, -1, -1, QCOM_QOS_MODE_FIXED, 1, 512);
>> +DEFINE_QNODE(slv_ebi_ch0, 512, 0, 8, 0, -1, 0, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_apps_l2, 514, 0, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(snoc_pnoc_slv, 10028, 0, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 1, 10012);
>> +DEFINE_QNODE(pnoc_int_0, 10012, 0, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 8, 10010, 10018, 10019, 10020, 10021, 10022, 10023, 10024);
>> +DEFINE_QNODE(pnoc_int_1, 10013, 0, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 1, 10010);
>> +DEFINE_QNODE(pnoc_m_0, 10014, 0, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 1, 10012);
>> +DEFINE_QNODE(pnoc_m_1, 10015, 0, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 1, 10010);
>> +DEFINE_QNODE(pnoc_s_0, 10018, 0, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 5, 620, 624, 579, 622, 521);
>> +DEFINE_QNODE(pnoc_s_1, 10019, 0, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 5, 627, 625, 535, 577, 618);
>> +DEFINE_QNODE(pnoc_s_2, 10020, 0, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 5, 533, 630, 629, 641, 632);
>> +DEFINE_QNODE(pnoc_s_3, 10021, 0, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 5, 536, 647, 636, 635, 634);
>> +DEFINE_QNODE(pnoc_s_4, 10022, 0, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 3, 596, 589, 590);
>> +DEFINE_QNODE(pnoc_s_8, 10023, 0, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 3, 614, 606, 613);
>> +DEFINE_QNODE(pnoc_s_9, 10024, 0, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 3, 609, 522, 598);
>> +DEFINE_QNODE(slv_imem_cfg, 627, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_crypto_0_cfg, 625, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_msg_ram, 535, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_pdm, 577, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_prng, 618, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_clk_ctl, 620, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_mss, 521, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_tlmm, 624, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_tcsr, 579, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_security, 622, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_spdm, 533, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_pnoc_cfg, 641, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_pmic_arb, 632, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_bimc_cfg, 629, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_boot_rom, 630, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_mpm, 536, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_qdss_cfg, 635, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_rbcpr_cfg, 636, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_snoc_cfg, 647, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_dehr_cfg, 634, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_venus_cfg, 596, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_display_cfg, 590, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_camera_cfg, 589, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_usb_hs, 614, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_sdcc_1, 606, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_blsp_1, 613, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_sdcc_2, 609, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_gfx_cfg, 598, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(slv_audio, 522, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 0, 0);
>> +DEFINE_QNODE(mas_blsp_1, 86, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 1, 10015);
>> +DEFINE_QNODE(mas_spdm, 36, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 1, 10014);
>> +DEFINE_QNODE(mas_dehr, 75, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 1, 10014);
>> +DEFINE_QNODE(mas_audio, 15, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 1, 10014);
>> +DEFINE_QNODE(mas_usb_hs, 87, 0, 4, 0, -1, -1, QCOM_QOS_MODE_FIXED, 1, 10015);
>> +DEFINE_QNODE(mas_pnoc_crypto_0, 55, 0, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 1, 10013);
>> +DEFINE_QNODE(mas_pnoc_sdcc_1, 78, 7, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 1, 10013);
>> +DEFINE_QNODE(mas_pnoc_sdcc_2, 81, 8, 8, 0, -1, -1, QCOM_QOS_MODE_FIXED, 1, 10013);
>> +DEFINE_QNODE(pnoc_snoc_mas, 10010, 0, 8, 0, 29, -1, QCOM_QOS_MODE_FIXED, 1, 10011);
>> +

[..]

>> +static const struct of_device_id qnoc_of_match[] = {
>> +	{ .compatible = "qcom,msm8916-pnoc", .data = &msm8916_pnoc },
>> +	{ .compatible = "qcom,msm8916-snoc", .data = &msm8916_snoc },
>> +	{ .compatible = "qcom,msm8916-bimc", .data = &msm8916_bimc },
>> +	{ },
>> +};
>> +MODULE_DEVICE_TABLE(of, qnoc_of_match);
>> +
>> +static struct platform_driver qnoc_driver = {
>> +	.probe = qnoc_probe,
>> +	.remove = qnoc_remove,
>> +	.driver = {
>> +		.name = "qnoc-msm8916",
>> +		.of_match_table = qnoc_of_match,
>> +	},
>> +};
>> +module_platform_driver(qnoc_driver);
>> +MODULE_AUTHOR("Georgi Djakov <georgi.djakov@linaro.org>");
>> +MODULE_DESCRIPTION("Qualcomm msm8916 NoC driver");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/include/linux/interconnect/qcom.h
>> b/include/linux/interconnect/qcom.h
> 
> Are the values in this file valid for all Qualcomm SoCs or specific to
> the MSM8916? In the latter case you might want to include the chip
> (family) in the name of the constant.

Currently i am trying to use common ids, which is useful if you have
same drivers for different SoCs and use only platform data. But the goal
here is to fully move to DT and then we could use arbitrary ids.

Thanks,
Georgi
