Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C900C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 12:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1818A2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 12:09:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1818A2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbeIRRlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 13:41:24 -0400
Received: from www62.your-server.de ([213.133.104.62]:45694 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbeIRRlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 13:41:24 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1g2EoN-00032N-UO; Tue, 18 Sep 2018 14:08:59 +0200
Received: from [178.197.249.15] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1g2EoN-0003AN-Og; Tue, 18 Sep 2018 14:08:59 +0200
Subject: Re: linux-next: manual merge of the net-next tree with the net tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Vakul Garg <vakul.garg@nxp.com>
Cc:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "davejwatson@fb.com" <davejwatson@fb.com>,
        "doronrk@fb.com" <doronrk@fb.com>
References: <20180918101107.74d8689a@canb.auug.org.au>
 <93982e9d-dc78-6423-bb9b-c5773d98e244@iogearbox.net>
 <DB7PR04MB42522B223D4E04F5DA519A8B8B1D0@DB7PR04MB4252.eurprd04.prod.outlook.com>
 <236589cd-b55d-1ceb-f236-36f9135f794e@iogearbox.net>
 <DB7PR04MB4252D31B8E79B789CC507D248B1D0@DB7PR04MB4252.eurprd04.prod.outlook.com>
 <5959dad0-dd02-1c3d-2487-13a69f8c507b@iogearbox.net>
 <d5eee0d9-c270-3ce7-5fcd-5f94b713dc3b@iogearbox.net>
 <DB7PR04MB425225AD548F3A3040250EF48B1D0@DB7PR04MB4252.eurprd04.prod.outlook.com>
 <20180918214814.4eae366d@canb.auug.org.au>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <c9b60dd3-5e47-bc5f-98ee-99f96a863710@iogearbox.net>
Date:   Tue, 18 Sep 2018 14:08:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180918214814.4eae366d@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.1/24951/Tue Sep 18 10:16:39 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/18/2018 01:48 PM, Stephen Rothwell wrote:
> Hi all,
> 
> On Tue, 18 Sep 2018 10:17:03 +0000 Vakul Garg <vakul.garg@nxp.com> wrote:
>>
>> Got it. 
>> Thanks for the guidance.
> 
> So, what should I remove? ;-)

My (very own personal) preference in general would be that we test / assert
the kernel behavior that exists /today/, meaning once we implement support
for multi-record peek we add the corresponding test case along with that
code. Fwiw, this practice would be consistent with the rest of the kernel
selftests development model we have under net (& bpf).

Thanks,
Daniel
