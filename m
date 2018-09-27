Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0C2C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 859942156B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ejlvwa1k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 859942156B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbeI1Ewu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 00:52:50 -0400
Received: from sonic302-28.consmr.mail.gq1.yahoo.com ([98.137.68.154]:37077
        "EHLO sonic302-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725957AbeI1Ewt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 00:52:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1538087537; bh=+blMXPnkw9U+tzuzdgsEaDHx14656Bl0m+1PHfJ8+40=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=ejlvwa1khTIu14bwj0r1dvT79gXy9NMBvbqJLUkNqC7ICCSpYxOs3BC24U7Ax+6r2OjmNnx00JkmM4GtkLIF9geE9dtki4rJ7D/nZzNkS/HuMTYduWSlhRQ8Rf0l4RyfvE5Cf6vFKTZwRnkyxLJ3HbrtJYKHrD6rB/FOo8655HrdRGT4l+RDPjmKY4+DhSo8SvzesG6PyMCe2MaqaOhs4d8K8KRtCqloxcPXPUVUQ0C+I7h46niA3Sp4f1+UvaaFixCKeiUO3svxj8gx4zC4JwVshmlLQTAj5IeZYqDAippObWo37iBmhRf5yjFR/iOkMmUnNsls3bWuwI0V5RziTQ==
X-YMail-OSG: fWCKTBoVM1mapm2MjLU.KDC509byz1mEVx4vhIcz03b3GH8eNGx_SA85S6wH94.
 WLtI7YVdVDVTUL5XMzBwR_NZKp1TpDzqR0ZQYSgiuNYR3kwQb1nLGJ0E.lr0PKer4ItwAdZZN7MY
 uKNhHdI59yn.QWrJ3fWlTpptFtekv5p2JyDylDJgVtRz66A7alWHZ2HfK9zhGd4_8BAo1.XxMtVC
 yN632Il8D3rQqeNr4ld_XH1OzbxIrOX4JJDy2QFwr0nAxvkF2GDZY3BNvGJ3H6VpfJkd09mQKLjN
 6PPpIkhU.R.e2LRtPc47t8zU5uuStbERuTpyu07cCZ48F4eus1FzjkCH78bFicT59C0K5scCAnhr
 8GLiNwKeb4LiAcQntqEeGHRbJSbdLwqBZy49RhiHC_nTfOh6VmLnRnZfHfo_OiZ9qc60aqGGXRnt
 EsNmafSG41D_kmWKopX4q9iujqQKKGa9xD.xjVAZ5HNQE_z7Tz82QN2KHJZel8vtwZPaik_LlwjL
 nANI1M3ZBBrnS01CwTcye4j560QEkXv7TjhRLFziZc0SficUlhMUtN71nzf0nIvClgVRCAcU3pnG
 CM2EJljQaFTp1lyReSH3RzYSH7za3csRZ4mUyjgvCze4YE.QnYVSZ6rc_Xg5jJJ4TKloFmE9FQR6
 JSKw3rN7MNzhnA2MJEjRJ.DMBbH2nqOrs.p4Y2srxxQ9kYw4WxBRGaKHjYDMrVlkv_ck.wEEsceV
 aiMX5fUGaBiT4uup6uVIjiD1GtLbrYXVV1W.JkszyBylCrrKyxvrygea4ZOoVupUCOwLkFT9yP3D
 3RPS5.39ZwnbCWkEPFw8n_7rNnpibgBqUfuqcACCZ4Y_9k2.GCvPqVPjcDR2z9R6sIwZtFDekQ8b
 l78_R1_I0bH81VfdTvUnB.m6yj9trkGyIoW4ywkrk0Ka5iKj1cjp9uEL8C0p2jDqqzA_fiEfuAYc
 .TvWzS8sJ0OqK6n_DvrIaZ7Px3ysMNNGIV9IWTIOyARvCrf.HEUuR5974sLmXVRsymI3DNlYDudI
 oPWhCb__adbHHV6kucvs-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Thu, 27 Sep 2018 22:32:17 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp425.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0b03ad2633d2b766f3841f07f09ec377;
          Thu, 27 Sep 2018 22:32:16 +0000 (UTC)
Subject: Re: [PATCH v4 04/19] SELinux: Remove cred security blob poisoning
To:     James Morris <jmorris@namei.org>
Cc:     LSM <linux-security-module@vger.kernel.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        LKLM <linux-kernel@vger.kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
 <5360cd42-5827-58af-515c-6e1ded1d9154@schaufler-ca.com>
 <alpine.LRH.2.21.1809280813270.8410@namei.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <84719272-fb62-76b6-b2fd-f0c36d49707d@schaufler-ca.com>
Date:   Thu, 27 Sep 2018 15:32:15 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1809280813270.8410@namei.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/2018 3:13 PM, James Morris wrote:
> On Fri, 21 Sep 2018, Casey Schaufler wrote:
>
>> The SELinux specific credential poisioning only makes sense
>> if SELinux is managing the credentials. As the intent of this
>> patch set is to move the blob management out of the modules
>> and into the infrastructure, the SELinux specific code has
>> to go. The poisioning could be introduced into the infrastructure
>> at some later date.
> If it's useful, it should be incorporated into core LSM, otherwise that's 
> a regression for SELinux

When I discussed this code with David Howells he indicated
that it was primarily used for debugging the original shared
credential implementation and that is was not especially
valuable any longer. If someone thinks it is valuable we
should consider doing it in the infrastructure for all the
blobs, not just the credential.

