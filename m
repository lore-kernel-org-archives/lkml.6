Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1028DC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 20:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A95032088E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 20:11:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A95032088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbeHUXcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 19:32:54 -0400
Received: from www62.your-server.de ([213.133.104.62]:33213 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbeHUXcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 19:32:53 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fsCzk-0008H5-8u; Tue, 21 Aug 2018 22:11:16 +0200
Received: from [178.197.248.16] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1fsCzk-000Tfw-3J; Tue, 21 Aug 2018 22:11:16 +0200
Subject: Re: [PATCH] libbpf: Remove the duplicate checking of function storage
To:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Taeung Song <treeze.taeung@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Linux Netdev List <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20180821161258.19718-1-treeze.taeung@gmail.com>
 <CAJpBn1zT1EnyKnzmoEO_4WwjR1qgY94wcQjHdKUPAa5z+5OvXw@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <e0799ee4-875d-de62-e6a1-cc461fe38be7@iogearbox.net>
Date:   Tue, 21 Aug 2018 22:11:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAJpBn1zT1EnyKnzmoEO_4WwjR1qgY94wcQjHdKUPAa5z+5OvXw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.1/24863/Tue Aug 21 18:48:32 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/21/2018 06:46 PM, Jakub Kicinski wrote:
> On Tue, Aug 21, 2018 at 6:12 PM, Taeung Song <treeze.taeung@gmail.com> wrote:
>> After the commit eac7d84519a3 ("tools: libbpf: don't return '.text'
>> as a program for multi-function programs"), bpf_program__next()
>> in bpf_object__for_each_program skips the function storage such as .text,
>> so eliminate the duplicate checking.
>>
>> Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
>> Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
> 
> Looks reasonable, but you may need to repost once bpf-next is open:
> 
> https://www.kernel.org/doc/Documentation/networking/netdev-FAQ.txt
> 
> Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>

Agree, please resubmit once bpf-next opens up again. Thanks!
