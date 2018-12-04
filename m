Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4F0C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 05:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FF7C2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 05:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZTG0ts/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FF7C2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbeLDFY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 00:24:29 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:32888 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbeLDFY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 00:24:28 -0500
Received: by mail-oi1-f194.google.com with SMTP id c206so13246876oib.0;
        Mon, 03 Dec 2018 21:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UyN8Hq1dBBXbfGjsLbMhdbfCYxowc+3U2M7TecsLOB0=;
        b=RZTG0ts/d+emSUHmAkoeuLknVCFi1qP46TmrcZUs9KGkMclGUcUo542j8tKqh8KK/R
         lSXj8R5d3Bux0KjcjFrH+cweMCPJNNiU6Te5oB9DDpa1kw9ZgwLAZgFd7/6seLNSUuLc
         anq+IH59WSTLvML5ahW1mtaodOnMIvhglIuA5iTlE42+tqk+6iKSY9BEFm/oswnucha1
         qOI0H0wEF7cGUJRisVdhSNIHFoKnSgyJqDi6Gd/YAQ2jJuq50jaHh/8nHRFeGSpY2XpH
         M1mlq1QNdrdMRDGQXmGIw179cZZVhqtX13LvNt+2PFRPMN54gHQGjitQQcP71Ab8JEn1
         ohiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UyN8Hq1dBBXbfGjsLbMhdbfCYxowc+3U2M7TecsLOB0=;
        b=Se1lhmF4xvVvwJ10Ev5uuNPzYwQMom/c3z15udQ6PgxYmYc8zU3zh46kOfkjFnTyv8
         TCtvVl2sAzNNs2e1paviiHVZ9/t10459LoUtaJvCMeb60qChMQFPWHi1nBoWHSZJw8uC
         mwAyclHcr8A7GSxP6FBV1zLQYSbe30I6OMqXkZwHQXzkqT3Azs4u5YVlIzVDvHA29DX7
         evYxTm5nFmCn9LldLR0CaADAG68CjJICnEdETwazWPEqwp54gEmjc0ceegsxdgWY5+5k
         vloFVnQys1u/nlLcV67/5k8FRjX7DcAo0NJM0vwxNDIEUMLgK9Nr532p9yew3x2PBeZ1
         vxRA==
X-Gm-Message-State: AA+aEWbXDxmI/KKAb0itkvKVrzgYUclbNs0mwDHicLCLzDTDBjEz1T74
        lepc09j66oJUZpTEOLwTiLci5Ynq7H4i9ktCP88=
X-Google-Smtp-Source: AFSGD/X8r0LRxmVMRiv7Jaj5XEq5Qxv6v5/lDwiQDoznO4kk2DydCYkFzpZqKugvDOT30IKIUyQlTbBVuCLr7CzYYrc=
X-Received: by 2002:aca:b9d6:: with SMTP id j205mr11156855oif.294.1543901067442;
 Mon, 03 Dec 2018 21:24:27 -0800 (PST)
MIME-Version: 1.0
References: <20181122030354.13570-1-ganapatrao.kulkarni@cavium.com>
 <20181122030354.13570-2-ganapatrao.kulkarni@cavium.com> <20181203120926.GB24824@arm.com>
In-Reply-To: <20181203120926.GB24824@arm.com>
From:   Ganapatrao Kulkarni <gklkml16@gmail.com>
Date:   Tue, 4 Dec 2018 10:54:15 +0530
Message-ID: <CAKTKpr7bzoQiBwkOduMQ0CS34i=8y=fY3s66C-sObwpZbeLppQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] perf, uncore: Adding documentation for ThunderX2
 pmu uncore driver
To:     Will Deacon <will.deacon@arm.com>
Cc:     Ganapatrao Kulkarni <Ganapatrao.Kulkarni@cavium.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>, suzuki.poulose@arm.com,
        Randy Dunlap <rdunlap@infradead.org>,
        "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>,
        Robert Richter <Robert.Richter@cavium.com>,
        Vadim.Lomovtsev@cavium.com, Jan.Glauber@cavium.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On Mon, Dec 3, 2018 at 5:39 PM Will Deacon <will.deacon@arm.com> wrote:
>
> On Thu, Nov 22, 2018 at 03:04:31AM +0000, Kulkarni, Ganapatrao wrote:
> > The SoC has PMU support in its L3 cache controller (L3C) and in the
> > DDR4 Memory Controller (DMC).
> >
> > Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> > ---
> >  Documentation/perf/thunderx2-pmu.txt | 106 +++++++++++++++++++++++++++
> >  1 file changed, 106 insertions(+)
> >  create mode 100644 Documentation/perf/thunderx2-pmu.txt
>
> Thanks for writing the documentation, although I think it needs a bit of
> help before we can merge it.

sure will send next version ASAP.
>
> > diff --git a/Documentation/perf/thunderx2-pmu.txt b/Documentation/perf/thunderx2-pmu.txt
> > new file mode 100644
> > index 000000000000..9f5dd7459e68
> > --- /dev/null
> > +++ b/Documentation/perf/thunderx2-pmu.txt
> > @@ -0,0 +1,106 @@
> > +
> > +Cavium ThunderX2 SoC Performance Monitoring Unit (PMU UNCORE)
> > +==========================================================================
> > +
> > +ThunderX2 SoC PMU consists of independent system wide per Socket PMUs such
> > +as Level 3 Cache(L3C) and DDR4 Memory Controller(DMC).
>
> Please add some punctuation here.

Thanks will do.
>
> > +
> > +DMC has 8 interleave channels and L3C has 16 interleave tiles. Events are
>
> *The* DMC and *the* L3C

ok
>
>
> > +sampled for default channel(i.e channel 0) and prorated to total number of
>
> I'm not sure I understand this; are you saying it's not possible to sample
> channels other than channel 0?

yes, sampling channel zero, since channels are interleave, multiplying
by number of channels will give fair data.
Removed per channel sample since it was involved SMC calls.

>
> > +channels/tiles.
> > +
> > +DMC and L3C, Each PMU supports up to 4 counters. Counters are independently
>
> The start of this sentence makes no sense and you've got a capital "Each".
>
> > +programmable and can be started and stopped individually. Each counter can
> > +be set to sample specific perf events. Counters are 32 bit and do not support
> > +overflow interrupt; they are sampled at every 2 seconds.
>
> I think this is unfortunate wording, because actually you don't support what
> perf calls "sampling" at all.

ok, let me rephrase it.
>
> > +
> > +PMU UNCORE (perf) driver:
> > +
> > +The thunderx2-pmu driver registers several perf PMUs for DMC and L3C devices.
>
> I think the driver name uses an underscore instead of a hyphen.

thanks.
>
> > +Each of the PMUs provides description of its available events
> > +and configuration options in sysfs.
> > +     see /sys/devices/uncore_<l3c_S/dmc_S/>
> > +
> > +S is socket id.
>
> *the* socket id

ok
>
> > +Each PMU can be used to sample up to 4 events simultaneously.
> > +
> > +The "format" directory describes format of the config (event ID).
> > +The "events" directory provides configuration templates for all
> > +supported event types that can be used with perf tool.
>
> You can drop this bit, since it's not specific to your PMU and is actually
> describing the perf ABI via sysfs. If we want to document that someplace, it
> should be in a separate file.

ok , let me drop sysfs part.
>
> > +
> > +For example, "uncore_dmc_0/cnt_cycles/" is an
> > +equivalent of "uncore_dmc_0/config=0x1/".
>
> Why is this helpful?

ok let me drop second line.
>
> > +
> > +Each perf driver also provides a "cpumask" sysfs attribute, which contains a
> > +single CPU ID of the processor which is likely to be used to handle all the
> > +PMU events. It will be the first online CPU from the NUMA node of the PMU device.
>
> Again, I don't think this really belongs in here.

ok.
>
> > +
> > +Example for perf tool use:
> > +
> > +perf stat -a -e uncore_dmc_0/cnt_cycles/ sleep 1
> > +
> > +perf stat -a -e \
> > +uncore_dmc_0/cnt_cycles/,\
> > +uncore_dmc_0/data_transfers/,\
> > +uncore_dmc_0/read_txns/,\
> > +uncore_dmc_0/write_txns/ sleep 1
> > +
> > +perf stat -a -e \
> > +uncore_l3c_0/read_request/,\
> > +uncore_l3c_0/read_hit/,\
> > +uncore_l3c_0/inv_request/,\
> > +uncore_l3c_0/inv_hit/ sleep 1
> > +
> > +The driver does not support sampling, therefore "perf record" will
> > +not work. Per-task (without "-a") perf sessions are not supported.
>
> What do you mean by "not supported"? If I invoke perf as:

I mean --per-core option, needs rephrasing.

>
> # ./perf stat -e uncore_dmc_0/cnt_cycles/ -- ls
>
> then I get results back.
>
> > +
> > +L3C events:
> > +============
> > +
> > +read_request:
> > +     Number of Read requests received by the L3 Cache.
> > +     This include Read as well as Read Exclusives.
> > +
> > +read_hit:
> > +     Number of Read requests received by the L3 cache that were hit
> > +     in the L3 (Data provided form the L3)
> > +
> > +writeback_request:
> > +     Number of Write Backs received by the L3 Cache. These are basically
> > +     the L2 Evicts and writes from the PCIe Write Cache.
> > +
> > +inv_nwrite_request:
> > +     This is the Number of Invalidate and Write received by the L3 Cache.
> > +     Also Writes from IO that did not go through the PCIe Write Cache.
> > +
> > +inv_nwrite_hit
> > +     This is the Number of Invalidate and Write received by the L3 Cache
> > +     That were a hit in the L3 Cache.
> > +
> > +inv_request:
> > +     Number of Invalidate request received by the L3 Cache.
> > +
> > +inv_hit:
> > +     Number of Invalidate request received by the L3 Cache that were a
> > +     hit in L3.
> > +
> > +evict_request:
> > +     Number of Evicts that the L3 generated.
>
> Wouldn't this be better off in the perf tools sources, as part of the JSON
> events file for your PMU?

That could be another effort to move all arm64 vendors uncore events
to JSON framework.
>
> > +
> > +NOTE:
> > +1. Granularity of all these events counter value is cache line length(64 Bytes).
> > +2. L3C cache Hit Ratio = (read_hit + inv_nwrite_hit + inv_hit) / (read_request + inv_nwrite_request + inv_request)
> > +
> > +DMC events:
> > +============
> > +cnt_cycles:
> > +     Count cycles (Clocks at the DMC clock rate)
> > +
> > +write_txns:
> > +     Number of 64 Bytes write transactions received by the DMC(s)
> > +
> > +read_txns:
> > +     Number of 64 Bytes Read transactions received by the DMC(s)
> > +
> > +data_transfers:
> > +     Number of 64 Bytes data transferred to or from DRAM.
>
> Same here.
>
> Will

thanks
Ganapat
