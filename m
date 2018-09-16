Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31783ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 18:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5CA020883
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 18:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="mUV+bvEQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5CA020883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbeIQAN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 20:13:27 -0400
Received: from sonic305-9.consmr.mail.bf2.yahoo.com ([74.6.133.48]:37585 "EHLO
        sonic305-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728333AbeIQAN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 20:13:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1537123774; bh=9YjMw12tbw7YqaqKwra2X7Q3ePUiT7BpqQBbuwaaWhw=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=mUV+bvEQ2N2yRP1ek75tGSD50dRMStWiYyJ1zG+6VIDvAB+NwwjbIVOF8QTW60iOsVjYso1gsFoEoL9WoIMrjcXBZbD3iXrci7Bu60trkrEH6exMG4wDWRmKL+a3bjWD8FURvfetXXj3cJ/tuL0SAKmwyHRN+iELE8t5tohxD2bWI4urs+SXLSqxwpVdno7ht16F9fY9Lj1ERN6ZVNW9yFR2+5vrzPKEgCkdkLk3pIITXZrUMcVGjVNFnTipF0/qgpZXoQ+UnQitDZJrhxKSiqrgYW+3B+RHBAipd3KCZmw5uLiuNrX2FjQuw9w6Vg2XH9c3oCkgZ8C6/5Vy9zzjUQ==
X-YMail-OSG: FjQFP7oVM1nqh8dzaOEvVhTFlh5nFxzQPHOupyD68lT9mPX5WFzxh1gByTlXmze
 xbZdBjwVYiJFJ2pQN4PMEVsAai_5jZsAJpqKurLrioxwGGijypDBYVkQx1OeNW5cVjYpJL57YMMb
 Qig4Tjusv8XT9_6znsqSrZTBO3SQNr2GU5YGH_DAufBkYtg8bCNvVDRCxMhrxqp6r.kVUFuPOqR3
 avjCkdww7.kzPHw3zGSIMomdtZoEWO7knFvJI8fDH6UL_qSpPnVcO6wZ5CuVoOvA23jLYvE8NGzI
 a5jbzXXZv7.K2Yqoxoo8mXFi_fKHSpW7yd_xmg410.94z0.PZ0rXU9KTxms98mP1pk2iKVLof2LB
 03JCtfv51VjdbfpsS3RfXaCzrOVfVAY4a31pJm8aaYTeO5ncilUymbqNuai09IiqaUI6nLvIGl_d
 viKuqt_xiPM_4j58QPI5Xr6.cmv2WtitdkheM.EUNdAIrHu3pNGtRVDd9banz97rpJd8CEMmT24e
 H6BPLFvFaUnbCEWcD0GZXIV1sdL4ZKWr_b9QG_IW.NZxi5pGY0FVvdyoKHtLwTd.sv3vBeNBKKrq
 lDNbvOJ_EtVyJAlGzj0_R8bGqvGWhaTWzRs6ffwgtaobub5oTLIp72HlLHWSARdkhnXUfiu.9OLu
 swHuO9azbeZZNolnL3IL79vh0LoLJQz_qpBOZeJG.6ccvrKh2tObPzI9vVF5glzLRc8AZjMm1CIg
 Pj2h_UkBlealaCTT6JvgQYsllk4XVFHahHLxyviG5SZDTTm4tpyw64_bXTkCvlnmvzmf_Isz1r30
 udMNZiSRZgm9rexiy0.opjZBglyc9sb.R7hb2Db5kIHIgk6qISkDQGxDfb1vBueBZAyLdZsTVZx0
 jqwT6W8DQ8jzMtrUS3A60U2IkfcOPXyDXVWwC4dW6jU_BqwRSAUlXvahfidHTvRwCJyl55zLj4sJ
 rD_PRflGn4DgVuMvVsHnTJ1m6oVgcqSQIk98uMAQEIenu__LsMtvMfPeKWZ8TucKhQYkOMhOeoyj
 R8v_Hs03EcROQJJCWPQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Sun, 16 Sep 2018 18:49:34 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp426.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 8264fe9faf49a75be875c1e190a9b9fd;
          Sun, 16 Sep 2018 18:49:34 +0000 (UTC)
Subject: Re: [PATCH 16/18] LSM: Allow arbitrary LSM ordering
To:     Kees Cook <keescook@chromium.org>, James Morris <jmorris@namei.org>
Cc:     John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>
References: <20180916003059.1046-1-keescook@chromium.org>
 <20180916003059.1046-17-keescook@chromium.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <84e1a5a8-8997-829f-cf09-1d29895a3f99@schaufler-ca.com>
Date:   Sun, 16 Sep 2018 11:49:31 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180916003059.1046-17-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/2018 5:30 PM, Kees Cook wrote:
> To prepare for having a third type of LSM ("shared blob"), this implements
> dynamic handling of LSM ordering. The visible change here is that the
> "security=" boot commandline is now a comma-separated ordered list of
> all LSMs, not just the single "exclusive" LSM. This means that the
> "minor" LSMs can now be disabled at boot time by omitting them from the
> commandline. Additionally LSM ordering becomes entirely mutable for LSMs
> with LSM_ORDER_MUTABLE ("capability" is not mutable and is always enabled
> first).

Today if I have Yama enabled and use security=apparmor I get a
module list of capability,yama,apparmor. With this change I would
get a different result, capability,apparmor. I am personally OK with
this, but I think others may see it as a violation of compatibility.

One solution is to leave security= as is, not affecting "minor"
modules and only allowing specification of one major module, and adding
another boot option security.stack= that overrides a security= option
and that takes the list as you've implemented here.

An icky alternative would be to say that any security= specification
with no commas in it retains the old behavior. So
	security=apparmor
	security=apparmor,
would get you
	capability,yama,apparmor
	capability,apparmor
respectively.

Another option would be to require negation on the minor modules,
such as
	security=apparmor,-loadpin

I can't honestly say which I like least or best.



