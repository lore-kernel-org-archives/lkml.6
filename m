Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CEDC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 14:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF35E2081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 14:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="QF4VzsQ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF35E2081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbeKBXIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 19:08:41 -0400
Received: from st11p02im-asmtp002.me.com ([17.172.220.114]:28684 "EHLO
        st11p02im-asmtp002.me.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbeKBXIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 19:08:41 -0400
X-Greylist: delayed 3608 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Nov 2018 19:08:40 EDT
Received: from process-dkim-sign-daemon.st11p02im-asmtp002.me.com by
 st11p02im-asmtp002.me.com
 (Oracle Communications Messaging Server 8.0.2.2.20180531 64bit (built May 31
 2018)) id <0PHK00200GXLZ400@st11p02im-asmtp002.me.com> for
 linux-kernel@vger.kernel.org; Fri, 02 Nov 2018 13:01:10 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;     s=04042017;
 t=1541163669;  bh=4sGrZ1GuUQTJ/1hTrW0LxGTqaKkRQVwIuXwSMWCa75Y=;
        h=Date:From:To:Subject:Message-id:MIME-version:Content-type;
        b=QF4VzsQ/sKIEsMsqRF4EXw+9nW9XyO6GyKBqzIJUGXxktiXOMHchpDV4RHvbDjGac
 6DH2zrEbVYOTWCc53WIMzRNtxeuma+MOx9qLs9Ol7hAdhNN2M/baBplVEoVJuZbs1Y
 RNyysvIiS+ZrnFT8PfFctRCdNiI8E3q8rF8J+LZoHxQYkafmpCUOTCkwPIzH5uopRr
 ORtuM/uPEZUPYMltFAi+rzBFFNhO5Adg1R4CDSTB3G9cCCG2ejkywTkLk9whasD0F4
 HZU0xOmm9PLPTawvBjpuuhWiVSZHXHT0Dc+MJLETY5mybzqJzYRHSCdInG0UVI8qYY
 UZiYCTuHHMMjw==
Received: from icloud.com ([127.0.0.1]) by st11p02im-asmtp002.me.com
 (Oracle Communications Messaging Server 8.0.2.2.20180531 64bit (built May 31
 2018)) with ESMTPSA id <0PHK01A8AHHS5540@st11p02im-asmtp002.me.com>; Fri,
 02 Nov 2018 13:01:09 +0000 (GMT)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811020120
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2018-11-02_07:,, signatures=0
Date:   Fri, 02 Nov 2018 14:01:04 +0100
From:   Damian Tometzki <linux_dti@icloud.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        linux-kernel@vger.kernel.org, tipbuild@zytor.com,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [tip:locking/core 5/6] /bin/bash: scripts/atomic/check-atomics.sh:
 No such file or directory
Message-id: <20181102130103.GA2064@Ubuntu-DTI>
Mail-followup-to: Mark Rutland <mark.rutland@arm.com>,
 kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
 linux-kernel@vger.kernel.org, tipbuild@zytor.com,
 Peter Zijlstra <peterz@infradead.org>
References: <201811011821.G9DTgwnD%fengguang.wu@intel.com>
 <20181101112943.4zwlwsmkeebg7p5k@lakrids.cambridge.arm.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-disposition: inline
In-reply-to: <20181101112943.4zwlwsmkeebg7p5k@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

i got now the error:
/bin/bash: scripts/atomic/check-atomics.sh: No such file or directory
make[2]: *** [/home/damian/kernel/linux/./Kbuild:86: old-atomics] Fehler 127
make[1]: *** [/home/damian/kernel/linux/Makefile:1112: prepare0] Fehler 2

Best regards
Damian




On Do, 01. Nov 11:29, Mark Rutland wrote:
> On Thu, Nov 01, 2018 at 06:16:22PM +0800, kbuild test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
> > head:   30bc7baa9de81efc0584b9290ce8040a1130f156
> > commit: 85f8507192fbfb4ad2ac01de879cb50045f4247f [5/6] locking/atomics: Check generated headers are up-to-date
> > config: i386-tinyconfig (attached as .config)
> > compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> > reproduce:
> >         git checkout 85f8507192fbfb4ad2ac01de879cb50045f4247f
> >         # save the attached .config to linux build tree
> >         make ARCH=i386 
> > 
> > All errors (new ones prefixed by >>):
> > 
> > >> /bin/bash: scripts/atomic/check-atomics.sh: No such file or directory
> >    make[2]: *** [old-atomics] Error 127
> >    make[2]: Target '__build' not remade because of errors.
> >    make[1]: *** [prepare0] Error 2
> >    make[1]: Target 'prepare' not remade because of errors.
> >    make: *** [sub-make] Error 2
> 
> It looks like we accidentally dropped execute permissions from the
> scripts when picking them from the list. Locally I get a slightly
> different failure:
> 
>   ALL    scripts/atomic/check-atomics.sh
>   scripts/atomic/check-atomics.sh: line 16: 
>   scripts/atomic/gen-atomic-instrumented.sh: Permission denied
>   warning: include/asm-generic/atomic-instrumented.h is out-of-date.
>   scripts/atomic/check-atomics.sh: line 16: 
>   scripts/atomic/gen-atomic-long.sh: Permission denied
>   warning: include/asm-generic/atomic-long.h is out-of-date.
>   scripts/atomic/check-atomics.sh: line 16: 
>   scripts/atomic/gen-atomic-fallback.sh: Permission denied
>   warning: include/linux/atomic-fallback.h is out-of-date.
> 
> I've sent a patch [1] to fix this.
> 
> Thanks,
> Mark.
> 
> [1] https://lkml.kernel.org/r/20181101112654.55898-1-mark.rutland@arm.com
