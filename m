Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C8BC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BF9B20651
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=skogtun.org header.i=@skogtun.org header.b="o+yYEEQA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfANTRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 14:17:16 -0500
Received: from smtp.domeneshop.no ([194.63.252.55]:35664 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbfANTRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 14:17:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=skogtun.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=FpK81aJB+9QajpbTQxWHTAlyuPkxj2U3vKtgdvN28/k=;
        b=o+yYEEQA7ti+u/MQyfxc4UuxswIKDqwXNgUdHhvbrEnh1S6ckSQmuM55i2o0EZcRojRr2BllxnbVOTKAMmztQ+yTILmIMEBKPyn5xj/xG8oY0DY13wt+iuzb7MuohSmQ6/0ReqgONbLGCEdk/TglJmY2OF0+MmaGe7JIsuQktvORoKO5M94Y1GbP59tz5K9ocectYRswqYDiS+ObgcKW7LCxcGr8z0+rm97dATnSNc7Y0nfXgImEZIMCcRiw538Pr3wzRkdJEafYCdkIrWBnUOEya/r+SxnqveecLGaYT7VTgznClStOCbnmBEB7RRjk0bis8ogjudq9HctOapaGwA==;
Received: from [2a01:79c:cebe:b88c:caff:28ff:fe94:90a0] (port=62386)
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <harald@skogtun.org>)
        id 1gj7jV-00085g-Gr; Mon, 14 Jan 2019 20:17:13 +0100
Subject: Re: [BISECTED] KVM error with 5.0-rc
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <c8d44a6a-bdb6-6b8c-4a50-1d152a3964f8@skogtun.org>
 <20190114183319.GB5141@linux.intel.com>
From:   Harald Arnesen <harald@skogtun.org>
Message-ID: <e0633c94-e0a3-a764-a69a-544890e02f63@skogtun.org>
Date:   Mon, 14 Jan 2019 20:17:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190114183319.GB5141@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: nb-NO
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson [14.01.2019 19:33]:

> On Mon, Jan 14, 2019 at 06:04:27PM +0100, Harald Arnesen wrote:
>> Qemu with KVM acceleration fails with kernel 5.0-rc1 and 5.0-rc2.
>> It works fine with 4.20.

> Can you test the attached patch?  Found a bug when re-inspecting the
> guilty commit, the wrong VMCS field is being modifying when applying an
> errata to disable VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL.  Your CPU is
> listed as one of the models affected by the errata.  Compile tested only.

Yes, this patch fixes the error.

Feel free to add a "Tested-by: Harald Arnesen <harald@skogtun.org>".
-- 
Hilsen Harald
