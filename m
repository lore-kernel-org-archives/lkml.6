Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143B2ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 18:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBEF920852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 18:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YsHjrKS/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBEF920852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388354AbeGWTZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 15:25:01 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40266 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388026AbeGWTZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 15:25:01 -0400
Received: by mail-ed1-f67.google.com with SMTP id e19-v6so1774410edq.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 11:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UOkiAcRVlAdFGHhBQHpUdRSIbs7FI6a5nUo3q7mpgq4=;
        b=YsHjrKS/ZnvV1/TOUSz4bb/JemrzhPEhghFxMFgeWarfPF8w+a1aT1tzUAnMwgKcnA
         oNv5wkyVviBmwaCfw1K7I+0+iDJDkbWUNOVTfAZ+UwstZdwrh8sCFqibpEqw4VYbedf2
         3eVJYzhs7VsEDUkqfAx+8SrYtZ6R+toiVwrgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UOkiAcRVlAdFGHhBQHpUdRSIbs7FI6a5nUo3q7mpgq4=;
        b=n4jVI1b7RhdoOaa97/86RpFqSikeKEXkL6vBOxxCk9bCYnM1PrQxH+vHtkvPiz5c8q
         o2eL0kvaFs9c3J0ca0fDQctmwfQf1RbYXXxnTj5xcsQmkTKr1OWS/CyW6Y33Rp8ZMsD6
         mQ0d8W/Qid1KMbLXoXYY1wSNpuvCWlDIRFioG6WcO2nTisqmtAHTe3sXr2XXpF06GpRx
         jxAQ2pjHAjRfKIV+vssWaqp6QzNRve2ahSf/3EswlgZysaDkWgxW8PeZ1r/cQEBv9Rk7
         CVIcCSkMG2mrJYFtbNWVgRrQiUrvz3zAsEATJjsgK3qIxz/gKNkJ1vhTLfDu8Ha9nxQk
         p9Kg==
X-Gm-Message-State: AOUpUlGfUsOzvrZarcohA7u0EGlzL5kcj52wmh1mR6RUyoNYwcHSakGd
        yNIGOv8aT4tt/+vWVg5w/PAXROrtpLDZYXIexvvI+g==
X-Google-Smtp-Source: AAOMgpevSX6AGkq/HPdtwfyWZf6/tvUplpjC5G/NyTifam5AW+IXo36yI2SE4NVHA2sumrRfY6HVFrcDiFM4tJj5OJ0=
X-Received: by 2002:a50:b2c6:: with SMTP id p64-v6mr15160577edd.293.1532370152726;
 Mon, 23 Jul 2018 11:22:32 -0700 (PDT)
MIME-Version: 1.0
References: <1531847501-22226-1-git-send-email-suzuki.poulose@arm.com>
 <1531847501-22226-10-git-send-email-suzuki.poulose@arm.com>
 <20180719203630.GC9421@xps15> <a68cff9d-51d3-7d86-0a73-c1d3cbbaced3@arm.com>
In-Reply-To: <a68cff9d-51d3-7d86-0a73-c1d3cbbaced3@arm.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Mon, 23 Jul 2018 12:22:21 -0600
Message-ID: <CANLsYkyN_+uTJZh7YEBPtMPvb8uQNwXvCwn_N4+D12xOVc=MNg@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] coresight: perf: Remove set_buffer call back
To:     "Suzuki K. Poulose" <Suzuki.Poulose@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Robert Walker <robert.walker@arm.com>,
        Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jul 2018 at 03:04, Suzuki K Poulose <Suzuki.Poulose@arm.com> wrote:
>
> Mathieu,
>
> On 19/07/18 21:36, Mathieu Poirier wrote:
> > On Tue, Jul 17, 2018 at 06:11:40PM +0100, Suzuki K Poulose wrote:
> >> In coresight perf mode, we need to prepare the sink before
> >> starting a session, which is done via set_buffer call back.
> >> We then proceed to enable the tracing. If we fail to start
> >> the session successfully, we leave the sink configuration
> >> unchanged. This was fine for the existing backends as they
> >> don't have any state associated with the buffers. But with
> >> ETR, we need to keep track of the buffer details and need
> >> to be cleaned up if we fail. In order to make the operation
> >> atomic and to avoid yet another call back, we get rid of
> >> the "set_buffer" call back and pass the buffer details
> >> via enable() call back to the sink.
> >
> > Suzuki,
> >
> > I'm not sure I understand the problem you're trying to fix there.  From the
> > implementation of tmc_enable_etr_sink_perf() in the next patch, wouldn't the
> > same result been achievable using a callback?
>
> We can definitely achieve the results using "set_buffer". But for ETR,
> we track the "perf_buf" in drvdata->perf_data when we do "set_buffer".
> But if we failed to enable_path(), we leave the drvdata->perf_data
> and doesn't clean it up. Now when another session is about to set_buf,
> we check if perf_data is empty and WARNs otherwise.
> Because we can't be sure if it belongs to an abandoned session or
> another active session and we completely messed somewhere in the driver.
> So, we need a clear_buffer call back if the enable fails, something
> not really worth. Anyways, there is no point in separating set_buffer
> and enabling the sink, as the error handling becomes cumbersome as explained
> above.
>
> >
> > I'm fine with this patch and supportive of getting rid of callbacks if we can, I
> > just need to understand the exact problem you're after.  From looking a your
> > code (and the current implementation), if we succeed in setting the memory for
> > the sink but fail in any of the subsequent steps i.e, enabling the rest of the
> > compoment on the path or the source, the sink is left unchanged.
>
> Yes, thats right. And we should WARN (which I missed in this version) if
> there is a perf_data already for a disabled ETR. Please see my response to the
> next patch.

The changelog for this patch states the following: "But with ETR, we
need to keep track of the buffer details and need to be cleaned up if
we fail."

I did a deep dive in the code and in the current implementation if the
source fails to be enabled in etm_event_start() the path and the sink
remains unchanged.  With your patchset this get fixed because a goto
was added to disable the path when such condition occur.  As such each
component in the path will see its ->disable() callback invoked.  In
tmc_disable_etr_sink(), drvdata->perf_data is set to NULL in
tmc_etr_disable_hw(), so the cleanup on error condition is done
properly.  As such we wouldn't need a clean_buffer() callback.

As I said I'm in favour of removing the set_buffer() callback but I
wouldn't associated it with ETR state cleanup.  If the code can be
rearranged in a way that code can be removed then that alone is enough
to justify the change.

>
> >> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> >> index 3cc4a0b..12a247d 100644
> >> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> >> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> >> @@ -269,16 +269,11 @@ static void etm_event_start(struct perf_event *event, int flags)
> >>      path = etm_event_cpu_path(event_data, cpu);
> >>      /* We need a sink, no need to continue without one */
> >>      sink = coresight_get_sink(path);
> >> -    if (WARN_ON_ONCE(!sink || !sink_ops(sink)->set_buffer))
> >> -            goto fail_end_stop;
> >> -
> >> -    /* Configure the sink */
> >> -    if (sink_ops(sink)->set_buffer(sink, handle,
> >> -                                   event_data->snk_config))
> >> +    if (WARN_ON_ONCE(!sink))
> >>              goto fail_end_stop;
> >>
> >>      /* Nothing will happen without a path */
> >> -    if (coresight_enable_path(path, CS_MODE_PERF))
> >> +    if (coresight_enable_path(path, CS_MODE_PERF, handle))
> >
> > Here we already have a handle on "event_data".  As such I think this is what we
> > should feed to coresight_enable_path() rather than the handle.  That way we
> > don't need to call etm_perf_sink_config(), we just use the data.
>
> The advantage of passing on the handle is, we could get all the way upto the
> "perf_event" for the given session. Passing the event_data will loose that
> information.
>
> i.e, perf_event-> |perf_ouput_handle | -> |event_data | -> sink_config
>                    |  <-event         |    |           |
>
> The purpose of the wrapper "etm_perf_sink_config()" is to abstract the way we
> handle the information under the event_data. i.e, if we decide to make some
> changes in the way we store event_data, we need to spill the changes every
> where. But the perf_ouput_handle has much more stable ABI than event_data,
> hence the choice of passing handle.

I agree that etm_perf_sink_config() has value but it should take a
void * as parameter (i.e what gets returned from perf_get_aux())
rather than a perf_output_handle *.

Thanks,
Mathieu

>
> Cheers
> Suzuki
