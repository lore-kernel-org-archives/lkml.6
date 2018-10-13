Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E0AC6787C
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 02:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82CFC20895
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 02:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BkHw4hPy";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LXYY1ZB/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82CFC20895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbeJMJsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 05:48:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52010 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbeJMJsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 05:48:19 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4031660BFE; Sat, 13 Oct 2018 02:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539396783;
        bh=YxG0wgOHAFsih/UvVuK8Jwdf0DGFBwOuS3XBPC4bxIs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BkHw4hPyTxui6t4JBVsm/dWXAm3hAAtGL/T76sbJoQVxMSJ0gbS7KTBAsYu3Ef9qc
         H319noWb/OQhpX4NDdi5yXWUum41u4+k7mZ1j+exFLfe1UOwoFFc1kd3jDyzKxJKcQ
         Zff58Qrg5MEJlPkojUQ0rjTT7nWStndvlO6KtKLo=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 5EAD460285;
        Sat, 13 Oct 2018 02:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539396782;
        bh=YxG0wgOHAFsih/UvVuK8Jwdf0DGFBwOuS3XBPC4bxIs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LXYY1ZB/uVZ+VT+Douq1msi4nm4Ejt6RffBWLEv4i2yYVVVHa6CL2T1F0texsxnhV
         75cSnUEGQNMF6BLfHupGxhjkDRFGOWqY2XJoD7aXhjysA2ppdLSICWUh6diQjvQN7z
         kChd4FJ8K6k2n1307+ddbLehHAoG40yihvOvkEl8=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 13 Oct 2018 10:13:02 +0800
From:   cang@codeaurora.org
To:     Doug Anderson <dianders@chromium.org>
Cc:     subhashj@codeaurora.org, Asutosh Das <asutoshd@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        jejb@linux.vnet.ibm.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        venkatg@codeaurora.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/1] scsi: ufs: make UFS Tx lane1 clock optional for
 QCOM platforms
In-Reply-To: <CAD=FV=WjO9YvKHDiEDt8+8TJ_JjnzcVAqB99nhP5LwnWO0fuLw@mail.gmail.com>
References: <1539306736-9519-1-git-send-email-cang@codeaurora.org>
 <CAD=FV=WjO9YvKHDiEDt8+8TJ_JjnzcVAqB99nhP5LwnWO0fuLw@mail.gmail.com>
Message-ID: <5f2d152941aed6411f54d47dd7ec199e@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-13 00:55, Doug Anderson wrote:
> Hi,
> 
> On Thu, Oct 11, 2018 at 6:12 PM Can Guo <cang@codeaurora.org> wrote:
>> +       if (err != -EPROBE_DEFER)
>> +               dev_err(dev, "failed to get %s err %d",
>> +                               name, err);
> 
> I wouldn't spin just for this, but if you spin for some other reason
> you could move the above "dev_err" onto one line now.  Sorry: I should
> have noticed that / done that on my patch...
> 
> 

Yeah... I didn't notice it too. Shall push a new one to address it.

>> @@ -141,24 +147,21 @@ static int ufs_qcom_enable_lane_clks(struct 
>> ufs_qcom_host *host)
> 
> Idea for a future patch: now that I look at what's left of this
> function you're basically re-implementing clk_bulk_prepare_enable()
> and clk_bulk_disable_unprepare() now.  I bet your code would be
> cleaner / nicer by switching to that.
> 
> ...possibly you might need to improve the clk_bulk_get() API to allow
> for some clock to be optional, but that would be a pretty easy patch
> to post up.
> 
> In any case I think it's better to do the clk_bulk switch in a future
> / separate patch, so:
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Tested-by: Douglas Anderson <dianders@chromium.org>
> 
> 
> -Doug

That is a good idea, I shall follow up after this one is merged.

Thank you.
-Can Guo
