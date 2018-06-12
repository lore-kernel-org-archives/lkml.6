Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A29B0C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 13:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58D012089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 13:31:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58D012089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933583AbeFLNbw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 09:31:52 -0400
Received: from icp-osb-irony-out4.external.iinet.net.au ([203.59.1.220]:24943
        "EHLO icp-osb-irony-out4.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932749AbeFLNbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 09:31:50 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AOAQDmyR9b/zSOqnwNTxoBAQEBAQIBA?=
 =?us-ascii?q?QEBCAEBAQGFTIN3lTEBAQEBAQEGgQUpllOEdwKCUjgUAQIBAQEBAQEChj4BAQE?=
 =?us-ascii?q?DIxVBEAsNCwICJgICVwYNBgIBAYMegXSpdW2CHBqEQINsgWiBC4hJgQeBDySCa?=
 =?us-ascii?q?IdzglUCmQYIAY5ziBqFHpMQgXMzGggoCIJ+kGFdkCoBAQ?=
X-IPAS-Result: =?us-ascii?q?A2AOAQDmyR9b/zSOqnwNTxoBAQEBAQIBAQEBCAEBAQGFTIN?=
 =?us-ascii?q?3lTEBAQEBAQEGgQUpllOEdwKCUjgUAQIBAQEBAQEChj4BAQEDIxVBEAsNCwICJ?=
 =?us-ascii?q?gICVwYNBgIBAYMegXSpdW2CHBqEQINsgWiBC4hJgQeBDySCaIdzglUCmQYIAY5?=
 =?us-ascii?q?ziBqFHpMQgXMzGggoCIJ+kGFdkCoBAQ?=
X-IronPort-AV: E=Sophos;i="5.51,214,1526313600"; 
   d="scan'208";a="80706464"
Received: from unknown (HELO [192.168.0.106]) ([124.170.142.52])
  by icp-osb-irony-out4.iinet.net.au with ESMTP; 12 Jun 2018 21:31:17 +0800
Subject: Re: [PATCH 1/3] m68k: coldfire: Normalize clk API
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        "David S. Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1528706663-20670-1-git-send-email-geert@linux-m68k.org>
 <1528706663-20670-2-git-send-email-geert@linux-m68k.org>
 <944b08ba-a882-e6cd-42fa-9251bce1d7b1@linux-m68k.org>
 <CAMuHMdUyD8d2yoe6v8TEinEH3hhS7Znv99pPxDCkr_uEFS0Fzg@mail.gmail.com>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <e6a2da2c-60e5-b57a-f6c1-3652b8be161c@linux-m68k.org>
Date:   Tue, 12 Jun 2018 23:31:12 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUyD8d2yoe6v8TEinEH3hhS7Znv99pPxDCkr_uEFS0Fzg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 12/06/18 17:31, Geert Uytterhoeven wrote:
> On Tue, Jun 12, 2018 at 9:27 AM Greg Ungerer <gerg@linux-m68k.org> wrote:
>> On 11/06/18 18:44, Geert Uytterhoeven wrote:
>>> Coldfire still provides its own variant of the clk API rather than using
>>> the generic COMMON_CLK API.  This generally works, but it causes some
>>> link errors with drivers using the clk_round_rate(), clk_set_rate(),
>>> clk_set_parent(), or clk_get_parent() functions when a platform lacks
>>> those interfaces.
>>>
>>> This adds empty stub implementations for each of them, and I don't even
>>> try to do something useful here but instead just print a WARN() message
>>> to make it obvious what is going on if they ever end up being called.
>>>
>>> The drivers that call these won't be used on these platforms (otherwise
>>> we'd get a link error today), so the added code is harmless bloat and
>>> will warn about accidental use.
>>>
>>> Based on commit bd7fefe1f06ca6cc ("ARM: w90x900: normalize clk API").
>>>
>>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>>
>> I am fine with this for ColdFire, so
>>
>> Acked-by: Greg Ungerer <gerg@linux-m68k.org>
> 
> Thanks!
> 
>> Are you going to take this/these via your m68k git tree?
> 
> I''m fine delagating this to you.

No problem. I'll add it to the m68knommu git tree (for-next branch)
when the merge window closes.

Thanks
Greg

