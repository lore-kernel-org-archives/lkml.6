Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02CEC04EBA
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE20E20663
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:15:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE20E20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408870AbeKWT7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 14:59:14 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:49182 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2408854AbeKWT7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 14:59:14 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wAN90EUo019052;
        Fri, 23 Nov 2018 03:15:42 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail4.cirrus.com ([87.246.98.35])
        by mx0a-001ae601.pphosted.com with ESMTP id 2nth989ycq-1;
        Fri, 23 Nov 2018 03:15:41 -0600
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail4.cirrus.com (Postfix) with ESMTP id 7A44D611C8B2;
        Fri, 23 Nov 2018 03:19:06 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Fri, 23 Nov 2018
 09:15:40 +0000
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id wAN9Fexo018505; Fri,
 23 Nov 2018 09:15:40 GMT
Date:   Fri, 23 Nov 2018 09:15:40 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <lee.jones@linaro.org>
CC:     <kbuild-all@01.org>, <lee.jones@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <broonie@kernel.org>, <linus.walleij@linaro.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <lgirdwood@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <linux-clk@vger.kernel.org>, <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v5 6/8] mfd: lochnagar: Add support for the Cirrus Logic
 Lochnagar
Message-ID: <20181123091540.GL16508@imbe.wolfsonmicro.main>
References: <20181120141631.18949-6-ckeepax@opensource.cirrus.com>
 <201811231606.fDWBzL7a%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <201811231606.fDWBzL7a%fengguang.wu@intel.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1811230072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 05:00:57PM +0800, kbuild test robot wrote:
> Hi Charles,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on ljones-mfd/for-mfd-next]
> [also build test ERROR on v4.20-rc3]
> [cannot apply to next-20181122]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>    drivers/regulator/lochnagar-regulator.c: In function 'lochnagar_micbias_of_parse':

> >> drivers/regulator/lochnagar-regulator.c:115:7: error: 'LOCHNAGAR2_P2_MICBIAS_SRC_SHIFT' undeclared (first use in this function); did you mean 'LOCHNAGAR_DEVICE_ID_SHIFT'?
>           LOCHNAGAR2_P2_MICBIAS_SRC_SHIFT;
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

These issues will resolve themselves in the merge, this patch is
already merged in Mark's tree and will resolve the issue:

fa2bb8b97d77 ("regulator: lochnagar: Explicitly include register headers")

Thanks,
Charles
