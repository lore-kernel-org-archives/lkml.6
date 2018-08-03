Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3C8C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 15:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C872521774
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 15:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="CswNtDEE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C872521774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbeHCRYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 13:24:43 -0400
Received: from sonic315-19.consmr.mail.bf2.yahoo.com ([74.6.134.193]:35701
        "EHLO sonic315-19.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727374AbeHCRYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 13:24:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1533310073; bh=LAZp9llg41VUD4EPFjwjUZ8lYVF3GobMYt8Gl3zhcXA=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=CswNtDEEA5Jw+meR8V1SQ5OU8tRDQF1m1SUafFeCpYWP5ncIjVmtjWmV1W8L2Ebj2ao9HnQW3YEqD7gGEJ4z/kqJOq2RQHccpBlvFPKJlcmlQY/QqyxWcZrCMdSfzSFOGqaI2UhjuaG8zTkBYa9XzOPzFN9sqDNwqceovDGtCeF/73AfdX+fDfAoDDWAiFHjeMcPVP4U05bNyS2bj21+Lh8AdT7Nj1U/nYoP/Ee3H045sScJsNnCP73yczG/FYZFaHO1pZ616OXtwmKmmxIP7GjSapupzJZ+4zaio55vkUKMTAl0nArHHltlAiMgIITLzjkx6a7y6Qij62FvqjMEYQ==
X-YMail-OSG: GhRziRgVM1kh0WzA2siQAdxzKWpuXOdKracaz71jxFS8Y6KXYi835nU08ctudpQ
 FXA2WgdrSnGK6AUfFulbeHdAXwtSgqGMorFsLjLr5ZHTHis7s80yvxdT8Vzn3VHO_Hf_iNdn1pLz
 PrfZW0HTRII7vOqyKKTQC.aXargrVd56jNtWmSxs4HsoOIcxjjq.kmmw9PZJqfTvs0M61SOjsui_
 NYGpjZO8vyRktkdDjUgilLKf67HE0i10CoHlqwXJJeX4NL3pIuW3viHdTBpLZJlJkNngVNs0EcXU
 TIJ9c_2dJ8GNOAy4cPwv8_H__H4Pl1.y6FJU7ccR.7qNIQ3RE2FfL8AaJ51bWzudu0GbHWxI9sGu
 LHoZpcb5g76tySt8WUEVIhkTuqJlS6EAr8k27RWt_J8F9my0PkcjCEZH_ApC8HDhARHzy.E1NAEr
 NhDf0gGanYMDouDUHgN.5D4T4W082zuv8vWyxXfJWI_mDrsZ6jG9RCN8PbB0QI3k.V5WylA39cUe
 9aB.CGSmUzDlMt3OAz3EdlpoYjbOUE7rJDzRV.AU0jGRp34YraklWZsRRsJwZ6UyU7.rBdnFw2ZZ
 OpPzwdsmLUfmfV.UyG1uZ9_e4WXTTIjouwVlT3OQNmSO5CtnAYKIwPmKFp2djyKLGNVEA5sya8gJ
 L97V_Sg_B56NC0_xubAeuZyc5OnL.IoiJHrmH_2mz.ciSO5PND74CQJNnMnM0OOqG8D72csRjLWr
 ODzE9Nqcpv83DHo8GpD5UDEqiFB9MHPs0QVci3mxZldHeV1.cR54gp2qyXk7JJ1Jef3F75TjxO0L
 FvRL1lHToiNDS7EGWRmxEzOtDvZiua_57FGano7BvC6mDctoZ8uJ3SFlPLbqEFDhd7vp18NdrJLU
 F3kl175web4yx8PHLkHecQptrUYPOG4lUAa80XpjJqopiymY2jgKLfsTGrAIHpU4ddsYsA0vjlJM
 zg57i2yYyMWUSZFk23MaxUTxggs4sUNQPPQd19WbwUF6it9SynFIU3VQ19Un9iO30IwuCr.0_7s1
 iR7rS.D.pAVVOZLJPaneeZDhqkHvP2E_B.ITMpSnzmyBxsw9l2xO8TeE.58guDahxM2i2GbbTlDF
 _wStkZg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.bf2.yahoo.com with HTTP; Fri, 3 Aug 2018 15:27:53 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.104]) ([67.169.65.224])
          by smtp403.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID a2fa08dd94d843db7329e67a62acc2be;
          Fri, 03 Aug 2018 15:27:51 +0000 (UTC)
Subject: Re: [PATCH v1 20/22] Move common usercopy into
 security_getpeersec_stream
To:     Piotr Sawicki <p.sawicki2@partner.samsung.com>,
        LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        SE Linux <selinux@tycho.nsa.gov>,
        "SMACK-discuss@lists.01.org" <SMACK-discuss@lists.01.org>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        James Morris <jmorris@namei.org>
Cc:     "Schaufler, Casey" <casey.schaufler@intel.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <8a325db8-e7eb-9581-2b77-fc987a165df7@schaufler-ca.com>
 <ac4a4408-5c69-4b87-b57d-537dba588b18@schaufler-ca.com>
 <CGME20180803091011eucas1p29e46a12d1986f11e63547ea1ec8e8663@eucas1p2.samsung.com>
 <20180803091011eucas1p29e46a12d1986f11e63547ea1ec8e8663~HVMbjcXDZ2739127391eucas1p2M@eucas1p2.samsung.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <0c4b4f28-e51f-8b5d-9259-c6ab97c5c506@schaufler-ca.com>
Date:   Fri, 3 Aug 2018 08:27:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180803091011eucas1p29e46a12d1986f11e63547ea1ec8e8663~HVMbjcXDZ2739127391eucas1p2M@eucas1p2.samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/2018 2:10 AM, Piotr Sawicki wrote:
> On 07/16/2018 08:24 PM, Casey Schaufler wrote:
>> [PATCH 20/22] Move common usercopy into security_getpeersec_stream
>>
>> The modules implementing hook for getpeersec_stream
>> don't need to be duplicating the copy-to-user checks.
>> Moving the user copy part into the infrastructure makes
>> the security module code simpler and reduces the places
>> where user copy code may go awry.
> Hi,
>
> This change will break the API. Some clients may call getsockopt(..,SO_PEERSEC,..) twice. Firstly, to fetch the length. In that case xxx_socket_getpeersec_stream should return -ERANGE and set *optlen. Secondly, to retrieve a proper security label.

Nuts. You're correct. I will fix this in the next round.

>
> Please take a look at the implementation of the getClientSmackLabel() function in Cynara: https://review.tizen.org/gerrit/#/c/26888/6/src/helpers/creds-socket/creds-socket-inner.cpp
> Also there is an email thread about this socket option which tells us why it is made this way: "[RFC] SO_PEERSEC - security credentials for Unix stream sockets"
>
> http://lists.jammed.com/linux-security-module/2003/12/0029.html
>
> Regards,
> Piotr
>

