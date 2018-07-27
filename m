Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E0AC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 19:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F47F20842
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 19:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZFvnUMyT";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZFvnUMyT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F47F20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389232AbeG0Utn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 16:49:43 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50640 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389143AbeG0Utn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 16:49:43 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D90DA60B11; Fri, 27 Jul 2018 19:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532719585;
        bh=qdWodCh0lhiiYvQLy6bcYbDwPBsL39I/Hj6WXIzvWUQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZFvnUMyTID+rUn+hbcopicjSOnuCJ3H4X/oPhtREoYrLQstmUHaJqeCNpAYyndiae
         65fnTWdmZR0EIFCppQjVCEjsEn7XDRkiCPMTFJdGOsTeXOkdlKNcu/CQt5YLduDuQ/
         zxqMWeuTfkv/IXEuLBj/gpYxUNrvUSCkkz5kJENs=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 40B1C607BD;
        Fri, 27 Jul 2018 19:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532719585;
        bh=qdWodCh0lhiiYvQLy6bcYbDwPBsL39I/Hj6WXIzvWUQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZFvnUMyTID+rUn+hbcopicjSOnuCJ3H4X/oPhtREoYrLQstmUHaJqeCNpAYyndiae
         65fnTWdmZR0EIFCppQjVCEjsEn7XDRkiCPMTFJdGOsTeXOkdlKNcu/CQt5YLduDuQ/
         zxqMWeuTfkv/IXEuLBj/gpYxUNrvUSCkkz5kJENs=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 27 Jul 2018 12:26:25 -0700
From:   Sodagudi Prasad <psodagud@codeaurora.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, wen.xu@gatech.edu
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Remounting filesystem read-only
In-Reply-To: <366cf3ac534bbadaaa61714a43006ac7@codeaurora.org>
References: <366cf3ac534bbadaaa61714a43006ac7@codeaurora.org>
Message-ID: <e9869d6cd358e9de395d730ab7b3aa60@codeaurora.org>
X-Sender: psodagud@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-26 18:04, Sodagudi Prasad wrote:
> Hi All,
> 

+linux-kernel@vger.kernel.org list.

Hi All,

Observing the following issue with one of the partition on android 
device with 4.14.56 kernel.  When I try to remount this partition using 
the command - mount -o rw,remount /vendor/dsp, it is remounting as 
read-only.

[  191.364358] EXT4-fs error (device sde9): ext4_has_uninit_itable:3108: 
comm mount: Inode table for bg 0 marked as needing zeroing
[  191.364762] Aborting journal on device sde9-8.
[  191.365226] EXT4-fs (sde9): Remounting filesystem read-only
[  191.365232] EXT4-fs (sde9): re-mounted. Opts: data=ordere

If I revert this commit [1] -"ext4: only look at the bg_flags field if 
it is valid", the issue is not observed. It is just giving following 
warning message.
[1] - https://patchwork.ozlabs.org/patch/929239/.

[  123.373456] EXT4-fs (sde9): warning: mounting fs with errors, running 
e2fsck is recommended
[  123.389649] EXT4-fs (sde9): re-mounted. Opts: data=ordered

Can you provide some inputs what could be the issue with this partition?

> Observing the following issue with one of the partition on android
> device with 4.14.56 kernel.  When I try to remount this partition
> using the command - mount -o rw,remount /vendor/dsp, it is remounting
> as read-only.
> 
> [  191.364358] EXT4-fs error (device sde9):
> ext4_has_uninit_itable:3108: comm mount: Inode table for bg 0 marked
> as needing zeroing
> [  191.364762] Aborting journal on device sde9-8.
> [  191.365226] EXT4-fs (sde9): Remounting filesystem read-only
> [  191.365232] EXT4-fs (sde9): re-mounted. Opts: data=ordere
> 
> If I revert this commit [1] -"ext4: only look at the bg_flags field if
> it is valid", the issue is not observed. It is just giving following
> warning message.
> [1] - https://patchwork.ozlabs.org/patch/929239/.
> 
> [  123.373456] EXT4-fs (sde9): warning: mounting fs with errors,
> running e2fsck is recommended
> [  123.389649] EXT4-fs (sde9): re-mounted. Opts: data=ordered
> 
> Can you provide some inputs what could be the issue with this 
> partition?
> 
> -Thanks, Prasad

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
Linux Foundation Collaborative Project
