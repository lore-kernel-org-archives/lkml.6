Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB54C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 06:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFE222075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 06:09:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFE222075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbeIFKnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 06:43:37 -0400
Received: from smtp-proxy003.phy.lolipop.jp ([157.7.104.44]:56018 "EHLO
        smtp-proxy003.phy.lolipop.jp" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725885AbeIFKnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 06:43:37 -0400
X-Greylist: delayed 603 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Sep 2018 06:43:36 EDT
Received: from smtp-proxy003.phy.lolipop.lan (HELO smtp-proxy003.phy.lolipop.jp) (172.19.44.44)
  (smtp-auth username m12129643-o-takashi , mechanism plain)
  by smtp-proxy003.phy.lolipop.jp (qpsmtpd/0.82) with ESMTPA; Thu, 06 Sep 2018 14:59:45 +0900
Received: from 127.0.0.1 (127.0.0.1)
 by smtp-proxy003.phy.lolipop.jp (LOLIPOP-Fsecure);
 Thu, 06 Sep 2018 14:59:40 +0900 (JST)
X-Virus-Status: clean(LOLIPOP-Fsecure)
Subject: Re: [PATCH 08/11] UAPI: sound: Fix use of u32 and co. in UAPI headers
To:     David Howells <dhowells@redhat.com>, linux-api@vger.kernel.org,
        linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        moderated for non-subscribers <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.com>
References: <153616286704.23468.584491117180383924.stgit@warthog.procyon.org.uk>
 <153616293089.23468.13515059526628668970.stgit@warthog.procyon.org.uk>
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
Message-ID: <ce6ac597-751c-8881-160d-28d62a898a3e@sakamocchi.jp>
Date:   Thu, 6 Sep 2018 14:59:40 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <153616293089.23468.13515059526628668970.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sep 6 2018 00:55, David Howells wrote:
> Fix the use of u32 and co. in UAPI headers as these are not defined.  Switch
> to using the __u32-style equivalents instead.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Jaroslav Kysela <perex@perex.cz>
> cc: Takashi Iwai <tiwai@suse.com>
> cc: alsa-devel@alsa-project.org (moderated for non-subscribers)
> ---
> 
>   include/uapi/sound/skl-tplg-interface.h |  106 ++++++++++++++++---------------
>   1 file changed, 54 insertions(+), 52 deletions(-)

A similar patch was already proposed[1] and has been applied by Mark to
his tree[2]. Your issue (3) is going to be solved soon for v4.19
kernel.

[1] [alsa-devel] [PATCH] uapi: fix sound/skl-tplg-interface.h userspace 
compilation errors
http://mailman.alsa-project.org/pipermail/alsa-devel/2018-August/139392.html
[2] ASoC: uapi: fix sound/skl-tplg-interface.h userspace compilation errors
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/log/?h=for-4.19


Thanks

Takashi Sakamoto
