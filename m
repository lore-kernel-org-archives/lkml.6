Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417B9C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 02:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED632083E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 02:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sTcprHs/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CED632083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbeIFHPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 03:15:54 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:36090 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbeIFHPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 03:15:53 -0400
Received: by mail-pg1-f176.google.com with SMTP id d1-v6so4408914pgo.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 19:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qiBZc2IxMhxSEkJoa8YmMba53gZuoD1ISFDGdgAjcYI=;
        b=sTcprHs/uuLdQ13bd9NTL/0a7fMtjqXEK5nzFLlJFRqjYfndY1M9EZ1Bh1EhCF9/Kf
         DFAVnrbvRN/9URt/UtIbAcSFCpms3jSBHQ3WqGpd7RUNGco8WaKiD9jOpt7hPgSM5AUb
         hXXAJcM/mgePQjW8sgWHi6fZmnwzeeV+BRkRb2xwpuW0nI/dWsatT5l+Xtjzym2+ldJi
         OkZHGTmROD8temBqmoI3jzEV3HjLWGvdk+y/BILilhpZUWgR6TkMVH9wDy5ipz/qYgzX
         aTPnPNaMW9FPyudvIh4/h/azeats/cwvATK1+JO65Hexc3Tji3yvo85wxuOmcCPcxC00
         Ekrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qiBZc2IxMhxSEkJoa8YmMba53gZuoD1ISFDGdgAjcYI=;
        b=axkk2isnQog01FDMOchvrie4PCmBgAbB/nGCsEQEERn2vPxilzbd3F/j/Dv//c0p2t
         w4Zb9GJCfQTbLxgKvr/9CQL1cu4DF6pBeofFYafZR+4ZqWhElsZIL31nbf5u9cR1Pmsg
         nZoKhdFnkQafl8tnQX6FYSmi7vV62i5o9VlQQUfvxnh1EAu/hrTkKjU6N1idiKBblQOi
         WYBrNOjDinGgm5AvqpEAGpZsiqjMlsBKolZnf9ORHXSskKehWgEZiuVsjoyKdY1FelVT
         tQ8gzpQKDA4zIreoo7dVwQ+Um2K4SXYyZwecbSuAnrc3gM0ec900M5fWkrlMrTjeW1T7
         VnQQ==
X-Gm-Message-State: APzg51CQXhV4ISQ4nVgxD10JjUDw2e6TLWWFBIJ8+6jCKr54qIiv7kvV
        BnMkU9bSyajFTAhvFO/G3Ws=
X-Google-Smtp-Source: ANB0VdaKs08pJ67pnHTsBWPGSdQL94sqRd2lLI3rQNBflcS1h8pZuRo90MA4znWkCT16DMHnjGQplw==
X-Received: by 2002:aa7:8118:: with SMTP id b24-v6mr712626pfi.78.1536201768575;
        Wed, 05 Sep 2018 19:42:48 -0700 (PDT)
Received: from localhost ([110.70.59.68])
        by smtp.gmail.com with ESMTPSA id p19-v6sm7563826pgh.60.2018.09.05.19.42.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Sep 2018 19:42:47 -0700 (PDT)
Date:   Thu, 6 Sep 2018 11:42:43 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [linux-next] DDC responded, but no EDID for %s errors
Message-ID: <20180906024243.GB749@jagdpanzerIV>
References: <20180802024648.GA499@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180802024648.GA499@jagdpanzerIV>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (08/02/18 11:46), Sergey Senozhatsky wrote:
> Hi,
> 
> My dmesg is filled up with these errors
> 
>  nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for HDMI-A-1
>  nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
>  nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for HDMI-A-1
>  nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
>  nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
> [..]
>  nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
>  nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
>  nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
>  nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
>  nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
>  nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
> [..]
> 
> Basically, a message every 10s or so. Any chance we can make them
> go away?

A gentle ping?

It literally floods my logbuf with that "DRM: DDC responded, but no EDID
for VGA-1" thing.

name -a
4.19.0-rc2-dbg-00118-gb9a3bad8af2d

$ dmesg | tail -42
[ 3615.796938] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
[ 3626.036865] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
[ 3636.276878] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
[ 3646.516866] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
[ 3656.756750] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
[ 3666.996949] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
[ 3677.236884] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
[ 3687.476865] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
[ 3697.716858] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
[ 3707.956934] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
[ 3718.196925] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
[ 3728.436884] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
[ 3738.676861] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
[ 3748.916731] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
[ 3759.156754] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
[ 3769.396861] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
[ 3779.636826] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
[ 3789.876892] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
[ 3800.116686] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
[ 3810.356926] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
[ 3820.596887] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
[ 3830.836909] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
[ 3841.076932] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
[ 3851.316681] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
[ 3861.556926] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
[ 3871.796869] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
[ 3882.036750] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
[ 3892.276836] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
[ 3902.516803] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
[ 3912.756640] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
[ 3922.996957] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
[ 3933.236700] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
[ 3943.476851] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
[ 3953.716928] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
[ 3963.956915] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
[ 3974.196861] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
[ 3984.436928] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
[ 3994.676885] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
[ 4004.917030] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
[ 4015.156935] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
[ 4025.396872] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1
[ 4035.636877] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for VGA-1

	-ss
