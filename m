Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3A5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D824A20850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="LjdJq9+4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbfARQcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:32:53 -0500
Received: from mail-pg1-f182.google.com ([209.85.215.182]:33309 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728610AbfARQc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 11:32:26 -0500
Received: by mail-pg1-f182.google.com with SMTP id z11so6305487pgu.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 08:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=xvbE8XZmtCZCSs5MWpPwk6dkNccrBNOLuVifdX7k3Xo=;
        b=LjdJq9+4pb+pmC/Blh3PEwkS70/QkT1TVnSry47lIMUuwJ4SEtOb5bJ9zLEU3ZbHH5
         DJZUbeCLK7uhJUvWts8m1XSlJwJSqkeXjBikPmU6g/T+qw5rkeJ0+5/essWHv+UT4dKp
         pX+esyEV6f5LYJO1VpXM4QX/EDXBC+2Fi7IH79nKJvF/4gO4qhU52ApuMsx3pt8/ArWL
         0L+rDeV/ETA3KBWyUxqiLfoUCvWT/Dht+1YPvWyBfGlRFqb10p3bnWRy1o0wmGNeSPVv
         mL7FeL33mMO6LqYkDPDOqDaMbAKjLBgJOvPTJE1Dwj79uH5f2AWp28w5y1FjByESBfiH
         KiXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=xvbE8XZmtCZCSs5MWpPwk6dkNccrBNOLuVifdX7k3Xo=;
        b=WlCz3sUr0bgASE6mC4CSNObh6mfMrME9gP4kLrMU1RYcvkwXMXzq9xQB4WY/BmOe4C
         GnTYO0ywKCdyoMpgzZ6PL9ABVX1No5/6umqHPQnHKU3UVN2kc2SjyLG+ljHPGa7hX6L8
         +vV7pFQSujEEF2NfHE7fm2K57m9eCO0wdoziPx6Z6/i2mQVM9nBFHA3UM+NF6h5WXibP
         97ai924YymD3tjZczAMnr3xazfLayaRfPDOTCalX5w80ZcIvZPfIBpMptpavp/rW51XY
         WKem9kpq5MCrzeaPkya80+tMA9uQswGJUATzye05Pg53YYyYGzxQc2Pnow229lpWOuD4
         XtkA==
X-Gm-Message-State: AJcUukcZU4xA36vbqEZBKiowgsR3A1Q/owLZLES4PF1kl6doSOltupTy
        9alMTDldD6orWLHdhldwTCWAmQ==
X-Google-Smtp-Source: ALg8bN41vU7C41MgW8QMNhvyh4+lddekKSCXC1hud8wGDbcdP86lo7b+0XyB9n/KJl5lDmjxE+QpSg==
X-Received: by 2002:a62:8c11:: with SMTP id m17mr20034783pfd.224.1547829145672;
        Fri, 18 Jan 2019 08:32:25 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id l70sm12344130pgd.20.2019.01.18.08.32.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 08:32:24 -0800 (PST)
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        IDE/ATA development list <linux-ide@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: LSF/MM 2019: Call for Proposals
Message-ID: <51b4b263-a0f2-113d-7bdc-f7960b540929@kernel.dk>
Date:   Fri, 18 Jan 2019 09:32:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The annual Linux Storage, Filesystem and Memory Management (LSF/MM)
Summit for 2019 will be held from April 30 - May 2 at the Sheraton
Puerto Rico Hotel & Casino Lodges in San Juan, Puerto Rico. LSF/MM is an
invitation-only technical workshop to map out improvements to the Linux
storage, filesystem and memory management subsystems that will make
their way into the mainline kernel within the coming years.

https://events.linuxfoundation.org/events/linux-storage-filesystem-mm-summit-2019/

LSF/MM 2019 will be a three day, stand-alone conference with three
subsystem-specific tracks, cross-track discussions, as well as BoF and
hacking sessions.

On behalf of the committee I am issuing a call for agenda proposals
that are suitable for cross-track discussion as well as technical
subjects for the breakout sessions.

If advance notice is required for visa applications then please point
that out in your proposal or request to attend, and submit the topic
as soon as possible.

1) Proposals for agenda topics should be sent before February 15th,
2019 to:

	lsf-pc@lists.linux-foundation.org

and CC the mailing lists that are relevant for the topic in question:

	FS:	linux-fsdevel@vger.kernel.org
	MM:	linux-mm@kvack.org
	Block:	linux-block@vger.kernel.org
	ATA:	linux-ide@vger.kernel.org
	SCSI:	linux-scsi@vger.kernel.org
	NVMe:	linux-nvme@lists.infradead.org

Please tag your proposal with [LSF/MM TOPIC] to make it easier to
track. In addition, please make sure to start a new thread for each
topic rather than following up to an existing one. Agenda topics and
attendees will be selected by the program committee, but the final
agenda will be formed by consensus of the attendees on the day.

2) Requests to attend the summit for those that are not proposing a
topic should be sent to:

	lsf-pc@lists.linux-foundation.org

Please summarize what expertise you will bring to the meeting, and
what you would like to discuss. Please also tag your email with
[LSF/MM ATTEND] and send it as a new thread so there is less chance of
it getting lost.

We will try to cap attendance at around 25-30 per track to facilitate
discussions although the final numbers will depend on the room sizes
at the venue.

For discussion leaders, slides and visualizations are encouraged to
outline the subject matter and focus the discussions. Please refrain
from lengthy presentations and talks; the sessions are supposed to be
interactive, inclusive discussions.

There will be no recording or audio bridge. However, we expect that
written minutes will be published as we did in previous years:

2018: https://lwn.net/Articles/lsfmm2018/

2017: https://lwn.net/Articles/lsfmm2017/

2016: https://lwn.net/Articles/lsfmm2016/

2015: https://lwn.net/Articles/lsfmm2015/

2014: http://lwn.net/Articles/LSFMM2014/

2013: http://lwn.net/Articles/548089/

3) If you have feedback on last year's meeting that we can use to
improve this year's, please also send that to:

	lsf-pc@lists.linux-foundation.org

Thank you on behalf of the program committee:

	Anna Schumaker (Filesystems)
	Josef Bacik (Filesystems)
	Martin K. Petersen (Storage)
	Jens Axboe (Storage)
	Michal Hocko (MM)
	Rik van Riel (MM)
	Johannes Weiner (MM)

-- 
Jens Axboe

