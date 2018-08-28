Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6DFC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B4952087D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xpykmlbu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B4952087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbeH1X5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 19:57:55 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:42313 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbeH1X5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 19:57:55 -0400
Received: by mail-ua1-f65.google.com with SMTP id w7-v6so1802401uan.9;
        Tue, 28 Aug 2018 13:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=C2PlMf+238WuEND21yZhJRCFMzq+hVAx4mHDLuyO9UA=;
        b=XpykmlbuNsRM+KCvZNhRxpFqqO+/3Yzv1FY+Hh/K4W7zGl4044tC7UiTGNsZ1GSWE8
         4t4wjGUVmvpuakNlfWC1MGRHjhiSl3KME22S1sEMDAbTiZclTfdVnudPUORzWXasG3w9
         L+AWEhoaZ6et2ffUsJVzf4y9XbzRGq3GxBB7r19Slbg4rr5uApWOh+wD93ddUIapwUCY
         /Bhk5Nzigb914RdfWci8omIV+Xgs6TOzVryV41tvJmabLZM4ng50or+Afc+pyIqFJwpP
         y8HLi2GwMSDWfBiVSNk0lkjYMn62FAfWg8c8RWIpDsYIETdz4AbFj6+3GGBaHNFG6Bpf
         rpsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=C2PlMf+238WuEND21yZhJRCFMzq+hVAx4mHDLuyO9UA=;
        b=JxVXBRI87hHnHy7oa+02vNhXehjhKMUOLegoSILnCq1vKh+NCoRu3uJqav9tcCJkDB
         sQZ5TCiRgwfkfV7A2bVm0oAkDCXp/ViYxFZmbXzYKYQo3OT5euOA+FUFap76dBGlHscA
         pQZtKbH1aezwD7hsmUD+z9zWeV+t4IK+cTvD/cUWgEYFGQEUOd4V/MD5eq00igENgAmh
         N1NyJleBnM+DqqbSL3+S5z9SrF+jBcM1L9VT3ez6L12j9slQGapdcOaPcfGC8DaahKC5
         ktBd3AtCjsnCaob+iPUUmH/WaAxW1MdlOsSiP/Q9KuKzALonohk8KutT9V6sBJukfeSA
         GU6A==
X-Gm-Message-State: APzg51BsonYOkrnDs3O7gitBuxGD0xMJkqYI19fWy2Lr2zKzuTXi8Pii
        ajlLzzoRRCqKnopvGRGGQkzQyr1dzE2tQN8KfCQ=
X-Google-Smtp-Source: ANB0VdaTlxFSd8SWzJiO65xqbBGJMMKBSmClNHlMPliplUIgqh+KqFtV0Aw1sW54LQiysQes6Am7+P0oEGGA9qI8WAc=
X-Received: by 2002:ab0:48a4:: with SMTP id x33-v6mr66647uac.138.1535486681931;
 Tue, 28 Aug 2018 13:04:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:5e5c:0:0:0:0:0 with HTTP; Tue, 28 Aug 2018 13:04:41
 -0700 (PDT)
In-Reply-To: <bcb1b461-76ee-7d9b-2b35-d575ec608027@arm.com>
References: <1531762009-15112-1-git-send-email-tbaicar@codeaurora.org>
 <20180719140102.GB25185@nazgul.tnic> <94e3a0fb-9b7d-045f-733b-9f063dcb39e4@arm.com>
 <45fefe7d-c6ea-5791-4477-13ecce39ce48@codeaurora.org> <b568fdcc-ca39-67ea-2799-8ed246c8ffb6@arm.com>
 <CABo9ajA7SPrVE-oiG=RicH+nL9_pp7fVATCdMugY5fuNAPzHaQ@mail.gmail.com>
 <68a800c7-446e-9b6b-1847-6e45a1d17262@arm.com> <CABo9ajAvo-bskhrM8h95Y9D4U88zFUZfVW_HTMLK3o_5Q1VSUw@mail.gmail.com>
 <bcb1b461-76ee-7d9b-2b35-d575ec608027@arm.com>
From:   Tyler Baicar <baicar.tyler@gmail.com>
Date:   Tue, 28 Aug 2018 16:04:41 -0400
Message-ID: <CABo9ajA3Bs0ibcNXumFLzdaaCTDSBVpCc5UaBRHsw-1pzBuAkA@mail.gmail.com>
Subject: Re: [RFC PATCH] EDAC, ghes: Enable per-layer error reporting for ARM
To:     James Morse <james.morse@arm.com>
Cc:     Tyler Baicar <tbaicar@codeaurora.org>, wufan@codeaurora.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        harba@qti.qualcomm.com, Borislav Petkov <bp@alien8.de>,
        mchehab@kernel.org,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        linux-edac@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 1:11 PM, James Morse <james.morse@arm.com> wrote:
> On 24/08/18 16:14, Tyler Baicar wrote:
>> On Fri, Aug 24, 2018 at 5:48 AM, James Morse <james.morse@arm.com> wrote:
>>> On 23/08/18 16:46, Tyler Baicar wrote:
>>> so edac_raw_mc_handle_error() has no clue where the error happened. (I haven't
>>> read what it does with this information yet).
>>>
>>> ghes_edac_report_mem_error() does check CPER_MEM_VALID_MODULE_HANDLE, and if its
>>> set, it uses the handle to find the bank/device strings and prints them out.
>>
>> Yes, I think this is where we need to add support to increment the
>> count based on that module handle.
>
> If layer[0] is EDAC_MC_LAYER_ALL_MEM, sized for num_dimm, don't we just put the
> dimm number in e->top_layer and flip e->enable_per_layer_report?

Yes, that is all we would need to do. Figuring out that DIMM number is
the issue, but that can be done with the map of module handles to DIMM
index.

>>> Naively I thought we could generate some index during ghes_edac_count_dimms(),
>>> and use this as e->${whichever}_layer. I hoped there would be something we could
>>> already use as the index, but I can't spot it, so this will be more than the
>>> one-liner I was hoping for!
>>
>> We could use what ghes_edac_register does by setting up a single layer
>> with all memory and
>> then keep a map of which module handle maps to which index into that
>> layer. From that it would
>> be easy to increment the proper sysfs exposed DIMM counters using the
>> single layer
>
> Yes, I think this is what we should do!

Sounds good, I'll start working on this!

Thanks,
Tyler
