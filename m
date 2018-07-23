Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53EACECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18E3320875
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:32:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18E3320875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388054AbeGWMc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 08:32:56 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:39840 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387847AbeGWMc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 08:32:56 -0400
Received: from [192.168.122.135] (helo=_)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fhZ4S-0004jn-4c; Mon, 23 Jul 2018 12:32:08 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 23 Jul 2018 12:32:08 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, pgaikwad@nvidia.com,
        jonathanh@nvidia.co, thierry.reding@gmail.com,
        linux-kernel@lists.codethink.co.uk
Subject: Re: [PATCH 2/8] clk: tegra: host1x has fractional divider
In-Reply-To: <20180723111216.GM1636@tbergstrom-lnx.Nvidia.com>
References: <20180720134532.13148-1-ben.dooks@codethink.co.uk>
 <20180720134532.13148-3-ben.dooks@codethink.co.uk>
 <20180723085010.GK1636@tbergstrom-lnx.Nvidia.com>
 <7df28a76490315402d28ad7de43dc0db@codethink.co.uk>
 <20180723111216.GM1636@tbergstrom-lnx.Nvidia.com>
Message-ID: <0e52ce60b6d0aed73ca171352a56d3e7@codethink.co.uk>
X-Sender: ben.dooks@codethink.co.uk
User-Agent: Roundcube Webmail/1.1.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018-07-23 12:12, Peter De Schrijver wrote:
> On Mon, Jul 23, 2018 at 10:32:58AM +0100, Ben Dooks wrote:
>> 
>> 
>> On 2018-07-23 09:50, Peter De Schrijver wrote:
>> >On Fri, Jul 20, 2018 at 02:45:26PM +0100, Ben Dooks wrote:
>> >>The host1x clock according to both tegra2 and tegra3 manuals is
>> >>an 8bit divider with lsb being fractional. This is running into
>> >>an issue where the host1x is being set on a tegra20a system to
>> >>266.4MHz but ends up at 222MHz instead.
>> >>
>> >
>> >The fact the hw has a fractional divider, does not mean we're
>> >allowed to use
>> >it. Due to the non 50% duty cycle of fractional divided clocks,
>> >they are not
>> >allowed for certain peripherals. Do you have information
>> >indicating this is
>> >ok for the host1x clock?
>> 
>> Only that's what was setup for the systems we're using.
>> We couldn't match the 2.6 working system without these changes.
>> 
> 
> On Tegra20 or Tegra30?

I'll check tomorrow when I have access to all the hw involved.

-- 
Ben

