Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CBFECDE44
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 01:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D83602081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 01:05:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D83602081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=electrozaur.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbeKAKGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 06:06:17 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39811 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbeKAKGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 06:06:16 -0400
Received: by mail-wm1-f66.google.com with SMTP id u13-v6so16111wmc.4;
        Wed, 31 Oct 2018 18:05:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=mZrQLCZ80witWb65HQRpwMtBiu9oFUiAXXFeg2MC4P4=;
        b=uHDAvyLEv8XJ7peAeT6Ny97Etn0aZqnXuunx6gpTuDJO4CraZWmYAbILiCamMDEDvL
         oUIO6iIIIhBcvjkeRipCUBZ5gImB8KFvusI3T7v8W60AqI9VIlEzloI+IaIQ1axzq9zg
         ufuacgYNKeR6T4euGAcGpgeRZYM026RooCUAIg9IfvnolHZ/NaVvVZ2lOpO7s55jF+yK
         +V4n77TI8IMquxjyVj76u3NyZs4pstA5pZHaII7RIdsMyL2YtauDqHUo/o3SIJ5DwoOk
         3glr6wWQafVA7JnXAVZk0FlZyoVD5ZBPO08ubJ5HaHmKUqseWso6EvxlFVt8Nw0TZc2W
         82tQ==
X-Gm-Message-State: AGRZ1gLS2bpqSJWNSH2G56rQ3yz9eDq6OWR0+b3+K43oWSoR/R6fkEpk
        Gp308BYN/Ufjk8KlhybWZUg=
X-Google-Smtp-Source: AJdET5cqPgz8MA5wtDAbngE1RWxmCoB59yFk7eDko0USirgcNi8Vp4Neji7h4oaBBOSuy9OwWkVH0g==
X-Received: by 2002:a1c:9cc9:: with SMTP id f192-v6mr4223034wme.135.1541034333519;
        Wed, 31 Oct 2018 18:05:33 -0700 (PDT)
Received: from [10.0.0.5] ([207.232.55.62])
        by smtp.gmail.com with ESMTPSA id b15-v6sm16916817wrr.90.2018.10.31.18.05.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 18:05:32 -0700 (PDT)
Subject: Re: [PATCH] libosd: Remove ignored __weak attribute
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>
References: <20180930205448.26205-1-natechancellor@gmail.com>
 <10b12992-3570-4646-374b-82cbd7276839@acm.org>
 <CAKwvOd=wgxB69dMxzMeH2edCn=TdQGPGkNVW1e=QHPTJtO9ZNw@mail.gmail.com>
 <1538503063.193396.6.camel@acm.org>
 <CAKwvOdmsNEexQL9R8rgcRcXTZButYM6YWwG8bhVWCoJ8bOqCrA@mail.gmail.com>
 <1538521591.193396.8.camel@acm.org> <20181025213144.GB24709@flashbox>
 <CAKwvOdn=TvoGdFvgxX6TyXBXnhVLttriRrZEnzS6DjcjL64DPA@mail.gmail.com>
 <20181025225548.GA10326@flashbox>
 <CAKwvOdnwmf47_m_0K5OCLmXbrkLNnekpNOPCCMeJqkuqKUbQ-A@mail.gmail.com>
 <1540576908.66186.103.camel@acm.org>
 <CAKwvOdnYx60JkJHJkD7CYA9yx5Oa7Tn9q4aZ3-tcZGx++yoduQ@mail.gmail.com>
 <1540589437.66186.124.camel@acm.org>
 <CAKwvOdm-xYRqCBXhLC1ceC44_rEmggW4qiSgGpRkpL+p-NadVg@mail.gmail.com>
 <1540591147.66186.127.camel@acm.org>
 <CAKwvOdmUhtK10cbYFoEJJp4O8LA_F-+f68A_NcL_fm_FH6QodA@mail.gmail.com>
 <1540592684.66186.136.camel@acm.org> <yq1o9bfcydm.fsf@oracle.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        hch@infradead.org
From:   Boaz Harrosh <ooo@electrozaur.com>
Message-ID: <3839ac8c-145c-9046-32d0-ab434dcee578@electrozaur.com>
Date:   Thu, 1 Nov 2018 03:05:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <yq1o9bfcydm.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/10/18 16:28, Martin K. Petersen wrote:
> 
> Bart,
> 
>> Removing kernel drivers that are not used helps to reduce the workload
>> of a maintainer and hence is a rational action. Additionally, if
>> anyone would ever complain about removal of a kernel driver, it can be
>> brought back by reverting the commit through which it has been
>> removed.  Martin, please reply if you see this differently.
> 
> We remove crusty old SCSI drivers all the time. The heuristic is based
> on lack of user bug reports and absence of commits that are not due to
> kernel interface changes or trivial cleanups. So removing stuff is
> perfectly normal.
> 
> The OSD protocol failed to get traction in the industry, adoption was
> very limited. 

Very true.

> If the code just plugged straight into existing kernel
> interfaces it would be easier to justify keeping it around. 

It was using the very much straight existing kernel interfaces
at the time of its insertion, basically the regular PC_command
(As opposed to FS_commnnd) Where the CDB/scsi_command content is
provided by the caller. And the commands complete as an whole.
Plus the added support for bidi PC_commands.

Please tell me what are those entangled interfaces you are unhappy with?
I would like to help disentangle them.

> However, the
> OSD support requires bidirectional command support so we carry a bunch
> of additional plumbing in both block and SCSI to accommodate it. There
> are no other users of these interfaces, so dropping OSD would mean we
> could simplify some (hot) code paths. That would be a win in my book.

But OSD is not the only one or scsi command-set that is using bidi. There
are a few more uses of scsi and BTW block-layer bidi commands in the field.
Target drivers been supporting bidi commands. Vendor drivers use bidi interface
for management CDBS. I'm afraid that by the Linus rules you cannot remove bidi.
Orthogonal to t10-osd or not to be.

> Consequently, if a patch were to materialize that disentangled and
> removed OSD, I'd be inclined to merge it.
> 

Is there a way I can help with this?

> But I do think that this is an orthogonal discussion to the innocuous
> __weak attribute cleanup.
> 

Thanks
Boaz

