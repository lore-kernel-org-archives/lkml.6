Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750865AbeCXEC3 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 00:02:29 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33704 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750723AbeCXEC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 00:02:27 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D69146055D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH v6 6/6] bnxt_en: Eliminate duplicate barriers on
 weakly-ordered archs
To: Michael Chan <michael.chan@broadcom.com>
Cc: Netdev <netdev@vger.kernel.org>, timur@codeaurora.org,
        sulrich@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>
References: <1521843791-21201-1-git-send-email-okaya@codeaurora.org>
 <1521843791-21201-7-git-send-email-okaya@codeaurora.org>
 <CACKFLinCMQ6aFXJDcqkTGGuPSEWsPPB09sS=mJJgsCdm5mvjhA@mail.gmail.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <9a5f49c8-ce50-a153-44e1-6f21f8d1f44b@codeaurora.org>
Date: Sat, 24 Mar 2018 00:02:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CACKFLinCMQ6aFXJDcqkTGGuPSEWsPPB09sS=mJJgsCdm5mvjhA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/2018 6:36 PM, Michael Chan wrote:
>> +               mmiowb();
> Sorry for the late review.  mmiowb() is not required here because we
> are in NAPI context, so only one CPU will be updating this doorbell.
> 
> Other than that, it looks good.
> 

OK, I'll fix this on the next version.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
