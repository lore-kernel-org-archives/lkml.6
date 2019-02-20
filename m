Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D22C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12F992183E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="EO+9uBM/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730045AbfBTC6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 21:58:35 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34198 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfBTC6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 21:58:35 -0500
Received: by mail-ot1-f66.google.com with SMTP id 98so37896908oty.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 18:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5NHiYX2r93COso0vk6pUV/wr2p/w/XjcR4bORcRnaCs=;
        b=EO+9uBM/R9zuv/Zk+tWD0Svf8mf2wvMwSTTKBA0eAtfMOByfbq80r/0GtcTDX/42qm
         hGBHekrDfNCNPImZWHf5sm7y95Q5p//Hvrm1HWtyKci2hP5kUIDNyKyOtx3lUUSXmH5N
         RlwaU7/zH74GFQZu1cKC3iKVbl4pwKgkDaaRXN0vDvLW85JNcf3L0yQ46iBjASSgTCQc
         QHQyB3roTCCO7AL+S9KajeuRfZ6VhPF7NDwgKjA3iO6kUv8Clxphmt1BxIPvPlHMpGtu
         1jjyCL4Oc4rJOadXNSGvCvoN255SXcjfZp5mUN6azkyVoM9rW2R0dytHu7EkW0Fu0wUZ
         /bEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5NHiYX2r93COso0vk6pUV/wr2p/w/XjcR4bORcRnaCs=;
        b=PyaAUSFZDfywe3NDMJrfn2CVsj+2Z/lndumr+fF3iaIrk5pzgtdau5iQPkRzJfu6bV
         sqGfDXVG7nQfVh5qtmJ1011oVT2yo4NE/QztNfuqZqk6rhRLWNTV62aupkcEHUJF7Xqg
         JnysBvtIhGY8XL+WWxOotEkqUAUqdgvyj0fxNP87EdGvQsyyyzfItwV9VXlyAqKAI6yh
         ilXki78hbQecFJurckSIL5bnb01FMvuBwaEOwGOyLimvxmSv2ODhqkp0MbxOUBi/ckm/
         35yT8U5ZWcUeP2rphFZOyW2bHmBvi5DiwjBhzQMW0Mts+7ylf5JKylpoRpVRiRBMcpTT
         kevQ==
X-Gm-Message-State: AHQUAuad2QuJYpLeW4wKivEP2rCicU2RFzkpo5Kz3vtq88F9rkKq7D4r
        KHtJEVEdhPyyW5/LFmR4NWU4TKeWd1OLwhUHLSXbAQ==
X-Google-Smtp-Source: AHgI3IaS8d7p6Dib+oC1qd/HorCsOjis5IFe8td+4OC+spivsPOSHTmlWRXjxQd+tcY1ZlaZJ7/YIgHJC5lRoF7O1kw=
X-Received: by 2002:aca:4a10:: with SMTP id x16mr4330532oia.73.1550631514626;
 Tue, 19 Feb 2019 18:58:34 -0800 (PST)
MIME-Version: 1.0
References: <154958385172.3932544.193235520333886200.stgit@dwillia2-desk3.amr.corp.intel.com>
 <x49lg2bql2v.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49lg2bql2v.fsf@segfault.boston.devel.redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 19 Feb 2019 18:58:23 -0800
Message-ID: <CAPcyv4iiZS_zfroRtmS-zD-cCDj1yQonBsWM23utR9m9kiBizA@mail.gmail.com>
Subject: Re: [PATCH] acpi/nfit: Fix bus command validation
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Vishal Verma <vishal.verma@intel.com>,
        stable <stable@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 5:57 PM Jeff Moyer <jmoyer@redhat.com> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> > Commit 11189c1089da "acpi/nfit: Fix command-supported detection" broke
> > ND_CMD_CALL for bus-level commands. The "func = cmd" assumption is only
> > valid for:
> >
> >     ND_CMD_ARS_CAP
> >     ND_CMD_ARS_START
> >     ND_CMD_ARS_STATUS
> >     ND_CMD_CLEAR_ERROR
> >
> > The function number otherwise needs to be pulled from the command
> > payload for:
> >
> >     NFIT_CMD_TRANSLATE_SPA
> >     NFIT_CMD_ARS_INJECT_SET
> >     NFIT_CMD_ARS_INJECT_CLEAR
> >     NFIT_CMD_ARS_INJECT_GET
> >
> > Update cmd_to_func() for the bus case and call it in the common path.
> >
> > Fixes: 11189c1089da ("acpi/nfit: Fix command-supported detection")
> > Cc: <stable@vger.kernel.org>
> > Cc: Vishal Verma <vishal.verma@intel.com>
> > Reported-by: Grzegorz Burzynski <grzegorz.burzynski@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> Tricky code path, eh?

ioctl path, number one source of bugs / thrash in this subsystem. 2nd
place, ARS.

> Tested-by: Jeff Moyer <jmoyer@redhat.com>

Thanks.
