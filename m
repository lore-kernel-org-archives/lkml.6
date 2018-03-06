Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753906AbeCFQ4W (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 11:56:22 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:44346 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753849AbeCFQ4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 11:56:20 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E2D586016D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date: Tue, 6 Mar 2018 09:56:19 -0700
From: Lina Iyer <ilina@codeaurora.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>
Subject: Re: [PATCH v4 1/2] drivers: qcom: add command DB driver
Message-ID: <20180306165619.GD4930@codeaurora.org>
References: <20180226175802.20052-1-ilina@codeaurora.org>
 <20180226175802.20052-2-ilina@codeaurora.org>
 <152027534725.108663.13213325833387672227@swboyd.mtv.corp.google.com>
 <20180306162140.GC4930@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180306162140.GC4930@codeaurora.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06 2018 at 09:21 -0700, Lina Iyer wrote:
>On Mon, Mar 05 2018 at 11:42 -0700, Stephen Boyd wrote:
>>Quoting Lina Iyer (2018-02-26 09:58:01)
>>>+size_t cmd_db_read_aux_data_len(const char *id)
>>>+{
>>>+       int ret;
>>>+       struct entry_header ent;
>>>+       struct rsc_hdr rsc_hdr;
>>>+
>>>+       ret = cmd_db_get_header_by_rsc_id(id, &ent, &rsc_hdr);
>>
>>A bunch of code is calling this function. Why not change the user
>>interface to use an opaque 'resource' cookie that we can 'get' or 'find'
>>and then use that cookie in the rest of the API to pull out the data
>>that's desired?
>>
>Fair point. Let me find out. I suspect this was done to keep the API
>similar to other non-Linux interfaces. I am not sure why they all didn't
>use a handle instead of char *.
>
I was reminded that the APIs are generally used once for each resource
and are used for multiple resources and usually only at init. The handle
method doesn't buy much in benefits.

-- Lina
