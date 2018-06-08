Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id En7WGXPbGluvZgAAmS7hNA
	; Fri, 08 Jun 2018 19:39:31 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4C6E96074D; Fri,  8 Jun 2018 19:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1528486771;
	bh=cOx1fPBllLgCV950pmRhBjPNsd+hoCC9W6PDSnMBxCw=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=hVYLsN7ozXsgqmd5zDJu6k3HSqf2+MLbhudIdW76nWEeGePnyhd1beo6CiVIareEb
	 o143425KsX2bpILuefYa2dagBtzdXWmg/Q3KnFOT2NOFAHG8+qT89IpVtQt+U1K1qK
	 +zixVJQnbOP+ld3A5QYto/mYCQit9VpIcwqcyXtU=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id BDA4F601B4;
	Fri,  8 Jun 2018 19:39:30 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LFi+SvJA";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="o3kDQWHb"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BDA4F601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752789AbeFHTj2 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 15:39:28 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55812 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752535AbeFHTj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 15:39:26 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 177896074D; Fri,  8 Jun 2018 19:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528486766;
        bh=cOx1fPBllLgCV950pmRhBjPNsd+hoCC9W6PDSnMBxCw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LFi+SvJA0AuG47U5uI6+DYvKu4Acgf6Sx44ZSKLFW/+kRda8anlnc1+B+UTsAOJyc
         maWBh7oSK91htIV66ZAL3pNKBnxFCC8DVZFplsrCRqLV+neONP6zY9rvnGwObvvy72
         E5eoAdGkiH1V01B5j+3PhzXvTsn0aHLn9/ltj6w4=
Received: from [192.168.0.106] (cpe-174-109-247-98.nc.res.rr.com [174.109.247.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C088C601B4;
        Fri,  8 Jun 2018 19:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528486765;
        bh=cOx1fPBllLgCV950pmRhBjPNsd+hoCC9W6PDSnMBxCw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=o3kDQWHbY3ig9r6K9sae/52iiOXTbvhQUXKOJyfoE7xZglCrH0LSI/5rxdbW+4CXA
         E0elPAxl7PAkr5Er7u7fhgdkfH+v4SVR7bWrRY/4U6e100i0nh3LUnXCgJ74PvGHzg
         6asUbjIQqg66yKgS46UXnX4miq1T2epTRx4pJHcw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C088C601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH] scsi: ipr: fix build on 32-bit architectures
To: Brian King <brking@linux.vnet.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc: Brian King <brking@us.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Hannes Reinecke <hare@suse.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Wen Xiong <wenxiong@linux.vnet.ibm.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>
References: <20180608144617.2900894-1-arnd@arndb.de>
 <04758f3a-0f03-4fe9-6eb8-10ebb2430a98@codeaurora.org>
 <CAK8P3a2=uMFOcw=gZGuwsH+V=1DMXGgxf_hZHw3tMJD1nDdG2Q@mail.gmail.com>
 <830c2468-293c-385c-0b91-c96bedae4d4a@codeaurora.org>
 <07a50fe0-0378-769a-f4eb-d39ac543dc95@linux.vnet.ibm.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <53f391e7-24b6-3c14-1e68-975078ae683b@codeaurora.org>
Date: Fri, 8 Jun 2018 15:39:23 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <07a50fe0-0378-769a-f4eb-d39ac543dc95@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/2018 3:20 PM, Brian King wrote:
>> I don't think there is a consensus about using these includes in the community.
>> I bumped into this issue before and came up with an include you pointed.
>> I didn't get too much enthusiasm from the maintainer.
>>
>> Why are we pushing the responsibility into the drivers? I'd think that architecture
>> should take care of this. Is there a portability issue that I'm missing from some
>> architecture I never heart of? (I work on Little-Endian machines most of the time)
> The attributes of the adapter hardware can have an impact here. The ipr hardware, for
> example, depends on the upper 4 bytes to be written first, then the lower 4 bytes
> to be written second, and its the act of writing the lower 4 bytes that triggers
> the adapter hardware to read the value and take action on it.

Thanks, I never thought about this.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
