Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A826C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 23:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0BDD215E5
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 23:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Md/5CIbf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0BDD215E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732258AbeHCBjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 21:39:46 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:56143 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732219AbeHCBjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 21:39:46 -0400
Received: by mail-wm0-f65.google.com with SMTP id f21-v6so4336803wmc.5;
        Thu, 02 Aug 2018 16:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Z+C/XRR+49iiHG7ZehiT2eF9uDPmtNQPd+ygHjjJWFQ=;
        b=Md/5CIbfEi6QM25BlK+dlZuXddJE0o/u4Zvy0Z9oJV5q0BYfPR0s33e+82YOpcXx/m
         2wHk8VOKJNjijr/DwBwJRMadbXtv9XM3ZFMmQj3C/S9Njp6EVLw1uWBgzmrOOCdmTUqA
         VC7QQg8H90SUkIF7ZskDw2eMgxnXj1Z7fhQ2MrWCfduR6ytv+Hy5Sum/zzQKnVXdGRI1
         n5mbAcIBJqUO6zqt+QM8OyX08OD6aDD3sL2gAEn8MXSSDJGuIr0ZxWc8I+55nM2j2xgH
         P3BDZQFEHqSW4Xl583+c7LlU/xMcJxUuG0LNk/A4gqMh0x3g5abLfwuySkHWcbWeYt2F
         p7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Z+C/XRR+49iiHG7ZehiT2eF9uDPmtNQPd+ygHjjJWFQ=;
        b=pW8y3Car8DkLPaWwtTyfikebMx7y2DCxm46KUSe5kGIab3v6h1Cyk2oRv8fC3fNsTl
         xdtuSTPq+IXilbwflaDh5xFZ+L0PVsv3bt/s+h3FI80Ae2jBmrU/ASLZmg2gVCWMMgPF
         91opURSlba4QTAfVchbLPJiKjYyHV3aG0nEKZkDLRWzt+Pg9JZQmhL7LSTwCRaZjuPhG
         W6o6AM6o+xQ9a78XSELbCliXsXvk7ucl28KWRXiTC919DpdKRv0QbN1e0DM94c/oI6wp
         FVHOLiRqooSnRlMv1MbawMSiv1s2xu+SaUCLgulGf2MULNU0nelPVjubgsiDuJGPMBSY
         7eQA==
X-Gm-Message-State: AOUpUlFL2YCUQbeES0UaG5oW9hMfjPNyirpCRfL5NvVfCGt4MM4aJb2j
        5Dd3UqqFOvhTd5IqysKwMpG57Q4C
X-Google-Smtp-Source: AAOMgpfiAgLyLGr8SiiDvYUfS8sO7SfKtQxwJ/YtY9Qafs6mCCiA3aTv1gA4ohuqbDjapbL8p3OCfQ==
X-Received: by 2002:a1c:b9cf:: with SMTP id j198-v6mr3480713wmf.93.1533253576406;
        Thu, 02 Aug 2018 16:46:16 -0700 (PDT)
Received: from [172.16.9.139] (host-78-151-217-159.as13285.net. [78.151.217.159])
        by smtp.gmail.com with ESMTPSA id c129-v6sm5318267wmh.2.2018.08.02.16.46.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 16:46:15 -0700 (PDT)
Subject: Re: [PATCH 01/33] vfs: syscall: Add open_tree(2) to reference or
 clone a mount [ver #11]
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, linux-api@vger.kernel.org,
        torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <7a292a44-7e17-572b-2d1e-0085ef400010@gmail.com>
 <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
 <153313705165.13253.4602180607294286849.stgit@warthog.procyon.org.uk>
 <21311.1533246718@warthog.procyon.org.uk>
From:   Alan Jenkins <alan.christopher.jenkins@gmail.com>
Message-ID: <c50af5da-2168-b35a-0d28-5af887cd997a@gmail.com>
Date:   Fri, 3 Aug 2018 00:46:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <21311.1533246718@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/18 22:51, David Howells wrote:
> Alan Jenkins <alan.christopher.jenkins@gmail.com> wrote:
>
>> Another closely-related limitation of `mount`, is that it can't atomically set
>> the propagation type at mount time.
> I want to add a mount_setattr() too at some point:
>
> 	fd = open_tree(..., OPEN_TREE_CLONE);
> 	mount_setattr(fd, ...);
> 	move_mount(fd, ...);

Cool.  Not having to mess with fchdir() sounds nice.  (And as a bonus, 
being able to avoid the existing multiplexed mount() call, which looks 
ugly from all the NULL arguments if nothing else).

> I'm not sure whether you should be able to fchdir into the cloned tree since
> it isn't attached to any mount namespace.
>
> David

I don't see a check prohibiting it :-). I don't think it's a problem.

You can already chdir/chroot into a different mount namespace, you just 
can't do any mount operations on it.  (You said you want to be able to, 
but so far move_mount() still prohibits it, I guess that's for the future).

And you can already do the same into a mount that has been detached, 
which will have `mount->mnt_ns = NULL` if I'm reading correctly.

Hmm, there is something that's been nagging at me though.  I'm 
suspicious about what happens in this series, when you move_mount() from 
a victim of MNT_DETACH.  I think umount2(MNT_DETACH) sets a flag 
MNT_UMOUNT.  It's a flag that was added to help correctly handle 
MNT_LOCKED in the face of umount2(MNT_DETACH).  It's also the point 
where my understanding of the kernel mount/unmount code breaks down 
:-).  But it seems to override both IS_MNT_LOCKED() and UMOUNT_CONNECTED 
in disconnect_mount().  That would give another chance to defeat locked 
mounts.

Regards
Alan
