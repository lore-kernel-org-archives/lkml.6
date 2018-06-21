Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECF3C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D4C9223F7
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCz5lKsM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D4C9223F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933490AbeFUVZL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 17:25:11 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:42478 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933162AbeFUVZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 17:25:09 -0400
Received: by mail-ua0-f193.google.com with SMTP id x18-v6so2977556uaj.9;
        Thu, 21 Jun 2018 14:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=W9XsZeZ5NcVzTmpayYXrlxoOH7VPKi9EgF76265DTYs=;
        b=lCz5lKsMOM0Jw9KZsyPl9o9QxLhJzKYIBF9BQjZOti9WokfDjddBZxS5RkEyYDv2Gy
         axR+T4ZV3uegd0yjLmJIFme8olKjLjw24kzdr+oLul94IIaQYs/UzxuztZShZ1Is4zFL
         CZjVim8A95EWBITCpiOq+9pgeiaFZWUBCDZSmwAI0fsjngqIt+m6Sh3rT78RnNc3Hb2o
         Td1Mrm66qXeuCE127khR5PmgJAh/N2D3wc4nQ7luhkHXc0H47Qy8g0l8DmgUppzvnx5B
         ea14s4HlEggVhweVT8qq08Zs8EEXG9nCkT8pKnGinBiHA/Luvy4fgpdRvz5nff3rvTIA
         wDzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc;
        bh=W9XsZeZ5NcVzTmpayYXrlxoOH7VPKi9EgF76265DTYs=;
        b=AhQrIcIXMKYG0WmGTg9wCRhv06Fj4J465cbzcJVH2f3YZukfKuohn9csJortS1eFCP
         gAIdznUqNzmpcLYuYK6O2Cc3cd6z2E4GNRFSYKxKJE1deKzH9oyseebaSlXcj9PgvRVO
         ryf4q34vb6/3xYzV53wFExDkeUJiUmZeuB4ksZEoE3+iH/57/OQkXYx3DU4mg3HnXGVR
         NU5ZlY5F+dvTiVswJRfczYBDy1Ab8Y1ZZ9681AT3fWPmpkRMxZpv6cT8g5rbqCk8KCyY
         BCU3NOMPq/O80nyEjJ7s/wKVY8xoLPiIymFa6mWK8BeDJMrzeAQ6zLytUYc0ZgplGviS
         x9bw==
X-Gm-Message-State: APt69E1zS0RXVyJWLNYBxUoWFugYHSAQg6LohP0lJp1QDrdghW385eag
        kJyy9u5oXyEZsnsMGkhxEdsGvyPr8I3g/nalWJs=
X-Google-Smtp-Source: ADUXVKJMMSZkhJ+nl84vetDGeCHnC8fYtfEESlT2zkXg2APbiDFp5tHhCojPEzlafaAS1ndOOQbyFm0/pF7DBDitOmw=
X-Received: by 2002:ab0:5c6d:: with SMTP id a45-v6mr17292891uag.105.1529616308260;
 Thu, 21 Jun 2018 14:25:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:3593:0:0:0:0:0 with HTTP; Thu, 21 Jun 2018 14:25:07
 -0700 (PDT)
Reply-To: rajatxjain@gmail.com
In-Reply-To: <20180621184822.GB14136@bhelgaas-glaptop.roam.corp.google.com>
References: <20180522222805.80314-1-rajatja@google.com> <20180620234147.48438-1-rajatja@google.com>
 <20180620234147.48438-3-rajatja@google.com> <20180621184822.GB14136@bhelgaas-glaptop.roam.corp.google.com>
From:   Rajat Jain <rajatxjain@gmail.com>
Date:   Thu, 21 Jun 2018 14:25:07 -0700
Message-ID: <CAA93t1rz6YGmvvORDB0ehr7Gwp-W+0HDYxEDgjtgYmGm3qMgCw@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] PCI/AER: Add sysfs attributes to provide breakdown
 of AERs
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Rajat Jain <rajatja@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frederick Lawler <fred@fredlawl.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Thomas Tai <thomas.tai@oracle.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jes Sorensen <jsorensen@fb.com>, Kyle McMartin <jkkm@fb.com>,
        Tyler Baicar <tbaicar@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 11:48 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> [+cc Tyler for AER dmesg decoding]
>
> I really like this idea a lot; thanks for putting it together!
>
> On Wed, Jun 20, 2018 at 04:41:45PM -0700, Rajat Jain wrote:
>> Add sysfs attributes to provide breakdown of the AERs seen,
>> into different type of correctable or uncorrectable errors:
>>
>> dev_breakdown_correctable
>> dev_breakdown_uncorrectable
>
> - Can you include a more complete sysfs path here in the commit log,
>   as well as a snippet of the contents?  From the doc patch, I think
>   it is currently:
>
>     /sys/bus/pci/devices/<dev>/aer_stats/dev_breakdown_correctable
>     /sys/bus/pci/devices/<dev>/aer_stats/dev_breakdown_uncorrectable
>
> - I'm not sure it's worth making a new subdirectory.  What if you
>   simply added these?

Its your call. We're going to be creating 6 files for aer_stats (I'll
be following your suggestion below), and I think it may clutter the
directory. In my next patch, I'm going to remove the sub directory,
but we can add that later if you feel so.

>
>     /sys/bus/pci/devices/<dev>/aer_correctable
>     /sys/bus/pci/devices/<dev>/aer_uncorrectable
>
>   or perhaps, since you split the "total" files into
>   cor/nonfatal/fatal, these could match?
>
>     /sys/bus/pci/devices/<dev>/aer_correctable
>     /sys/bus/pci/devices/<dev>/aer_nonfatal
>     /sys/bus/pci/devices/<dev>/aer_fatal

This sounds like a better idea.

>
>   I think the nonfatal/fatal distinction might be worth exposing
>   because some of those are configurable and the kernel handling is
>   significantly different.  So I think it would make this more
>   approachable if the "remove/re-enumerate" situations that will be
>   obvious in dmesg logs were clearly connected with "aer_fatal"
>   statistics, as opposed to being connected to some subset of what's
>   in "aer_uncorrectable".

Agree, however note that theoretically, the classification of
uncorrectable errors into fatal or non fatal can be programmed /
changed (by who?), so it is possible that some of the same types of
errors may show up such that some instances in counted in fatal and
some in non-fatal (depending on whether those bits were set while
handling ERR_FATAL or ERR_NONFATAL respectively). Not that I think
there is something wrong with this, just thought I will mention.

>
> - Possibly the totals that you currently have in dev_total_cor_errs
>   could even be added to the bottom of these?  Not sure what direction
>   would be best, and as you say, there's the potential for confusion
>   because the individual items won't add up to the totals.  If they
>   were in the same file, maybe that could be addressed in the label.

Agree, this also sounds good.

>
> - Can you include the related doc update in the same patch?  That way
>   the doc update is more likely to be backported along with the patch.

Will do.

>
> - I was going to ask whether these should all be in a single file or
>   whether they should be split up so there's a separate file for each
>   type or error, each containing a single number.  But
>   Documentation/filesystems/sysfs.txt says either is OK and
>   /sys/devices/system/node/node0/vmstat is an example of a similar
>   situation in an existing file, so I think what you did is perfect.

Thank you, I initially thought of having a different file for each
error, but then it looked like we're be having much more files - at
least large enough for the number of files to overwhelm the user
space.


Thanks,

Rajat

>
>> Signed-off-by: Rajat Jain <rajatja@google.com>
>> ---
>> v5: Fix the signature
>> v4: use "%llu" in place of "%llx"
>> v3: Merge everything in aer.c
>>
>>  drivers/pci/pcie/aer.c | 28 ++++++++++++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>>
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index ce0d675d7bd3..c989bb5bb6f1 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -587,10 +587,38 @@ aer_stats_aggregate_attr(dev_total_cor_errs);
>>  aer_stats_aggregate_attr(dev_total_fatal_errs);
>>  aer_stats_aggregate_attr(dev_total_nonfatal_errs);
>>
>> +#define aer_stats_breakdown_attr(field, stats_array, strings_array)  \
>> +     static ssize_t                                                  \
>> +     field##_show(struct device *dev, struct device_attribute *attr, \
>> +                  char *buf)                                         \
>> +{                                                                    \
>> +     unsigned int i;                                                 \
>> +     char *str = buf;                                                \
>> +     struct pci_dev *pdev = to_pci_dev(dev);                         \
>> +     u64 *stats = pdev->aer_stats->stats_array;                      \
>
> Nit: add a blank line here.

Will do.

>
>> +     for (i = 0; i < ARRAY_SIZE(strings_array); i++) {               \
>> +             if (strings_array[i])                                   \
>> +                     str += sprintf(str, "%s = 0x%llu\n",            \
>> +                                    strings_array[i], stats[i]);     \
>> +             else if (stats[i])                                      \
>> +                     str += sprintf(str, #stats_array "bit[%d] = 0x%llu\n",\
>> +                                    i, stats[i]);                    \
>
> - I like the way this uses the same text as used in dmesg
>   (aer_correctable_error_string[] and
>   aer_uncorrectable_error_string[]).
>
> - I think this incorrectly prints a "0x" prefix for a decimal number
>   (probably an artifact of your v4 change).

Will do.

>
> - Tyler posted a patch [1] to update those dmesg strings so they match
>   the way lspci decodes them.  I really liked that update, but we
>   never quite finished it.  If we're going to do that, it would be
>   nice to do it first, so we don't publish new sysfs files, then
>   immediately change the labels used in them.

Sure, I guess you can push them in the right order.

>
> - IIRC, Tyler's patch had the nice property of changing the strings so
>   each error name had no spaces, which would make it a little easier
>   to parse this sysfs file: each line would be a single identifier
>   followed by a single number (I would probably remove the "=" from
>   the middle).


Will do.

>
> [1] https://lkml.kernel.org/r/1518034285-3543-1-git-send-email-tbaicar@codeaurora.org
>
>> +     }                                                               \
>> +     return str-buf;                                                 \
>> +}                                                                    \
>> +static DEVICE_ATTR_RO(field)
>> +
>> +aer_stats_breakdown_attr(dev_breakdown_correctable, dev_cor_errs,
>> +                      aer_correctable_error_string);
>> +aer_stats_breakdown_attr(dev_breakdown_uncorrectable, dev_uncor_errs,
>> +                      aer_uncorrectable_error_string);
>> +
>>  static struct attribute *aer_stats_attrs[] __ro_after_init = {
>>       &dev_attr_dev_total_cor_errs.attr,
>>       &dev_attr_dev_total_fatal_errs.attr,
>>       &dev_attr_dev_total_nonfatal_errs.attr,
>> +     &dev_attr_dev_breakdown_correctable.attr,
>> +     &dev_attr_dev_breakdown_uncorrectable.attr,
>>       NULL
>>  };
>>
>> --
>> 2.18.0.rc1.244.gcf134e6275-goog
>>
