Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B629C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 10:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C173925727
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 10:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bi7H2H5N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C173925727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755101AbeFYKAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 06:00:13 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:41024 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754996AbeFYKAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 06:00:11 -0400
Received: by mail-oi0-f66.google.com with SMTP id 21-v6so1243067oip.8;
        Mon, 25 Jun 2018 03:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=uxRlrGo/EKuxPxitbLP3Ca4E4l5NfDROA5r5AYAj/Oo=;
        b=bi7H2H5NDmQyxDgDsEaChmshBpsmrCpiRfc7U1MIJ0MO/uBZVp2GJlpl8fsjdaP8mA
         bQRRsecfrgWofjlfHHFkkqoqGvC2XNo7rOShMEJ/3Xzvcm8fsOrWxAFtmtnFiQP0+s00
         TbANS7JQIbPC+GadIfckfU2CIJDfsEu0u8TSYtdOdaucmpqDOnUvVKXhga2g48vXnhHV
         +bzinWgmp/v1n21t1NtbKCl4m1mp+ve6GqWfawPwxBebP0nF6CyEE/W1W1ZD/0RfmzH4
         mL91Y737Qtw2Sgj0nJ6gSj0ZguEfgEyKvYQwEf67CTiyrncRe7nYLSMhkaNl92tiPDjT
         z/XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=uxRlrGo/EKuxPxitbLP3Ca4E4l5NfDROA5r5AYAj/Oo=;
        b=dx8bkR101rGhHHPoChJ1Eta7H8fdyT8vlj+Uh5vJej4hODGWCnKguwPd0u4g6AjzBu
         UpA48hYICYgmPkxA9OExWiUazXRliJxUt0ibgQq4X/69lcXOxIr77yfBSSnnNnf583Mw
         qxnNewmohvalAZNkqaUjk8mHCbfFp57GsntoQEZx0hGWb7wtTWRdRNT/FJol98gv2HkA
         ZWF7lrxcxt/bNh6AbBCE3nFkI1ilEQaPMILWWY5bpfVdEECI5aSrOE3uFE3z5dhLWRHB
         mJRADB2kWf1PO/2xtDARfR8JirBnb/+a1wtiIXLG/X3e4VsmSNhSL+SQjvj+r6Oz+CTo
         3ImA==
X-Gm-Message-State: APt69E0hUVpgKPaXCqTKBxNexsrnI8uLhQE6bEv9gWoF0m4fNMEzpXVi
        T2l/TQOkygsy1wmkA/DBCEm5fj6YudnEWr6kWpw=
X-Google-Smtp-Source: ADUXVKINL2Dpd+RV9dl6Fo3J/vhiFReS07ES6vdOw0+w5P4h64ha9ErrWFvQ3/23xG3BBYq1/xFfP8LBQdraTnnhs18=
X-Received: by 2002:aca:ec0c:: with SMTP id k12-v6mr5018988oih.227.1529920810990;
 Mon, 25 Jun 2018 03:00:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1429:0:0:0:0:0 with HTTP; Mon, 25 Jun 2018 03:00:10
 -0700 (PDT)
In-Reply-To: <20180625094411.ubklcaxvd7hvuind@vireshk-i7>
References: <1529414627-5638-1-git-send-email-daniel.lezcano@linaro.org>
 <CAJZ5v0iyS7wUx5sYnyhZxhRD7EMEWyKzcpBu7vXUGxuwM4+prw@mail.gmail.com> <20180625094411.ubklcaxvd7hvuind@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 25 Jun 2018 12:00:10 +0200
X-Google-Sender-Auth: i5kWhaGsVMOCHQDQd1RPSAmeoVk
Message-ID: <CAJZ5v0gHPxw2Ne3HFoqQiSs+AvSJdh_rMmVXbV7sBvJSTaM5qw@mail.gmail.com>
Subject: Re: [PATCH V9] powercap/drivers/idle_injection: Add an idle injection framework
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Kevin Wangtao <kevin.wangtao@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rui Zhang <rui.zhang@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 11:44 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 25-06-18, 10:23, Rafael J. Wysocki wrote:
>> On Tue, Jun 19, 2018 at 3:23 PM, Daniel Lezcano
>> > +void idle_injection_get_duration(struct idle_injection_device *ii_dev,
>> > +                                unsigned int *run_duration_ms,
>> > +                                unsigned int *idle_duration_ms)
>> > +{
>> > +       *run_duration_ms = READ_ONCE(ii_dev->run_duration_ms);
>> > +       *idle_duration_ms = READ_ONCE(ii_dev->idle_duration_ms);
>>
>> Should you check the arguments against NULL before attempting to
>> dereference them?  If not, then why not?
>
> I would vote with a NO. This is a mandatory parameter and not filling it in with
> a valid pointer is a BUG really. I don't see a reason why we should prevent the
> kernel from crashing if such a mistake happens :)

Well, fair enough.
