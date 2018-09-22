Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4990EC433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 16:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF9AB2154C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 16:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ophGbOXg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF9AB2154C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbeIVWc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 18:32:27 -0400
Received: from sonic305-9.consmr.mail.bf2.yahoo.com ([74.6.133.48]:33641 "EHLO
        sonic305-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728455AbeIVWc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 18:32:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1537634296; bh=FVKK+wY/E0fyOKd9JNeGWSi7MbkeV0YbAK7BxC/Aic0=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=ophGbOXgkDCXmMkB3jiBi1+EVIKEHJaXBKIMp8am66mq8LW6w5fl5KQLZKjl4YGWsu+EP+8jp+t13p5CFHpqErFN4RhE97S69aR6N4g1HJa8DQdB2qbAop2scrrZmMaFG3/Z4Xt+jPmGHCsLItsjaLgPM5dZ7WkPNLsHYGDlYpe7Rnp/9KUDUYJ2ItMvZpuLZlyXoPWAo9DPsxX9fLY7xIahfi++wOJUwynDuQyc6JdKeQ6vemS71qAjm4bhmQlcUgKlMEyCfHzo4QQNfTz/PLeg0cziHh8H5GGH1dyeIeCbvFa+8wDhTD1xvCce0BGr1z9+GepPmKjO9KwYoNJPHg==
X-YMail-OSG: SNca7ewVM1lG068HaD_YIhVYUNdhhuQix198QiyjCrkwnT.46TAQTQJCASGI_8E
 Tw5O5nJv5I4CEye.moZB6OwNM3Sd7nI8T4kDOAFOgXnpmFi5K.fQ7JBHGk4GWwbe8i5FyKSj.7bY
 ZQWpGchA0bEHS.BJrwiyXPych0huiEk5otox5XWB3NQF13vI2tVxHCSDiMZBdmKyPSvP6xoYqJFj
 mnK.assA1V_o6kb5osVb8T0zOv6T8MTdkGiW9D2qAjXcz37j4vP7LGL5El3_Qai65D3K5JD0q.jI
 12jF..uCTxzGh3mfPOi19vkQDvA7M8mz7B0ihTr3Ngl9jqq0fUU7onLwJoraQipJU1R1Znn2IqNh
 RlO0dyFUB7AEfiMb2j2AOTXwVS6MEk7YNxmGtUIwRWCZGVvsysWWF09.3_rORZgxyZSEo5xypGxX
 jXk6dYfafdAQ_hmDCllsKhIn4lE2f.UtaHL.pnNu0aqB15MhvBt3lvbmRIIRj._wp_pYjvNW5Oza
 gnF4jLMuZqkhzz6OVFyHSweNCMKY3Wje4Uj0cOyaJFVG_3ipaD9V9j_nNVSeu5sQf7hDf1HJ7XDS
 bqejWmaqsJovD_wnk1bAjNqZ9wPd4MyFnDZm0xTyRT7IZDpP4uv3Q8ZcjWcKe0zlD235zYhFYZ._
 bqhx7dVGoyLvkV5dNGobt4p.kIEtw9qeyOl8SZoV3LwQsa.wlejWaaOUB1X3czK64B9guhIlrYca
 P5tpPlfGOdlXX6JTPquNU92u5tW.j8UNOK4XkJ4ik.vnfs1yJgPO9Kj1.7BLZ3qEFY17XHMRD6C4
 bY17OTQLR_cCbXqYQxL10XXW6STtNLDpGTMwu5ve.9n1t9FACXUucB11xsPls1KToFvMWgPDmlQB
 UbS0hwwkt8Lhi27su1KKloVydQhy_.zTtEllFXy.K9pRI5VhPqrgxnsoLKTagxmWL1LwflgIdWsg
 AdqMGD7by2JSYx9p4qffGkSThny.5BSOPmrGQ1nIFdxvYmkGd9PKypLetBnx6LqMS5Ri8wASBU_V
 8FHKmyIzc7ra4TgO0.kUfOujh.H6zYoKDu4AF7b8-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Sat, 22 Sep 2018 16:38:16 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp426.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 97fca731e8f1dd87996fa7fa4d470d00;
          Sat, 22 Sep 2018 16:38:15 +0000 (UTC)
Subject: Re: [PATCH v4 00/19] LSM: Module stacking for SARA and Landlock
To:     Kees Cook <keescook@chromium.org>
Cc:     LSM <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        LKLM <linux-kernel@vger.kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
 <CAGXu5jK=+FuL+JiSxcHy0i9Ppha=BQYdJW5zvbm1Redbo12wmw@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <680e6e16-0890-8304-0e8e-6c58966813b5@schaufler-ca.com>
Date:   Sat, 22 Sep 2018 09:38:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5jK=+FuL+JiSxcHy0i9Ppha=BQYdJW5zvbm1Redbo12wmw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/2018 8:02 PM, Kees Cook wrote:
> On Fri, Sep 21, 2018 at 4:59 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>> v4: Finer granularity in the patches and other
>>     cleanups suggested by Kees Cook.
>>     Removed dead code created by the removal of SELinux
>>     credential blob poisoning.
> Thanks for the splitting, this really does make it easier to review
> (at least for me). I think this looks really good, though obviously
> I'd like to refactor it slightly on top of my series. :)

Whichever goes on top is fine with me. What's one
more patch set merge, after all?

> One additional thought I had was about the blobs allocations: some are
> separate kmem caches, and some are kmalloc. I'm thinking it might make
> sense to use separate kmem caches for two reasons:

I had seriously considered doing that. I can't see any reason
not to. It's something that could be done at any time, and with
all the other things that had to change it just didn't get in.

> - they're going to always be the same size and are regularly
> allocated/freed, so it may offer a performance benefit.
>
> - they're explicitly not supposed to be exposed to userspace, so
> hardened usercopy would protect them if they were not kmalloc()ed.
>
> I'm excited about getting this landed!

Soon. Real soon. I hope. I would very much like for
someone from the SELinux camp to chime in, especially on
the selinux_is_enabled() removal.

On a somewhat related note, I will be out for the first three
weeks of October, returning just in time for the Linux Security
Summit in Edinburgh. My connectivity will be severely limited.
I don't expect to accomplish anything while I'm out.

