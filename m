Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LJHta7bd"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7A41960290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752341AbeFFPOd (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 11:14:33 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46406 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752006AbeFFPOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 11:14:31 -0400
X-Google-Smtp-Source: ADUXVKIgXDQIBQkjVJyS5myiTgnCrrTqME8FHUkDphIWcSKzg51jWwoKTTgYM9BAeVjfCZHSrXH7Tg==
From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v4 5/7] interconnect: qcom: Add msm8916 interconnect
 provider driver
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>,
        gregkh@linuxfoundation.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        khilman@baylibre.com, Vincent Guittot <vincent.guittot@linaro.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        seansw@qti.qualcomm.com, davidai@quicinc.com,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm@vger.kernel.org
References: <20180309210958.16672-1-georgi.djakov@linaro.org>
 <20180309210958.16672-6-georgi.djakov@linaro.org>
 <CAHLCerNnoNowC6CfNc7O9Nbj+xy0GGw0qmadOxzGsy5iSrOtOg@mail.gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <0f03e7b9-aed6-b012-08da-5921061e3db2@linaro.org>
Date: Wed, 6 Jun 2018 18:14:28 +0300
MIME-Version: 1.0
In-Reply-To: <CAHLCerNnoNowC6CfNc7O9Nbj+xy0GGw0qmadOxzGsy5iSrOtOg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amit,

On 25.05.18 г. 11:27, Amit Kucheria wrote:
> On Fri, Mar 9, 2018 at 11:09 PM, Georgi Djakov <georgi.djakov@linaro.org> wrote:
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

[..]

>> +#define DEFINE_QNODE(_name, _id, _port, _buswidth, _ap_owned,          \
>> +                       _mas_rpm_id, _slv_rpm_id, _qos_mode,            \
>> +                       _numlinks, ...)                                 \
>> +               static struct qcom_icc_node _name = {                   \
>> +               .id = _id,                                              \
>> +               .name = #_name,                                         \
>> +               .port = _port,                                          \
>> +               .buswidth = _buswidth,                                  \
>> +               .qos_mode = _qos_mode,                                  \
>> +               .ap_owned = _ap_owned,                                  \
>> +               .mas_rpm_id = _mas_rpm_id,                              \
>> +               .slv_rpm_id = _slv_rpm_id,                              \
>> +               .num_links = _numlinks,                                 \
>> +               .links = { __VA_ARGS__ },                               \
>> +       }
> 
> Move this macro definition just above its use below.
> 

Ok.

>> +enum qcom_qos_mode {
>> +       QCOM_QOS_MODE_BYPASS = 0,
>> +       QCOM_QOS_MODE_FIXED,
>> +       QCOM_QOS_MODE_MAX,
>> +};
>> +
>> +struct qcom_icc_provider {
>> +       struct icc_provider     provider;
>> +       void __iomem            *base;
>> +       struct clk              *bus_clk;
>> +       struct clk              *bus_a_clk;
>> +};
>> +
>> +#define MSM8916_MAX_LINKS      8
>> +
>> +/**
>> + * struct qcom_icc_node - Qualcomm specific interconnect nodes
>> + * @name: the node name used in debugfs
>> + * @links: an array of nodes where we can go next while traversing
>> + * @id: a unique node identifier
>> + * @num_links: the total number of @links
>> + * @port: the offset index into the masters QoS register space
>> + * @buswidth: width of the interconnect between a node and the bus
> 
> units?

Will add.

[..]

>> +static int qcom_icc_init(struct icc_node *node)
>> +{
>> +       struct qcom_icc_provider *qp = to_qcom_provider(node->provider);
>> +       /* TODO: init qos and priority */
>> +
> 
> No need to set_rate here before enabling the clock?

Yes, i am planing to initially set the bus clocks at max rate. The rate
would be adjusted as soon as the consumers start placing requests.

> 
>> +       clk_prepare_enable(qp->bus_clk);
>> +       clk_prepare_enable(qp->bus_a_clk);
>> +
>> +       return 0;
>> +}
>> +
>> +static int qcom_icc_set(struct icc_node *src, struct icc_node *dst,
>> +                       u32 avg, u32 peak)
>> +{
>> +       struct qcom_icc_provider *qp;
>> +       struct qcom_icc_node *qn;
>> +       struct icc_node *node;
>> +       struct icc_provider *provider;
>> +       u64 avg_bw;
>> +       u64 peak_bw;
>> +       u64 rate = 0;
>> +       int ret = 0;
>> +
>> +       if (!src)
>> +               node = dst;
>> +       else
>> +               node = src;
>> +
>> +       qn = node->data;
>> +       provider = node->provider;
>> +       qp = to_qcom_provider(node->provider);
>> +
>> +       /* convert from kbps to bps */
>> +       avg_bw = avg * 1000ULL;
>> +       peak_bw = peak * 1000ULL;
>> +
> 
> Since the core uses kbps and various SoC HW might use bps (or other
> units), perhaps consider providing a macro in the core header such as:
> 
> #define icc_units_to_bps(bw)  (bw * 1000ULL)
> 
> and then move this conversion to the top of the function where you
> define the variable
> 
> u64 avg_bw = icc_units_to_bps(avg);
> u64 peak_bw = icc_units_to_bps(peak);
> 
> Since other drivers will end up copying this driver, it might help
> prevent silly errors in the drivers and has a side-effect of allowing
> the core to change internal units w/o any driver changes down the
> line, if needed.

Ok, i am fine with this.

Thanks,
Georgi
