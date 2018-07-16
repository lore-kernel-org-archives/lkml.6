Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37237ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 19:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEB1C208E8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 19:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="HTnMQsSJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEB1C208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729828AbeGPUSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 16:18:17 -0400
Received: from sonic302-28.consmr.mail.gq1.yahoo.com ([98.137.68.154]:41677
        "EHLO sonic302-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729603AbeGPUSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 16:18:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1531770562; bh=shKDbc3JO89/Ms6qUiE9NLYn3gQsmMgpLL+MePgpxPA=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=HTnMQsSJ3+UypildF9/m2YMD5dsO3PQpDdlwV02/CS+ISrwiqwnjn8WKSJvFnAqZ/m5elD80M2mjF+PzwzmQhE18Yr83muNim+HW/yhiHMMU6HS8FNRUOguiRipBFSkdmZCCtvy6PiQYTD4NtU1mOujjCLYHvGMUEw/7yJIkabwOaxzyxKT4Ri5CHlETGwipU/bKuzOcj6iT4m7D7tWEt/im1OpO/PvpxLNwzNzOqJTYSiGhMssiGDVQHJU0NVFq0JAEIHM5uRscZYHz3OlmitLzYFRPPhOf01HV2hgpviK/yI/RzsGRziO1cqYz1vjyJAhlu/tf39h9VhlsN0znBA==
X-YMail-OSG: 96vCdzQVM1nEPAvtfGtitAAIaZ7nOpuNqujw3wiJ8ymocpGnvE0AGqSTZSnM3s7
 8j_HPphK8KoYbzM6mxO5RVj4vL4Eeyvl0NDIlgteJ6sYE8j7VyPCZNt4jDxxlYB4J5VpSmcU5z7D
 OqKSyUHnGYrhmmoGMqitWzcUJ5wk3Biw5Lfg63.a6Q3FMvCx1BO58EhrO14QRX6KVsUwYSL8irG9
 Ctw.__u6sKFv0XAz8BAznKnGOWeuLfBXR1OCd8IY20CHfQW4FQ7tevoYxqvTa84mrz1EtbHnz.V.
 yqgE0vqd76L9qx974YbsKQR7kD3x_xRWz7sbywrtv0wjpquUFQk9n7ONvdSTPy3kqgfDtQVH9zip
 9.AYg4kMAtf_ALLetHYrBa4LYINOmjepfCAz_8DLmraKvNm_DDcr5GLiKFG8hY2DhvetTw4YK0Gf
 FgJHYFDB8K4k0tt4_4QWh7peD1V_oUovk2SrKxXNDAQ9jUnT_T0YV2Do_W5vHQftJ48po48D6ubG
 _qcpAExiY2D2g2LHoo9r0F9xC7A_7QfeWQ_CZJF8wIINDmytG3CT._07GI9RBy8qoMeKpy6PM9rT
 Aw6W5GIY.dekad_FgB7cFBKarfqepWXy.qnXGEqJogEnfl3xtU3QIhvDfQfwBaSbmjhzXV7aC4lF
 yz9ZZ8fhgs2ptp2G7nET6w.jMaxVADRP7eIKjFKkcq1zhFSB5NcsMSeIxNH9ojb4abiYt5Erb10c
 noF9Hp7KA8rD8nmrdWhMIlXI4Ztq._JocxxIwKA9fqTv5KYhjeDp5X4gy_qWBEkijF3gljTMLOMI
 VjpW.WP_NC8DUT7qhawY9eLwrvOswoSAZX4LYvWjEHCbyWMhwcN75ZmEPIlxJwoixDzac9y3yoMl
 S65q5ctKBtjPPEx2pS9oWtbQH9OQSI4krjRVaR6RNdIZuxDExfnMup08DsA6ZpBDImtXlHiqFJBK
 .iFIR_MwaAOskCWH9OiEBZEhmG_tzP5xBtH10kq29PNBv7ysJ1XYldNo6KjXpvIYdRYwNHR1wZc6
 wD5c-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Mon, 16 Jul 2018 19:49:22 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.100]) ([67.169.65.224])
          by smtp402.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 2e4f3b13a5faae174d9073d516f8a05d;
          Mon, 16 Jul 2018 19:49:22 +0000 (UTC)
Subject: Re: [PATCH v1 00/22] LSM: Full security module stacking
To:     James Morris <jmorris@namei.org>
Cc:     LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        SE Linux <selinux@tycho.nsa.gov>,
        "SMACK-discuss@lists.01.org" <SMACK-discuss@lists.01.org>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Schaufler, Casey" <casey.schaufler@intel.com>
References: <8a325db8-e7eb-9581-2b77-fc987a165df7@schaufler-ca.com>
 <alpine.LRH.2.21.1807170453400.18292@namei.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <c189ed40-4b8e-de1a-6917-273fdad207c0@schaufler-ca.com>
Date:   Mon, 16 Jul 2018 12:49:18 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1807170453400.18292@namei.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/16/2018 11:53 AM, James Morris wrote:
> On Mon, 16 Jul 2018, Casey Schaufler wrote:
>
>> LSM: Full security module stacking
>>
>> I'm calling this v1 not because it's the first version
>> I've put out but because it's the first version I'm getting
>> serious external pressure to get upstream. 
> >From whom?

S.A.R.A. , Ubuntu and a couple lesser embedded projects I'm working with.

