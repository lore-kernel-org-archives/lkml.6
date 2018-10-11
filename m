Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A691C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 12:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 297722077C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 12:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNbFTmJL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 297722077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbeJKTuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 15:50:37 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37736 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbeJKTuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 15:50:37 -0400
Received: by mail-wm1-f67.google.com with SMTP id 185-v6so9242656wmt.2;
        Thu, 11 Oct 2018 05:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=VTgrN83eV44trcz7AoCP3x7j0C0ZjcixD+eBwwdA9lE=;
        b=ZNbFTmJL7kq10MnjdGGGAGYilLXpRfIRizmuSEgqVTMEIWWdPkDIhXfhuqxL/dO5LK
         bLzmLpn4HUt8cMRkwSYLQCHhQBP6CMGLlR+EcgG8B2auZP2H7sTTp1P/ZX7RY3eDu6bW
         wVIm/HouFxyObJSpp44k6dibnRiuE6R+d1Nb6U0fp6kAdU18JavYwK/UA2ZB9I10Fpye
         Zn/7WTyBe0ruEEZg81dEuG+5gyhur1YeYsNaJyP2lohE+VFAAdSuU66feTRRkC7iLDp4
         WXQF4nws0LOS5Ex/xZ2yFwwQ3Xx0F/J0BKH/pTeJdtC9K+EOQYUIStGjFzaWbUMR5PBk
         u+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=VTgrN83eV44trcz7AoCP3x7j0C0ZjcixD+eBwwdA9lE=;
        b=DxnNo+vjO0caQt6EABgNenMDhC3r4cVMQ3JsTq1fOUxqrGPxoXMGoD8CFC55QAF2El
         4WKH4Pn+QkJref75Uqil8JY/Qw8G/i0qvrzp7SnpK7/jSK9OuvwmZ9Ss+UhHx3LCpN84
         Wo8I1TEFwV67GVF/aaUZ1q1R2fARtiWEPOZpin8gv8Gkr7Wzp0tgT2RDxRjEzc4LYO/f
         Heh06WEmOSB7oln5Va6QhiOztd7CFNdCBCZ06STvdq1C6fEDHwb5WHLookUNHfr9hrUd
         cL5XMtHtzlP/Hnsdwg2L9pMSnzKvHGFX4P7awKGU3FbUkgs2mw755iE4Gl2yA4sPrCE3
         wKYQ==
X-Gm-Message-State: ABuFfoigYue1xUeaDgyM4NHyb0lBfGo/VZTSknPKx63RpZopm9U1hCqf
        ZG5JoJF/EezkhomJQUHyT6w=
X-Google-Smtp-Source: ACcGV63Px9Ja8FSmFyAIWh/O6CT4GVfQJkFVWZTmIBQ6tEuQDcgfMS3dUR39xCAe8up2OZ6HWAYCRw==
X-Received: by 2002:a1c:2dc7:: with SMTP id t190-v6mr1483232wmt.31.1539260616767;
        Thu, 11 Oct 2018 05:23:36 -0700 (PDT)
Received: from [172.16.1.10] (host-89-243-172-161.as13285.net. [89.243.172.161])
        by smtp.gmail.com with ESMTPSA id y64-v6sm10540993wmg.28.2018.10.11.05.23.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 05:23:35 -0700 (PDT)
Subject: Re: [PATCH 03/34] teach move_mount(2) to work with OPEN_TREE_CLONE
 [ver #12]
To:     David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk
Cc:     torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mszeredi@redhat.com
References: <16207.1539249451@warthog.procyon.org.uk>
 <5c6f3d62-4cec-2aea-4693-62928611c526@gmail.com>
 <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
 <153754743491.17872.12115848333103740766.stgit@warthog.procyon.org.uk>
 <de050902-f3d0-b2db-2627-983a36c87b3c@gmail.com>
 <862e36a2-2a6f-4e26-3228-8cab4b4cf230@gmail.com>
 <6533.1539260096@warthog.procyon.org.uk>
From:   Alan Jenkins <alan.christopher.jenkins@gmail.com>
Message-ID: <92bfc752-100b-619d-f1c9-b1ea93244ab4@gmail.com>
Date:   Thu, 11 Oct 2018 13:23:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <6533.1539260096@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2018 13:14, David Howells wrote:
> David Howells <dhowells@redhat.com> wrote:
>
>> The reason that you can do this with open_tree()/move_mount() is that it
>> allows you to create a mount tree (OPEN_TREE_CLONE) that has no namespace
>> assignment, pass it through the namespace switch and then attach it inside the
>> child namespace.  The cross-namespace checks in do_move_mount() are bypassed
>> because the root of the newly-cloned mount tree doesn't have one.
> It's worse than that.  The apparently disconnected tree given you by
> open_tree(OPEN_TREE_CLONE) is still subject to modification by outside
> forces.  All it takes is one shared object within that tree.
>
> So I do wonder if it's possible to form a ring, even in an upstream kernel, by
> using the propagation mechanism to push through an nsfs mount into itself,
> possibly with a layer of indirection (ie. having two mutually-referential
> namespaces).
>
> David

Upstream does cover the mount propagation case, by simply never 
propagating mounts of mount NS files.  See commit 4ce5d2b1a8fd "vfs: 
Don't copy mount bind mounts of /proc/<pid>/ns/mnt between namespaces" / 
https://unix.stackexchange.com/questions/473717/what-code-prevents-mount-namespace-loops-in-a-more-complex-case-involving-mount-propagation 



