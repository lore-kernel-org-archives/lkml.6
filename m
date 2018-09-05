Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79979C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 17:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33D0920857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 17:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="WQFpC/gd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33D0920857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbeIEWIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 18:08:48 -0400
Received: from sonic311-28.consmr.mail.ne1.yahoo.com ([66.163.188.209]:42969
        "EHLO sonic311-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726497AbeIEWIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 18:08:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1536169055; bh=vRAS3RyBJ6lu3nyQRd5UwzkfAszvDeJQ9e7LetV1GxE=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=WQFpC/gdN1LN+kqKtZ258dvS0tbCNpEb8f0ttZ4UaKd940zfwO7Wp0VBOL087QoIJRfdJljGMkv1WiVWsrkLL4zv9NET1hlHJ40WsPKxPdouUmBzJVVsvzTmhucciQABhLZauJf5w9UTeZW+ACtOOqA41lJxWGb/gjVxwtiV2otfWZnAuZ5HVzwpzM+oTsDI0nnVxrSZHDi2rt3Bsn2RRfu49fp+E70ISH0xcdGvaJ7dv+UDT8lYTHenYWdHBAQpbmtHNrQNR0Aq4xBr90XvD8EiU68uLOU56m/CqKx5bkRQrGa2BzhGtCq+uzk6bsJnK4HoARFH6AhYsTk4GNb+0g==
X-YMail-OSG: 1f_tfkgVM1kdJ.v8Am60JhpjKDMqpsbu0RkFve1nN_f8BfZQSD1mR_fWjBsc2uP
 IPVdeZnf7Vuj0Ldxvr2ZffSVgYfNheRChQr4O7ipB.OI1OdQksbpho4URnxt6kOjGJ_CGiHLhHXo
 Wez67xCsZvzOkQjNOYYHCRQFe_i0Nq4tf4vj0AWPjs.KUOMy_wFwbCDAcIgNXvWieTrktlywF6Z0
 J_eU3b.vLka2dkvWz17X4WohxX8XaWAr51xkL06TxWChbh3EBTz0KYHDjGBHWN8iq2ckcOAbHHeS
 1ArVyR4gSIVkqZRmxcUodPv6hFhbqVjbsEnKqPpN1Dtx5heQA9KApJ.XDEc.Cv7UhVl25Pfr1Lrs
 PXc6W0GKx.s81CYugpg7uv9gIrgBb3SV6j2yCEjCJV9Hf5rAcbMPXEqhIi147bsjLYHcrLciaFJY
 TkyOYAVAXHRJDpHnf1jDI6spkv17S1OQCvcaiBD2XZvxnJpfYLWbN8XY53KMsSV0Cuvcc9wpJqOv
 RHCaEoB7APx4keqkmTCMHHPVjXVzOC8NoNcnzEKr0lfjKTSWWYszBK6QmItkZ4K3D.vFmJxCPusW
 aXmhiJgkTI77uxi6HGC_pUrKDJLUuExmOct.Xiaaf0_.kOINmFoP8Hm4KwaEZ9llO4Y58jaOxe.8
 yDveqtHfoyj.lMqVrOvNpJydSCfoVIu4VNjKQr1R7zbVQ1MmEkfaT0YbfP7OpLyikt0voBdBQgtj
 IV.7U0JosFa_muZNGvCut7qboUp9Sc7vvk9mjzqEwFVfm.YF8pETiGTPq2ceLU70mqNOhJlWXWPD
 EfHi40k42_PEXSr66ASGN_yJDJdTomcybsRwH.qlx2hZBgOP49W4f.yEL3BYYwCRnVaMdmhY7qLM
 Igd_CQH1BfsjDZm18cEoWHAABJg518cdczyzsTRVSSeAtT2bDfyLXOONO8zolGPv7Cg6Z3L8LegQ
 kN_qV7Bq78yBwJ5BtgHXQoE1PT1BEquxRij5oTWi8_WjruDq9MZnWN8m6QxxJxlTCFMcGaHBZb8U
 oej.eR5Tki3FUYPCMxs2JOU1Lmzo1w1ePrKul5E_FYj..m71wEDApLmm3BK0rAwyOhpFzvIYI3Id
 wtirQRHboRA0jO3UJyJVoPEI.l2iVGg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Wed, 5 Sep 2018 17:37:35 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp429.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 186839ff6d328e24b7635e18ac99aeed;
          Wed, 05 Sep 2018 17:37:31 +0000 (UTC)
Subject: Re: WARNING in apparmor_secid_to_secctx
To:     Dmitry Vyukov <dvyukov@google.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        syzbot <syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com>,
        tyhicks@canonical.com, John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        Serge Hallyn <serge@hallyn.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        SELinux <selinux@tycho.nsa.gov>,
        Russell Coker <russell@coker.com.au>,
        Laurent Bigonville <bigon@debian.org>
References: <000000000000c178e305749daba4@google.com>
 <CACT4Y+Z9wmuq=Pb-gxAJauQNi0uZGDUimWEL66UzWGSp_x2uQA@mail.gmail.com>
 <37aec45f-69ad-9705-21f1-64ee4ce4a772@tycho.nsa.gov>
 <CAHC9VhSeP=b1xxpCT8R-CYLEP3507ezwDwkq2Bsyekfa4otLGw@mail.gmail.com>
 <9537a6ff-daf4-d572-bf93-68230909b68e@tycho.nsa.gov>
 <4b37e892-4d79-aefb-92ab-7753b89b8963@tycho.nsa.gov>
 <CACT4Y+YOxTTYzEi3uCeLm3gquvSkJNZ+DhPVziEnbXGX6HVkVA@mail.gmail.com>
 <1ea19628-3bbe-2073-d623-824337c15ed6@tycho.nsa.gov>
 <CACT4Y+ai0do=8smTG0h0QXDnOrWh8PNwaTosJtqOEB_HG59eGg@mail.gmail.com>
 <b2b38348-f3a4-6498-c9b8-1090532f6a23@tycho.nsa.gov>
 <CACT4Y+bXaLe0FKyGPT=WqGitZPrawvpOXHS-UOVX0ZXTDV+JVQ@mail.gmail.com>
 <6c9112a2-33f3-0c29-c944-1d129a0026e7@tycho.nsa.gov>
 <CAHC9VhR6gG6_RkT1OEH4PArHpzUGkOjVCpKwAmad+TDfC15sgQ@mail.gmail.com>
 <CACT4Y+YaBpi95Puae3Bjn1opL+UsdUWns2PDaFU-EmamuMusag@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <e2e02f43-abfe-171e-a5b7-3fb9086cc733@schaufler-ca.com>
Date:   Wed, 5 Sep 2018 10:37:27 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACT4Y+YaBpi95Puae3Bjn1opL+UsdUWns2PDaFU-EmamuMusag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/2018 4:08 AM, Dmitry Vyukov wrote:
> Thanks! I've re-enabled selinux on syzbot:
> https://github.com/google/syzkaller/commit/196410e4f5665d4d2bf6c818d06f1c8d03cfa8cc
> Now we will have instances with apparmor and with selinux.

Any chance we could get a Smack instance as well?

