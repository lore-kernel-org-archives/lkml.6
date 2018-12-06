Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,TRACKER_ID autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 170FBC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFF5320838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:23:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFF5320838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbeLFMXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 07:23:48 -0500
Received: from smtprelay0240.hostedemail.com ([216.40.44.240]:59845 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727996AbeLFMXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 07:23:48 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id AEA0B182CED28;
        Thu,  6 Dec 2018 12:23:46 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cloud35_3996dab0e71a
X-Filterd-Recvd-Size: 2046
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Thu,  6 Dec 2018 12:23:44 +0000 (UTC)
Message-ID: <61385d4cb6c9d990427349849d0af28faa3b67af.camel@perches.com>
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
Date:   Thu, 06 Dec 2018 04:23:43 -0800
In-Reply-To: <d2a1f009-b2c7-240d-7e1c-e48a08d8ac7d@daenzer.net>
References: <20181205165621.5805-1-michel@daenzer.net>
         <10fca21a-5d7c-fe9e-07f0-6200e9de538e@amd.com>
         <1586a49594d30b4bf4d88eba0d258e21efd26da2.camel@perches.com>
         <276fbf7f-d33f-83a5-cb88-bd4051dc03ba@daenzer.net>
         <e7859ce4b8417b094604d9ab4740d338730e38bf.camel@perches.com>
         <d2a1f009-b2c7-240d-7e1c-e48a08d8ac7d@daenzer.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-12-06 at 12:52 +0100, Michel Dänzer wrote:
> In contrast to the 2b case, the pr_debug output isn't visible by default
> with 1b, so the latter doesn't fit "always produce output" either.

I think you are mistaken here.

Adding #define DEBUG as Chris did enables pr_debug output
and is your 1b.

Perhaps your default console logging level is set to a
non-default value.

CONSOLE_LOGLEVEL_DEFAULT

lib/Kconfig.debug:config CONSOLE_LOGLEVEL_DEFAULT
lib/Kconfig.debug-      int "Default console loglevel (1-15)"
lib/Kconfig.debug-      range 1 15
lib/Kconfig.debug-      default "7"

