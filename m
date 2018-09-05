Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4E8C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 668DE206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:22:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 668DE206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inai.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbeIEXxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 19:53:49 -0400
Received: from a3.inai.de ([88.198.85.195]:36068 "EHLO a3.inai.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726544AbeIEXxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 19:53:49 -0400
Received: by a3.inai.de (Postfix, from userid 25121)
        id 2BDFE116ECEE; Wed,  5 Sep 2018 21:22:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 237473BB6971;
        Wed,  5 Sep 2018 21:22:11 +0200 (CEST)
Date:   Wed, 5 Sep 2018 21:22:11 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Greg KH <greg@kroah.com>
cc:     David Howells <dhowells@redhat.com>, linux-api@vger.kernel.org,
        linux-kbuild@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        keyrings@vger.kernel.org, David Airlie <airlied@linux.ie>,
        linux-nilfs@vger.kernel.org, linux-nvdimm@lists.01.org,
        "Michael S. Tsirkin" <mst@redhat.com>, codalist@coda.cs.cmu.edu,
        coda@cs.cmu.edu, coreteam@netfilter.org,
        Rob Clark <robdclark@gmail.com>, linux-arm-msm@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Takashi Iwai <tiwai@suse.com>, linux-bcache@vger.kernel.org,
        Coly Li <colyli@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Jan Harkes <jaharkes@cs.cmu.edu>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        Jason Wang <jasowang@redhat.com>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        netfilter-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        moderated for non-subscribers <alsa-devel@alsa-project.org>,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] UAPI: Check headers by compiling all together as C++
In-Reply-To: <20180905165552.GB25206@kroah.com>
Message-ID: <nycvar.YFH.7.76.1809052120510.24932@n3.vanv.qr>
References: <153616286704.23468.584491117180383924.stgit@warthog.procyon.org.uk> <20180905165552.GB25206@kroah.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 2018-09-05 18:55, Greg KH wrote:

>On Wed, Sep 05, 2018 at 04:54:27PM +0100, David Howells wrote:
>> 
>> Here's a set of patches that inserts a step into the build process to make
>> sure that the UAPI headers can all be built together with C++ (if the
>> compiler being used supports C++).  All but the final patch perform fixups,
>> including:
>
>Wait, why do we care?  What has recently changed to start to directly
>import kernel uapi files into C++ code?

With C++11, C++ has become a much nicer language to use (for userspace, anyway).

>And if userspace wants to do this, can't they do the C namespace trick
>themselves when they do the import?

The only trick is to use an extra C source file and extensively wrap things.
