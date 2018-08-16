Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B7FC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 12:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD42A21480
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 12:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qBQ9JC1K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD42A21480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391462AbeHPPwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 11:52:45 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34340 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731477AbeHPPwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 11:52:44 -0400
Received: by mail-pf1-f193.google.com with SMTP id k19-v6so2005072pfi.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 05:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VRcqOlI6RPYkLvuhjleTmyVPP39IVFNEDyEyndDhVIc=;
        b=qBQ9JC1KnQtxsQNOFYkOZa7pT1CCNwxeKbQX5MmKmW2X7RK0k2XUlU/pP58pAeKMi6
         ZMJaGlGrLPPZqUnrKbsZs7Ij9gjg9c19pTYyVF5MlOaIlgs4pxsb/yBakoWs7XpTy5gO
         1LVM4ueT5OwRsWAHEW+emVpgqY1Y0AttrExWN+usA4cEGDd7Q76iZfOPdC79Sn46W/mX
         046B+6rGl+kHdq7oGYPf27WfLq+zqLwIVP2qVNIdYB6vAaZlrcaEZ6NQkMBWcXtFS7ED
         v2RJed8bBq3YOHApYb7LfZhwn2EgH2WlGDedHRR2x9P+Ttwwa0zDnGPtoeLmmaE548HB
         0IGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=VRcqOlI6RPYkLvuhjleTmyVPP39IVFNEDyEyndDhVIc=;
        b=oFWVaMdlItRdMio4U6ChzzdqSEu+0htaev0/mhQzKCW0bVbuubQWWsb5zSXYRrXqBT
         15F06aqkWn69O0buJobb/kNQnxOjuefhPzh5sQPg1ifXGkKsCGI3wFQxHJWm+Ti0IOdQ
         b3YK7AxDtMSXlhbYvfQjIsL394Bn9spaC1HJtnqsGwEGQKjfoZ4WOTJnSbgi75CiOZQV
         niVOuFu3GH1pwvjmJOw7StSLa2LsBxWFYa51FK8OP311aYl2rbFU7OokZo/q/Y2Pr1OW
         TTmMjuUs4VluBvAigZx+fnF5pKl8vTf/Fb2zN82G82SFf0mxVzh2qLBgJOgDOJe8BV/w
         SCIA==
X-Gm-Message-State: AOUpUlGPcVBHviBhO2iQZNtOwlWXrhA0bRJAdqbD/MYk+zoRoQefcioZ
        fgcNnWLYZ8VxssnS5x25DyU=
X-Google-Smtp-Source: AA+uWPz9UsAxOqNmKdBIbFUQXsCp3wfbB6MkuIpGW+rvkn+hDpeoeYRiShCweFw/M+24RgMTqMAIeg==
X-Received: by 2002:a62:c8c2:: with SMTP id i63-v6mr32302440pfk.73.1534424059920;
        Thu, 16 Aug 2018 05:54:19 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a77-v6sm45853638pfj.38.2018.08.16.05.54.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Aug 2018 05:54:19 -0700 (PDT)
Date:   Thu, 16 Aug 2018 20:54:11 +0800
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     mingo@kernel.org, Wei Yang <richard.weiyang@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/numa_emulation: Introduce uniform split
 capability
Message-ID: <20180816125411.GA3740@WeideMacBook-Pro.local>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <152738260746.11641.13275998345345705617.stgit@dwillia2-desk3.amr.corp.intel.com>
 <152738261787.11641.828328345742419506.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152738261787.11641.828328345742419506.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 26, 2018 at 05:56:57PM -0700, Dan Williams wrote:
...
>
>numa=fake=6
>available: 5 nodes (0-4)
>node 0 cpus: 0 2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38
>node 0 size: 2648 MB
>node 0 free: 2443 MB
>node 1 cpus: 1 3 5 7 9 11 13 15 17 19 21 23 25 27 29 31 33 35 37 39
>node 1 size: 2672 MB
>node 1 free: 2442 MB
>node 2 cpus: 0 2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38
>node 2 size: 5291 MB
>node 2 free: 5278 MB

Hi, Dan

I am trying to understand in which case leads to this behavior.

The difference between this and the new one is this node gets too
much memory and leads to no memory for node 5.

I guess the reason is there are mem hole in this region, so it tries to add
FAKE_NODE_MIN_SIZE until it is enough.

FAKE_NODE_MIN_SIZE is 32M, while this fake node is 2000M larger than others.
This means the mem hole is that large?

In which case, eg. the physical numa layout, leads to this behavior?

>node 3 cpus: 1 3 5 7 9 11 13 15 17 19 21 23 25 27 29 31 33 35 37 39
>node 3 size: 2677 MB
>node 3 free: 2665 MB
>node 4 cpus: 1 3 5 7 9 11 13 15 17 19 21 23 25 27 29 31 33 35 37 39
>node 4 size: 2676 MB
>node 4 free: 2663 MB
>node distances:
>node   0   1   2   3   4
>  0:  10  20  10  20  20
>  1:  20  10  20  10  10
>  2:  10  20  10  20  20
>  3:  20  10  20  10  10
>  4:  20  10  20  10  10
>
>
>numa=fake=3U
># numactl --hardware
>available: 6 nodes (0-5)
>node 0 cpus: 0 2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38
>node 0 size: 2900 MB
>node 0 free: 2637 MB
>node 1 cpus: 0 2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38
>node 1 size: 3023 MB
>node 1 free: 3012 MB
>node 2 cpus: 0 2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38
>node 2 size: 2015 MB
>node 2 free: 2004 MB
>node 3 cpus: 1 3 5 7 9 11 13 15 17 19 21 23 25 27 29 31 33 35 37 39
>node 3 size: 2704 MB
>node 3 free: 2522 MB
>node 4 cpus: 1 3 5 7 9 11 13 15 17 19 21 23 25 27 29 31 33 35 37 39
>node 4 size: 2709 MB
>node 4 free: 2698 MB
>node 5 cpus: 1 3 5 7 9 11 13 15 17 19 21 23 25 27 29 31 33 35 37 39
>node 5 size: 2612 MB
>node 5 free: 2601 MB
>node distances:
>node   0   1   2   3   4   5
>  0:  10  10  10  20  20  20
>  1:  10  10  10  20  20  20
>  2:  10  10  10  20  20  20
>  3:  20  20  20  10  10  10
>  4:  20  20  20  10  10  10
>  5:  20  20  20  10  10  10
>

-- 
Wei Yang
Help you, Help me
