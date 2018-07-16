Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60E7ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 18:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8602F208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 18:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="CoVESIqO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8602F208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbeGPS5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 14:57:22 -0400
Received: from sonic308-15.consmr.mail.gq1.yahoo.com ([98.137.68.39]:36620
        "EHLO sonic308-15.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727809AbeGPS5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 14:57:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1531765723; bh=hEaiu28bErhTCl2gwUobUYnxPqdbb7ncIlCw0CKAP8I=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=CoVESIqO8hi+GDPK3O7MIAsMGIt38+DHQvxehhPx8fWdcroHEuTj+hxAbU+4JeAb0ijxwgonj1N6rTHuvqQJ2BIithn+/CnDHZQ+UkqGRrJP0VpoTNjCXVStt3QEwKLotsDIss1IeTLJobZyAHuqb1Yfdq86G4XTX1QG4X+Tz2Zo7dcMW5iCfdmi4/YIvDzKEmUksYTIvzMxSR6M95VJp8PFUec669cOvOTJ+VF0dIY6x0LEp0XA6mdog9kwLqsILjv6fRsTYdfMLiyTdg27oslZaYZIwn8I1pKTrfXI753yzYseX0Ltcr6o3Sse84qea11CYSRvNc2Ep5wjRGzspw==
X-YMail-OSG: UVlm5zMVM1kQA0kSeLOLwgOnb6uz3MUolH8NIENFcyHLia_knlEBGnrASDTkXe1
 F2Hnzn2EtSxql7AFaoFNiyGuEB7zyiNKUDAFoquJQdgHlcUx7DIFpdZsYlyXVH1ERXizha5CZxjY
 OkRtdVjDjZ5fEDSU1Xg9n4jbXevsSujp6k9MnEG4GJEJLuidfc3n7JfWaDeXY8AQuSjJkL0JTJR8
 oRZiz8FKxUQbsomE__qw39A7rqjV6Cip7i8bVWQVcONqsjOiboynb4SuNmvKM2YCHhuevoulskho
 nC0aNNWz0Q.7mS.55FokLVSD60W3ctXprzxDI_Y1_zRG.iaUxNvsKox6azNA3TtfoipF44Gz30Eg
 kC7Bv1xBCFbHc9LDWef2mykzaTemd7RKiFPcfP11av9NJaaMBy2zJRIinfnySc.Xz3LMqSGa3n.r
 ERFbA.WrIUBzwTYh2Y0c3QDBtF4vSzBfd5S05709Nh4EVluGxYcGTLaorAKRk8ZxrroxbtqdzNtQ
 _5hdqHrw5Ma5ZImIWBop3QyvVz9alvxAoOvN7lUweNVeP2fcQvVru0wT5I1g6CPjmj_d3VRHZQWt
 8YTX9yk93FZcdkTZkU7KLhnkbeeErWun0RdsnPmgyH0yKRhyuDOQqivjNdX8Ramf0gJvOuSXqlRS
 ONfFiVe7Q3b4XTZfarHWvJlRn2pDDZbN_OKK3DDrHcfNHKzPGQumC_dte23y.T._Eysl7hWb9.xR
 BSb146U6DWPxF5vaEbiTyrKMPvluRpCP0YYgQGLFQja4rwrfbClVYUww5dL51zHy.z.Bzp1JQhee
 5DE59Q_lLdMCoocIyW22TUpqkCePKmB2o2OMarDgW1c8QUli5YyKf0gqGnOmRBQEmIDaRx5Jf6C.
 9PM7NWzonczCVWb3Ccseqn..efvyiupX3kwZa_.JrkUKtf6APYWR6wGfoPtPxyo0uFJjQ3ol8V.G
 RHbobASb2Amu3PDyDrlRXC_.BPXIUpqI73dPy_8ham7s4NqQuhhxb7a1GXN7LHWSdB0yXREgx0Ix
 4jzIwwj9NfDaAgPDJ9.xhUjg440pDBS4nloG2yVDdKm3N6w--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.gq1.yahoo.com with HTTP; Mon, 16 Jul 2018 18:28:43 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.100]) ([67.169.65.224])
          by smtp422.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID d139727de46168e623205579daea6ea4;
          Mon, 16 Jul 2018 18:28:42 +0000 (UTC)
Subject: Re: [PATCH v1 00/22] LSM: Full security module stacking
To:     LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        SE Linux <selinux@tycho.nsa.gov>,
        "SMACK-discuss@lists.01.org" <SMACK-discuss@lists.01.org>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        James Morris <jmorris@namei.org>
Cc:     "Schaufler, Casey" <casey.schaufler@intel.com>
References: <8a325db8-e7eb-9581-2b77-fc987a165df7@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <30381606-5632-df49-380b-1f49f88cc953@schaufler-ca.com>
Date:   Mon, 16 Jul 2018 11:28:39 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <8a325db8-e7eb-9581-2b77-fc987a165df7@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/16/2018 10:53 AM, Casey Schaufler wrote:
> LSM: Full security module stacking
>
For the tree minded:

	git://github.com/cschaufler/lsm-stacking#stacking-4.19

