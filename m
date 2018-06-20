Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61299C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CF5720846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtbaHS85"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CF5720846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932844AbeFTTlt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 15:41:49 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:42381 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932154AbeFTTlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 15:41:46 -0400
Received: by mail-lf0-f65.google.com with SMTP id z207-v6so1044556lff.9;
        Wed, 20 Jun 2018 12:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=lUFBVuslF/Egzi4+1w+nwpzrydySOCdO/WBR14NZkCE=;
        b=HtbaHS85WIc2g8mVncc8mYjHP9A/jTRgFqQKP/XAh+Mwx+oJ8wUJLsX7+ySEwzHsHb
         Qqb6tQFF6noMNyB96olYs3rsVnu8qqudEvKqf0Zy+OVAFx5jaUN80zVGnIWLvOpwmfX4
         bc4AHKTaxQG3hAkLxmzsy8e2TOgrtZVvYA0WDILgD1HfzKpTMmq2wB2ObpLBYxwM5a85
         9fJtkd/LspNkDmpoDh22D1xrp8Fnh83FkCY1egscjMhtoxJvG9iNiVBPMbGw1i6qI+wt
         GKiAtk2B1fzqK77KkfpJoJQsgzIEk7hsWb+4QJYDZP3XAjDI+Nut61OL7HuRBGBlMF6k
         MAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=lUFBVuslF/Egzi4+1w+nwpzrydySOCdO/WBR14NZkCE=;
        b=uSg2fF0siqQz6tihzb9GbMXvc1jl6mSfxkzF00wROirsC93G1n+T1e1LVcsnn3ahuW
         zctjkuKsaGiK84hEMjHcmDa8fSF5eHrOifxFaBSReag1A7tPv9uNELSkiV9uIY3qsn9W
         oaqVV8o8iHbOX5vv2eY51j/NazEIKxh9dLdxSeqEKoKlAoXpIWWoGDaUvVSM8N3lGPfr
         c5TaoHUftYzFXvO68z69lCWXGLz0prwPX7N6lhlQx6irzjmV8wvWz//Oo8rdN780auIP
         nVZvcAquW7pW+5FOhwrgyIh1HU2moXZubbUt/+Q4uXOGH1JRq77CZikoBCi0TICfNAL9
         ofCg==
X-Gm-Message-State: APt69E10UHG2appl9ZDLyz5Fnah2VpK2n/JFPQAU9kZ/XTakTlv2Hcqb
        dFbb2c+7NGREYeMqUNqiUhXBHidXlrc/CXoMB60=
X-Google-Smtp-Source: ADUXVKL3k15esTvgQfnFSCe8rsWOZPVkHP1Sw73fvT/ikn3yWfwQN/twWvbZ9nZZmVjJAc6GWvvKbUTUgrGDvhlpbxU=
X-Received: by 2002:a2e:40d9:: with SMTP id r86-v6mr14978374lje.19.1529523705291;
 Wed, 20 Jun 2018 12:41:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:56c8:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 12:41:44
 -0700 (PDT)
In-Reply-To: <263b1bc6-0efb-8803-fb9a-68a1393d35b2@suse.com>
References: <20180620143448.44388-1-arnd@arndb.de> <20180620143448.44388-3-arnd@arndb.de>
 <20180620163804.GE24375@twin.jikos.cz> <263b1bc6-0efb-8803-fb9a-68a1393d35b2@suse.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 20 Jun 2018 21:41:44 +0200
X-Google-Sender-Auth: PggiaUh97z9GW9moSiOSaUXKfyk
Message-ID: <CAK8P3a01n5shWS9x6q8Camd0WyuSfSRftthmUBQHYgPLOBUTWQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] btrfs: use timespec64 for i_otime
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     David Sterba <dsterba@suse.cz>, Chris Mason <clm@fb.com>,
        Josef Bacik <jbacik@fb.com>, David Sterba <dsterba@suse.com>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Omar Sandoval <osandov@fb.com>, Liu Bo <bo.li.liu@oracle.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 9:34 PM, Nikolay Borisov <nborisov@suse.com> wrote:
>
>
> On 20.06.2018 19:38, David Sterba wrote:
>> On Wed, Jun 20, 2018 at 04:34:34PM +0200, Arnd Bergmann wrote:
>>> While the regular inode timestamps all use timespec64 now, the
>>> i_otime field is btrfs specific and still needs to be converted
>>> to correctly represent times beyond 2038.
>>>
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>
>> This patch addresses the remaining type conversions, so I'm going to
>> merge it, thanks.
>>
>
> Actually for the sake of consistency we might want to merge this series
> altogether. As it stands we now use ktime_get_seconds and
> ktime_get_real_seconds (from Allen's patch). I haven't dug to see what's
> the difference (if any) between the two .

I just checked again and see that Allen's patch addresses the first two
of my three patches, but he picked a different approach for
transaction_kthread(): My patch moved to CLOCK_MONOTONIC,
while his version only changed the to time64_t but kept the
CLOCK_REALTIME behavior. It's a small difference, but I think
my version is slightly better. My patch 2/3 is identical to his version.

If you like, I can also rebase my patch 1/3 on top of his patch and
change it to CLOCK_MONOTONIC.

         Arnd
