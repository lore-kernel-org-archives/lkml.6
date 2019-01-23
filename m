Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C67B9C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 861F920870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="aYQ/Yvjh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfAWKDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 05:03:50 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37281 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbfAWKDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 05:03:49 -0500
Received: by mail-pg1-f195.google.com with SMTP id c25so855177pgb.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 02:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LNnOgToRSSP5etzihkL4+IodyV/Ttljyt+UWvpD3evM=;
        b=aYQ/YvjhuNlX/SBdSrKl8lbguTOfknq2QAKraI8KIjeIqEaxjJqpFNEoqTFgCAdnXr
         lryqcnbMJZBRxGnd8CxxYcR6Pf1Y0lE2IMavNcrUVrRfPnsALxLwSmvfrv/HyVmuGquY
         waYh01o5fdFSm2OPfwaHCGDJar00G/vhNBqZH+FP4O+h76TWP4FVNn/B7xbL05NoZoOV
         HnfYUDhaM7yjyIpJubJUi9N8huKi+0mVMtG8PKM3mnP572ZbMx/0pFWO2ZhC3CPm/SIW
         kSlRkHpcC9LxD4EYdoxrE3ht/M9GN7WYKnD34Sgom2I8C2EIYD7UMxN9C+a2s1WWlq0c
         7DJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LNnOgToRSSP5etzihkL4+IodyV/Ttljyt+UWvpD3evM=;
        b=VP66/29sfe6ClO2/wxJ1JLTMSBpzOQr2t0MAmV/S88008a03GYgUU6nkoKogWzrNkP
         gTPAj0FboadoLNVpPfcgoC3Vhr8hGX7oraVEaeb4XesONN4xueVPCr7TUHw6FqjGWb1h
         01xpIhecmWthdxw9gvrZCLxhQ+F71xD7l0lHxFC6CY9FgFWV0AxyQffo3f9W+AUgPGAn
         ZZk+Kz3i+vy02mYIyv0S33DQMBXofEaYns72d3fr8InWKrKGZWD4MY10i0k5aCRyWH8g
         uICDrcbO1likBuf4Uks1xlHgUJu4gv/wfGS/gkzKvtGl3vcDyxpb6Q75AYW6/mnMK/Ky
         O1WA==
X-Gm-Message-State: AJcUukd2Rftpvy7q/+T6QxUr9KbBt6Vos7M+SwcHVdoU/waLo9mfsCsV
        jq219yNanOUvL3/N39KqhESVbitMpzAmkA==
X-Google-Smtp-Source: ALg8bN7Vdp0olT5JvmQV9FD6oixhbNMqvCEQSxXGFYdwmZ1sUQxt6A9QkfcCL7hFLTTnXShCyRcIqA==
X-Received: by 2002:a63:6506:: with SMTP id z6mr1425623pgb.334.1548237828984;
        Wed, 23 Jan 2019 02:03:48 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([134.134.139.82])
        by smtp.gmail.com with ESMTPSA id d6sm29360694pgc.89.2019.01.23.02.03.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 02:03:48 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 84EB0301A3F; Wed, 23 Jan 2019 13:03:43 +0300 (+03)
Date:   Wed, 23 Jan 2019 13:03:43 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Cao jin <caoj.fnst@cn.fujitsu.com>
Cc:     kirill.shutemov@linux.intel.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: question about head_64.S
Message-ID: <20190123100343.oi25gn2llvkvejfy@kshutemo-mobl1>
References: <6aebbf86-2ba1-c517-dc47-054279daec49@cn.fujitsu.com>
 <023da151-bb1d-1b11-ec1d-01eb675d528f@cn.fujitsu.com>
 <20190122130800.cpfor3klov22badb@kshutemo-mobl1>
 <4d4efba6-9b15-4730-b4c4-b70e79a5e6e2@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d4efba6-9b15-4730-b4c4-b70e79a5e6e2@cn.fujitsu.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 12:01:23PM +0800, Cao jin wrote:
> Thanks for your info! BTW, could I know how you construct the test
> environment?

Nothing fancy. I just built different versions of binutils from git.

-- 
 Kirill A. Shutemov
