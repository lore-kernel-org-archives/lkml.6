Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330F6C476E5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD07621471
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:04:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD07621471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732433AbeGLQOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 12:14:32 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:45069 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbeGLQOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 12:14:32 -0400
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1fde4m-0004XJ-2o from Sandra_Loosemore@mentor.com ; Thu, 12 Jul 2018 09:04:16 -0700
Received: from [127.0.0.1] (147.34.91.1) by svr-orw-mbx-03.mgc.mentorg.com
 (147.34.90.203) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Thu, 12 Jul
 2018 09:04:12 -0700
Subject: Re: [PATCH V2 00/19] C-SKY(csky) Linux Kernel Port
To:     Guo Ren <ren_guo@c-sky.com>, David Howells <dhowells@redhat.com>
CC:     <linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tglx@linutronix.de>, <daniel.lezcano@linaro.org>,
        <jason@lakedaemon.net>, <arnd@arndb.de>,
        <c-sky_gcc_upstream@c-sky.com>, <gnu-csky@mentor.com>,
        <thomas.petazzoni@bootlin.com>, <wbx@uclibc-ng.org>,
        <green.hu@gmail.com>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <27030.1531302693@warthog.procyon.org.uk> <20180712125152.GA5226@guoren>
From:   Sandra Loosemore <sandra@codesourcery.com>
Message-ID: <5731b5c4-e29d-30f6-095f-4a74f52cb72d@codesourcery.com>
Date:   Thu, 12 Jul 2018 10:04:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180712125152.GA5226@guoren>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SVR-ORW-MBX-09.mgc.mentorg.com (147.34.90.209) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2018 06:51 AM, Guo Ren wrote:
> On Wed, Jul 11, 2018 at 10:51:33AM +0100, David Howells wrote:
>> Can you say what the --target tuple should be so that I can add the arch to my
>> collection of Fedora cross-binutils and cross-gcc tools built from upstream
>> binutils and gcc sources?
> Metor Graghics are helping us upstream gcc and binutils.
> 
> @Sandra,
> 
> Could you help me to reply the question?

Neither binutils nor gcc support for C-SKY are in the upstream 
repositories yet.  We should be resubmitting the binutils port soon 
(with bug fixes to address the test failures that caused it to be 
rejected the last time), and the gcc port will follow that shortly.

The target triplets we have been testing are csky-elf, csky-linux-gnu, 
and csky-linux-uclibc.  Note that the gcc port will only support v2 
processors/ABI so that is the default ABI for these triplets.

I'm not familiar with the Fedora tools, but to build a complete 
toolchain you'll need library support as well and I'm not sure what the 
submission status/plans for that are.  E.g. Mentor did a newlib/libgloss 
port for local testing of the ELF toolchain and provided it to C-SKY, 
but pushing that to the upstream repository ourselves is not on our todo 
list.

-Sandra
