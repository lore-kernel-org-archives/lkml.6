Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753081AbeDSPGs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 11:06:48 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38736 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752100AbeDSPGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 11:06:46 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B63B0601E6
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date: Thu, 19 Apr 2018 09:06:44 -0600
From: Lina Iyer <ilina@codeaurora.org>
To: Stephen Boyd <swboyd@chromium.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, evgreen@chromium.org,
        dianders@chromium.org
Subject: Re: [PATCH v5 07/10] drivers: qcom: rpmh: cache sleep/wake state
 requests
Message-ID: <20180419150644.GB17907@codeaurora.org>
References: <20180405161834.3850-1-ilina@codeaurora.org>
 <20180405161834.3850-8-ilina@codeaurora.org>
 <152411832959.46528.17741598693542734318@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <152411832959.46528.17741598693542734318@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18 2018 at 00:12 -0600, Stephen Boyd wrote:
>Quoting Lina Iyer (2018-04-05 09:18:31)
>> Active state requests are sent immediately to the mailbox controller,
>
>Drive by note, mailbox went away from this code so grep 'mailbox' or
>'mbox' on these patches should come up with zero hits.
>
Will do. Thanks.

-- Lina

>> while sleep and wake state requests are cached in this driver to avoid
>> taxing the mailbox controller repeatedly. The cached values will be sent
>> to the controller when the rpmh_flush() is called.
>>
