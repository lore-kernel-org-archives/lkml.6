Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09974C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 23:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93AA5240CA
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 23:06:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93AA5240CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=de.adit-jv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753525AbeGEXGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 19:06:22 -0400
Received: from smtp1.de.adit-jv.com ([62.225.105.245]:37981 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753123AbeGEXGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 19:06:20 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 537733C09AD;
        Fri,  6 Jul 2018 01:06:18 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 367sfEzJPqYz; Fri,  6 Jul 2018 01:06:09 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 247343C0160;
        Fri,  6 Jul 2018 01:06:09 +0200 (CEST)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.399.0; Fri, 6 Jul 2018
 01:06:08 +0200
Date:   Fri, 6 Jul 2018 01:06:02 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Julian Scheel <julian@jusst.de>
CC:     Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.de>,
        Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: Re: [PATCHv2 3/3] usb: gadget: f_uac*: Support multiple sampling
 rates
Message-ID: <20180705230602.GA25476@vmlxhi-102.adit-jv.com>
References: <2333fe05-da2e-e6f6-931a-16fce2980f17@jusst.de>
 <20180702162436.GA3496@vmlxhi-102.adit-jv.com>
 <CAB=otbTOwJaxTB=7e0sjFPDAM-hQ+bH-kHfAVZCQkeDpwG-NCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAB=otbTOwJaxTB=7e0sjFPDAM-hQ+bH-kHfAVZCQkeDpwG-NCg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.72.93.184]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 01:29:54AM +0300, Ruslan Bilovol wrote:
> Hi guys,
> 
> On Mon, Jul 2, 2018 at 7:30 PM, Eugeniu Rosca <erosca@de.adit-jv.com> wrote:
> > Hi Julian,
> >
> > [CC:Takashi, since we are discussing sound-related parts of USB]
> >
> > On Mon, Jul 02, 2018 at 04:07:19PM +0200, Julian Scheel wrote:
> >> Hi Eugeniu,
> >>
> >> On 30.06.2018 20:16, Eugeniu Rosca wrote:
> >> > Would it be possible to revive the uac2 multiple sampling rate
> >> > patch-set [1] by rebasing it onto the most recent kernel? If you
> >> > don't have time for this, I could help you.
> >>
> >> I have this on my todo-list for a while now... In fact I fixed the build
> >> errors reported by the robot last year, but didn't had the time to
> >> verify all of it and push again.
> >> Still, I'd be happy to get this merged, so I'll try to check the state
> >> of this within the next days and either post to the list or get back to
> >> you if more work needs to be done.
> >
> > We've been living with an internally developed uac2 multiple rate
> > support since June 2015, initially written on top of v3.14. Due to
> > significant refactoring of uac2 driver brought by v4.13 commit [1], I
> > went through the comparison between the in-house implementation (which
> > no more applied cleanly to post-[1] vanilla) and your proposal from [2].
> >
> 
> When Julian posted his patches, I've been working on UAC3 gadget
> implementation which I posted later [1]. While I originally tried to make
> UAC3 function to have same configfs files as UAC1/2, now, preparing
> UAC3 gadget patch I see it doesn't fit this approach, and patch
> "usb: gadget: f_uac*: Reduce code duplication" isn't applicable for UAC3
> case. Especially for channels configuration which in new spec can be
> done only through clusters descriptions, which makes configfs interface
> more complicated and not so straightforward as UAC1/2 have.
> 
> I didn't finish my UAC3 gadget patch v2 yet, but if you can try to avoid
> adding patch "Reduce code duplication" or wait for a few weeks, when
> I'll post UAC3 patches, it would be great; so we will be able to take into
> account new spec as well.
> 
> [1]: https://lkml.org/lkml/2017/11/6/1514

Hello Ruslan, hello Julian,

I took some time to study the implementations of existing uac drivers,
including uac3 v1 [1] and would like to share some thoughts with you.

My main thesis is that, w/o going too deep into the semantics and specs,
there is just a lot of code shared between the drivers. Why I am
pointing this out is because features like [2] and possibly a number of
other upcoming features which are agnostic on the exact UAC spec (just
like multiple rate support is) will need a copy-paste (and individual
maintenance) in every single UAC{1,2,3} driver.

To quantify the degree of similarity (the percentage of common
code), I took the uac2 driver as reference and compared it to uac1
and to uac3 implementations.

Some comments/assumptions:
 - To get relevant diff output between the drivers, I needed to reorder
   the functions some *.c files slightly (this already can be a source
   of bugs, since contributors can't see the difference between the
   drivers clearly).
 - To highlight as much common code as possible, I needed to reorder
   statements inside functions (some functions performing the same role
   are doing things in slightly different order, which again can be
   source of subtle bugs).
 - I used v4.18-rc3, on top of which patch [1] applies cleanly.
 - I only compared *.c code (functions and macros), not data structs.
 - I ignored the differences in the names of local variables.
 - I ignored the differences in the prints.
 - I considered 'struct f_uac{1,2,3}_opts' identical, since they
   really are.
 - I ignored the difference between 'struct f_uac{1,2,3}' since they
   can be easily unified.
 - I ignored the values behind the 'UAC{1,2,3}_DEF_*' macros, since they
   are not essential.
 - Obviously, I ignored any whitespace difference.
 - I paired the functions/macros by role.
 - The actual % values are estimated *visually*, therefore might be not
   precise (unless it is a 0% or 100%).

The results are drawn in the following two tables.
 
 ###### UAC2 vs UAC1

 | uac2                   | %   | uac1                   |
 |------------------------|-----|------------------------|
 | afunc_bind             | 50  | f_audio_bind           |
 | afunc_unbind           | 100 | f_audio_unbind         |
 | afunc_set_alt          | 100 | f_audio_set_alt        |
 | afunc_get_alt          | 100 | f_audio_get_alt        |
 | afunc_disable          | 100 | f_audio_disable        |
 | in_rq_cur              | 0   | -                      |
 | in_rq_range            | 0   | -                      |
 | out_rq_cur             | 0   | -                      |
 | ac_rq_in               | 0   | -                      |
 | setup_rq_inf           | 0   | -                      |
 | afunc_setup            | 50  | f_audio_setup          |
 | to_f_uac2_opts         | 100 | to_f_uac1_opts         |
 | f_uac2_attr_release    | 100 | f_uac1_attr_release    |
 | UAC2_ATTRIBUTE         | 100 | UAC1_ATTRIBUTE         |
 | afunc_free_inst        | 100 | f_audio_free_inst      |
 | afunc_alloc_inst       | 100 | f_audio_alloc_inst     |
 | afunc_free             | 100 | f_audio_free           |
 | afunc_alloc            | 100 | f_audio_alloc          |
 | set_ep_max_packet_size | 0   | -                      |
 | -                      | 0   | audio_get_endpoint_req |
 | -                      | 0   | audio_set_endpoint_req |

 ###### UAC2 vs UAC3

 | uac2                   | %   | uac3                     |
 |------------------------|-----|--------------------------|
 | afunc_bind             | 50  | f_audio_bind             |
 | afunc_unbind           | 50  | f_audio_unbind           |
 | afunc_set_alt          | 100 | f_audio_set_alt          |
 | afunc_get_alt          | 100 | f_audio_get_alt          |
 | afunc_disable          | 100 | f_audio_disable          |
 | in_rq_cur              | 30  | in_rq_cur                |
 | in_rq_range            | 30  | in_rq_range              |
 | out_rq_cur             | 20  | out_rq_cur               |
 | ac_rq_in               | 50  | ac_rq_in                 |
 | setup_rq_inf           | 90  | setup_rq_inf             |
 | afunc_setup            | 100 | f_audio_setup            |
 | to_f_uac2_opts         | 100 | to_f_uac3_opts           |
 | f_uac2_attr_release    | 100 | f_uac3_attr_release      |
 | UAC2_ATTRIBUTE         | 100 | UAC3_ATTRIBUTE           |
 | afunc_free_inst        | 100 | f_audio_free_inst        |
 | afunc_alloc_inst       | 100 | f_audio_alloc_inst       |
 | afunc_free             | 100 | f_audio_free             |
 | afunc_alloc            | 100 | f_audio_alloc            |
 | set_ep_max_packet_size | 100 | set_ep_max_packet_size   |
 | -                      | 0   | in_rq_hc_desc            |
 | -                      | 0   | uac3_copy_descriptors    |
 | -                      | 0   | alloc_fu_desc            |
 | -                      | 0   | build_cluster_descriptor |
 | -                      | 0   | UAC3_ATTRIBUTE_CHMASK    |

The message I wanted to share here is that, in my opinion, there is
really a lot of common code across UAC drivers. AFAIK features like
multiple sampling rate support really don't care about the exact UAC
spec, which means that w/o any attempt to reduce code duplication, we
would end up with duplicated (and diverging over time) implementations
of such features in several places.

Can I have your view on that?
Since you likely have more experience with uac* code, do you think is
feasible to isolate the common parts into a separate file?

Thanks,
Eugeniu.

[1] https://lkml.org/lkml/2017/11/6/1514 ("[PATCH 1/1]
    usb: gadget: add USB Audio Device Class 3.0 gadget support")
[2] https://lkml.org/lkml/2017/6/30/276 ("[PATCHv2 0/3]
    USB Audio Gadget: Support multiple sampling rates")
[3] https://lkml.org/lkml/2017/6/30/270 ("[PATCHv2 2/3]
    usb: gadget: f_uac*: Reduce code duplication")
