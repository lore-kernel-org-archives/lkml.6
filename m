Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227AFC7112C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 16:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCAC52075D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 16:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="KmrBgLXa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCAC52075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbeJXBMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 21:12:34 -0400
Received: from sonic311-28.consmr.mail.gq1.yahoo.com ([98.137.65.209]:35176
        "EHLO sonic311-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727402AbeJXBMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 21:12:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1540313303; bh=yynKm9stIduSWPbk4zo7xnaN/eaxsH/tXE8xgOv8za4=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=KmrBgLXalpL5wnPbINQPxmTe5mWs3L7LrF+NppQU6xT5bgvBCsLzx/seWDLCESfaKCwOSlabL7CkCBc/2CpTWGrSkDvnxRP01SPYERD6FM0O/M4lJzoHD+//caWWHy+xZenUKC3JDooY5o2E0V+D5OXmrUo7MrRgGq+RsCbF0fJEPdm4y/lOZW6LYdat2S5mZKCts/fnZ7MD04TLscgbGGwgJzN+9ZoEeeM4UUV1cWN/6I78b2H5D4xElxlrwvJEHY4W15h8bIkGIFU7uWIQs5z/FZToEC/b7f/XDHq3PC44oc0eA+uaJLG1iascY+8r13t56zc2MK5WbOoH3gZPkQ==
X-YMail-OSG: v.mP48gVM1lVhhZ4ugFahggzMCsjQncp6iymfalc1FGk0O6IcBXU1v0Tu6Epgfe
 AWFJMvOcKN3JQ9voTSxUZS6XKWkztuXgAKPvmi85EqsV8UzNZ0ch80TQcRsBIpniY.lRL_kjNKAV
 bINZc94RadbEEDLRpAD4JCs42VHHM5LQBkg1ZUwZymjelO5RDxwIAHnUNPisZZh_yAmZVIx_JpxI
 MjV0_vZh1foSFiwrjUFTKZUllfegaAyOQaCmz5R0jFcdD.LgLCIcUTk61_k2JNBd94obG7GxVl1O
 vtXR.05ag9JzKjfW8Rn8qzFfBp5ScT9_wbs4ee7Fx4aexqff8f9eGmuMqS2yuC9FSgviTeMqnoBl
 AadEN2FMw4WJ5bJYv78qcJ8AdukY9MQKLgH4M5zAZUX.GnbhPIqfSL5fRrcPA4fqBamYBY0dfXAI
 teqkpugihjAoPOjMRknze1vnJt.0SRYEsVpMJmFTg.AQsru1mTrpufienXIjBnpOlJd5hSFwJsox
 oi.qzJYhEyFrQTsnWnS2GPuaNS3mDfCHzqg8PTc75WdN8FuWgXXxJ2gh8OVvEjkjqzxFRR84UldL
 alQCKmJJA.Wmbu81AlxObS.d4BoOPRoIMpm6VUGF1yDksC61Q8pF6s7U2UZXbAA6DAJJD9Kp45DQ
 1LUz3HDTt7XgPSt1yZECSABuW.izuKJVRCAMJSd2iRkDaO.lmayCxnVcjJiRHJptofx7KTWM5Tu9
 uBMYZPAQiO3WLuSQFlOao530WhifPImaGv0u6dVRSgtWAPJkmCrHR0I_dkHlkEDsM4KPxffJ2uCk
 Bs2btmt75fPt4WasNHqiiDOH5WDHAxQ0.NC2XQZ.8OWU1zueONdBZ2u_8S3KsufKuFeLrJVKSVvO
 2a3zGEHXanhuOwPnWQONC1QboSDSI9SOoE5JQajpeD3feaCTYVMcPpbZ6eAY.YtH6JSfrx.bf5JF
 n91r5gvqAaQKjrabbklAOwwePvvV2F3ioCGN1Okul1DWN0IF0nX.NIKObGpuqqouh6MJn_U5QpL9
 V41lwwOJ7PVgbqyumYEQjaGD0S_eZOu3et8xtE6NuBVlG_BUdQEGNO9Mn5eGCdwx4U4kUbdlGTt3
 4yAfoXkvhYombS3AiDfNBJ_VSXzWkQWmuUJc1TWJQ1k5HjpFU2Hzf9qD8UfsT
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.gq1.yahoo.com with HTTP; Tue, 23 Oct 2018 16:48:23 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp411.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID b419b420ec331b823b05909e1f5b1a99;
          Tue, 23 Oct 2018 16:48:22 +0000 (UTC)
Subject: Re: [PATCH security-next v5 00/30] LSM: Explict ordering
To:     Kees Cook <keescook@chromium.org>,
        John Johansen <john.johansen@canonical.com>
Cc:     Jordan Glover <Golden_Miller83@protonmail.ch>,
        James Morris <jmorris@namei.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        LSM <linux-security-module@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20181011001846.30964-1-keescook@chromium.org>
 <CAGXu5jLBaHj5MhXaK-8zdu6Rgo2B6rEq+at17xZ1Puct+YUajQ@mail.gmail.com>
 <ZhaXhoElmWQlsxHmgFHpB2xSWzJYFZWBasrSKQNjGj4_T2A4AY2F9v1rP9LkUfilUbZ0ExWXX9koLNjUM8S6baX6xfSSMPXY_CpihbCetVc=@protonmail.ch>
 <CAGXu5j+kekUdcE2EhUu__8MXJ1O+D=-zTXLGNCRVa_VyDxePpw@mail.gmail.com>
 <f68e5f4b-6360-a9e7-597f-89d1d3ca73c1@canonical.com>
 <32stV62RmME8Dj5jKB8Z03zPe_Et72kMo71D8SpgSOHUo6SaROc8DomMWdk5jDGpyqVd8T63NIIK2NdDw95clpF8Uj47Wca2FBFItXDRh7E=@protonmail.ch>
 <38dde301-d77e-35fd-88d4-5cdc5b570ee8@canonical.com>
 <_CkJnKYmEZ4ZF0JtsSYuahAd9sgnX9OtcstjXaeqb8wn5uxfimc6S4jomly7If9VqnOXqXwaiCbJ9ttS6NiqE7n6cQUlwLvfO53paLmacvU=@protonmail.ch>
 <8251564f-ba7a-1777-a606-dec472b32f35@canonical.com>
 <CAGXu5j+2yVZ5DQHyqvJKnSYYqRCzeMtEabBwYFOWkTcwMUWhEw@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <96e92224-aedf-5026-d6dd-b29121b4dc0d@schaufler-ca.com>
Date:   Tue, 23 Oct 2018 09:48:20 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5j+2yVZ5DQHyqvJKnSYYqRCzeMtEabBwYFOWkTcwMUWhEw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/2018 12:01 PM, Kees Cook wrote:
> On Friday, October 12, 2018 3:19 AM, John Johansen
> <john.johansen@canonical.com> wrote:
>> It isn't perfect but it manages consistency across distros as best as
>> can be achieved atm.
> Yeah, this is why I'm okay with the current series: it provides as
> consistent a view as possible, but leaves room for future improvements
> (like adding "+" or "!" or "all" or whatever).
>
> I'm curious to see what SELinux folks think of v5, though. I *think* I
> addressed all the concerns there, even Paul's "I want my distro
> default to not have extreme stacking" case too.
>
> -Kees

Looks like I should go on vacation more often. :)

I am generally opposed to fancy specification languages.
I support the explicit lsm= list specification because you
don't have to know any context to create a boot line that
will work, and be as close to what you've specified as possible
for the kernel configuration. One need look no further than
the mechanisms for setting POSIX ACLs for an example of
how to ensure a feature isn't used.

Had we the foresight to make security= take a list of
modules when Yama was added we might have avoided some of
this brouhaha, but there was no reason to expect that stacking
was ever going to happen back then.

