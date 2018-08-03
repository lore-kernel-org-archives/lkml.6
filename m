Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE9CC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 18:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3D0E2177F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 18:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="vkKrFkcl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3D0E2177F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729876AbeHCUjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 16:39:22 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:37730 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbeHCUjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 16:39:21 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w73IY0Hs131783;
        Fri, 3 Aug 2018 18:41:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=UEQcC2hX6VpFxdNUev9a6kKvqYiqZXI2TCaRvCY7GiU=;
 b=vkKrFkclInAXnFcU0COrFd0QvE2+8hY0Jtqt+c/wwSi4FAooNjo/xcsNdYHMItyOLHSr
 TpP1LlSKWFhSNs303jmdqgzTg5ZldM17hp9YT7eeKSiHAgTNbKKHk4XZmevBE5qq+qOP
 73i/XHkguVZugVZ579LZqRWirLcGCvXqvcCdmfdJgNZGYjFgTuZx1WxxOT90tEjPuRor
 X81R+neykTr3QDzn7giNded5Tq15b3Go/xJAhE6eR8rXRwdbxmlyLl+tpIn7no34muK8
 bfX7Rw935CvNU4PscMS2tcF6XV8WjQ3+V3tmAeX14o6irieZOpER4hGmeANUT/o1XH0Q VA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2kma04bfnh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Aug 2018 18:41:37 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w73Ifab9024927
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Aug 2018 18:41:37 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w73IfaFo017864;
        Fri, 3 Aug 2018 18:41:36 GMT
Received: from [10.175.167.229] (/10.175.167.229)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 03 Aug 2018 11:41:36 -0700
Subject: Re: [PATCH] objtool: Support multiple rodata sections.
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
References: <20180725141754.29644-1-allan.x.xavier@oracle.com>
 <20180726163647.xxn5u6c2ekxtk2b4@treble>
From:   Allan Xavier <allan.x.xavier@oracle.com>
Openpgp: preference=signencrypt
Autocrypt: addr=allan.x.xavier@oracle.com; prefer-encrypt=mutual; keydata=
 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
 Jycc5aNW5OOSmgYj
Message-ID: <d36c5422-d7f7-00f8-f52b-6e3887884566@oracle.com>
Date:   Fri, 3 Aug 2018 19:41:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180726163647.xxn5u6c2ekxtk2b4@treble>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8974 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808030202
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josh,

Thanks for your comments, I've sent a v2 with fixes for what you mentioned, but
also just wanted to respond to some of your comments directly.

On 26/07/18 17:36, Josh Poimboeuf wrote:
> 
>> +		if (strstr(sec->name, ".rodata") == sec->name) {
>> +			sec->rodata = true;
>> +			found = true;
> 
> This check is too broad.  It will also match the following sections:
> 
> .rodata.str1.8
> .rodata.str1.1
> .rela.rodata
> .init.rodata

As written, it doesn't match .rela.rodata or .init.rodata, although you're right
that incorrectly matches .rodata.str1.[18] as well as
.rodata.<funcname>.str1.[18] when data sections are used.

In the v2 I've addressed this by checking for .str1. before the last character
of the section name, I fully admit it's pretty ugly though and the logic could
be relaxed for a cleaner implementation, it depends on how strict you want to be.

Alternatively, it could also be possible to key off whether the rodata section
has any relocations, which has the additional benefit of narrowing down which
rodata sections are likely to contain jump tables.

Let me know what you think of this or if you have any better suggestions.

> Also, the loop should break once it finds an rodata section.

I don't quite understand your point here. If the loop breaks once it has found
an .rodata section it would only ever mark that one section as rodata, ignoring
the rest?

Thanks,
Allan
