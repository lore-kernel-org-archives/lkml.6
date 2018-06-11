Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIM_INVALID,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1DD51C5CFF0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB08B20660
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="grynVbPj";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RLF9zPRF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB08B20660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934081AbeFKRRl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 13:17:41 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38784 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752521AbeFKRRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 13:17:39 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 04B1660541; Mon, 11 Jun 2018 17:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528737459;
        bh=bEZcOJfaIrd/+qo7xA7dscZg0Lv/M5MJNg8zvpsNXoM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=grynVbPjncBBNHFyUs0OqJpXSmvA+Q+rCUiA7Z2wEXv3rbsxizOn/mM1NQFgrW5s6
         i3yvQCa4QJNhZjqYSI7yjJ3mmLAmqcr4rpVcJ5YBGrYjBd9RMPpWKQAErI13gErfQD
         3JiBTM+h8R8OgE+7xbLCiT1Xv610H7/xEDmBL7S0=
Received: from [192.168.1.7] (unknown [183.83.75.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4FEF360351;
        Mon, 11 Jun 2018 17:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528737458;
        bh=bEZcOJfaIrd/+qo7xA7dscZg0Lv/M5MJNg8zvpsNXoM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RLF9zPRFyCQehs2xtVqI01S+mrvcmhYiEK9GyRgP3gUVAZeJIy+87FbNRKOpde9ws
         EpczdSOyNKVpGnlBAjvtb0Qj4FERlXp3S7f43rsQvuGu+si9OdbB9SuCcmHAeHwkH3
         6YFnX1FkOubFhb6aBSjg4Zszi0BKVVSEDYRiHNa0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4FEF360351
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
Subject: Re: [PATCH v9 09/10] drivers: qcom: rpmh: add support for batch RPMH
 request
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Lina Iyer <ilina@codeaurora.org>
References: <1527158731-17685-1-git-send-email-rplsssn@codeaurora.org>
 <1527158731-17685-10-git-send-email-rplsssn@codeaurora.org>
 <CAD=FV=X7Bv587F753AXJ2VtxedLdeBhk8JQf-a8E4h33JfFiWA@mail.gmail.com>
From:   Raju P L S S S N <rplsssn@codeaurora.org>
Message-ID: <9db0ca7e-6ca9-7e00-5092-7e561b997fbd@codeaurora.org>
Date:   Mon, 11 Jun 2018 22:47:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=X7Bv587F753AXJ2VtxedLdeBhk8JQf-a8E4h33JfFiWA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/31/2018 3:20 AM, Doug Anderson wrote:
> Hi,
> 
> On Thu, May 24, 2018 at 3:45 AM, Raju P L S S S N
> <rplsssn@codeaurora.org> wrote:
>>   #define DEFINE_RPMH_MSG_ONSTACK(dev, s, q, name)       \
>>          struct rpmh_request name = {                    \
>> @@ -35,6 +37,7 @@
>>                  .completion = q,                        \
>>                  .dev = dev,                             \
>>                  .needs_free = false,                            \
>> +               .wait_count = NULL,                     \
> 
> You ignored my feedback on v8 that wait_count is not useful.  Please
> squash in <http://crosreview.com/1079905>.  That also has a fix where
> it introduces a WARN_ON for the timeout case in batch mode too.

Oh. Sorry.. I missed it. Thanks for pointing out. Will take up in next spin

> 
> 
>> +/**
>> + * rpmh_write_batch: Write multiple sets of RPMH commands and wait for the
>> + * batch to finish.
>> + *
>> + * @dev: the device making the request
>> + * @state: Active/sleep set
>> + * @cmd: The payload data
>> + * @n: The array of count of elements in each batch, 0 terminated.
>> + *
>> + * Write a request to the RSC controller without caching. If the request
>> + * state is ACTIVE, then the requests are treated as completion request
>> + * and sent to the controller immediately. The function waits until all the
>> + * commands are complete. If the request was to SLEEP or WAKE_ONLY, then the
>> + * request is sent as fire-n-forget and no ack is expected.
>> + *
>> + * May sleep. Do not call from atomic contexts for ACTIVE_ONLY requests.
>> + */
>> +int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
>> +                    const struct tcs_cmd *cmd, u32 *n)
>> +{
>> +       struct rpmh_request *rpm_msg[RPMH_MAX_REQ_IN_BATCH] = { NULL };
>> +       DECLARE_COMPLETION_ONSTACK(compl);
>> +       atomic_t wait_count = ATOMIC_INIT(0);
>> +       struct rpmh_ctrlr *ctrlr = get_rpmh_ctrlr(dev);
>> +       int count = 0;
>> +       int ret, i, j;
>> +
>> +       if (IS_ERR(ctrlr) || !cmd || !n)
>> +               return -EINVAL;
>> +
>> +       while (n[count++] > 0)
>> +               ;
>> +       count--;
>> +       if (!count || count > RPMH_MAX_REQ_IN_BATCH)
>> +               return -EINVAL;
>> +
>> +       for (i = 0; i < count; i++) {
>> +               rpm_msg[i] = __get_rpmh_msg_async(state, cmd, n[i]);
>> +               if (IS_ERR(rpm_msg[i])) {
>> +                       ret = PTR_ERR(rpm_msg[i]);
>> +                       for (j = i-1; j >= 0; j--) {
>> +                               if (rpm_msg[j]->needs_free)
> 
> How could needs_free be false here?

Yes. Just an additional check. Can be omitted. Will do it in next spin.

> 
>> +                                       kfree(rpm_msg[j]);
>> +                       }
>> +                       return ret;
>> +               }
>> +               cmd += n[i];
>> +       }
>> +
>> +       if (state != RPMH_ACTIVE_ONLY_STATE)
>> +               return cache_batch(ctrlr, rpm_msg, count);
> 
> Previously I said:
>> Don't you need to free rpm_msg items in this case?
> 
> ...but I think that wasn't clear enough.  Perhaps I should have said:
> 
> Don't you need to free rpm_msg items in the case where cache_batch
> returns an error?  AKA squash in <http://crosreview.com/1079906>.

Now I got it. will add the changes in next spin.

> 
> 
>> +
>> +       atomic_set(&wait_count, count);
>> +
>> +       for (i = 0; i < count; i++) {
>> +               rpm_msg[i]->completion = &compl;
>> +               rpm_msg[i]->wait_count = &wait_count;
>> +               ret = rpmh_rsc_send_data(ctrlr->drv, &rpm_msg[i]->msg);
>> +               if (ret) {
>> +                       int j;
> 
> You're shadowing another "j" variable.  Please squash in
> <http://crosreview.com/1080027>.
> 

Agreed.

>> +
>> +                       pr_err("Error(%d) sending RPMH message addr=%#x\n",
>> +                              ret, rpm_msg[i]->msg.cmds[0].addr);
>> +                       for (j = i; j < count; j++)
>> +                               rpmh_tx_done(&rpm_msg[j]->msg, ret);
> 
> Previously I said:
> 
>> Note that you'll probably do your error handling in this
>> function a favor if you rename __get_rpmh_msg_async()
>> to __fill_rpmh_msg() and remove the memory
>> allocation from there
> 
> I tried to implement this but then I realized cache_batch() requires
> individual allocation.  Sigh.
> 
> OK, I attempted this in <http://crosreview.com/1080028>.  This gets
> rid of several static-sized arrays and gets rid of all of the little
> memory allocations in rpmh_write_batch(), replacing it with one bigger
> one.  In my mind this is an improvement, but I welcome other opinions.
> 
> As discussed previously, I'm still of the belief that we'll be better
> off getting rid of separate "batch" data structures.  I'll see if I
> can find some time to do that too and see how it looks.
> 
> 
> -Doug
> 

Thanks,
Raju
