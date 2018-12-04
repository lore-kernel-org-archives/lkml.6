Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCDCC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 05:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD90F208A3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 05:49:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD90F208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbeLDFts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 00:49:48 -0500
Received: from terminus.zytor.com ([198.137.202.136]:47031 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbeLDFts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 00:49:48 -0500
Received: from carbon-x1.hos.anvin.org (c-24-5-245-234.hsd1.ca.comcast.net [24.5.245.234] (may be forged))
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id wB45nRiu745337
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 3 Dec 2018 21:49:27 -0800
Subject: Re: [PATCH] x86/boot: clear rsdp address in boot_params for broken
 loaders
To:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     sstabellini@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de
References: <20181203103811.17056-1-jgross@suse.com>
 <2489CC78-0410-4F0D-9D79-7905868B51BC@zytor.com>
 <082a6607-09f2-72d3-84f7-794c68412c66@suse.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <0917d755-3311-92a9-8fb4-c0f408633f5c@zytor.com>
Date:   Mon, 3 Dec 2018 21:49:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <082a6607-09f2-72d3-84f7-794c68412c66@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/18 9:32 PM, Juergen Gross wrote:
> 
> I'd like to send a followup patch doing that. And I'd like to not only
> test sentinel for being non-zero, but all padding fields as well. This
> should be 4.21 material, though.
> 

No, you can't do that.  That breaks backwards compatibility.

	-hpa

