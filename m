Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0847C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C39020659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:22:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C39020659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbeLFQWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:22:51 -0500
Received: from smtprelay0217.hostedemail.com ([216.40.44.217]:38714 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725849AbeLFQWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 11:22:50 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 76675100E86DA;
        Thu,  6 Dec 2018 16:22:49 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: toe67_357d55e604208
X-Filterd-Recvd-Size: 3377
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Thu,  6 Dec 2018 16:22:47 +0000 (UTC)
Message-ID: <733672ada4f532f02137067b14d285728cdd120c.camel@perches.com>
Subject: Re: [PATCH 1/2] drm: Only #define DEBUG if CONFIG_DYNAMIC_DEBUG is
 disabled
From:   Joe Perches <joe@perches.com>
To:     Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
        "Zhang, Jerry(Junwei)" <Jerry.Zhang@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Chris Wilson <chris@chris-wilson.co.uk>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Date:   Thu, 06 Dec 2018 08:22:46 -0800
In-Reply-To: <747d6c1b-8c0a-8168-bd1e-e969839ff5be@daenzer.net>
References: <20181205165621.5805-1-michel@daenzer.net>
         <10fca21a-5d7c-fe9e-07f0-6200e9de538e@amd.com>
         <1586a49594d30b4bf4d88eba0d258e21efd26da2.camel@perches.com>
         <276fbf7f-d33f-83a5-cb88-bd4051dc03ba@daenzer.net>
         <e7859ce4b8417b094604d9ab4740d338730e38bf.camel@perches.com>
         <d2a1f009-b2c7-240d-7e1c-e48a08d8ac7d@daenzer.net>
         <61385d4cb6c9d990427349849d0af28faa3b67af.camel@perches.com>
         <747d6c1b-8c0a-8168-bd1e-e969839ff5be@daenzer.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-12-06 at 15:41 +0100, Michel Dänzer wrote:
> On 2018-12-06 1:23 p.m., Joe Perches wrote:
> > On Thu, 2018-12-06 at 12:52 +0100, Michel Dänzer wrote:
> > > In contrast to the 2b case, the pr_debug output isn't visible by default
> > > with 1b, so the latter doesn't fit "always produce output" either.
> > 
> > I think you are mistaken here.
> 
> Still puzzled as to what you're hoping to achieve with that kind of
> language. None of the confusion about this patch has been on my part. :)

Doubtful.

> > Adding #define DEBUG as Chris did enables pr_debug output
> > and is your 1b.
> > 
> > Perhaps your default console logging level is set to a
> > non-default value.
> 
> I have CONFIG_DYNAMIC_DEBUG enabled in my kernels. The problem addressed
> by this patch is that messages from drm_debug_printer are visible by
> default (case 2b), whereas they shouldn't be (case 2a, like 1b).

The default for config_dynamic_debug when DEBUG is defined is
to output the message equivalent to when DEBUG is defined and
config_dynamic_debug is not.

That's a good thing and has been the general default since 2011.

You want to override that, I suppose that's OK but it's
definitely not a _fix_ as you have written.

It's just a change in behavior.

You added a "Fixes:" line.  I believe that wrong.

A long time ago, at my suggestion:

commit b558c96ffa53f4b3dd52b774e4fb7a52982ab52b
Author: Jim Cromie <jim.cromie@gmail.com>
Date:   Mon Dec 19 17:11:18 2011 -0500

    dynamic_debug: make dynamic-debug supersede DEBUG ccflag
    
    If CONFIG_DYNAMIC_DEBUG is defined, honor it over DEBUG, so that
    pr_debug()s are controllable, instead of always-on.  When DEBUG is
    also defined, change _DPRINTK_FLAGS_DEFAULT to enable printing by
    default.

cheers, Joe

