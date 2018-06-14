Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 07EFEC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 01:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACE0B208CC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 01:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8HRD90O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACE0B208CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936037AbeFNBHj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 21:07:39 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:38790 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935513AbeFNBHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 21:07:36 -0400
Received: by mail-pg0-f67.google.com with SMTP id c9-v6so2097383pgf.5;
        Wed, 13 Jun 2018 18:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rUaPNqdNJTMk9JIlxYmwbC+A5hqcg2xYFqho0ak6YQw=;
        b=j8HRD90OMwUT1EckRS3CIkshzy6odo+9MhyRdcLLBwrmrIyIFaBi/4ZNUWvJ8icnwA
         8YroawAEC6nGP0HPmm/fLCRmX6KERweJrutRF2lqoDFUeH4yhM11WLogH+BlgzBZVlyS
         q/RIznm3j9pmNTeBDlbyU2FIiN3c1h5gSi2iDa9fsAyFHfN/7MBJpYhEDef39kJEP/Ql
         GlAjL3mWJYIvhJ5nj6A8RZWeYElqtD48NafGrShBMINO5Ty65WxsNX4Hx2j3zeK0TlEk
         rnUl2iWShau7xJIiHKEzmiHDIG5vdkWxkb3jt9K2nBoIJj60qqdkymI2Gf0LVR4I6Olv
         MDaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rUaPNqdNJTMk9JIlxYmwbC+A5hqcg2xYFqho0ak6YQw=;
        b=pz49r25ru8DVpkvEv1NVj8c7IaP0Ih6w3cAqGfbDu2BQToxKFbVu87HUM7zCXwIkFz
         CxMJjka3ojm+TvBfW+NVCawC9fvExMSadPno+2tsup5V0KphLNF0EYgxypPTBMVnsrIT
         oydWyGB4yn3X8VF6vT04D+Kpv2KJPkUePX0o4SO2T+6hb4ICyVClCaBxna9n3IWTrOLb
         v+KKs2PE9gpdB/Zxgo866XrKQJxyifRYiosNqCMz6YrDZBSTId7Hq9L5cPZJ5Q6PTAH4
         nlH1s+E3gVrKrt6V034X/l+j3sS32DiYFKX3s0srWI1GO5QR3xuNVY54dZMVqNLaDsgO
         2xCQ==
X-Gm-Message-State: APt69E3cD3xUMAEbl9L++AqdyV62NcKHyyHOHsxJjUIpuc6bcxPQ3vp6
        uzOpCrt/T+saaOCcc7Ss4RQ=
X-Google-Smtp-Source: ADUXVKIXrKxqtj2KZddRa2Kwk9/VpWDKpm5kapJs6QxWdw1jhLEc366XknCz4oOgO+86P7ANNMJk6g==
X-Received: by 2002:a62:ccdc:: with SMTP id j89-v6mr7163253pfk.232.1528938455572;
        Wed, 13 Jun 2018 18:07:35 -0700 (PDT)
Received: from 350D (14-202-194-140.static.tpgi.com.au. [14.202.194.140])
        by smtp.googlemail.com with ESMTPSA id 14-v6sm4578932pgc.63.2018.06.13.18.07.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 18:07:34 -0700 (PDT)
Message-ID: <814fc15e80908d8630ff665be690ccbe6e69be88.camel@gmail.com>
Subject: Re: [PATCH 00/10] Control Flow Enforcement - Part (3)
From:   Balbir Singh <bsingharora@gmail.com>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Mike Kravetz <mike.kravetz@oracle.com>
Date:   Thu, 14 Jun 2018 11:07:23 +1000
In-Reply-To: <1528815820.8271.16.camel@2b52.sc.intel.com>
References: <20180607143807.3611-1-yu-cheng.yu@intel.com>
         <bbfde1b3-5e1b-80e3-30e8-fd1e46a2ceb1@gmail.com>
         <1528815820.8271.16.camel@2b52.sc.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-06-12 at 08:03 -0700, Yu-cheng Yu wrote:
> On Tue, 2018-06-12 at 20:56 +1000, Balbir Singh wrote:
> > 
> > On 08/06/18 00:37, Yu-cheng Yu wrote:
> > > This series introduces CET - Shadow stack
> > > 
> > > At the high level, shadow stack is:
> > > 
> > > 	Allocated from a task's address space with vm_flags VM_SHSTK;
> > > 	Its PTEs must be read-only and dirty;
> > > 	Fixed sized, but the default size can be changed by sys admin.
> > > 
> > > For a forked child, the shadow stack is duplicated when the next
> > > shadow stack access takes place.
> > > 
> > > For a pthread child, a new shadow stack is allocated.
> > > 
> > > The signal handler uses the same shadow stack as the main program.
> > > 
> > 
> > Even with sigaltstack()?
> > 
> Yes.

I am not convinced that it would work, as we switch stacks, oveflow might
be an issue. I also forgot to bring up setcontext(2), I presume those
will get new shadow stacks

Balbir Singh.

