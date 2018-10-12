Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3E4C28CF8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 00:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B1A220644
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 00:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iXeahS7N";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="B20uJHTT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B1A220644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbeJLIZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 04:25:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54528 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbeJLIZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 04:25:16 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id ABCB660C60; Fri, 12 Oct 2018 00:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539305726;
        bh=NBlomhmy8pJqwpVilnH8sLnIQGcR7aWMCSAPqJXMne0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iXeahS7N9RS88Ua8JP2zF/kkwSQQ5+P+kSOy6nTV2NosJmkIublLCpSyUwKz9H3rh
         gb0l4rWmg8q3k0hSc8PbFzuvpdHJSCOME0HJ8pr+DqmQ2iw0LVuKfChBaSq6Z0kEly
         swuBkMi1Ca2+3x/wdvXjEEouSGHg/+uqJQalnnDo=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id ADB4F60866;
        Fri, 12 Oct 2018 00:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539305725;
        bh=NBlomhmy8pJqwpVilnH8sLnIQGcR7aWMCSAPqJXMne0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=B20uJHTTvUeFIMIMVkhNxSmmWzasg+EAi8IMdf9jttd8tJRhWZ5adyn7CxQnUVer4
         us7XUb3MySe8hIsN5TRvHp2l2QJdRCZ5DINCkjOzYJdvsl4TJLyWYToUAlSXgmk4o3
         j1RezeaMidLOTLWGuYtIJemGYowmJVCXaPxwpXt0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 12 Oct 2018 08:55:25 +0800
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
Subject: Re: [PATCH v2 1/1] scsi: ufs: make UFS Tx lane1 clock optional for
 QCOM platforms
In-Reply-To: <CAD=FV=VSyJAna4JwLXJi1=Z_Y1mzr8cW4iD+vJLPU2GASP3wQA@mail.gmail.com>
References: <1539261196-14550-1-git-send-email-cang@codeaurora.org>
 <CAD=FV=VSyJAna4JwLXJi1=Z_Y1mzr8cW4iD+vJLPU2GASP3wQA@mail.gmail.com>
Message-ID: <0f371e5e2cd1fe47834560a5072c0581@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

On 2018-10-12 04:21, Doug Anderson wrote:
> Hi,
> 
> On Thu, Oct 11, 2018 at 5:33 AM Can Guo <cang@codeaurora.org> wrote:
>>  static int ufs_qcom_host_clk_get(struct device *dev,
>> -               const char *name, struct clk **clk_out)
>> +               const char *name, struct clk **clk_out, bool optional)
>>  {
>>         struct clk *clk;
>>         int err = 0;
>> 
>>         clk = devm_clk_get(dev, name);
>> -       if (IS_ERR(clk)) {
>> +       if (clk == ERR_PTR(-EPROBE_DEFER)) {
>> +               err = -EPROBE_DEFER;
>> +               dev_warn(dev, "required clock %s hasn't probed yet, 
>> err %d\n",
>> +                               name, err);
>> +       } else if (IS_ERR(clk)) {
>> +               if (optional)
>> +                       return 0;
> 
> Change this function to:
> 
> static int ufs_qcom_host_clk_get(struct device *dev,
>     const char *name, struct clk **clk_out, bool optional)
> {
>   struct clk *clk;
>   int err;
> 
>   clk = devm_clk_get(dev, name);
>   if (!IS_ERR(clk)) {
>     *clk_out = clk;
>     return 0;
>   }
> 
>   err = PTR_ERR(clk);
> 
>   if (optional && err == -ENOENT) {
>     *clk_out = NULL;
>     return 0;
>   }
> 
>   if (err != -EPROBE_DEFER)
>     dev_err(dev, "failed to get %s err %d",
>         name, err);
> 
>   return err;
> }
> 
> Specifically:
> 
> * Typically it just spams the log to print something when you see an
> -EPROBE_DEFER.
> 
> * If a clock is optional you should only consider things a success
> only if "-ENOENT" was returned.  All other errors should be considered
> fatal.
> 
> * If a clock is optional it's slightly cleaner to set *clk_out to
> NULL.  I know you're initting global data that happened to already be
> NULL by default, but it still feels nice for the abstraction of the
> function to do this.
> 
> * Please don't pass __func__ to your error messages.
> 
> 

Thank you for the detailed instructions. Shall make the change like so.

>>                 err = PTR_ERR(clk);
>>                 dev_err(dev, "%s: failed to get %s err %d",
>>                                 __func__, name, err);
>> @@ -113,10 +119,10 @@ static void ufs_qcom_disable_lane_clks(struct 
>> ufs_qcom_host *host)
>>         if (!host->is_lane_clks_enabled)
>>                 return;
>> 
>> -       if (host->hba->lanes_per_direction > 1)
>> +       if (host->tx_l1_sync_clk)
> 
> Remove this "if".  Always call clk_disable_unprepare() which will be a
> no-op if "host->tx_l1_sync_clk" is NULL.  clk_disable_unprepare() is a
> no-op for NULL clocks by design specifically to make code like this
> cleaner.
> 
> 

Shall do.

>>                 clk_disable_unprepare(host->tx_l1_sync_clk);
>>         clk_disable_unprepare(host->tx_l0_sync_clk);
>> -       if (host->hba->lanes_per_direction > 1)
>> +       if (host->rx_l1_sync_clk)
> 
> Remove this "if".  Always call clk_disable_unprepare() which will be a
> no-op if "host->rx_l1_sync_clk" is NULL.  clk_disable_unprepare() is a
> no-op for NULL clocks by design specifically to make code like this
> cleaner.
> 
> 

Shall do.

>>                 clk_disable_unprepare(host->rx_l1_sync_clk);
>>         clk_disable_unprepare(host->rx_l0_sync_clk);
>> 
>> @@ -141,12 +147,14 @@ static int ufs_qcom_enable_lane_clks(struct 
>> ufs_qcom_host *host)
>>         if (err)
>>                 goto disable_rx_l0;
>> 
>> -       if (host->hba->lanes_per_direction > 1) {
>> +       if (host->rx_l1_sync_clk) {
> 
> Remove this "if".  Always call ufs_qcom_host_clk_enable().  The
> clk_prepare_enable() inside ufs_qcom_host_clk_enable() will be a no-op
> if "host->rx_l1_sync_clk" is NULL and will return 0 (no error).
> 
> 

Shall do so.

>>                 err = ufs_qcom_host_clk_enable(dev, 
>> "rx_lane1_sync_clk",
>>                         host->rx_l1_sync_clk);
>>                 if (err)
>>                         goto disable_tx_l0;
>> +       }
>> 
>> +       if (host->tx_l1_sync_clk) {
> 
> Remove this "if".  Always call ufs_qcom_host_clk_enable().  The
> clk_prepare_enable() inside ufs_qcom_host_clk_enable() will be a no-op
> if "host->tx_l1_sync_clk" is NULL and will return 0 (no error).
> 
> 
> -Doug

Shall do so. Thank you.

-Can Guo
