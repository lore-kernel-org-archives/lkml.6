Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751998AbeFANdw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 09:33:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35848 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751687AbeFANdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 09:33:50 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 50E4760224
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
Subject: Re: [RFC PATCH 0/5] Hexagon remoteproc spring cleaning
To: Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Sricharan R <sricharan@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20180523052054.19025-1-bjorn.andersson@linaro.org>
From: Rohit Kumar <rohitkr@codeaurora.org>
Message-ID: <9dd77f05-9ac4-55d1-5f79-03f40c9306f9@codeaurora.org>
Date: Fri, 1 Jun 2018 19:03:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180523052054.19025-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Bjorn for the cleanup.

I validated PAS and Non- PAS ADSP PIL with the cleanup changes on SDM845.

Adding tag for ADSP PIL.

Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>

On 5/23/2018 10:50 AM, Bjorn Andersson wrote:
> With the introduction of support for the non-MSA Hexagon WCSS driver from
> Sricharan and the non-PAS ADSP driver from Rohit it makes sense to overhaul the
> structure of the Qualcomm "Q6V5 drivers".
>
> The first patch is from Sricharan's series and included here for completeness.
> The second patch introduces a set of helper functions, based on the current
> state of the qcom_q6v5_pil driver. The third and forth patch migrates the PAS
> and the MSA drivers over to using these helpers. Finally a (completely)
> reworked version of Sricharan's WCSS remoteproc driver is introduced.
>
>
> With this in place I suggest that we rename qcom_adsp_pil.c to qcom_q6v5_pas.c,

I am making changes for non-PAS ADSP PIL by creating new file.
In case you plan to rename qcom_adsp_pil.c to qcom_q6v5_pas, please 
include that change with this.
Also, let me know the filename which we should keep it for non-PAS ADSP 
PIL driver.
> qcom_q6v5_pil.c to qcom_q6v5_msa.c and depending on the details of the non-PAS
> ADSP we could potentially combine that into a qcom_q6v5_pil.c - or we carry
> them as separate files.
I tried comparing qcom_q6v5_pil.c with non-PAS ADSP pil driver. I don't 
think that we can combine
them as there are good amount of code differences. However, we can take 
a look into it once
I post non-PAS ADSP PIL.
>
> Looking at the remaining non-essential parts of these drivers we have
> memory-region handling and halt_axi handling. The prior is actively being
> worked on and the latter should (if no better abstraction is presented) be
> possible to just put in the new qcom_q6v5.c.
>

Thanks,
Rohit

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
