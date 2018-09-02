Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E4BC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 08:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC3D62077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 08:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIdxXKIf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC3D62077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbeIBM2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 08:28:49 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42240 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbeIBM2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 08:28:49 -0400
Received: by mail-pf1-f196.google.com with SMTP id l9-v6so7341991pff.9;
        Sun, 02 Sep 2018 01:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5+csTKAKjmiIxzUnNNHFUVZGkU9DR1FPAuAj3U58Z4I=;
        b=QIdxXKIfyLsQO4AzG/vN1whEyRsukrE00zuvvbKssn4hVHZLLr8Y9EM7J5qYyAFH9r
         Nm59XyueMqAb7zPi5lTTpV438TXu5o+Ia4jxfPYgQMVOICRHwGmg4EgoupLnd+u1XoDI
         TrYnw0T1XrigSibllg/kCMSt/RWvsvVw1K8CWR7NVvRzn1OkdlPyTKqVu3BxKE/Tqphy
         itUnx+p83FNNRfJRyr/Bd8X06D02zZycZlcoPUqBHr6Pb8kFNP2EqX6ps39lMWnmTL7d
         It6sfWe60X4bDX4brEY4b1wGJeg5KD4PvnkUEmeB8SR0laqomoU2ojyWFwwy9RgvQA65
         OH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5+csTKAKjmiIxzUnNNHFUVZGkU9DR1FPAuAj3U58Z4I=;
        b=kXt2praGc/8SjH4JcgDgzHqn1E7ZgeeA4Jebly24qblbDHX/N9tgZlCFsaKGRYVbSX
         +eG6YD5cwsvADIiL6n8E+Lb3X8rs6rb+jzko2y/nqFf88W7dP1KoBkoMam1WAltDXFja
         ixyvVMXmfwJZevYe8CRvnh/YTYb0ZdN/1L2BtEB85wxe6W0wr/Bf9/B7vlwbAvknxCTu
         N2Hyheymrr8E08H31Zn+z7IllBVbMOs6EnM6SWa2eWv9gOxBBjzZIvoUrjhWvmHCMMqw
         vBjNVI9QTCTP+E3P3u69mOy9VFVnctebeZIKguqtRhZwaoUW9hL7NUZ3tepcDgYRFJW6
         oinQ==
X-Gm-Message-State: APzg51AOdn6DW/4C271qGfF5Fb2DprVmaqdqqTm0/PNjrFUGAt44igZG
        hXQ8V4MrZCU+HNm4t5MREDk=
X-Google-Smtp-Source: ANB0VdafZ79AYnn5h/WQ6MjWypQW+iEpOCtKVihKDDJ4qEcNdL5IZRBzDfRTVcazc54IY8KKL5Nepw==
X-Received: by 2002:a63:b812:: with SMTP id p18-v6mr21286065pge.156.1535876034023;
        Sun, 02 Sep 2018 01:13:54 -0700 (PDT)
Received: from localhost (14-202-194-140.static.tpgi.com.au. [14.202.194.140])
        by smtp.gmail.com with ESMTPSA id a16-v6sm16455953pgv.29.2018.09.02.01.13.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Sep 2018 01:13:53 -0700 (PDT)
Date:   Sun, 2 Sep 2018 18:13:50 +1000
From:   Balbir Singh <bsingharora@gmail.com>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromiun.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Subject: Re: [RFC PATCH v3 00/24] Control Flow Enforcement: Shadow Stack
Message-ID: <20180902081350.GF28695@350D>
References: <20180830143904.3168-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830143904.3168-1-yu-cheng.yu@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 07:38:40AM -0700, Yu-cheng Yu wrote:
> The previous version of CET patches can be found in the following
> link.
> 
>   https://lkml.org/lkml/2018/7/10/1031
> 
> Summary of changes from v2:
> 
>   Move Shadow Stack page fault handling logic to arch/x86.
>   Update can_follow_write_pte/pmd; move logic to arch/x86.
>   Fix problems in WRUSS in-line assembly.
>   Fix issues in ELF parser.
>   Split out IBT/PTRACE patches to a second set.
>   Other small fixes.
>

Quick question -- is there a simulator or some other way you've
been testing this? Just curious, if it's possible to run these
patches or just a review and internal hardware/simulator where
they are run and posted

Balbir Singh.
