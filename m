Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570A7C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 06:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 085EA2080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 06:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tTRkHRhd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 085EA2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729239AbeJ2PBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 11:01:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35114 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729058AbeJ2PBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 11:01:03 -0400
Received: by mail-wr1-f67.google.com with SMTP id w5-v6so7292937wrt.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 23:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=55RzmsgNBR00R+nUfSgSgyNQ98yJ/Cxh/a2lF8z8jvY=;
        b=tTRkHRhdstktFDqMqJopu076Z04agyLhYC0aemJD8xPEGBMmVFgWhK1C+akCWydBTr
         RXNIj9360xfqFPw4JBcequkIEqz0EjiesVx3BtL5wx6ngxA9uBj13ipUE2Op1X7bGLzS
         zFdORhHMxaV1YgX+t7eINHtwHe/BrzvN5de48YBftuZJ7uocnX7iqItYVpfeSOI2RA61
         EefscL4R7JrFX4pT8JcJdYJO+TcaDkvZSco57loQjuk16hg+xfWVjHF+ClrLI/Z/aBis
         HvDmoOGiaR36a+jvlhn4EnsZr5Qdbot/yxdYNQCnPbsbtio7WYaITaRsFmXXbaCRRQ/h
         Mkgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=55RzmsgNBR00R+nUfSgSgyNQ98yJ/Cxh/a2lF8z8jvY=;
        b=CCNKR2yQOQLdLKvYwJTicpsgRR2FPZ7cW7iMQporseZfL0P3N+L8B+igoi/Etog7YD
         x0tLySqqh8cTZmX71V/wVuNNBeL15h8pRjd6jR2rpW2Eug7/yoiS7nAu+NnCtjsr5AC2
         y4nSrQAimq9XoLtBKp4qtjwUhkLITjr6uADTI7CW1bqPTpeSAfhtM/tH+S5sev67ga5J
         COet/NTX0OSrLRmv4KN2knopDlg1OoJMfp5zaBru14IzDfd6/deHBZkBVkIk2hwW8di4
         iYO9QoB6JRtOpr9Wk5r4Ra9aarrAxV7Z5j036lBnTuYv/jvBNLJWJtXkk1K0ggVAt0Wx
         hLAg==
X-Gm-Message-State: AGRZ1gJBFVu9ZLCGajs/VNWndEWLyJ+eAzbciLXgO4sUUvp6O0HWrYG8
        Y3uWMrk8fuGymkIhYrRa3BR6fa1A
X-Google-Smtp-Source: AJdET5f3mUt2Ufs2YWQ9gws6J4goho+1PCpu3jfbps62bZzErJ33Jsz0hA6eodMuzzo3m/Un7v3b4g==
X-Received: by 2002:adf:93e6:: with SMTP id 93-v6mr5081628wrp.311.1540793629269;
        Sun, 28 Oct 2018 23:13:49 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id z4-v6sm8581626wru.83.2018.10.28.23.13.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Oct 2018 23:13:48 -0700 (PDT)
Date:   Mon, 29 Oct 2018 07:13:46 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Jordan Borgner <mail@jordan-borgner.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com
Subject: Re: [PATCH] arch: x86: Touched up patterns of 'sizeof' functions
Message-ID: <20181029061346.GC128403@gmail.com>
References: <20181028125828.7rgammkgzep2wpam@JordanDesktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181028125828.7rgammkgzep2wpam@JordanDesktop>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Jordan Borgner <mail@jordan-borgner.de> wrote:

> Addded missing parentheses to 'sizeof()' functions in arch/x86/.
> 
> Like this:
> Before: 'sizeof x'
> After:  'sizeof(x)'
> 
> Done by motivation of Ingo Molnar.
> 
> Signed-off-by: Jordan Borgner <mail@jordan-borgner.de>

Thanks!

Note that you sent a -p2 patch, the lkml standard is -p1 patches.
Not sure how you managed to set up your Git to get such a patch.

I fixed it up.

Thanks,

	Ingo
