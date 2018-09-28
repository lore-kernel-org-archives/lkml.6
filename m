Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DE8C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A073B206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="guXk7lLJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A073B206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbeI1WTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 18:19:39 -0400
Received: from sonic315-26.consmr.mail.ne1.yahoo.com ([66.163.190.152]:32997
        "EHLO sonic315-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729201AbeI1WTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 18:19:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1538150115; bh=frdaIPXBTlNMV879jTZNUMiSFT7QBFEon4bVG4nF/Xw=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=guXk7lLJTiuP3l62XVsQ/aOiX5TnI1DuuUj0mb2hRLHb8OUuo6EFhVZXMpypT80kx5ajteCtDoAhKqFfBFZSAXKpBO6pEJyU5XxBPIvD7WBzzzH4R0zDfIeC9CxXwoa7duT25Z7IbgTktVzT/ib4qfHR44elgLFg0DXYwGz5XwXMmHJs7Q9UXKqGOLD2KG56L7yqGGTARVyge5slkEZKJwbPHt0KlXUxppu8gQGhwO082rpZoyVcB+mpeoMjjby246YTa6oYja6ODbaf9q7UkM/X+p9LdlQ4z3aia1T5YVm92yHxMM1UX33kc5MJwXa1MtfbDiIYhoimUzl5kdeCDw==
X-YMail-OSG: 5m3VHfUVM1m1oYD9irxOovy6gTHBSAOMbPzs.lcEm4ONv7ExrdkjjFxZkwL97ve
 uLxI3afqaSuMuRSfvjy0scdx4Acm.z9_WliiXnb1ScLhagz9OQ6VIuiC0sqoJpcUmqHWxYXc_jmE
 r7lXPYKFa38OlFkRzvS.ItUWeoi2YvIfqt9X.svx3k131Ni3n_wMoZUjj1eLkyeEUxSRd5L57FTw
 8qcXLnM1B4djIZa4U8cnhS8_0S28LQsIX5gb0p3KrZ3cd60iMvjfWCBq6ghWztUjizVQ9GHUH5Xe
 x3Wsyc5qH5HrcS9Bjl8vYXoVV7X5obCvsFx02FkMZdAR7zi4uFFvCbH7ZTMCcZXhkya44_mNIBdH
 jj4Nbhc.zH87FByqvPMzAiksGAkt.rxdVn.bE1Cn1q9lBMtDIXuMqQ3W78wC.DjIVB7i8BKgEauK
 jpceD5RDFYaz48XyQCP0BIHybgJbuX807zV0nZMQdTHhxPE5lALzsOYS64nca0sHKWQd3Z70lXsr
 75y5pVNwlOEzUaSGAEccHJSEUNpd51QCMNoUezLYxJm2Kl4iFcOdEdDvS0FfMILQ0xwDJ5kBXRHJ
 dD_QOrm1gxqfbKvxGuTyBXBWjAnF6uqxw5LM_.BngDPBduWUuPSMKBIlsyWw3zROLiFayFtvc4TD
 VvOj.U6EJJD8F0bYVhQNz4ppPclgmyFSiBwRTHYpaKYX4HQ_8d7ujxw3jsbrKTXbRTcisRN9DN.Z
 ZmquAVDsfv5kvV_7iIRWlTDlxY3rcjyP2Xy5cYV4l3yUSi21UlI7Gzh26NjoXsgBquLkCxiaIteb
 3IsU8xSbCWeYmacBuiQyw1tFT8P4AgEd9wjOhYjHOeZc8R85S3CBjAeehxxLBPXOUKtdFzuqPzjS
 pbq_0FnpHpjDJATxxpQtQD41n31UKAXpILepKxe70mONgErokBaYOkzLoBHOajlSXc870nyXyi9s
 qqzxnQ4FtEWP.fGTIEMmgF_hQwp_wNXe92ijERofZb60FS3Xce5CfQvu5aKrcpMR8jGnA9q13O.v
 Uzqeb8w7GbmwplO6rHWoBSqeoFXsRdd4U99ESpG5T2vAa1RzW
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Fri, 28 Sep 2018 15:55:15 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp429.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID fc1289fcf068aea5d5b9b7544d6a23b3;
          Fri, 28 Sep 2018 15:55:14 +0000 (UTC)
Subject: Re: [PATCH security-next v3 00/29] LSM: Explict LSM ordering
To:     Kees Cook <keescook@chromium.org>, James Morris <jmorris@namei.org>
Cc:     John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180925001832.18322-1-keescook@chromium.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <e6122c7d-bd29-d081-3c1e-96b7c369d4fe@schaufler-ca.com>
Date:   Fri, 28 Sep 2018 08:55:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180925001832.18322-1-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/2018 5:18 PM, Kees Cook wrote:
> v3:
> - add CONFIG_LSM_ENABLE and refactor resulting logic

Kees, you can add my

	Reviewed-by:Casey Schaufler <casey@schaufler-ca.com>

for this entire patch set. Thank you for taking this on, it's
a significant and important chunk of the LSM infrastructure
update.


> ...
> Breakdown of patches:
>
> Infrastructure improvements (no logical changes):
>   LSM: Correctly announce start of LSM initialization
>   vmlinux.lds.h: Avoid copy/paste of security_init section
>   LSM: Rename .security_initcall section to .lsm_info
>   LSM: Remove initcall tracing
>   LSM: Convert from initcall to struct lsm_info
>   vmlinux.lds.h: Move LSM_TABLE into INIT_DATA
>   LSM: Convert security_initcall() into DEFINE_LSM()
>   LSM: Record LSM name in struct lsm_info
>   LSM: Provide init debugging infrastructure
>   LSM: Don't ignore initialization failures
>
> Split "integrity" out into "ordered initialization" (no logical changes):
>   LSM: Introduce LSM_FLAG_LEGACY_MAJOR
>   LSM: Provide separate ordered initialization
>
> Provide centralized LSM enable/disable infrastructure:
>   LoadPin: Rename "enable" to "enforce"
>   LSM: Plumb visibility into optional "enabled" state
>   LSM: Lift LSM selection out of individual LSMs
>   LSM: Prepare for arbitrary LSM enabling
>   LSM: Introduce CONFIG_LSM_ENABLE
>   LSM: Introduce lsm.enable= and lsm.disable=
>   LSM: Prepare for reorganizing "security=" logic
>   LSM: Refactor "security=" in terms of enable/disable
>
> Provide centralized LSM ordering infrastructure:
>   LSM: Build ordered list of ordered LSMs for init
>   LSM: Introduce CONFIG_LSM_ORDER
>   LSM: Introduce "lsm.order=" for boottime ordering
>
> Move minor LSMs into ordered LSM initialization:
>   LoadPin: Initialize as ordered LSM
>   Yama: Initialize as ordered LSM
>   LSM: Introduce enum lsm_order
>   capability: Initialize as LSM_ORDER_FIRST
>
> Move major LSMs into ordered LSM initialization:
>   LSM: Separate idea of "major" LSM from "exclusive" LSM
>   LSM: Add all exclusive LSMs to ordered initialization
>
> -Kees
>
>  .../admin-guide/kernel-parameters.txt         |  20 +
>  arch/arc/kernel/vmlinux.lds.S                 |   1 -
>  arch/arm/kernel/vmlinux-xip.lds.S             |   1 -
>  arch/arm64/kernel/vmlinux.lds.S               |   1 -
>  arch/h8300/kernel/vmlinux.lds.S               |   1 -
>  arch/microblaze/kernel/vmlinux.lds.S          |   2 -
>  arch/powerpc/kernel/vmlinux.lds.S             |   2 -
>  arch/um/include/asm/common.lds.S              |   2 -
>  arch/xtensa/kernel/vmlinux.lds.S              |   1 -
>  include/asm-generic/vmlinux.lds.h             |  25 +-
>  include/linux/init.h                          |   2 -
>  include/linux/lsm_hooks.h                     |  43 ++-
>  include/linux/module.h                        |   1 -
>  security/Kconfig                              |  61 ++-
>  security/apparmor/lsm.c                       |  16 +-
>  security/commoncap.c                          |   8 +-
>  security/integrity/iint.c                     |   5 +-
>  security/loadpin/Kconfig                      |   4 +-
>  security/loadpin/loadpin.c                    |  28 +-
>  security/security.c                           | 351 +++++++++++++++---
>  security/selinux/hooks.c                      |  16 +-
>  security/smack/smack_lsm.c                    |   8 +-
>  security/tomoyo/tomoyo.c                      |   7 +-
>  security/yama/yama_lsm.c                      |   7 +-
>  24 files changed, 438 insertions(+), 175 deletions(-)
>

